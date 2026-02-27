# Comparison of CDAC Switching Schemes for Low-Power SAR ADC
### Simulation Study using Sky130 PDK

---

## Abstract

This report presents a simulation-based comparison of two capacitive DAC (CDAC) switching schemes for Successive Approximation Register (SAR) analog-to-digital converters (ADCs): the conventional switching scheme and the monotonic switching scheme. Simulations were performed using ngspice with the SkyWater 130nm (Sky130) open-source PDK. Results show that the monotonic switching scheme achieves approximately **80% reduction in switching energy** compared to the conventional scheme, which is consistent with previously published results.

---

## 1. Introduction

SAR ADCs are widely used in low-power applications such as biomedical devices and IoT sensors due to their energy-efficient architecture and relatively simple implementation. The capacitive DAC (CDAC) is one of the primary sources of power consumption in a SAR ADC, and reducing its switching energy is a key research topic.

The conventional switching scheme requires both upward (GND → VDD) and downward (VDD → GND) transitions during the binary search conversion process, resulting in significant energy dissipation. The monotonic switching scheme, first proposed by Liu et al. [1], eliminates upward transitions entirely, reducing switching energy by approximately 81%.

This study implements and compares both schemes using the Sky130 PDK in a 4-bit CDAC, measuring switching energy through SPICE simulation.

---

## 2. Circuit Design

### 2.1 SAR ADC Overview

A SAR ADC consists of three main components:

- **Comparator**: Compares the input voltage with the DAC output
- **CDAC**: Generates the reference voltage through binary-weighted capacitors
- **SAR Logic**: Controls the switching sequence based on comparator output

In this study, the focus is on the CDAC switching schemes. A StrongARM latch comparator was also designed and simulated separately.

### 2.2 Capacitor Array

Both schemes use a 4-bit binary-weighted capacitor array:

```
C_total = C8 + C4 + C2 + C1 + C1(dummy) = 16C
Unit capacitor = 1fF
```

| Bit | Capacitance |
|-----|------------|
| B3 (MSB) | 8fF |
| B2 | 4fF |
| B1 | 2fF |
| B0 (LSB) | 1fF |
| Dummy | 1fF |

### 2.3 Conventional Switching Scheme

The conventional scheme uses two NMOS transistors per capacitor bit, switching the bottom plate between Vref (1.8V) and GND.

**Circuit topology (per bit):**
```
        Vout (top plate)
          |
         Cap
          |
    ┌─────┴─────┐
NMOS(gate=b)  NMOS(gate=b_bar)
    |               |
   Vref            GND
```

**Switching sequence (example: input = 0101):**
```
Initial:  All caps → GND,  Vout = 0V
Step 1:   B3 → Vref,       Vout rises  (MSB trial)
Step 2:   B3 → GND (miss), Vout falls
Step 3:   B2 → Vref,       Vout rises
...
```

**Key characteristics:**
- Both upward and downward transitions occur
- Uses NMOS only (simpler fabrication)
- Higher switching energy due to charge/discharge cycles

### 2.4 Monotonic Switching Scheme

The monotonic scheme uses one PMOS + one NMOS per bit. All capacitors start connected to VDD, and are switched to GND one by one during conversion.

**Circuit topology (per bit):**
```
        Vout (top plate)
          |
         Cap
          |
    ┌─────┴─────┐
PMOS(gate=b_p) NMOS(gate=b_n)
    |               |
   VDD             GND
```

**Switching sequence (all bits → 0, worst case):**
```
Initial:  All caps → VDD,  Vout = 1.8V  (.ic condition)
t=20ns:   B3(8C) → GND,   Vout ≈ 0.79V
t=40ns:   B2(4C) → GND,   Vout ≈ 0.34V
t=60ns:   B1(2C) → GND,   Vout ≈ 0.11V
t=80ns:   B0(1C) → GND,   Vout ≈ 0.00V
```

**Key characteristics:**
- Only downward (monotonic) transitions
- No upward switching → no reset energy
- Uses PMOS + NMOS (slightly more complex)
- Significantly lower switching energy

---

## 3. Implementation

### 3.1 Tools and Environment

| Item | Details |
|------|---------|
| Simulator | ngspice |
| Schematic | Xschem 3.4.4 |
| PDK | SkyWater Sky130 (tt corner) |
| Supply Voltage | 1.8V |
| Resolution | 4-bit |
| Unit Capacitor | 1fF |

### 3.2 MOSFET Parameters (Sky130)

**NMOS (sky130_fd_pr__nfet_01v8):**
```
W = 1μm, L = 0.15μm
Source = GND, Drain = switch node, Bulk = GND
```

**PMOS (sky130_fd_pr__pfet_01v8):**
```
W = 2μm, L = 0.15μm
Source = VDD, Drain = switch node, Bulk = VDD
```

### 3.3 Control Signals

