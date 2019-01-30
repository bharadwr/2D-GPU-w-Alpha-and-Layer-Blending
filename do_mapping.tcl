# Step 1:  Read in the source file
analyze -format sverilog -lib WORK {AHB_MasterInterface.sv APB_SlaveInterface.sv bresenham.sv clear.sv controller.sv decode_pro.sv flex_counter.sv memoryManager.sv render_module.sv render_rcu.sv GPU.sv}
elaborate GPU -lib WORK
uniquify
# Step 2: Set design constraints
# Uncomment below to set timing, area, power, etc. constraints
# set_max_delay <delay> -from "<input>" -to "<output>"
# set_max_area <area>
# set_max_total_power <power> mW


# Step 3: Compile the design
compile -map_effort medium

# Step 4: Output reports
report_timing -path full -delay max -max_paths 1 -nworst 1 > reports/GPU.rep
report_area >> reports/GPU.rep
report_power -hier >> reports/GPU.rep

# Step 5: Output final VHDL and Verilog files
write_file -format verilog -hierarchy -output "mapped/GPU.v"
echo "\nScript Done\n"
echo "\nChecking Design\n"
check_design
quit
