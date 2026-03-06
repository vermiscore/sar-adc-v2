import sys
sys.path.insert(0, '/home/user/Desktop/myfolder/research/２/sar-adc-v2/sar_logic')
from sar_adc_cosim_real import sim_cdac_comp

# Vdac = 0.9V固定（bits=[1,0,0,0]でVdac≒0.9Vになる）
# Vin2をVdac付近でスイープして反転点を探す

print("=== Comparator Offset Measurement ===")
print("Vdac固定, Vin2をスイープして反転点を探す\n")

bits = [1, 0, 0, 0]  # Vdac ≈ 0.9V

results = []
for delta_mv in range(-100, 101, 10):  # -100mV〜+100mV, 10mV刻み
    vin2 = 0.9 + delta_mv * 0.001
    vdac, comp = sim_cdac_comp(bits, vin2)
    if vdac is None:
        continue
    results.append((delta_mv, vin2, vdac, comp))
    print(f"ΔV={delta_mv:+5d}mV | Vin2={vin2:.4f}V | Vdac={vdac:.4f}V | comp={comp}")

# 反転点を検出
print("\n=== 反転点 ===")
for i in range(len(results)-1):
    if results[i][3] != results[i+1][3]:
        dv1, dv2 = results[i][0], results[i+1][0]
        print(f"反転: ΔV={dv1}mV〜{dv2}mV の間")
        print(f"オフセット ≈ {(dv1+dv2)/2:.1f}mV")
