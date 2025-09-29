/*-----------------------------------------------------------------
File name     : top.sv
Description   : lab01_data top module template file
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/

module top;
// import the UVM library
import uvm_pkg::*;
// include the UVM macros
`include "uvm_macros.svh" 
// import the YAPP package
import yapp_pkg::*;
// generate 5 random packets and use the print method
// to display the results
// experiment with the copy, clone and compare UVM method
yapp_packet pkt;
string pkt_name;

initial begin
	for(int i = 0; i<5; i++) begin
		$sformat(pkt_name, "pkt_%0d", i);
		pkt = new(pkt_name);
		if(!pkt.randomize()) begin
			`uvm_error("TOP", "Randomizing failed :(");
		end
		pkt.print();
	end
end

endmodule : top
