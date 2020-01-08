module StateMachine(switch,halt_c,halt_s, clk);

input switch,halt_c, clk;
output halt_s;

reg halt_interno;

reg r0 = 0;

always@(posedge clk)
begin
	if(halt_c)
	begin
		if(switch == 1 && r0 == 0)
		begin
			halt_interno = halt_c;
			r0 = 1;
		end
		else if(switch == 0 && r0 == 1)
		begin
			halt_interno = 0;
			r0 = 0;
		end
		else if(switch == 0 && r0 == 0)
		begin	
			halt_interno = halt_c;
		end
		else if(switch == 1 && r0 == 1)
		begin
			halt_interno = halt_c;
		end
	end
	else
		halt_interno = halt_c;
end

assign halt_s = halt_interno;
endmodule
