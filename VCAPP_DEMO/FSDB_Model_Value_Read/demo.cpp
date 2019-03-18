#include <stdio.h>
#include "npi.h"       // must have for NPI programs
#include "npi_fsdb.h"  // header for NPI FSDB model

int main(int argc, char** argv)
{
  const char* fsdb_name = "demo.fsdb";
  const char* sig_name = "test.M1.A";
  npiFsdbTime minTime, maxTime, currTime;
  
  // call npi_init before using any APIs in the FSDB model
  npi_init(argc, argv);

  // open the FSDB file named "demo.fsdb"
  npiFsdbFileHandle fp = npi_fsdb_open( fsdb_name );
  if ( !fp ) {
    printf("Failed to open FSDB file: %s.\n", fsdb_name);
    return 1;
  }
  else { // print time information of the FSDB file
    npi_fsdb_min_time( fp, &minTime );
    npi_fsdb_max_time( fp, &maxTime );
    printf("Time range: %llu ~ %llu\n", minTime, maxTime );
    printf("Scale unit: %s\n", npi_fsdb_file_property_str( npiFsdbFileScaleUnit, fp) );
  }

  // get signal handle by name 
  npiFsdbSigHandle sig = npi_fsdb_sig_by_name( fp, sig_name, NULL);
  npiFsdbValue val;
  val.format = npiFsdbBinStrVal;
  if ( sig ) {
    // create vc traverse handle
    npiFsdbVctHandle vch = npi_fsdb_create_vct( sig );
    if ( vch ) {
      // go to first time for initialization
      if ( npi_fsdb_goto_first( vch ) ) { 

        // get the time & value information of current vct handle
        npi_fsdb_vct_time( vch, &currTime );
        npi_fsdb_vct_value( vch, &val );
        printf("Time = %10llu, value = %s\n", currTime, val.value.str );

        // traverse vc to the last one
        while ( npi_fsdb_goto_next( vch ) ) {
          npi_fsdb_vct_time( vch, &currTime );
          npi_fsdb_vct_value( vch, &val );
          printf("Time = %10llu, value = %s\n", currTime, val.value.str );
        }
      }
      else
        printf("Failed to goto first vc for sig: %s.\n", sig_name);
    }
    else
      printf("Failed to create vct for sig: %s.\n", sig_name);
  }
  else
    printf("Failed to find sig: %s.\n", sig_name);
  // close the FSDB file
  npi_fsdb_close( fp );
  // end of NPI program
  npi_end();
  return 0;
}

