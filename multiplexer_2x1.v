module multiplexer_2x1 #
(
  parameter DATA_WIDTH  = 32
) 
(
  input  wire [DATA_WIDTH-1:0] in_0 ,
  input  wire [DATA_WIDTH-1:0] in_1 ,
  input  wire                  sel  ,
  
  output wire [DATA_WIDTH-1:0] out
);

assign out = sel ? in_1 : in_0;

endmodule