#include <stdio.h>
#include "npi.h"
#include "npi_hdl.h"
#include "npi_L1.h"
#include <cstring>

extern "C" {
	int get_mod_instances(int argc,char** argv);
}
int get_mod_instances(int argc,char** argv) {
		char* mod_name	= nullptr;
		char* file_name = nullptr;

		//handle argument
		for(int i=0;i<argc;i++) {
				if ( strcmp("-mod",argv[i]) == 0 ) {
						mod_name = argv[++i];
				} else if ( strcmp("-log",argv[i]) == 0 ) {
						file_name = argv[++i];
				}
		}
		FILE* p_File = fopen(file_name,"w");
		npi_mod_define_dump_inst(mod_name,p_File);
		fclose(p_File);
		return 0;
}
