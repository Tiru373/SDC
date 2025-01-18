# Clock Definitions
create_clock -period 10 [get_ports clk]   # Clock with a period of 10ns
create_clock -period 12 [get_ports clk_2] # Another clock with 12ns period

# Clock uncertainty (account for skew, jitter, etc.)
set_clock_uncertainty 0.3 [get_clocks clk]  # Set clock uncertainty for clk to 0.3ns
set_clock_uncertainty 0.5 [get_clocks clk_2] # Set clock uncertainty for clk_2 to 0.5ns

# Define clock constraints for both edges (e.g., rising and falling edges)
set_clock_edges [get_clocks clk] rising    # Rising edge for clk
set_clock_edges [get_clocks clk_2] both    # Both rising and falling edges for clk_2

# Input and Output Delay Constraints (with different values for max and min)
set_input_delay -max 3.0 -clock [get_clocks clk] [get_pins my_module/input_signal]
set_input_delay -min 1.0 -clock [get_clocks clk] [get_pins my_module/input_signal]

set_output_delay -max 4.0 -clock [get_clocks clk] [get_pins my_module/output_signal]
set_output_delay -min 2.0 -clock [get_clocks clk] [get_pins my_module/output_signal]

# Input setup and hold constraints for timing analysis
set_input_setup -max 3.0 [get_pins my_module/input_signal]   # Max setup time for input signal
set_input_hold -min 0.5 [get_pins my_module/input_signal]    # Min hold time for input signal

# Output setup and hold constraints for timing analysis
set_output_setup -max 3.0 [get_pins my_module/output_signal]  # Max setup time for output signal
set_output_hold -min 0.5 [get_pins my_module/output_signal]   # Min hold time for output signal

# Multicycle Paths (e.g., paths that take multiple clock cycles)
set_multicycle_path -setup 2 -hold 1 -from [get_pins my_module/output_signal] -to [get_pins my_module/input_signal]

# False Path Constraints (timing analysis skipped on certain paths)
set_false_path -from [get_pins my_module/reset] -to [get_pins my_module/output_signal]
set_false_path -from [get_pins my_module/clk_enable] -to [get_pins my_module/data_out]

# Define Clock Groups (for asynchronous clock domains)
create_clock -period 10 [get_pins clk_a]
create_clock -period 10 [get_pins clk_b]
set_clock_groups -asynchronous -group [get_clocks clk_a] -group [get_clocks clk_b]

# Set the operating conditions for power, voltage, and temperature
set_operating_conditions -process fast -voltage 1.0 -temperature 25  # For fast process corner

# Define an ideal path (very low delay or no delay)
set_ideal_path [get_pins my_module/ideal_path]  # Ideal path with negligible delay

# Minimum and Maximum Delay Constraints for Paths
set_max_delay 5.0 -from [get_pins my_module/input_signal] -to [get_pins my_module/output_signal]
set_min_delay 2.0 -from [get_pins my_module/input_signal] -to [get_pins my_module/output_signal]

# Set clock uncertainty for specific edges (e.g., falling edge)
set_clock_uncertainty 0.2 -edge falling [get_clocks clk]  # Set uncertainty for falling edge

# Physical Constraints (for layout purposes)
# Define the clock region or clock domain area (useful for placement and routing)
set_clock_region -start 1000 -end 2000 [get_ports clk]

# Set maximum capacitance for I/O pins (used in power analysis)
set_max_capacitance 3.5 [get_pins my_module/output_signal]  # Max capacitance for output pin

# Set input transition time constraints (rise/fall time for inputs)
set_input_transition 0.2 [get_pins my_module/input_signal]  # Max input rise/fall time of 0.2ns

# Set output transition time constraints (rise/fall time for outputs)
set_output_transition 0.3 [get_pins my_module/output_signal]  # Max output rise/fall time of 0.3ns

# Enable or Disable clock gating (for power reduction)
set_clock_gating -enable [get_clocks clk]    # Enable clock gating for the clock

# Define Power Domains (if multiple power supplies are used)
create_pnra -name power_domain1 -cells [get_cells my_module/*]  # Create power domain for module
set_power_domain -name power_domain1 -cells [get_cells my_module/*]

# Specify setup and hold time for sequential elements (flip-flops, registers)
set_input_setup -max 2.0 -from [get_pins my_module/flip_flop_input]  # Max setup time for flip-flop input
set_output_setup -min 1.0 -to [get_pins my_module/flip_flop_output]  # Min setup time for flip-flop output

# Set maximum delay for combinational logic paths
set_max_comb_delay 4.5 [get_pins my_module/output_signal]  # Max delay for combinational paths

# Hold time constraints for sequential elements (registers, latches)
set_input_hold -min 0.3 [get_pins my_module/flip_flop_input]  # Min hold time for flip-flop input
set_output_hold -max 0.5 [get_pins my_module/flip_flop_output] # Max hold time for flip-flop output
