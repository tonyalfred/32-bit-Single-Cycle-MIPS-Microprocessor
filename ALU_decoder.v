module ALU_decoder 
(
  input  wire [5:0] Funct      ,
  input  wire [1:0] ALUOp      ,
  output reg  [2:0] ALUControl
);

localparam  AND =   6'b10_0100  ;
localparam  OR  =   6'b10_0101  ;
localparam  ADD =   6'b10_0000  ;
localparam  SUB =   6'b10_0010  ;
localparam  SLT =   6'b10_1010  ;
localparam  MUL =   6'b01_1100  ;

always @ (*)
  begin
    case (ALUOp)
      2'b00: ALUControl = 3'b010;
      2'b01: ALUControl = 3'b100;
      2'b10:
        case (Funct)
          AND:     ALUControl = 3'b000;
          OR :     ALUControl = 3'b001;
          ADD:     ALUControl = 3'b010;
          SUB:     ALUControl = 3'b100;
          SLT:     ALUControl = 3'b110;
          MUL:     ALUControl = 3'b101;
          
          default: ALUControl = 3'b010;
        endcase
      default: ALUControl = 3'b010;
    endcase
  end
  
endmodule