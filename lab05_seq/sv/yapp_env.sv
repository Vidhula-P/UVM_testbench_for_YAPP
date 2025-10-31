class yapp_env extends uvm_env;

	yapp_tx_agent agent;

	`uvm_component_utils(yapp_env)

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		//using create instead of new to enable factory
		agent = yapp_tx_agent::type_id::create("agent", this);
	endfunction

endclass
