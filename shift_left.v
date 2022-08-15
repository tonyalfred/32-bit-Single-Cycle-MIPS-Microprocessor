module shift_left #
(
  parameter DATA_WIDTH   = 32 ,
  parameter SHIFT_TIMES  = 2
)
(
  input  wire [DATA_WIDTH-1:0] in  , 
  
  output wire [DATA_WIDTH-1:0] out 
);

assign out = in << SHIFT_TIMES;

endmodule