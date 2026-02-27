import subprocess
import re
import sys
sys.path.insert(0, '/home/user/Desktop/myfolder/research/1/sar_logic')
from sar_adc_cosim import sar_adc_convert

vref = 1.8
lsb = vref / 16  # 1LSB = 0.1125V

print("=== DNL/INL Measurement ===")
print(f"Vref={vref}V, 4-bit, 1LSB={lsb*1000:.2f}mV\n")

# 全16コードの遷移電圧を測定
# 各コードnの遷移点: Vin = n * LSB
transition = []
for code in range(1, 16):
    vin = code * lsb
    result = sar_adc_convert(vin)
    transition.append((code, vin, result))

# DNL/INL計算
print("\n=== DNL / INL ===")
print(f"{'Code':>5} {'Vin(V)':>8} {'Out':>5} {'DNL(LSB)':>10} {'INL(LSB)':>10}")
print("-" * 45)

dnl_list = []
inl_list = []
inl = 0

for code, vin, out in transition:
    # 実際の遷移点
    actual = out * lsb
    ideal  = code * lsb
    dnl = (actual - ideal) / lsb
    inl += dnl
    dnl_list.append(dnl)
    inl_list.append(inl)
    print(f"{code:>5} {vin:>8.4f} {out:>5} {dnl:>10.3f} {inl:>10.3f}")

print(f"\nMax DNL: {max(dnl_list):.3f} LSB, Min DNL: {min(dnl_list):.3f} LSB")
print(f"Max INL: {max(inl_list):.3f} LSB, Min INL: {min(inl_list):.3f} LSB")
