
#------------------------------------------------------------
#---------------------- Clock signal ------------------------
#------------------------------------------------------------
set_property PACKAGE_PIN W5 [get_ports clk]  	 	 	 	  
set_property IOSTANDARD LVCMOS33 [get_ports clk] 
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk] 



#------------------------------------------------------------
#-------------------- 7 segment display ---------------------
#------------------------------------------------------------
set_property PACKAGE_PIN W7 [get_ports {a}] 	 	 	 	 	 
 	set_property IOSTANDARD LVCMOS33 [get_ports {a}] 
set_property PACKAGE_PIN W6 [get_ports {b}] 	 	 	 	 	 
 	set_property IOSTANDARD LVCMOS33 [get_ports {b}] 
set_property PACKAGE_PIN U8 [get_ports {c}] 	 	 	 	 	 
 	set_property IOSTANDARD LVCMOS33 [get_ports {c}] 
set_property PACKAGE_PIN V8 [get_ports {d}] 	 	 	 	 	 
 	set_property IOSTANDARD LVCMOS33 [get_ports {d}] 
set_property PACKAGE_PIN U5 [get_ports {e}] 	 	 	 	 	 
 	set_property IOSTANDARD LVCMOS33 [get_ports {e}] 
set_property PACKAGE_PIN V5 [get_ports {f}] 	 	 	 	 	 
 	set_property IOSTANDARD LVCMOS33 [get_ports {f}] 
set_property PACKAGE_PIN U7 [get_ports {g}] 	 	 	 	 	 
 	set_property IOSTANDARD LVCMOS33 [get_ports {g}] 
set_property PACKAGE_PIN V7 [get_ports dp]  	 	 	 	  
 	set_property IOSTANDARD LVCMOS33 [get_ports dp] 
	
set_property PACKAGE_PIN U2 [get_ports {an[0]}] 	 	 	 	 	 
 	set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}] 
set_property PACKAGE_PIN U4 [get_ports {an[1]}] 	 	 	 	 	 
 	set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}] 
set_property PACKAGE_PIN V4 [get_ports {an[2]}] 	 	 	 	 	 
 	set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}] 
set_property PACKAGE_PIN W4 [get_ports {an[3]}] 	 	 	 	 	 
 	set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}] 

	
#------------------------------------------------------------
#---------------------- Stepper motor -----------------------
#------------------------------------------------------------	

#4 phases
#step motor: Bb
set_property PACKAGE_PIN B16 [get_ports {phases[0]}]	 	 	 	 
 	set_property IOSTANDARD  LVCMOS33 [get_ports {phases[0]}] 
#step motor: Ab
set_property PACKAGE_PIN A16 [get_ports {phases[1]}] 	 	 	 	 	 
 	set_property IOSTANDARD  LVCMOS33 [get_ports {phases[1]}] 
#step motor: B
set_property PACKAGE_PIN B15 [get_ports {phases[2]}] 	 	 	 	 	 
 	set_property IOSTANDARD  LVCMOS33 [get_ports {phases[2]}] 
#step motor: A
set_property PACKAGE_PIN A14 [get_ports {phases[3]}] 	 	 	 	 	 
 	set_property IOSTANDARD  LVCMOS33 [get_ports {phases[3]}] 
	
#direction	
set_property PACKAGE_PIN R2 [get_ports {direction}] 	 	 	 	 	 
 	set_property IOSTANDARD  LVCMOS33 [get_ports {direction}] 

#speed
set_property PACKAGE_PIN U1 [get_ports {speed[0]}] 	 	 	 	 	 
 	set_property IOSTANDARD  LVCMOS33 [get_ports {speed[0]}] 	
set_property PACKAGE_PIN T1 [get_ports {speed[1]}] 	 	 	 	 	 
 	set_property IOSTANDARD  LVCMOS33 [get_ports {speed[1]}]

#stop	
set_property PACKAGE_PIN W2 [get_ports {stop}] 	 	 	 	 	 
 	set_property IOSTANDARD  LVCMOS33 [get_ports {stop}] 
	
	



	


