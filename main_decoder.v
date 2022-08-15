module main_decoder
(
  input wire [5:0] OpCode   ,
  input wire       Zero     ,
  
  output reg [1:0] ALUOp    ,
  
  output reg       MemtoReg ,
  output reg       MemWrite ,
  output reg       ALUSrc   ,
  output reg       RegDst   ,
  output reg       RegWrite ,
  output reg       Jmp      ,
  output wire      PCSrc       
);

reg Branch;

localparam  rType           =   6'b00_0000 ;
localparam  loadWord        =   6'b10_0011 ;
localparam  storeWord       =   6'b10_1011 ;
localparam  addImmediate    =   6'b00_1000 ;
localparam  branchIfEqual   =   6'b00_0100 ;
localparam  jump_inst       =   6'b00_0010 ;

assign PCSrc = Branch & Zero ;

always @(*) 
  begin
    case (OpCode)
      rType :
        begin
            Jmp         =   1'b0  ; 
            ALUOp       =   2'b10 ;
            MemWrite    =   1'b0  ;
            RegWrite    =   1'b1  ;
            RegDst      =   1'b1  ;
            ALUSrc      =   1'b0  ;
            MemtoReg    =   1'b0  ;
            Branch      =   1'b0  ;
        end
      loadWord :
        begin
            Jmp         =   1'b0  ; 
            ALUOp       =   2'b00 ;
            MemWrite    =   1'b0  ;
            RegWrite    =   1'b1  ;
            RegDst      =   1'b0  ;
            ALUSrc      =   1'b1  ;
            MemtoReg    =   1'b1  ;
            Branch      =   1'b0  ;
        end
      storeWord :
        begin
            Jmp         =   1'b0  ; 
            ALUOp       =   2'b00 ;
            MemWrite    =   1'b1  ;
            RegWrite    =   1'b0  ;
            RegDst      =   1'b0  ;
            ALUSrc      =   1'b1  ;
            MemtoReg    =   1'b1  ;
            Branch      =   1'b0  ;
        end
      addImmediate :
        begin
            Jmp         =   1'b0  ; 
            ALUOp       =   2'b00 ;
            MemWrite    =   1'b0  ;
            RegWrite    =   1'b1  ;
            RegDst      =   1'b0  ;
            ALUSrc      =   1'b1  ;
            MemtoReg    =   1'b0  ;
            Branch      =   1'b0  ;
        end
      branchIfEqual :
        begin
            Jmp         =   1'b0  ; 
            ALUOp       =   2'b01 ;
            MemWrite    =   1'b0  ;
            RegWrite    =   1'b0  ;
            RegDst      =   1'b0  ;
            ALUSrc      =   1'b0  ;
            MemtoReg    =   1'b0  ;
            Branch      =   1'b1  ;
        end
      jump_inst :
        begin
            Jmp         =   1'b1  ; 
            ALUOp       =   2'b00 ;
            MemWrite    =   1'b0  ;
            RegWrite    =   1'b0  ;
            RegDst      =   1'b0  ;
            ALUSrc      =   1'b0  ;
            MemtoReg    =   1'b0  ;
            Branch      =   1'b0  ;
        end
      default : 
        begin
            Jmp         =   1'b0  ; 
            ALUOp       =   2'b00 ;
            MemWrite    =   1'b0  ;
            RegWrite    =   1'b0  ;
            RegDst      =   1'b0  ;
            ALUSrc      =   1'b0  ;
            MemtoReg    =   1'b0  ;
            Branch      =   1'b0  ;
        end  
    endcase
  end
  
endmodule