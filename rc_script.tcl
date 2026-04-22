set_db lib_search_path ../lib/
set_db hdl_search_path ../rtl/
set_db library slow_vddlv0_basicCells.lib
read_hdl alarm_clock.v
elaborate
read_sdc ../constraint/constraints_top.sdc
sync_generic
syn_map

#synthesize -to_mapped -effort medium
write_hdl > alarm_clock_netlist.v
write_sdc > alarm_clock_sdc.sdc
