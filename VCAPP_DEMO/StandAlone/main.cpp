#include <stdio.h>
#include "npi.h"
#include "npi_hdl.h"
#include "npi_L1.h"
#include <cstring>

int main(int argc,char** argv) {
		char* mod_name	= nullptr;
		char* file_name = nullptr;

		int		new_argc = 0;
		char** 	new_argv = (char**) malloc(sizeof(char*)*argc);
		
		//handle argument
		for(int i=0;i<argc;i++) {
				if ( strcmp("-mod",argv[i]) == 0 ) {
						mod_name = argv[++i];
				} else if ( strcmp("-log",argv[i]) == 0 ) {
						file_name = argv[++i];
				} else {
						new_argv[new_argc++] = argv[i];
				}
		}
		//init
		npi_init(new_argc,new_argv);
		//load
		npi_load_design(new_argc,new_argv);
		//main function
		FILE* p_File = fopen(file_name,"w");
		npi_mod_define_dump_inst(mod_name,p_File);
		fclose(p_File);
		//end
		npi_end();
		return 0;
}
