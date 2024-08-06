set projDir "/media/share/Alchitry/test-rca-v1/work/vivado"
set projName "test-rca-v1"
set topName top
set device xc7a35tftg256-1
if {[file exists "$projDir/$projName"]} { file delete -force "$projDir/$projName" }
create_project $projName "$projDir/$projName" -part $device
set_property design_mode RTL [get_filesets sources_1]
set verilogSources [list "/media/share/Alchitry/test-rca-v1/work/verilog/au_top_0.v" "/media/share/Alchitry/test-rca-v1/work/verilog/rca_1.v" "/media/share/Alchitry/test-rca-v1/work/verilog/reset_conditioner_2.v" "/media/share/Alchitry/test-rca-v1/work/verilog/fa_3.v" ]
import_files -fileset [get_filesets sources_1] -force -norecurse $verilogSources
set xdcSources [list "/media/share/Alchitry/test-rca-v1/work/constraint/alchitry.xdc" "/home/debian/alchitry-labs-1.2.7/library/components/au.xdc" "/media/share/Alchitry/test-rca-v1/work/constraint/io.xdc" ]
read_xdc $xdcSources
set_property STEPS.WRITE_BITSTREAM.ARGS.BIN_FILE true [get_runs impl_1]
update_compile_order -fileset sources_1
launch_runs -runs synth_1 -jobs 8
wait_on_run synth_1
launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1
