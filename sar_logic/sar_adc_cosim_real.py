import subprocess
import re

LIB = "/home/user/.volare/volare/sky130/versions/0fe599b2afb6708d281543108caf8310912f54af/sky130A/libs.tech/ngspice/sky130.lib.spice"
N  = "L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29' pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W' sa=0 sb=0 sd=0 mult=1 m=1"
P  = "L=0.15 W=2 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29' pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W' sa=0 sb=0 sd=0 mult=1 m=1"
P1 = "L=0.15 W=1 nf=1 ad='int((nf+1)/2) * W/nf * 0.29' as='int((nf+2)/2) * W/nf * 0.29' pd='2*int((nf+1)/2) * (W/nf + 0.29)' ps='2*int((nf+2)/2) * (W/nf + 0.29)' nrd='0.29 / W' nrs='0.29 / W' sa=0 sb=0 sd=0 mult=1 m=1"

def sim_cdac_comp(bits, vin_analog):
    def pwl(val):
        gate = "0" if val == 1 else "1.8"
        return f"PWL(0 0 9.9n 0 10n {gate})"

    spice = f"""* CDAC + StrongARM Comparator
.lib {LIB} tt
.GLOBAL gnd

* CDAC
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

* StrongARM Comparator (Vin1=Vdac, Vin2=Vin_analog)
XM2  cnet3 cnet5 cnet2 gnd sky130_fd_pr__nfet_01v8 {N}
XM3  cnet4 Vdac  cnet1 gnd sky130_fd_pr__nfet_01v8 {N}
XM4  cnet2 Vin2  cnet1 gnd sky130_fd_pr__nfet_01v8 {N}
XM5  cnet1 clk   gnd   gnd sky130_fd_pr__nfet_01v8 {N}
XM6  cnet5 cnet3 vdd   vdd sky130_fd_pr__pfet_01v8 {P1}
XM7  cnet3 cnet5 vdd   vdd sky130_fd_pr__pfet_01v8 {P1}
XM8  cnet4 clk   vdd   vdd sky130_fd_pr__pfet_01v8 {P1}
XM9  cnet5 clk   vdd   vdd sky130_fd_pr__pfet_01v8 {P1}
XM10 cnet3 clk   vdd   vdd sky130_fd_pr__pfet_01v8 {P1}
XM11 cnet2 clk   vdd   vdd sky130_fd_pr__pfet_01v8 {P1}
XM1  cnet5 cnet3 cnet4 gnd sky130_fd_pr__nfet_01v8 {N}

Vvdd vdd gnd 1.8
Vvin Vin2 gnd {vin_analog}
* clk: delay=15n(CDAC settling後), High=10n
Vclk clk gnd PULSE(0 1.8 15n 100p 100p 10n 40n)

Vb3p b3_p gnd {pwl(bits[0])}
Vb3n b3_n gnd {pwl(bits[0])}
Vb2p b2_p gnd {pwl(bits[1])}
Vb2n b2_n gnd {pwl(bits[1])}
Vb1p b1_p gnd {pwl(bits[2])}
Vb1n b1_n gnd {pwl(bits[2])}
Vb0p b0_p gnd {pwl(bits[3])}
Vb0n b0_n gnd {pwl(bits[3])}

.ic V(Vdac)=1.8
.tran 10p 40n
.measure tran Vdac_val  FIND V(Vdac)  AT=14n
.measure tran Outp_val  FIND V(cnet3) AT=25n
.measure tran Outn_val  FIND V(cnet5) AT=25n
.end
"""
    with open('/tmp/sar_comp.spice', 'w') as f:
        f.write(spice)
    result = subprocess.run(['ngspice', '-b', '/tmp/sar_comp.spice'],
                           capture_output=True, text=True)

    vdac_m = re.search(r'vdac_val\s*=\s*([\d.e+\-]+)', result.stdout, re.IGNORECASE)
    outp_m = re.search(r'outp_val\s*=\s*([\d.e+\-]+)', result.stdout, re.IGNORECASE)
    outn_m = re.search(r'outn_val\s*=\s*([\d.e+\-]+)', result.stdout, re.IGNORECASE)

    if not (vdac_m and outp_m and outn_m):
        print("ERROR"); print(result.stderr[-200:]); return None, None

    vdac = float(vdac_m.group(1))
    outp = float(outp_m.group(1))
    outn = float(outn_m.group(1))
    comp_out = 1 if outp > outn else 0
    return vdac, comp_out

def sar_adc_convert_real(vin, vref=1.8):
    print(f"\n=== SAR ADC (Real Comp): Vin={vin:.4f}V ===")
    expected = int(vin / vref * 16)
    print(f"Expected = {expected:04b} ({expected})")

    confirmed = [1, 1, 1, 1]

    for step in range(4):
        trial = confirmed.copy()
        trial[step] = 0
        vdac, comp = sim_cdac_comp(trial, vin)
        if vdac is None:
            return None

        confirmed[step] = 0 if comp else 1
        print(f"Step {step+1}: B{3-step} | Vdac={vdac:.4f}V | {'→0' if comp else '→1'} | bits={''.join(map(str,confirmed))}")

    digital = confirmed[0]*8 + confirmed[1]*4 + confirmed[2]*2 + confirmed[3]
    vrecon = digital / 16 * vref
    print(f"Result: {''.join(map(str,confirmed))} ({digital}) → {vrecon:.4f}V | Error: {abs(vin-vrecon)*1000:.2f}mV")
    return digital

sar_adc_convert_real(0.5625)
sar_adc_convert_real(0.9)
sar_adc_convert_real(1.2)

print("\n=== Full DNL/INL with Real Comparator ===")
vref = 1.8
lsb = vref / 16

results = []
for code in range(1, 16):
    vin = code * lsb
    result = sar_adc_convert_real(vin)
    results.append((code, vin, result))

print(f"\n{'Code':>5} {'Vin(V)':>8} {'Out':>5} {'DNL(LSB)':>10} {'INL(LSB)':>10}")
print("-" * 45)
inl = 0
dnl_list = []
inl_list = []
for code, vin, out in results:
    if out is None:
        continue
    dnl = out - code
    inl += dnl
    dnl_list.append(dnl)
    inl_list.append(inl)
    print(f"{code:>5} {vin:>8.4f} {out:>5} {dnl:>10.3f} {inl:>10.3f}")

print(f"\nMax DNL: {max(dnl_list):.3f} LSB")
print(f"Min DNL: {min(dnl_list):.3f} LSB")
print(f"Max INL: {max(inl_list):.3f} LSB")
print(f"Min INL: {min(inl_list):.3f} LSB")

print("\n=== Full DNL/INL with Real Comparator ===")
vref = 1.8
lsb = vref / 16

results = []
for code in range(1, 16):
    vin = code * lsb
    result = sar_adc_convert_real(vin)
    results.append((code, vin, result))

print(f"\n{'Code':>5} {'Vin(V)':>8} {'Out':>5} {'DNL(LSB)':>10} {'INL(LSB)':>10}")
print("-" * 45)
inl = 0
dnl_list = []
inl_list = []
for code, vin, out in results:
    if out is None:
        continue
    dnl = out - code
    inl += dnl
    dnl_list.append(dnl)
    inl_list.append(inl)
    print(f"{code:>5} {vin:>8.4f} {out:>5} {dnl:>10.3f} {inl:>10.3f}")

print(f"\nMax DNL: {max(dnl_list):.3f} LSB")
print(f"Min DNL: {min(dnl_list):.3f} LSB")
print(f"Max INL: {max(inl_list):.3f} LSB")
print(f"Min INL: {min(inl_list):.3f} LSB")
