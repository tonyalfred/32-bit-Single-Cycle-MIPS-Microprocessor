module data_memory #
(
  parameter MEM_WIDTH       = 32  , 
  parameter MEM_DEPTH       = 100 , 
  parameter ADDRESS_WIDTH   = 32  
)
( 
  input  wire                      CLK        , 
  input  wire                      RST        ,
  
  input  wire [ADDRESS_WIDTH-1:0]  A          ,  
  input  wire                      WE         , 
  input  wire [MEM_WIDTH-1:0]      WD         , 
  
  output wire [MEM_WIDTH-1:0]      RD         ,
  output wire [(MEM_WIDTH/2)-1:0]  test_value 
);

localparam DATA_MEM_ADDR = 32'h0000_0000;

integer i;
reg [MEM_WIDTH-1:0] data_mem [MEM_DEPTH-1:0]; 

/* Asynchronous Reading */
assign RD         = data_mem [A]; 
assign test_value = data_mem [DATA_MEM_ADDR] [(MEM_WIDTH/2)-1:0];

/* Synchronous Writing */ 
always @ (posedge CLK or negedge RST)
  begin
    if (!RST)
      begin
        for (i = 0; i < MEM_DEPTH; i = i + 1)
          begin
            data_mem [i] <= {(MEM_WIDTH){1'b0}};
          end
      end
    else if (WE)
      begin
        data_mem [A] <= WD; 
      end
  end
  
endmodule