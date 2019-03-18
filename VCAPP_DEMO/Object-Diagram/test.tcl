viaSetupL1Apps

proc print_mod_port_highconn { mod fout } {

set port_iter [npi_iterate -type npiPort -refHandle $mod];
if { $port_iter != "" } {
		set port_ele ""
		while { [set port_ele [npi_scan -iterator $port_iter] ] != "" } {
				set name 	 [npi_get_str -property npiName -object $port_ele]
				set highconn [npi_handle -type npiHighConn -refHandle $port_ele]
				set highconn_name [npi_get_str -property npiFullName -object $highconn]
				puts $fout "$name : $highconn_name"
		}
}

}

set fout [open "ports.log" w]
set mod [npi_handle_by_name -name "top.inst" -scope ""]
print_mod_port_highconn $mod $fout
debExit