**Conventional:**
```spice
V_b0 b0 gnd PULSE(0 1.8 0 100p 100p 5n 10n)
V_b0_bar b0_bar gnd PULSE(1.8 0 0 100p 100p 5n 10n)
```

**Monotonic:**
```spice
V_b3_p b3_p gnd PWL(0 0 19.9n 0 20n 1.8)  * PMOS gate: 0→1.8V (turn OFF)
V_b3_n b3_n gnd PWL(0 0 19.9n 0 20n 1.8)  * NMOS gate: 0→1.8V (turn ON)
```

---

## 4. Simulation Results

### 4.1 Transient Waveforms

**Conventional DAC Output (Vout):**

![Conventional DAC waveform](images/conventional_waveform.png)
*Fig. 1: Conventional switching DAC output voltage. Vout transitions between 0V and Vref as bits are switched.*

**Monotonic DAC Output (Vout):**

![Monotonic DAC waveform](images/monotonic_waveform.png)
*Fig. 2: Monotonic switching DAC output voltage. Vout decreases monotonically from 1.8V to 0V in 4 steps.*

### 4.2 Step Voltages (Monotonic)

| Event | Expected Vout | Simulated Vout |
|-------|--------------|----------------|
| Initial (all VDD) | 1.800V | 1.800V |
| B3(8C) → GND | 0.788V | ≈ 0.79V |
| B2(4C) → GND | 0.338V | ≈ 0.34V |
| B1(2C) → GND | 0.113V | ≈ 0.15V |
| B0(1C) → GND | 0.000V | ≈ 0.00V |

### 4.3 Energy Measurement

Switching energy was measured using ngspice:

```spice
let E_total = integ(V(vdd)*(-I(Vvdd)))
print E_total[last_index]
```

| Scheme | Switching Energy | Reduction vs Conventional |
|--------|-----------------|--------------------------|
| Conventional | 16.5 fJ | — |
| Monotonic | 3.37 fJ | **79.6%** |

### 4.4 Comparison with Published Results

| Reference | Technology | Reduction |
|-----------|-----------|-----------|
| Liu et al. [1] (2010) | 0.13μm CMOS | 81% |
| **This work** | **Sky130 (0.13μm)** | **~80%** |

The simulation results are in good agreement with the published value of 81% energy reduction.

---

## 5. Discussion

### 5.1 Why Monotonic Switching Saves Energy

In the conventional scheme, each MSB trial that fails requires the capacitor to be discharged back to GND, wasting the energy used to charge it. This charge/discharge cycle repeats for every incorrect bit decision.

The monotonic scheme avoids this by:
1. Pre-charging all capacitors to VDD at the start (sampling phase)
2. Only switching downward (VDD → GND) — never upward
3. Eliminating reset energy entirely

### 5.2 Trade-offs

| Factor | Conventional | Monotonic |
|--------|-------------|-----------|
| Switching energy | High (16.5fJ) | Low (3.37fJ) |
| Transistors per bit | 2 × NMOS | 1 × PMOS + 1 × NMOS |
| Circuit complexity | Simple | Slightly more complex |
| Common-mode shift | Small | Large (converges to GND) |
| Reference voltage | Vref needed | VDD only |

### 5.3 Limitations of This Study

- Only worst-case (all bits = 0) was measured; average energy over all codes was not computed
- 4-bit resolution only; higher resolution would show larger absolute energy differences
- Parasitic capacitances from routing were not included

---

## 6. Conclusion

This study implemented and compared conventional and monotonic CDAC switching schemes for a 4-bit SAR ADC using the Sky130 130nm PDK. The simulation results confirm that the monotonic switching scheme achieves approximately **80% reduction in switching energy** (from 16.5fJ to 3.37fJ), consistent with the theoretical value of 81% reported by Liu et al.

The monotonic scheme achieves this reduction by eliminating all upward capacitor transitions, at the cost of slightly increased circuit complexity (requiring one PMOS per bit instead of one NMOS).

---

## References

[1] C. C. Liu, S. J. Chang, G. Y. Huang, and Y. Z. Lin, "A 10-bit 50-MS/s SAR ADC with a monotonic capacitor switching procedure," *IEEE Journal of Solid-State Circuits*, vol. 45, no. 4, pp. 731–740, Apr. 2010.

[2] M. Hariprasath, J. Guerber, S. H. Lee, and U. K. Moon, "Merged capacitor switching based SAR ADC with highest switching energy-efficiency," *Electronics Letters*, vol. 46, no. 9, pp. 620–621, Apr. 2010.

---

## Appendix: SPICE Netlists

### A.1 Conventional DAC

```spice
C1 Vout net1 1f m=1
XM1 net1 b0 Vref gnd sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ...
XM5 net1 b0_bar gnd gnd sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ...
...
Vref Vref gnd 1.8
V_b0 b0 gnd PULSE(0 1.8 0 100p 100p 5n 10n)
V_b0_bar b0_bar gnd PULSE(1.8 0 0 100p 100p 5n 10n)
```

### A.2 Monotonic DAC

