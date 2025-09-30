//testbench
class router_tb extends uvm_env;
	`uvm_component_utils(router_tb) //component utility macro

	function new(string name, uvm_component parent); //component constructor
		super.new(name,parent);
	endfunction

	//YAPP UVC
	yapp_env uvc;

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info(get_type_name(), "Testbench build phase under execution\n", UVM_HIGH)
		//instatiate YAPP UVC
		uvc = new("uvc",this);
	endfunction

endclass: router_tb
