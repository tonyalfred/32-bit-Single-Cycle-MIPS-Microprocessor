module adder #
(
  parameter DATA_WIDTH  = 32 
)
(
  input  wire [DATA_WIDTH-1:0] in_0 ,
  input  wire [DATA_WIDTH-1:0] in_1 ,
  
  output wire [DATA_WIDTH-1:0] out 
);

assign out = in_0 + in_1;

endmodule