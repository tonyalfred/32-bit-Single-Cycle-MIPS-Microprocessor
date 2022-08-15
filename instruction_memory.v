module instruction_memory #
(
  parameter MEM_WIDTH       = 32  , 
  parameter MEM_DEPTH       = 100 , 
  parameter ADDRESS_WIDTH   = 32 
)
( 
  input  wire [ADDRESS_WIDTH-1:0]  A  , 
  
  output wire [MEM_WIDTH-1:0]      RD 
);

reg [MEM_WIDTH-1:0] inst_mem [MEM_DEPTH-1:0]; 

initial 
  begin 
    $readmemh("test_cases/test.txt", inst_mem);
  end
  
/* Asynchronous Reading */ 
assign RD = inst_mem [A >> 2]; 

endmodule