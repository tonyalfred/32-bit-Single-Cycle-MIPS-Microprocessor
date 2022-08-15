module control_unit
(
  input  wire [5:0] OpCode     ,
  input  wire [5:0] Funct      ,
  input  wire       Zero       ,
  
  output wire [2:0] ALUControl ,
  
  output wire       MemtoReg   ,
  output wire       MemWrite   ,
  output wire       ALUSrc     ,
  output wire       RegDst     ,
  output wire       RegWrite   ,
  output wire       Jmp        ,
  output wire       PCSrc
);

/* Internal Signals */
  wire [1:0] ALUOp;

  main_decoder MAIN_DECOD
(
  .OpCode     (OpCode)      ,
  .Zero       (Zero)        ,
  
  .ALUOp      (ALUOp)       ,
  
  .MemtoReg   (MemtoReg)    ,
  .MemWrite   (MemWrite)    ,
  .ALUSrc     (ALUSrc)      ,
  .RegDst     (RegDst)      ,
  .RegWrite   (RegWrite)    ,
  .Jmp        (Jmp)         ,
  .PCSrc      (PCSrc)
);

  ALU_decoder ALU_DECOD
(
  .Funct      (Funct)      ,
  .ALUOp      (ALUOp)      ,
  .ALUControl (ALUControl)
);  

endmodule
