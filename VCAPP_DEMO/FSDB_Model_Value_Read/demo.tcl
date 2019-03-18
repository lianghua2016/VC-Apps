set file_name "demo.fsdb"
set sig_name "test.M1.A"

# open the FSDB file
set file_hdl [npi_fsdb_open -name $file_name]
if { $file_hdl != "" } {
  set min_time [npi_fsdb_min_time -file $file_hdl]
  set max_time [npi_fsdb_max_time -file $file_hdl]
  set scale_unit [npi_fsdb_file_property_str -file $file_hdl -type npiFsdbFileScaleUnit]
  puts "Time range: $min_time ~ $max_time"
  puts "Scale unit: $scale_unit"

# get signal handle by name
  set sig_hdl [npi_fsdb_sig_by_name -file $file_hdl -name $sig_name -scope ""]
  if { $sig_hdl != "" } {

# create signal handle
    set vct_hdl [npi_fsdb_create_vct -sig $sig_hdl]
    if { $vct_hdl != "" } {

# goto first vc for initialization 
      if { [npi_fsdb_goto_first -vct $vct_hdl] != 0 } {
        set vct_time [npi_fsdb_vct_time -vct $vct_hdl]
        set vct_val [npi_fsdb_vct_value -vct $vct_hdl -format npiFsdbBinStrVal]
        puts "Time = $vct_time, value = $vct_val"

# traverse value changes to the last one 
        while { [npi_fsdb_goto_next -vct $vct_hdl] != 0 } {
          set vct_time [npi_fsdb_vct_time -vct $vct_hdl]
          set vct_val [npi_fsdb_vct_value -vct $vct_hdl -format npiFsdbBinStrVal]
          puts "Time = $vct_time, value = $vct_val"
        }
      } else {
        puts "Failed to goto first vc for sig: $sig_name"
      }
    } else {
      puts "Failed to create vct handle for sig: $sig_name"
    }
  } else {
    puts "Failed to find sig: $sig_name"
  }
# close the FSDB file
  npi_fsdb_close -file $file_hdl
} else {
  puts "Failed to open FSDB file: $file_name"
}

# below is the Verdi Tcl command that will leave Novas executable
debExit

