`timescale 1us / 1ps

///////////////////////////////////////////////////////////////////////////////
// 
////////////////////////////////////////////////////////////////////////////////

module alarmTest;

	// Inputs
	reg reset;
	reg clk;
	reg [1:0] hourIn1;
	reg [3:0] hourIn0;
	reg [3:0] minIn0;
	reg [3:0] minIn1;
	reg ldTime;
	reg ldAlarm;
	reg alarmOn;

	// Outputs
	wire alarm;
	wire [1:0] hourOut1;
	wire [3:0] hourOut0;
	wire [3:0] minOut0;
	wire [3:0] minOut1;

	// Instantiate the Unit Under Test (UUT)
	alarm uut (
		.reset(reset), 
		.clk(clk), 
		.hourIn1(hourIn1), 
		.hourIn0(hourIn0), 
		.minIn0(minIn0), 
		.minIn1(minIn1), 
		.ldTime(ldTime), 
		.ldAlarm(ldAlarm),  
		.alarmOn(alarmOn), 
		.alarm(alarm), 
		.hourOut1(hourOut1), 
		.hourOut0(hourOut0), 
		.minOut0(minOut0), 
		.minOut1(minOut1)
	);

   
	initial begin
		// Initialize Inputs
		reset = 1;
		clk = 0; 
		hourIn1 = 0;
		hourIn0 = 0;
		minIn0 = 0;
		minIn1 = 0;
		ldTime = 0;
		ldAlarm = 0;
		alarmOn = 0;
	
		// Wait 100 ns for global reset to finish
		#5;			
		reset = 0;
		hourIn1 = 1;
		hourIn0 = 2;
		minIn0 = 2;
		minIn1 = 1;
		ldTime = 1;

		#5
		hourIn1 = 1;
		hourIn0 = 2;
		minIn0 = 9;
		minIn1 = 1;
		ldTime = 0;
		ldAlarm = 1;
		#5
		ldAlarm = 0;
		alarmOn = 1;
		#100 $finish;
		
		end  
			
	    	
		 always begin 
	$display( " time	 hourout1	 hourout0 	minout1 	minout0 	alarm");	
	$display("%d	 %d 	 %d 	 %d 	 %d 	 %d", $time,hourOut1,hourOut0,minOut1,minOut0,alarm);
		  #1 clk = ~clk;
		  end		
			

      
endmodule