```spice
C1 Vout net1 1f m=1
XM1 net1 b0_p vdd vdd sky130_fd_pr__pfet_01v8 L=0.15 W=2 nf=1 ...
XM5 net1 b0_n gnd gnd sky130_fd_pr__nfet_01v8 L=0.15 W=1 nf=1 ...
...
Vdd Vdd gnd 1.8
V_b0_p b0_p gnd PWL(0 0 79.9n 0 80n 1.8)
V_b0_n b0_n gnd PWL(0 0 79.9n 0 80n 1.8)
.ic V(Vout)=1.8
```

---

## 7. SAR ADC System Integration

### 7.1 System Overview

A complete 4-bit SAR ADC was implemented by integrating:
- **CDAC**: Monotonic switching scheme (Sky130 PDK)
- **Comparator**: Ideal (Python)
- **SAR Logic**: Verilog (iverilog)
- **Co-simulation**: Python + ngspice

### 7.2 Co-simulation Method

Each conversion step is simulated independently in ngspice. Python controls the SAR algorithm and determines bit decisions based on the CDAC output voltage.
```
Python (SAR control)
  └── ngspice (CDAC analog simulation)
       └── Vdac → Python comparator → bit decision
```

### 7.3 Linearity Results

| Metric | Value |
|--------|-------|
| DNL (max) | 0.000 LSB |
| DNL (min) | 0.000 LSB |
| INL (max) | 0.000 LSB |
| INL (min) | 0.000 LSB |

All 16 codes verified with **0.00mV error** at exact transition points.

### 7.4 Full 16-code Transfer Curve

| Code | Vin (V) | Output | Error |
|------|---------|--------|-------|
| 0 | 0.0000 | 0000 | — |
| 1 | 0.1125 | 0001 | 0.00mV |
| 2 | 0.2250 | 0010 | 0.00mV |
| 3 | 0.3375 | 0011 | 0.00mV |
| 4 | 0.4500 | 0100 | 0.00mV |
| 5 | 0.5625 | 0101 | 0.00mV |
| 6 | 0.6750 | 0110 | 0.00mV |
| 7 | 0.7875 | 0111 | 0.00mV |
| 8 | 0.9000 | 1000 | 0.00mV |
| 9 | 1.0125 | 1001 | 0.00mV |
| 10 | 1.1250 | 1010 | 0.00mV |
| 11 | 1.2375 | 1011 | 0.00mV |
| 12 | 1.3500 | 1100 | 0.00mV |
| 13 | 1.4625 | 1101 | 0.00mV |
| 14 | 1.5750 | 1110 | 0.00mV |
| 15 | 1.6875 | 1111 | 0.00mV |

---

## 8. Real Comparator Integration and Limitations

### 8.1 StrongARM Latch Integration

The StrongARM latch comparator was integrated with the monotonic CDAC in the co-simulation framework. Results for mid-range inputs showed correct operation:

| Vin (V) | Expected | Output | Error |
|---------|----------|--------|-------|
| 0.5625 | 0101 (5) | 0101 (5) | 0.00mV |
| 0.9000 | 1000 (8) | 1000 (8) | 0.00mV |
| 1.2000 | 1010 (10) | 1011 (11) | 37.50mV |

### 8.2 Low-Voltage Operation Failure

DNL/INL measurement revealed severe nonlinearity at low input codes:

| Code | Vin (V) | Output | DNL (LSB) | INL (LSB) |
|------|---------|--------|-----------|-----------|
| 1 | 0.1125 | 5 | +4.000 | +4.000 |
| 2 | 0.2250 | 5 | +3.000 | +7.000 |
| 3 | 0.3375 | 5 | +2.000 | +9.000 |
| 4 | 0.4500 | 0 | -4.000 | +5.000 |
| 5–15 | 0.5625–1.6875 | Correct | 0.000 | +5.000 |

**Max DNL: +4.0 LSB, Max INL: +9.0 LSB**

### 8.3 Root Cause Analysis

The StrongARM latch requires a minimum common-mode input voltage to operate correctly. When Vdac falls below approximately 0.4V, the input NMOS pair (XM3, XM4) cannot turn on sufficiently, causing the comparator to fail.

This is a fundamental limitation of the Monotonic switching scheme combined with a StrongARM latch:
```
Monotonic switching → Vdac approaches 0V for small codes
StrongARM latch    → Requires Vcm > Vth_n ≈ 0.4V
→ Incompatibility at low input range
```

### 8.4 Implications and Future Work

This finding highlights an important design constraint:

1. **Input range limitation**: The effective input range is approximately 0.4V–1.8V, not 0V–1.8V
2. **Comparator selection**: A PMOS-input or rail-to-rail comparator would be required for full-range operation
3. **Offset voltage**: The 37.50mV error at Vin=1.2V suggests a comparator offset of approximately 0.33 LSB

These results demonstrate that the choice of switching scheme and comparator topology are tightly coupled in SAR ADC design.
