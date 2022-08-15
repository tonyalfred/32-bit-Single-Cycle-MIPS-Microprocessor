module mips #
(
  parameter   INSTRUCTION_WIDTH  = 32 ,
  parameter   DATA_WIDTH         = 32  
) 
(
  input  wire                      CLK        ,
  input  wire                      Reset      ,

  output wire [(DATA_WIDTH/2)-1:0] test_value
);

/* Internal Signals */
  wire [INSTRUCTION_WIDTH-1:0] PC         ;
  wire [INSTRUCTION_WIDTH-1:0] Instr      ;

  wire [DATA_WIDTH-1:0]        ALUOut     ;
  wire [DATA_WIDTH-1:0]        WriteData  ;
  wire [DATA_WIDTH-1:0]        ReadData   ;

  wire [2:0]                   ALUControl ;
  wire                         Jmp        ;
  wire                         Zero       ;
  wire                         PCSrc      ;
  wire                         MemtoReg   ;
  wire                         ALUSrc     ;
  wire                         RegDst     ;
  wire                         RegWrite   ;
  wire                         MemWrite   ;

/* Data Unit */
  data_path DATA_PATH
(
  .CLK        (CLK)        , 
  .Reset      (Reset)      ,
  
  .Instr      (Instr)      , 
  .ReadData   (ReadData)   , 
  
  .ALUControl (ALUControl) ,
  .PCSrc      (PCSrc)      , 
  .MemtoReg   (MemtoReg)   , 
  .ALUSrc     (ALUSrc)     , 
  .RegDst     (RegDst)     , 
  .RegWrite   (RegWrite)   , 
  .Jmp        (Jmp)        , 
  
  .PC         (PC)         , 
  .ALUOut     (ALUOut)     ,
  .WriteData  (WriteData)  ,
  .Zero       (Zero)
);

/* Instruction Memory */
  instruction_memory INSTR_MEM
( 
  .A  (PC)    , 
  
  .RD (Instr) 
);

/* Data Memory */
 data_memory DATA_MEM
( 
  .CLK        (CLK)       , 
  .RST        (Reset)     ,
  
  .A          (ALUOut)    , 
  .WE         (MemWrite)  , 
  .WD         (WriteData) , 
  
  .RD         (ReadData)  ,
  .test_value (test_value)
);

/* Control Unit */
  control_unit CNTRL_UNIT
(
  .OpCode     (Instr [31:26]) ,
  .Funct      (Instr [5:0])   ,
  .Zero       (Zero)          ,
  
  .ALUControl (ALUControl)    ,
  
  .MemtoReg   (MemtoReg)      ,
  .MemWrite   (MemWrite)      ,
  .ALUSrc     (ALUSrc)        ,
  .RegDst     (RegDst)        ,
  .RegWrite   (RegWrite)      ,
  .Jmp        (Jmp)           ,
  .PCSrc      (PCSrc)
);

endmodule