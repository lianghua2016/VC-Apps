viaSetupL1Apps
set fout [open $env(vc_app_log) w]
::npi_L1::npi_mod_define_dump_inst $env(vc_app_mod) $fout
debExit
