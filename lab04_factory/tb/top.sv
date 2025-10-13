/*-----------------------------------------------------------------
File name     : top.sv
Description   : lab01_data top module template file
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/

module top;
	import uvm_pkg::*; //UVM library
	`include "uvm_macros.svh"  //UVM macros
	import yapp_pkg::*; // import the YAPP package

	//import router testbench and test files
	`include "router_tb.sv"
	`include "router_test_lib.sv"

	initial begin
		run_test("base_test"); //start UVM simulaton phases
		//if you want to run a different test, need to edit run_test() and hence, re-compile
		//alternate is to set flag +UVM_TESTNAME (takes precedence)
	end

endmodule: top
