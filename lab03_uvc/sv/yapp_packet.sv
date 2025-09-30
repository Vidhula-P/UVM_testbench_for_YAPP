/*-----------------------------------------------------------------
File name     : yapp_packet.sv
Description   : lab01_data YAPP UVC packet template file
Notes         : From the Cadence "SystemVerilog Advanced Verification with UVM" training
-------------------------------------------------------------------
Copyright Cadence Design Systems (c)2015
-----------------------------------------------------------------*/

// Define your enumerated type(s) here
typedef enum bit {GOOD_PARITY, BAD_PARITY} parity_type_e;

class yapp_packet extends uvm_sequence_item;

// Follow the lab instructions to create the packet.
// Place the packet declarations in the following order:

  // Define protocol data
	rand bit [6:0] length;
	rand bit [1:0] addr;
	rand bit [7:0] payload[];
			 bit [7:0] parity;

  // Define control knobs
	rand int packet_delay;
	rand parity_type_e parity_type;

  // Enable automation of the packet's fields
	`uvm_object_utils_begin(yapp_packet)
		`uvm_field_int(length, UVM_ALL_ON )
		`uvm_field_int(addr, UVM_ALL_ON)
		`uvm_field_array_int(payload, UVM_ALL_ON)
		`uvm_field_int(parity, UVM_ALL_ON + UVM_BIN)
		`uvm_field_enum(parity_type_e, parity_type, UVM_ALL_ON)
		`uvm_field_int(packet_delay, UVM_ALL_ON + UVM_NOCOMPARE)
	`uvm_object_utils_end

	function new (string name = "yapp_packet");
		super.new(name);
	endfunction

  // Define packet constraints
	constraint valid_addr { addr >= 0; addr < 3; }
	constraint valid_length { length > 0; length < 64; }
	constraint valid_payload { length == payload.size(); }
	constraint parity_ratio { parity_type dist { GOOD_PARITY:=5, BAD_PARITY:=1}; }
	constraint packet_delay_constraint { packet_delay inside {[1:20]}; }

  // Add methods for parity calculation and class construction
	function bit [7:0] calc_parity();
		bit [7:0] result = 0;
		foreach (payload[i]) begin
			result ^= payload[i];
		end
		return result;
	endfunction

	function void set_parity();
		if (parity_type == GOOD_PARITY)
			parity = calc_parity();
		else
			parity = calc_parity() + 1; //adding +1 to make parity invalid
	endfunction

	function void post_randomize();
		set_parity();
	endfunction

endclass: yapp_packet
