#!/usr/bin/perl
my $vc_app_mod = "";
my $vc_app_log = "";
my $Tcl_Name   = "test.tcl";
my @Novas_Import_Arg;

&parse_argv;
$ENV{vc_app_mod} = $vc_app_mod;
$ENV{vc_app_log}  = $vc_app_log;
&play_novas_tcl;

#################################################
# Sub-routine : parse_argv()
#################################################
sub parse_argv {
  my $all_arg = "-mod|-log";

  for(my $i=0; $i<=$#ARGV; $i++) {
    if( $ARGV[$i] =~ /-mod/ ) {
      $i++;
      $vc_app_mod = $ARGV[$i];
    }
    elsif( $ARGV[$i] =~ /-log/ ) {
      $i++;
      $vc_app_log = $ARGV[$i];
    }
    else { 
      push @Novas_Import_Arg, $ARGV[$i];
    }
  }
}

#################################################
# Sub-routine : play_novas_tcl()
#################################################
sub play_novas_tcl {
  # import design
  my $import_design_cmd = "";
  for(my $i=0; $i<=$#Novas_Import_Arg; $i++) {
    $import_design_cmd = "$import_design_cmd" . " $Novas_Import_Arg[$i]";
  }

  system("verdi $import_design_cmd -play $Tcl_Name -batch");
}

