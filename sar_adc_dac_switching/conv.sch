v {xschem version=3.4.4 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N -170 50 -170 120 {
lab=#net1}
N -170 -80 -170 -10 {
lab=Vout}
N 400 -220 400 -80 {
lab=Vout}
N 400 -220 500 -220 {
lab=Vout}
N -230 120 -130 120 {
lab=#net1}
N 30 50 30 120 {
lab=#net2}
N 30 -80 30 -10 {
lab=Vout}
N -30 120 70 120 {
lab=#net2}
N 260 50 260 120 {
lab=#net3}
N 260 -80 260 -10 {
lab=Vout}
N 200 120 300 120 {
lab=#net3}
N 500 50 500 120 {
lab=#net4}
N 500 -80 500 -10 {
lab=Vout}
N 440 120 540 120 {
lab=#net4}
N -170 -80 500 -80 {
lab=Vout}
N -230 150 -210 150 {
lab=gnd}
N -130 150 -110 150 {
lab=gnd}
N -30 150 -10 150 {
lab=gnd}
N 70 150 90 150 {
lab=gnd}
N 200 150 230 150 {
lab=gnd}
N 300 150 330 150 {
lab=gnd}
N 440 150 460 150 {
lab=gnd}
N 540 150 560 150 {
lab=gnd}
C {capa.sym} -170 20 0 0 {name=C1
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {sky130_fd_pr/nfet_01v8.sym} -250 150 0 0 {name=M1
W=1
L=0.15
nf=1 
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {lab_pin.sym} -10 360 0 0 {name=p1 sig_type=std_logic lab=xxx}
C {lab_pin.sym} -270 150 3 0 {name=p2 sig_type=std_logic lab=b0}
C {lab_pin.sym} -180 310 3 0 {name=p4 sig_type=std_logic lab=xxx}
C {lab_pin.sym} -320 420 1 0 {name=p10 sig_type=std_logic lab=xxx}
C {sky130_fd_pr/nfet_01v8.sym} -150 150 0 0 {name=M5
W=1
L=0.15
nf=1 
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {capa.sym} 30 20 0 0 {name=C5
m=1
value=2f
footprint=1206
device="ceramic capacitor"}
C {sky130_fd_pr/nfet_01v8.sym} -50 150 0 0 {name=M6
W=1
L=0.15
nf=1 
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {lab_pin.sym} -70 150 3 0 {name=p11 sig_type=std_logic lab=b1}
C {sky130_fd_pr/nfet_01v8.sym} 50 150 0 0 {name=M7
W=1
L=0.15
nf=1 
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {capa.sym} 260 20 0 0 {name=C2
m=1
value=4f
footprint=1206
device="ceramic capacitor"}
C {sky130_fd_pr/nfet_01v8.sym} 180 150 0 0 {name=M2
W=1
L=0.15
nf=1 
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {lab_pin.sym} 160 150 3 0 {name=p3 sig_type=std_logic lab=b2}
C {sky130_fd_pr/nfet_01v8.sym} 280 150 0 0 {name=M3
W=1
L=0.15
nf=1 
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {capa.sym} 500 20 0 0 {name=C3
m=1
value=8f
footprint=1206
device="ceramic capacitor"}
C {sky130_fd_pr/nfet_01v8.sym} 420 150 0 0 {name=M4
W=1
L=0.15
nf=1 
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {lab_pin.sym} 400 150 3 0 {name=p7 sig_type=std_logic lab=b3}
C {sky130_fd_pr/nfet_01v8.sym} 520 150 0 0 {name=M8
W=1
L=0.15
nf=1 
mult=1
ad="'int((nf+1)/2) * W/nf * 0.29'" 
pd="'2*int((nf+1)/2) * (W/nf + 0.29)'"
as="'int((nf+2)/2) * W/nf * 0.29'" 
ps="'2*int((nf+2)/2) * (W/nf + 0.29)'"
nrd="'0.29 / W'" nrs="'0.29 / W'"
sa=0 sb=0 sd=0
model=nfet_01v8
spiceprefix=X
}
C {lab_pin.sym} -170 150 3 0 {name=p15 sig_type=std_logic lab=b0_bar}
C {lab_pin.sym} 30 150 3 0 {name=p17 sig_type=std_logic lab=b1_bar}
C {lab_pin.sym} 260 150 3 0 {name=p18 sig_type=std_logic lab=b2_bar}
C {lab_pin.sym} 500 150 3 0 {name=p19 sig_type=std_logic lab=b3_bar}
C {lab_pin.sym} -130 310 3 0 {name=p20 sig_type=std_logic lab=Vref}
C {lab_pin.sym} -130 180 3 0 {name=p21 sig_type=std_logic lab=gnd}
C {lab_pin.sym} 70 180 3 0 {name=p22 sig_type=std_logic lab=gnd}
C {lab_pin.sym} 300 180 3 0 {name=p23 sig_type=std_logic lab=gnd}
C {lab_pin.sym} 540 180 3 0 {name=p24 sig_type=std_logic lab=gnd}
C {lab_pin.sym} -230 180 3 0 {name=p25 sig_type=std_logic lab=Vref}
C {lab_pin.sym} -30 180 3 0 {name=p26 sig_type=std_logic lab=Vref}
C {lab_pin.sym} 200 180 3 0 {name=p27 sig_type=std_logic lab=Vref}
C {lab_pin.sym} 440 180 3 0 {name=p28 sig_type=std_logic lab=Vref}
C {lab_pin.sym} 500 -220 2 0 {name=p29 sig_type=std_logic lab=Vout}
C {vsource.sym} -570 0 0 0 {name=Vref value=1.8 savecurrent=false}
C {vsource.sym} -480 0 0 0 {name=Vdd value=1.8 savecurrent=false}
C {vsource.sym} -400 0 0 0 {name=V_b0 value="PULSE(0 1.8 0 100p 100p 5n 10n)" savecurrent=false}
C {vsource.sym} -570 130 0 0 {name=V_b1 value="PULSE(0 1.8 0 100p 100p 5n 10n)" savecurrent=false}
C {vsource.sym} -480 130 0 0 {name=V_b2 value="PULSE(0 1.8 0 100p 100p 5n 10n)" savecurrent=false}
C {vsource.sym} -400 130 0 0 {name=V_b3 value="PULSE(0 1.8 0 100p 100p 5n 10n)" savecurrent=false}
C {code_shown.sym} -560 460 0 0 {name=s1 only_toplevel=false 
value=".tran 10p 100n
.lib /home/user/.volare/volare/sky130/versions/0fe599b2afb6708d281543108caf8310912f54af/sky130A/libs.tech/ngspice/sky130.lib.spice tt"}
C {vsource.sym} -570 250 0 0 {name=V_b0_bar value="PULSE(1.8 0 0 100p 100p 5n 10n)" savecurrent=false}
C {vsource.sym} -480 250 0 0 {name=V_b1_bar value="PULSE(1.8 0 0 100p 100p 5n 10n)" savecurrent=false}
C {vsource.sym} -400 250 0 0 {name=V_b2_bar value="PULSE(1.8 0 0 100p 100p 5n 10n)" savecurrent=false}
C {vsource.sym} -570 370 0 0 {name=V_b3_bar value="PULSE(1.8 0 0 100p 100p 5n 10n)" savecurrent=false}
C {lab_pin.sym} -210 150 2 0 {name=p5 sig_type=std_logic lab=gnd}
C {lab_pin.sym} -110 150 2 0 {name=p6 sig_type=std_logic lab=gnd}
C {lab_pin.sym} -10 150 2 0 {name=p8 sig_type=std_logic lab=gnd}
C {lab_pin.sym} 90 150 2 0 {name=p9 sig_type=std_logic lab=gnd}
C {lab_pin.sym} 230 150 2 0 {name=p12 sig_type=std_logic lab=gnd}
C {lab_pin.sym} 330 150 2 0 {name=p14 sig_type=std_logic lab=gnd}
C {lab_pin.sym} 460 150 2 0 {name=p16 sig_type=std_logic lab=gnd}
C {lab_pin.sym} 560 150 2 0 {name=p30 sig_type=std_logic lab=gnd}
C {lab_pin.sym} -570 -30 1 0 {name=p13 sig_type=std_logic lab=Vref}
C {lab_pin.sym} -480 -30 1 0 {name=p31 sig_type=std_logic lab=Vdd}
C {lab_pin.sym} -400 -30 1 0 {name=p32 sig_type=std_logic lab=b0}
C {lab_pin.sym} -570 100 1 0 {name=p33 sig_type=std_logic lab=b1}
C {lab_pin.sym} -480 100 1 0 {name=p34 sig_type=std_logic lab=b2}
C {lab_pin.sym} -400 100 1 0 {name=p35 sig_type=std_logic lab=b3}
C {lab_pin.sym} -570 220 1 0 {name=p36 sig_type=std_logic lab=b0_bar}
C {lab_pin.sym} -480 220 1 0 {name=p37 sig_type=std_logic lab=b1_bar}
C {lab_pin.sym} -400 220 1 0 {name=p38 sig_type=std_logic lab=b2_bar}
C {lab_pin.sym} -570 340 1 0 {name=p39 sig_type=std_logic lab=b3_bar}
C {lab_pin.sym} -570 30 0 0 {name=p40 sig_type=std_logic lab=gnd}
C {lab_pin.sym} -480 30 0 0 {name=p41 sig_type=std_logic lab=gnd}
C {lab_pin.sym} -400 30 0 0 {name=p42 sig_type=std_logic lab=gnd}
C {lab_pin.sym} -570 160 0 0 {name=p43 sig_type=std_logic lab=gnd}
C {lab_pin.sym} -480 160 0 0 {name=p44 sig_type=std_logic lab=gnd}
C {lab_pin.sym} -400 160 0 0 {name=p45 sig_type=std_logic lab=gnd}
C {lab_pin.sym} -570 280 0 0 {name=p46 sig_type=std_logic lab=gnd}
C {lab_pin.sym} -480 280 0 0 {name=p47 sig_type=std_logic lab=gnd}
C {lab_pin.sym} -400 280 0 0 {name=p48 sig_type=std_logic lab=gnd}
C {lab_pin.sym} -570 400 0 0 {name=p49 sig_type=std_logic lab=gnd}
