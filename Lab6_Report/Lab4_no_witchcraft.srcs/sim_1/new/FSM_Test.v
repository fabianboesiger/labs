`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: ETH Zurich
// Engineer: Frank K. Gurkaynak
//
// Create Date:   15:24:03 03/17/2011
// Design Name:   alu
// Module Name:   ALU_test.v
// Project Name:  Lab5b
// Target Device:  
// Tool versions:  
// Description: Simple testbench to test the ALU
//
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module FSM_Test;

	// Inputs
   reg reset, left, right;
   reg [1:0] state;

   // Outputs
   wire LA, LB, LC, RA, RB, RC;

   // Test clock 
   reg clk;
   reg[1:0] state_count = 2'b0;
   
   // Expected outputs
   reg eLA, eLB, eLC, eRA, eRB, eRC;

   // Vector and Error counts
   reg [10:0]	vec_cnt, err_cnt;
   
   // Test Vector
   reg [10:0] testvec [100:0];
    
   // The test clock generation
   always				// process always triggers
	begin
		clk=1; #5;
		clk=0; #5;
	end					// generate a 100 ns clock

   // Initialization
	initial
	begin
	    // !!!!!!!!!! IMPORTANT: CHANGE PATH WHEN EXECUTED ON ANOTHER MACHINE !!!!!!!!!!
        $readmemb("C:\\Users\\Fabian\\git\\labs\\Lab6_Report\\testvectors.txt", testvec);
        
		err_cnt=0; // number of errors
		vec_cnt=0; // number of vectors
	end
   
   // Tests
	always @ (posedge clk)		// trigger with the test clock
	begin
	
	              
        
	 
	 
	   	       
       $display("Currently in State %b", state_count);


        // Assign the signals from the testvec array
       {state, reset, left, right, eLA, eLB, eLC, eRA, eRB, eRC} = testvec[vec_cnt]; 
       #2;
       

        
	   
	   if(state_count == state)	       
       begin
       
           
            #4;
            
            // Check if output is not what we expect to see
            if ({LA, LB, LC, RA, RB, RC} !== {eLA, eLB, eLC, eRA, eRB, eRC})
            begin                                         
                // Display message
                $display("Error at %5d ns (test %5d): state=%b, reset=%b, left=%b, right=%b", $time, vec_cnt, state, reset, left, right);
                $display("%b %b %b %b %b %b (%b %b %b %b %b %b expected)", LA, LB, LC, RA, RB, RC, eLA, eLB, eLC, eRA, eRB, eRC);
                err_cnt = err_cnt + 1;
            end
            else
            begin
                $display("Success at %5d ns (test %5d): state=%b, reset=%b, left=%b, right=%b", $time, vec_cnt, state, reset, left, right);
                $display("%b %b %b %b %b %b", LA, LB, LC, RA, RB, RC);
            end
    
            vec_cnt = vec_cnt + 1;
            
            $display("Reset");
	        reset = 1;
            state_count = 2'b00;
             #2;


            // We use === so that we can also test for X
            if ((testvec[vec_cnt][10] === 1'bx))
            begin
                // End of test, no more entries...
                $display ("%d tests completed with %d errors", vec_cnt, err_cnt);
                
                // Wait so that we can see the last result
                #2; 
                
                // Terminate simulation
                $finish;
            end
            
		end
		else
            state_count = state_count + 1;
		
	end

   // Instantiate the Unit Under Test (UUT)
   TailLights UUT (clk, reset, left, right, LA, LB, LC, RA, RB, RC);
   
endmodule
