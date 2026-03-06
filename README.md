# SPICE Project: Charge-Domain SRAM CIM — Sky130

## Prerequisites

1. **Sky130 PDK** installed. Verify:
   ```bash
   ls /home/user/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice
   ```
   If your PDK is elsewhere, edit the `.lib` path in each testbench.

2. **Ngspice** (>= 37 recommended):
   ```bash
   ngspice --version
   ```

3. **Xschem** (for schematic entry later):
   ```bash
   xschem --version
   ```

## File Structure

```
spice/
├── README.md                    ← This file
├── mac_cell_sky130.spice        ← Cell library: 8T SRAM + MAC unit + 4-cell column
├── tb_mac_column.spice          ← TB1: Functional verification (write + compute)
├── tb_mac_monte_carlo.spice     ← TB2: Monte Carlo cap mismatch analysis
└── tb_mac_temp_corners.spice    ← TB3: Temperature corner sweep
```

## Quick Start

### Step 1: Verify PDK path
Open each `.spice` file and check the `.lib` line matches your sky130 installation:
```spice
.lib "/home/user/pdk/sky130A/libs.tech/ngspice/sky130.lib.spice" tt
```

### Step 2: Functional test
```bash
cd spice/
ngspice tb_mac_column.spice
```
**Expected:** 
- Q0=Q1=Q3 ≈ 1.8V (weight=1), Q2 ≈ 0V (weight=0)
- BL_MAC drops from 1.8V; final voltage depends on charge sharing ratio

### Step 3: Monte Carlo mismatch
```bash
ngspice tb_mac_monte_carlo.spice
```
**Expected:**
- 200 MC runs with cap mismatch σ=0.45%
- Reports mean, std, min, max of BL_MAC voltage
- Spread should be small (~mV) for 4 cells; will grow with array size

### Step 4: Temperature corners
```bash
ngspice tb_mac_temp_corners.spice
```
**Expected:**
- BL_MAC voltage at -40°C to 125°C
- Shows how much MAC output drifts with temperature
- If drift > 1 ADC LSB → factory calibration insufficient

## Architecture Notes

### MAC Operation
```
         VDD
          |
       [PRE]──── BL_MAC (precharged to VDD)
                    |
    Cell 0: ──[IN_gate]──[WT_gate]──[C_unit]── VSS
    Cell 1: ──[IN_gate]──[WT_gate]──[C_unit]── VSS
    Cell 2: ──[IN_gate]──[WT_gate]──[C_unit]── VSS
    Cell 3: ──[IN_gate]──[WT_gate]──[C_unit]── VSS

    V_BL_MAC = VDD × C_BL / (C_BL + Σ(w_i × x_i × C_unit_i))
```

### Key Parameters to Tune
| Parameter | Current | Range to Explore |
|-----------|---------|-----------------|
| C_unit    | 50 fF (5×5 μm MIM) | 10-100 fF |
| C_BL      | 30 fF   | 20-100 fF (scales with array size) |
| NMOS W    | 0.64 μm | 0.42-1.0 μm (affects Ron, charge injection) |
| Array size| 4 cells | 4, 8, 16, 32, 64, 128 |

## Next Steps

1. **Run TB1-TB3** and verify basic functionality
2. **Scale to 8/16 cells** — increase array, observe error growth
3. **Add calibration circuit** — comparator + trim cap per column
4. **Xschem schematic** — draw cells for layout-aware design
5. **Post-layout extraction** — compare pre/post-layout MAC accuracy

## Common Issues

- **Convergence failure:** Increase `.tran` step (e.g., 0.5n) or add `.option reltol=0.003`
- **SRAM not latching:** Ensure write WL is long enough (>2ns) and BL/BLB are driven rail-to-rail
- **BL_MAC not settling:** Increase evaluate time or reduce pass gate Ron (wider NMOS)
