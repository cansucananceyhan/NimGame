
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7a35t2default:defaultZ17-347h px
�
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7a35t2default:defaultZ17-349h px
�
�The version limit for your license is '%s' and will expire in %s days. A version limit expiration means that, although you may be able to continue to use the current version of tools or IP with this license, you will not be eligible for any updates or new releases.
519*common2
2016.122default:default2
-4972default:defaultZ17-1223h px
u
,Running DRC as a precondition to command %s
1349*	planAhead2#
write_bitstream2default:defaultZ12-1349h px
M
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px
�
Rule violation (%s) %s - %s
20*drc2
UCIO-12default:default2.
Unconstrained Logical Port2default:default2�
�4 out of 41 logical ports have no user assigned specific location constraint (LOC). This may cause I/O contention or incompatibility with the board power or connectivity affecting performance, signal integrity or in extreme cases cause damage to the device or the components to which it is connected. To correct this violation, specify all pin locations. This design will fail to generate a bitstream unless all logical ports have a user specified site LOC constraint defined.  To allow bitstream creation with unspecified pin locations (not recommended), use this command: set_property SEVERITY {Warning} [get_drc_checks UCIO-1].  NOTE: When using the Vivado Runs infrastructure (e.g. launch_runs Tcl command), add this command to a .tcl file and add that file as a pre-hook for write_bitstream step for the implementation run.  Problem ports: phases[3:0].2default:defaultZ23-20h px
�
Rule violation (%s) %s - %s
20*drc2
BUFC-12default:default2,
Input Buffer Connections2default:default2r
^Input buffer changePlayer_IBUF_inst has no loads. An input buffer must drive an internal load.2default:defaultZ23-20h px
�
Rule violation (%s) %s - %s
20*drc2
BUFC-12default:default2,
Input Buffer Connections2default:default2i
UInput buffer dlp_IBUF_inst has no loads. An input buffer must drive an internal load.2default:defaultZ23-20h px
�
Rule violation (%s) %s - %s
20*drc2
BUFC-12default:default2,
Input Buffer Connections2default:default2i
UInput buffer drp_IBUF_inst has no loads. An input buffer must drive an internal load.2default:defaultZ23-20h px
�
Rule violation (%s) %s - %s
20*drc2
BUFC-12default:default2,
Input Buffer Connections2default:default2i
UInput buffer ilp_IBUF_inst has no loads. An input buffer must drive an internal load.2default:defaultZ23-20h px
�
Rule violation (%s) %s - %s
20*drc2
BUFC-12default:default2,
Input Buffer Connections2default:default2i
UInput buffer irp_IBUF_inst has no loads. An input buffer must drive an internal load.2default:defaultZ23-20h px
�
Rule violation (%s) %s - %s
20*drc2
BUFC-12default:default2,
Input Buffer Connections2default:default2m
YInput buffer newGame_IBUF_inst has no loads. An input buffer must drive an internal load.2default:defaultZ23-20h px
�
Rule violation (%s) %s - %s
20*drc2
BUFC-12default:default2,
Input Buffer Connections2default:default2j
VInput buffer row1_IBUF_inst has no loads. An input buffer must drive an internal load.2default:defaultZ23-20h px
�
Rule violation (%s) %s - %s
20*drc2
BUFC-12default:default2,
Input Buffer Connections2default:default2j
VInput buffer row2_IBUF_inst has no loads. An input buffer must drive an internal load.2default:defaultZ23-20h px
�
Rule violation (%s) %s - %s
20*drc2
BUFC-12default:default2,
Input Buffer Connections2default:default2j
VInput buffer row3_IBUF_inst has no loads. An input buffer must drive an internal load.2default:defaultZ23-20h px
�
Rule violation (%s) %s - %s
20*drc2
BUFC-12default:default2,
Input Buffer Connections2default:default2j
VInput buffer row4_IBUF_inst has no loads. An input buffer must drive an internal load.2default:defaultZ23-20h px
�
Rule violation (%s) %s - %s
20*drc2
BUFC-12default:default2,
Input Buffer Connections2default:default2i
UInput buffer rst_IBUF_inst has no loads. An input buffer must drive an internal load.2default:defaultZ23-20h px
�
Rule violation (%s) %s - %s
20*drc2
CFGBVS-12default:default2G
3Missing CFGBVS and CONFIG_VOLTAGE Design Properties2default:default2�
�Neither the CFGBVS nor CONFIG_VOLTAGE voltage property is set in the current_design.  Configuration bank voltage select (CFGBVS) must be set to VCCO or GND, and CONFIG_VOLTAGE must be set to the correct configuration voltage, in order to determine the I/O voltage support for the pins in bank 0.  It is suggested to specify these either using the 'Edit Device Properties' function in the GUI or directly in the XDC file using the following syntax:

 set_property CFGBVS value1 [current_design]
 #where value1 is either VCCO or GND

 set_property CONFIG_VOLTAGE value2 [current_design]
 #where value2 is the voltage provided to configuration bank 0

Refer to the device configuration user guide for more information.2default:defaultZ23-20h px
�
Rule violation (%s) %s - %s
20*drc2
	RTSTAT-102default:default2%
No routable loads2default:default2�
�11 net(s) have no routable loads. The problem bus(es) and/or net(s) are changePlayer_IBUF, dlp_IBUF, drp_IBUF, ilp_IBUF, irp_IBUF, newGame_IBUF, row1_IBUF, row2_IBUF, row3_IBUF, row4_IBUF, rst_IBUF.2default:defaultZ23-20h px
d
DRC finished with %s
1905*	planAhead2)
1 Errors, 13 Warnings2default:defaultZ12-3199h px
f
BPlease refer to the DRC report (report_drc) for more information.
1906*	planAheadZ12-3200h px
O
+Error(s) found during DRC. Bitgen not run.
1345*	planAheadZ12-1345h px
W
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px
}
Exiting %s at %s...
206*common2
Vivado2default:default2,
Sat May 12 18:24:48 20182default:defaultZ17-206h px