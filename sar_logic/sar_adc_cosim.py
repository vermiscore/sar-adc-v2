import subprocess
import re

LIB = "/home/user/.volare/volare/sky130/versions/0fe599b2afb6708d281543108caf8310912f54af/sky130A/libs.tech/ngspice/sky130.lib.spice"
N = "L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29' pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W' sa=0 sb=0 sd=0 mult=1 m=1"
P = "L=0.15 W=2 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29' pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W' sa=0 sb=0 sd=0 mult=1 m=1"

def make_pwl(switch_times, final_val):
    """
    switch_times: [(time_ns, val), ...] 切り替えタイミング
    最初は全部0(PMOS ON)
    """
    pwl = "PWL(0 0"
    for t, v in switch_times:
        pwl += f" {t-0.1}n {pwl.split()[-1]} {t}n {v}"
    pwl += ")"
    return pwl

def sar_adc_convert(vin, vref=1.8):
    """
    動作確認済みのmonotonic_dac_4bit.spiceと同じ方式で
    1回のシミュレーションで4ステップを実行
    各ステップ20nsで切り替え、切り替え後15nsでVdacを読む
    """
    print(f"\n=== SAR ADC Conversion ===")
    print(f"Vin = {vin:.4f}V")
    expected = int(vin / vref * 16)
    print(f"Expected = {expected:04b} ({expected})")

    # Phase 1: B3試行 → t=20nで読む
    # 初期: 全PMOS ON (gate=0→0)
    # t=20n: B3をGNDへ切り替え(gate=1.8)、他はVDDのまま

    # Step1: B3=1試行 (全部VDDのまま → Vdacは変化なし)
    # → monotonic方式ではB3=1はVDD、B3=0はGND
    # → 試行: B3をGNDに落とす → Vdac下がる → Vdac>Vin? → B3=0確定
    #          B3をVDDのまま → Vdac変化なし → Vdac<Vin? → B3=1確定

    # 正しい方式:
    # 全キャップVDD初期
    # 試行: 対象ビットをGNDに落とす → Vdac読む
    # comp: Vdac > Vin → そのビット=0(GNDのまま)
    #        Vdac < Vin → そのビット=1(VDDに戻す)

    bits = [0, 0, 0, 0]  # 最終結果

    # まず全4ステップをシミュレーションで一気に読む
    # 各ステップで「そのビットをGNDに落とした状態」のVdacを測定

    # Step1: B3→GND, B2,B1,B0→VDD  t=20n
    # Step2: (B3確定後)B2→GND, 他→確定値  t=40n
    # ...だが1回のシミュレーションでは中間結果に依存するのでステップごとに実行

    vdac_prev = 1.8  # 前ステップのVdac（電荷保存のため）

    # 確定ビット状態 (1=VDD, 0=GND)
    confirmed = [1, 1, 1, 1]  # 初期は全VDD

    for step in range(4):
        # このステップでビットstepをGNDに落とす
        trial = confirmed.copy()
        trial[step] = 0  # 試行: GNDに落とす

        # PWL生成: 0-10n: 全て初期値(confirmed), 10n-: trial値に切り替え
        def bit_pwl(init_val, trial_val):
            if init_val == 1:
                gate_init = "0"  # PMOS ON
            else:
                gate_init = "1.8"  # NMOS ON
            if trial_val == 1:
                gate_trial = "0"
            else:
                gate_trial = "1.8"
            return (f"PWL(0 {gate_init} 9.9n {gate_init} 10n {gate_trial})",
                    f"PWL(0 {gate_init} 9.9n {gate_init} 10n {gate_trial})")

        b3p,b3n = bit_pwl(confirmed[0], trial[0])
        b2p,b2n = bit_pwl(confirmed[1], trial[1])
        b1p,b1n = bit_pwl(confirmed[2], trial[2])
        b0p,b0n = bit_pwl(confirmed[3], trial[3])

        spice = f"""* SAR step {step+1}
.lib {LIB} tt
C1 Vdac sw0 1f m=1
C2 Vdac sw1 2f m=1
C3 Vdac sw2 4f m=1
C4 Vdac sw3 8f m=1
Rleak Vdac gnd 1G
XMN0 sw0 b0_n gnd gnd sky130_fd_pr__nfet_01v8 {N}
XMP0 sw0 b0_p vdd vdd sky130_fd_pr__pfet_01v8 {P}
XMN1 sw1 b1_n gnd gnd sky130_fd_pr__nfet_01v8 {N}
XMP1 sw1 b1_p vdd vdd sky130_fd_pr__pfet_01v8 {P}
XMN2 sw2 b2_n gnd gnd sky130_fd_pr__nfet_01v8 {N}
XMP2 sw2 b2_p vdd vdd sky130_fd_pr__pfet_01v8 {P}
XMN3 sw3 b3_n gnd gnd sky130_fd_pr__nfet_01v8 {N}
XMP3 sw3 b3_p vdd vdd sky130_fd_pr__pfet_01v8 {P}
Vvdd vdd gnd 1.8
Vb3p b3_p gnd {b3p}
Vb3n b3_n gnd {b3n}
Vb2p b2_p gnd {b2p}
Vb2n b2_n gnd {b2n}
Vb1p b1_p gnd {b1p}
Vb1n b1_n gnd {b1n}
Vb0p b0_p gnd {b0p}
Vb0n b0_n gnd {b0n}
.ic V(Vdac)={vdac_prev}
.tran 10p 20n
.measure tran Vdac_final FIND V(Vdac) AT=18n
.end
"""
        with open('/tmp/sar_step.spice', 'w') as f:
            f.write(spice)

        result = subprocess.run(['ngspice', '-b', '/tmp/sar_step.spice'],
                               capture_output=True, text=True)
        match = re.search(r'vdac_final\s*=\s*([\d.e+\-]+)', result.stdout, re.IGNORECASE)
        if not match:
            print(f"ERROR at step {step+1}")
            print(result.stdout[-300:])
            return None

        vdac = float(match.group(1))
        comp = 1 if vdac > vin else 0

        if comp == 1:
            # Vdac > Vin → このビット=0 → GNDのまま確定
            confirmed[step] = 0
            bits[step] = 0
            vdac_prev = vdac  # GND状態のVdacを次ステップの初期値に
        else:
            # Vdac < Vin → このビット=1 → VDDに戻す
            confirmed[step] = 1
            bits[step] = 1
            vdac_prev = vdac_prev  # VDDのままなのでVdac変化なし

        print(f"Step {step+1}: B{3-step} trial | Vdac={vdac:.4f}V | {'→0(GND)' if comp else '→1(VDD)'} | bits={''.join(map(str,bits))}")

    digital = bits[0]*8 + bits[1]*4 + bits[2]*2 + bits[3]
    vrecon = digital / 16 * vref
    print(f"\nResult: {''.join(map(str,bits))} ({digital}) → {vrecon:.4f}V")
    print(f"Error:  {abs(vin - vrecon)*1000:.2f}mV")
    return digital

sar_adc_convert(0.5625)
sar_adc_convert(1.2)
sar_adc_convert(0.9)
