module sign_extend #
(
  parameter INPUT_DATA_WIDTH   = 16 ,
  parameter OUTPUT_DATA_WIDTH  = 32 
)
(
  input  wire [INPUT_DATA_WIDTH-1:0]  in  , 
  
  output wire [OUTPUT_DATA_WIDTH-1:0] out
);

assign out = { { (OUTPUT_DATA_WIDTH-INPUT_DATA_WIDTH) { in[INPUT_DATA_WIDTH-1] } }, in };

endmodule