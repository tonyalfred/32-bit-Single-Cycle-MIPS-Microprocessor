module ALU #
(
  parameter DATA_WIDTH  = 32 
)
(
  input  wire [DATA_WIDTH-1:0]    in_0 ,
  input  wire [DATA_WIDTH-1:0]    in_1 ,
  input  wire [2:0]               sel  ,
  
  output reg  [DATA_WIDTH-1:0]    out  ,
  output wire                     zero
);

localparam AND  = 3'b000 ;
localparam OR   = 3'b001 ;
localparam ADD  = 3'b010 ;
localparam SUB  = 3'b100 ;
localparam MUL  = 3'b101 ;
localparam SLT  = 3'b110 ;

always @ (*)
  begin
    case (sel)
      AND: out =  in_0 & in_1;
      OR : out =  in_0 | in_1;
      ADD: out =  in_0 + in_1;
      SUB: out =  in_0 - in_1;
      MUL: out =  in_0 * in_1;
      SLT: out = (in_0 < in_1) ? { { (DATA_WIDTH-1) { 1'b0 } }, (1'b1) } : { DATA_WIDTH {1'b0} };
      
      default : out = {DATA_WIDTH{1'b0}};
    endcase
  end

assign zero = ~ (| out);

endmodule  