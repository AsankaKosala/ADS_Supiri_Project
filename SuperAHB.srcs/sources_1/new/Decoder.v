`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Moratuwa
// Engineer: 
// 
// Create Date: 06/11/2018 03:07:19 PM
// Design Name: 
// Module Name: Decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision: 
// Revision 0.01 - File Created
// Additional Comments:
// 
// Reference: https://www.researchgate.net/figure/An-example-AHB-system-with-one-master-and-one-slave_fig5_221004353
//////////////////////////////////////////////////////////////////////////////////


module Decoder(
    input [11:0] HADDR,
    input HCLK,
    input HRESETn,
    output reg HSELx1,
    output reg HSELx2,
    output reg HSELx3
    );
    
    always @ (HRESETn)
        if (HRESETn == 1'b0) 
            begin
                HSELx1 = 1'b0;
                HSELx2 = 1'b0;
                HSELx3 = 1'b0;
            end        
    
    always @ (posedge HCLK) 
        case (HADDR)
            12'b1111_0000_0000:
                begin
                    HSELx1 = 1'b1;
                    HSELx2 = 1'b0;
                    HSELx3 = 1'b0;
                end
            12'b0000_1111_0000:
                begin
                    HSELx1 = 1'b0;
                    HSELx2 = 1'b1;
                    HSELx3 = 1'b0;
                end
            12'b0000_0000_1111:
                begin
                    HSELx1 = 1'b0;
                    HSELx2 = 1'b0;
                    HSELx3 = 1'b1;
                end
            default:
                begin
                    HSELx1 = 1'b0;
                    HSELx2 = 1'b0;
                    HSELx3 = 1'b0;
                end
        endcase
    
endmodule

module Decoder_tb();
 
  reg [11:0] HADDR;
  reg HCLK;
  reg HRESETn;
  
  wire HSELx1;
  wire HSELx2;
  wire HSELx3;
  
  initial begin
      HCLK = 1'b0;
      forever begin
          #1 HCLK = ~HCLK;
      end
  end
   
  Decoder DUT (
    .HADDR(HADDR),
    .HCLK(HCLK),
    .HRESETn(HRESETn),
    .HSELx1(HSELx1),
    .HSELx2(HSELx2),
    .HSELx3(HSELx3)
  );
 
  initial begin
    HADDR = 12'b0000_0000_0000;
    HRESETn = 1'b1;
    #2
    HADDR = 12'b1111_0000_0000;
    #2
    HADDR = 12'b0000_1111_0000;
    #2
    HADDR = 12'b0000_0000_1111;
    #2
    HADDR = 12'b1111_0000_1111;
    #2
    HADDR = 12'b0000_1111_0000;
    #2
    HRESETn = 1'b0;
    HADDR = 12'b0000_1111_0000;
    #2
    HADDR = 12'b0000_0000_1111;
    #2
    HRESETn = 1'b1;
    HADDR = 12'b1111_0000_1111;
    #2
    HADDR = 12'b0000_1111_0000;
    #2
    HADDR = 12'b1111_0000_0000;
    #2
    $finish;
  end
 
endmodule
