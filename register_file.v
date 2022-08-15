module register_file #
(
  parameter FILE_WIDTH          = 32  , 
  parameter FILE_DEPTH          = 32  , 
  parameter FILE_ADDRESS_WIDTH  = 5  
)
( 
  input  wire                          CLK , 
  input  wire                          RST ,
  
  input  wire [FILE_ADDRESS_WIDTH-1:0] A1  , 
  input  wire [FILE_ADDRESS_WIDTH-1:0] A2  , 
  input  wire [FILE_ADDRESS_WIDTH-1:0] A3  , 
  
  input  wire                          WE3 , 
  input  wire [FILE_WIDTH-1:0]         WD3 , 
  
  output wire [FILE_WIDTH-1:0]         RD1 , 
  output wire [FILE_WIDTH-1:0]         RD2
);

integer i;
reg [FILE_WIDTH-1:0] REG [FILE_DEPTH-1:0]; 

/* Asynchronous Reading */
assign RD1 = REG [A1]; 
assign RD2 = REG [A2];

/* Synchronous Writing */ 
always @ (posedge CLK or negedge RST)
  begin
    if (!RST)
      begin
        for (i = 0; i < FILE_DEPTH; i = i + 1)
          begin
            REG [i] <= {(FILE_WIDTH){1'b0}};
          end
      end
    else if (WE3)
      begin
        REG [A3] <= WD3; 
      end
  end
  
endmodule