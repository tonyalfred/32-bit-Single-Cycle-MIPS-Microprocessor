module program_counter #
(
  parameter INSTRUCTION_WIDTH  = 32 
)
(
  input  wire                          CLK ,
  input  wire                          RST ,
  
  input  wire [INSTRUCTION_WIDTH-1:0]  in  ,
  
  output reg  [INSTRUCTION_WIDTH-1:0]  out
);

always @ (posedge CLK or negedge RST)
  begin
    if (!RST)
        out <= {INSTRUCTION_WIDTH{1'b0}};
    else
        out <= in;
  end
  
endmodule