import subprocess
import re

LIB = "/home/user/.volare/volare/sky130/versions/0fe599b2afb6708d281543108caf8310912f54af/sky130A/libs.tech/ngspice/sky130.lib.spice"
N = "L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29' pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W' sa=0 sb=0 sd=0 mult=1 m=1"
P = "L=0.15 W=2 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29' pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W' sa=0 sb=0 sd=0 mult=1 m=1"

def sim_cdac(bits):
    """
    bits: [b3,b2,b1,b0] 1=VDD, 0=GND
    常にvdac_init=1.8からスタート
    0-10n: 全PMOS ON
    10n以降: bitsの値に切り替え
    18nでVdac読む
    """
    def pwl(val):
        gate = "0" if val == 1 else "1.8"
        return f"PWL(0 0 9.9n 0 10n {gate})"

    spice = f"""* CDAC sim bits={''.join(map(str,bits))}
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
Vb3p b3_p gnd {pwl(bits[0])}
Vb3n b3_n gnd {pwl(bits[0])}
Vb2p b2_p gnd {pwl(bits[1])}
Vb2n b2_n gnd {pwl(bits[1])}
Vb1p b1_p gnd {pwl(bits[2])}
Vb1n b1_n gnd {pwl(bits[2])}
Vb0p b0_p gnd {pwl(bits[3])}
Vb0n b0_n gnd {pwl(bits[3])}
.ic V(Vdac)=1.8
.tran 10p 20n
.measure tran Vdac_final FIND V(Vdac) AT=18n
.end
"""
    with open('/tmp/sar_step.spice', 'w') as f:
        f.write(spice)
    result = subprocess.run(['ngspice', '-b', '/tmp/sar_step.spice'],
                           capture_output=True, text=True)
    match = re.search(r'vdac_final\s*=\s*([\d.e+\-]+)', result.stdout, re.IGNORECASE)
    return float(match.group(1)) if match else None

def sar_adc_convert(vin, vref=1.8):
    print(f"\n=== SAR ADC: Vin={vin:.4f}V ===")
    expected = int(vin / vref * 16)
    print(f"Expected = {expected:04b} ({expected})")

    confirmed = [1, 1, 1, 1]

    for step in range(4):
        # 試行: このビットをGNDに落とす
        trial = confirmed.copy()
        trial[step] = 0
        vdac = sim_cdac(trial)
        if vdac is None:
            print(f"ERROR at step {step+1}")
            return None

        comp = 1 if vdac > vin else 0
        confirmed[step] = 0 if comp else 1

        print(f"Step {step+1}: B{3-step} | Vdac={vdac:.4f}V | {'→0' if comp else '→1'} | bits={''.join(map(str,confirmed))}")

    digital = confirmed[0]*8 + confirmed[1]*4 + confirmed[2]*2 + confirmed[3]
    vrecon = digital / 16 * vref
    print(f"Result: {''.join(map(str,confirmed))} ({digital}) → {vrecon:.4f}V | Error: {abs(vin-vrecon)*1000:.2f}mV")
    return digital

sar_adc_convert(0.5625)
sar_adc_convert(1.2)
sar_adc_convert(0.9)

print("\n=== Full 16-code Test ===")
errors = []
for code in range(16):
    vin = (code + 0.5) / 16 * 1.8
    result = sar_adc_convert(vin)
    if result is not None:
        errors.append(abs(result - code))

print(f"\nMax error: {max(errors):.1f} LSB")
print(f"Mean error: {sum(errors)/len(errors):.2f} LSB")
