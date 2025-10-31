//test class
class base_test extends uvm_test;
	`uvm_component_utils(base_test) //component utility macro

	function new (string name, uvm_component parent); //component constructor
		super.new(name, parent);
	endfunction

	router_tb tb; //handle for testbench router_tb

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		uvm_config_int::set(this,"*","recording_detail",1);
		uvm_config_wrapper::set(this, "tb.uvc.agent.sequencer.run_phase","default_sequence",yapp_5_packets::get_type());
		//using create instead of new to enable factory
		tb = router_tb::type_id::create("tb", this);
		`uvm_info(get_type_name(), "Test build phase is being executed\n", UVM_HIGH)
	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology();//print hierarchy
	endfunction

	function void check_phase(uvm_phase phase);
		check_config_usage();
	endfunction

endclass: base_test

class short_packet_test extends base_test;
	`uvm_component_utils(short_packet_test)

	function new (string name, uvm_component parent); //component constructor
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		set_type_override_by_type( yapp_packet::get_type(), short_yapp_packet::get_type() );
	endfunction

endclass: short_packet_test

class set_config_test extends base_test;
	`uvm_component_utils(set_config_test)
	function new (string name, uvm_component parent); //component constructor
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		uvm_config_int::set(this,"tb.uvc.agent","is_active",UVM_PASSIVE);
		super.build_phase(phase);
	endfunction
endclass: set_config_test


class incr_payload_test extends base_test;
	`uvm_component_utils(incr_payload_test)
	function new (string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		set_type_override_by_type(yapp_packet::get_type(), short_yapp_packet::get_type());
		super.build_phase(phase);
		uvm_config_wrapper::set(this,"tb.uvc.agent.sequencer.run_phase","default_sequence",yapp_incr_payload_seq::get_type());
	endfunction
endclass: incr_payload_test

class exhaustive_seq_test extends base_test;
	`uvm_component_utils(exhaustive_seq_test)
	function new (string name, uvm_component parent);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		set_type_override_by_type(yapp_packet::get_type(), short_yapp_packet::get_type());
		super.build_phase(phase);
		uvm_config_wrapper::set(this,"tb.uvc.agent.sequencer.run_phase","default_sequence",yapp_exhaustive_seq::get_type());
	endfunction
endclass: exhaustive_seq_test
