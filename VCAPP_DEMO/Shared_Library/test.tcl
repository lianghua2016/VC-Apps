viaSetupL1Apps
npiDlOpen -lib "./Get_Mod_Instances.so"
npiDlSym -func get_mod_instances -mod dut -log "dut.list"
debExit
