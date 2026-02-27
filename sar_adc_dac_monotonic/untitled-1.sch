v {xschem version=3.4.4 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 40 -100 40 -20 {
lab=Vref}
N 190 -100 190 -20 {
lab=Vref}
N 360 -100 360 -20 {
lab=Vref}
N 520 -100 520 -20 {
lab=Vref}
N 40 10 80 10 {
lab=gnd}
N 190 10 240 10 {
lab=gnd}
N 360 10 420 10 {
lab=gnd}
N 520 10 570 10 {
lab=gnd}
N 40 -230 40 -160 {
lab=Vout}
N 40 -230 510 -230 {
lab=Vout}
N 510 -230 520 -230 {
lab=Vout}
N 520 -230 520 -160 {
lab=Vout}
N 360 -230 360 -160 {
lab=Vout}
N 190 -230 190 -160 {
lab=Vout}
N 520 -330 520 -230 {
lab=Vout}
C {sky130_fd_pr/nfet_01v8.sym} 20 10 0 0 {name=M1
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
C {sky130_fd_pr/nfet_01v8.sym} 170 10 0 0 {name=M2
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
C {sky130_fd_pr/nfet_01v8.sym} 340 10 0 0 {name=M3
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
C {sky130_fd_pr/nfet_01v8.sym} 500 10 0 0 {name=M4
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
C {capa.sym} 40 -130 0 0 {name=C1
m=1
value=1f
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 190 -130 0 0 {name=C2
m=1
value=2f
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 360 -130 0 0 {name=C3
m=1
value=4f
footprint=1206
device="ceramic capacitor"}
C {capa.sym} 520 -130 0 0 {name=C4
m=1
value=8f
footprint=1206
device="ceramic capacitor"}
C {lab_pin.sym} 20 180 2 0 {name=p1 sig_type=std_logic lab=Vout}
C {lab_pin.sym} 80 10 2 0 {name=p2 sig_type=std_logic lab=gnd}
C {lab_pin.sym} 240 10 2 0 {name=p3 sig_type=std_logic lab=gnd}
C {lab_pin.sym} 420 10 2 0 {name=p4 sig_type=std_logic lab=gnd}
C {lab_pin.sym} 570 10 2 0 {name=p5 sig_type=std_logic lab=gnd}
C {lab_pin.sym} 40 40 3 0 {name=p6 sig_type=std_logic lab=gnd}
C {lab_pin.sym} 190 40 3 0 {name=p7 sig_type=std_logic lab=gnd}
C {lab_pin.sym} 360 40 3 0 {name=p8 sig_type=std_logic lab=gnd}
C {lab_pin.sym} 520 40 3 0 {name=p9 sig_type=std_logic lab=gnd}
C {lab_pin.sym} 0 10 3 0 {name=p10 sig_type=std_logic lab=b0}
C {lab_pin.sym} 150 10 3 0 {name=p11 sig_type=std_logic lab=b1}
C {lab_pin.sym} 320 10 3 0 {name=p12 sig_type=std_logic lab=b2}
C {lab_pin.sym} 480 10 3 0 {name=p13 sig_type=std_logic lab=b3}
C {vsource.sym} -350 -170 0 0 {name=V_b0 value="PULSE(0 1.8 0 100p 100p 5n 10n)" savecurrent=false}
C {vsource.sym} -280 -170 0 0 {name=V_b1 value="PULSE(0 1.8 0 100p 100p 5n 10n)" savecurrent=false}
C {vsource.sym} -210 -170 0 0 {name=V_b2 value="PULSE(0 1.8 0 100p 100p 5n 10n)" savecurrent=false}
C {vsource.sym} -140 -170 0 0 {name=V_b3 value="PULSE(0 1.8 0 100p 100p 5n 10n)" savecurrent=false}
C {lab_pin.sym} -350 -140 3 0 {name=p14 sig_type=std_logic lab=gnd}
C {lab_pin.sym} -280 -140 3 0 {name=p15 sig_type=std_logic lab=gnd}
C {lab_pin.sym} -210 -140 3 0 {name=p16 sig_type=std_logic lab=gnd}
C {lab_pin.sym} -140 -140 3 0 {name=p17 sig_type=std_logic lab=gnd}
C {lab_pin.sym} -350 -200 0 0 {name=p18 sig_type=std_logic lab=b0}
C {lab_pin.sym} -280 -200 0 0 {name=p19 sig_type=std_logic lab=b1}
C {lab_pin.sym} -210 -200 0 0 {name=p20 sig_type=std_logic lab=b2}
C {lab_pin.sym} -140 -200 0 0 {name=p21 sig_type=std_logic lab=b3}
C {lab_pin.sym} 40 -60 0 0 {name=p22 sig_type=std_logic lab=Vref}
C {lab_pin.sym} 520 -330 2 0 {name=p26 sig_type=std_logic lab=Vout}
C {vsource.sym} -350 -40 0 0 {name=V5 value=1.8 savecurrent=false}
C {lab_pin.sym} -350 -10 3 0 {name=p27 sig_type=std_logic lab=gnd}
C {lab_pin.sym} -350 -70 0 0 {name=p28 sig_type=std_logic lab=Vref}
C {code_shown.sym} -370 200 0 0 {name=s1 only_toplevel=false value=".tran 10p 100n
.lib /home/user/.volare/volare/sky130/versions/0fe599b2afb6708d281543108caf8310912f54af/sky130A/libs.tech/ngspice/sky130.lib.spice tt"}
C {lab_pin.sym} 190 -60 0 0 {name=p23 sig_type=std_logic lab=Vref}
C {lab_pin.sym} 360 -60 0 0 {name=p24 sig_type=std_logic lab=Vref}
C {lab_pin.sym} 520 -60 0 0 {name=p25 sig_type=std_logic lab=Vref}
