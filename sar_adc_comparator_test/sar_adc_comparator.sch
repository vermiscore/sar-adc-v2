v {xschem version=3.4.4 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 70 280 70 350 {
lab=#net1}
N 70 350 300 350 {
lab=#net1}
N 300 280 300 350 {
lab=#net1}
N 190 350 190 400 {
lab=#net1}
N 300 90 300 220 {
lab=#net2}
N 300 -100 300 30 {
lab=#net3}
N 70 -230 70 -160 {
lab=Vdd}
N 70 -230 820 -230 {
lab=Vdd}
N 820 -230 830 -230 {
lab=Vdd}
N 830 -230 830 -160 {
lab=Vdd}
N -460 -230 70 -230 {
lab=Vdd}
N -460 -230 -460 -160 {
lab=Vdd}
N -230 -230 -230 -160 {
lab=Vdd}
N 300 -230 300 -160 {
lab=Vdd}
N 600 -230 600 -160 {
lab=Vdd}
N 70 90 70 220 {
lab=#net4}
N 70 -100 70 30 {
lab=#net5}
N 190 520 970 520 {
lab=clk}
N 970 -40 970 520 {
lab=clk}
N 870 -130 970 -130 {
lab=clk}
N 970 -130 970 -40 {
lab=clk}
N -10 520 190 520 {
lab=clk}
N 100 430 150 430 {
lab=clk}
N 100 430 100 520 {
lab=clk}
N -320 -130 -270 -130 {
lab=clk}
N -320 -130 -320 490 {
lab=clk}
N -320 520 -10 520 {
lab=clk}
N -320 490 -320 520 {
lab=clk}
N -460 -100 -460 150 {
lab=#net4}
N -460 150 70 150 {
lab=#net4}
N -550 -130 -500 -130 {
lab=clk}
N -550 -130 -550 240 {
lab=clk}
N -550 240 -320 240 {
lab=clk}
N 110 -130 140 -130 {
lab=#net3}
N 140 -130 140 50 {
lab=#net3}
N 140 50 140 60 {
lab=#net3}
N 110 60 140 60 {
lab=#net3}
N 230 -130 260 -130 {
lab=#net5}
N 230 -130 230 60 {
lab=#net5}
N 230 60 260 60 {
lab=#net5}
N -230 -100 -230 -30 {
lab=#net5}
N -230 -30 70 -30 {
lab=#net5}
N 70 -30 230 -30 {
lab=#net5}
N 140 -50 300 -50 {
lab=#net3}
N 300 -50 600 -50 {
lab=#net3}
N 600 -100 600 -50 {
lab=#net3}
N 180 -310 180 -230 {
lab=Vdd}
N 100 -310 180 -310 {
lab=Vdd}
N 830 -100 830 150 {
lab=#net2}
N 300 150 830 150 {
lab=#net2}
N 640 -130 690 -130 {
lab=clk}
N 690 -130 690 30 {
lab=clk}
N 690 30 970 30 {
lab=clk}
N -560 440 -320 440 {
lab=clk}
N 340 250 430 250 {
lab=Vin2}
N -30 250 30 250 {
lab=Vin1}
N 70 250 130 250 {
lab=gnd}
N 230 250 300 250 {
lab=gnd}
N 190 460 190 480 {
lab=gnd}
N -460 -130 -390 -130 {
lab=Vdd}
N -230 -130 -170 -130 {
lab=Vdd}
N 10 -130 70 -130 {
lab=Vdd}
N 300 -130 390 -130 {
lab=Vdd}
N 520 -130 600 -130 {
lab=Vdd}
N 770 -130 830 -130 {
lab=Vdd}
N 300 60 360 60 {
lab=gnd}
N 0 60 70 60 {
lab=gnd}
N 190 430 270 430 {
lab=gnd}
N -930 80 -930 110 {
lab=gnd}
N -850 80 -850 110 {
lab=gnd}
N -770 80 -770 110 {
lab=gnd}
N -930 -30 -930 20 {
lab=clk}
N -850 -30 -850 20 {
lab=Vin1}
N -770 -30 -770 20 {
lab=Vin2}
N -1020 -30 -1020 20 {
lab=Vdd}
N -1020 80 -1020 110 {
lab=gnd}
C {sky130_fd_pr/nfet_01v8.sym} 280 60 0 0 {name=M2
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
C {sky130_fd_pr/nfet_01v8.sym} 50 250 0 0 {name=M3
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
C {sky130_fd_pr/nfet_01v8.sym} 320 250 0 1 {name=M4
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
C {sky130_fd_pr/nfet_01v8.sym} 170 430 0 0 {name=M5
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
C {sky130_fd_pr/pfet_01v8.sym} 90 -130 0 1 {name=M6
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
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} 280 -130 0 0 {name=M7
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
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} -480 -130 0 0 {name=M8
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
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} -250 -130 0 0 {name=M9
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
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} 620 -130 0 1 {name=M10
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
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/pfet_01v8.sym} 850 -130 0 1 {name=M11
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
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} 90 60 0 1 {name=M1
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
C {lab_pin.sym} -30 250 0 0 {name=p2 sig_type=std_logic lab=Vin1}
C {lab_pin.sym} 430 250 2 0 {name=p3 sig_type=std_logic lab=Vin2}
C {lab_pin.sym} 230 250 0 0 {name=p4 sig_type=std_logic lab=gnd}
C {lab_pin.sym} 130 250 2 0 {name=p5 sig_type=std_logic lab=gnd}
C {lab_pin.sym} 0 60 0 0 {name=p6 sig_type=std_logic lab=gnd}
C {lab_pin.sym} 190 480 0 0 {name=p7 sig_type=std_logic lab=gnd}
C {lab_pin.sym} 360 60 2 0 {name=p8 sig_type=std_logic lab=gnd
}
C {lab_pin.sym} -560 440 0 0 {name=p9 sig_type=std_logic lab=clk}
C {lab_pin.sym} -390 -130 2 0 {name=p10 sig_type=std_logic lab=Vdd}
C {lab_pin.sym} -180 -130 2 0 {name=p11 sig_type=std_logic lab=Vdd
}
C {lab_pin.sym} 10 -130 0 0 {name=p12 sig_type=std_logic lab=Vdd
}
C {lab_pin.sym} 390 -130 2 0 {name=p13 sig_type=std_logic lab=Vdd}
C {lab_pin.sym} 520 -130 0 0 {name=p14 sig_type=std_logic lab=Vdd}
C {lab_pin.sym} 770 -130 0 0 {name=p15 sig_type=std_logic lab=Vdd}
C {lab_pin.sym} 100 -310 0 0 {name=p16 sig_type=std_logic lab=Vdd}
C {gnd.sym} 190 480 0 0 {name=l1 lab=gnd}
C {lab_pin.sym} 270 430 2 0 {name=p1 sig_type=std_logic lab=gnd}
C {vsource.sym} -930 50 0 0 {name=V1 value="PULSE(0 1.8 0 100p 100p 5n 10n)" savecurrent=false}
C {vsource.sym} -850 50 0 0 {name=V2 
value="DC 1.000 AC 0.001" 
savecurrent=false }
C {vsource.sym} -770 50 0 0 {name=V3 
value="DC 0.9" 
savecurrent=false }
C {lab_pin.sym} -930 -30 0 0 {name=p18 sig_type=std_logic lab=clk}
C {lab_pin.sym} -850 -30 0 0 {name=p19 sig_type=std_logic lab=Vin1}
C {lab_pin.sym} -770 -30 0 0 {name=p20 sig_type=std_logic lab=Vin2}
C {lab_pin.sym} -930 110 0 0 {name=p21 sig_type=std_logic lab=gnd}
C {lab_pin.sym} -850 110 0 0 {name=p22 sig_type=std_logic lab=gnd}
C {lab_pin.sym} -770 110 0 0 {name=p23 sig_type=std_logic lab=gnd}
C {vsource.sym} -1020 50 0 0 {name=V4 value=1.8 savecurrent=false}
C {lab_pin.sym} -1020 110 0 0 {name=p17 sig_type=std_logic lab=gnd}
C {lab_pin.sym} -1020 -30 0 0 {name=p24 sig_type=std_logic lab=Vdd}
C {code_shown.sym} -1040 250 0 0 {name=s1 only_toplevel=false 
value="
.tran 10p 100n
.lib /home/user/.volare/volare/sky130/versions/0fe599b2afb6708d281543108caf8310912f54af/sky130A/libs.tech/ngspice/sky130.lib.spice tt"}
