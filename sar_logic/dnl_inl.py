vref = 1.8
lsb = vref / 16

def sim_cdac_fast(bits):
    weights = [8, 4, 2, 1]
    total_cap = 16
    charge = sum(w * b for w, b in zip(weights, bits))
    return charge / total_cap * vref

def sar_convert(vin):
    confirmed = [1, 1, 1, 1]
    for step in range(4):
        trial = confirmed.copy()
        trial[step] = 0
        vdac = sim_cdac_fast(trial)
        comp = 1 if vdac >= vin else 0
        confirmed[step] = 0 if comp else 1
    return confirmed[0]*8 + confirmed[1]*4 + confirmed[2]*2 + confirmed[3]

def find_transition(code, tol=1e-9):
    lo = (code - 1) * lsb
    hi = (code + 1) * lsb
    for _ in range(60):
        mid = (lo + hi) / 2
        if sar_convert(mid) >= code:
            hi = mid
        else:
            lo = mid
        if hi - lo < tol:
            break
    return (lo + hi) / 2

print("=== DNL/INL Measurement (Ideal CDAC + Ideal Comparator) ===")
print(f"Vref={vref}V, 4-bit, 1LSB={lsb*1000:.2f}mV\n")

transitions = {}
for code in range(1, 16):
    t = find_transition(code)
    transitions[code] = t
    ideal = code * lsb
    err = (t - ideal) * 1000
    print(f"T[{code:>2}] = {t:.9f}V  (ideal={ideal:.4f}V, error={err:+.6f}mV)")

print(f"\n{'Code':>5} {'Width(mV)':>10} {'DNL(LSB)':>10} {'INL(LSB)':>10}")
print("-" * 45)

dnl_list = []
inl_list = []
inl = 0.0

for code in range(1, 15):
    width = transitions[code + 1] - transitions[code]
    dnl = width / lsb - 1.0
    inl += dnl
    dnl_list.append(dnl)
    inl_list.append(inl)
    print(f"{code:>5} {width*1000:>10.6f} {dnl:>10.6f} {inl:>10.6f}")

print(f"\nMax DNL: {max(dnl_list):.6f} LSB, Min DNL: {min(dnl_list):.6f} LSB")
print(f"Max INL: {max(inl_list):.6f} LSB, Min INL: {min(inl_list):.6f} LSB")
