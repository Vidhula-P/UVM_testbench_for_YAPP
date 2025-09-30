//test class
class base_test extends uvm_test;
	`uvm_component_utils(base_test) //component utility macro

	function new (string name, uvm_component parent); //component constructor
		super.new(name, parent);
	endfunction

	router_tb tb; //handle for testbench router_tb

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		tb = new("tb", this);//(instance name,print)
		`uvm_info(get_type_name(), "Test build phase is being executed\n", UVM_HIGH)
	endfunction

	function void end_of_elaboration_phase(uvm_phase phase);
		uvm_top.print_topology();//print hierarchy
	endfunction

endclass: base_test

// can extend this base_test to additional test classes (will inherit tb instance)
