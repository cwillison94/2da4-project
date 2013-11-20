module cursor (

output reg X_Position = 300,
output reg Y_Position = 300,  // starting position

input Up_UC,  //unconditioned inputs
input Down_UC,
input Left_UC,
input Right_UC,

input Clock

);


wire Up;     //conditioned inputs
wire Down;
wire Left;
wire Right;

pulse u(Up, Up_UC, Clock);
pulse d(Down, Down_UC, Clock);
pulse l(Left, Left_UC, Clock);
pulse r(Right, Right_UC, Clock);

 

always @(posedge Clock)

	
	if (Up == 1) begin
		Y_Position = Y_Position + 1;	//Up	
		if (Left == 1) begin 
		X_Position = X_Position - 1;	//Up Left  
		end else if (Right == 1) begin
		X_Position = X_Position + 1;	//Up Right
		end
	end
	
	else if (Down == 1) begin
		Y_Position = Y_Position - 1;	//Down	
		if (Left == 1) begin 
		X_Position = X_Position - 1;	//Down Left
		end else if (Right == 1) begin
		X_Position = X_Position + 1;	//Down Right
		end
	end
	
	else if (Right == 1) begin			//Right
		X_Position = X_Position + 1;
	end
	
	else if (Left == 1) begin			//Left
		X_Position = X_Position - 1;
	end


endmodule



module pulse (PulseOut, In, Clock); //conditions input so cursor doesnt move at 25 million pixels per second

	input In;
	input Clock;
	output reg PulseOut = 0;
	
	reg cycles_since_pulse = 'd200000;
	reg cycles_per_pulse = 'd200000;
	
	always @(posedge Clock)
	
		if (In == 1) begin 
			if (cycles_since_pulse == cycles_per_pulse) begin
				PulseOut <= 1;
				cycles_since_pulse <= 'd1;
			end else begin
				PulseOut <=0;
				cycles_since_pulse <= cycles_since_pulse + 1;
			end
			
		end else begin
			PulseOut <= 0;
			cycles_since_pulse <= 'd200000;
		end
			
endmodule
