import sys
sys.path.insert(0, '/home/user/Desktop/myfolder/research/２/sar-adc-v2/sar_logic')
from sar_adc_cosim import sim_cdac

vref = 1.8
lsb = vref / 16

print("=== CDAC Accuracy Check ===")
print(f"{'Code':>5} {'Bits':>6} {'Ideal(V)':>10} {'Actual(V)':>10} {'Error(mV)':>10} {'Error(LSB)':>11}")
print("-" * 55)

for code in range(16):
    bits = [(code >> (3-i)) & 1 for i in range(4)]
    ideal = code / 16 * vref
    actual = sim_cdac(bits)
    if actual is None:
        continue
    error_mv = (actual - ideal) * 1000
    error_lsb = (actual - ideal) / lsb
    print(f"{code:>5} {''.join(map(str,bits)):>6} {ideal:>10.4f} {actual:>10.4f} {error_mv:>10.2f} {error_lsb:>11.3f}")
