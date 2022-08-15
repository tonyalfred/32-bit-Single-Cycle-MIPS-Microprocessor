module data_path #
(
  parameter DATA_WIDTH         = 32 , 
  parameter INSTRUCTION_WIDTH  = 32 ,
  parameter ADDRESS_WIDTH      = 5 
)
( 
  /* Input Signals */
  input wire                          CLK        , 
  input wire                          Reset      ,
  
  input wire  [INSTRUCTION_WIDTH-1:0] Instr      , 
  input wire  [DATA_WIDTH-1:0]        ReadData   , 
  
  /* Control Signals */
  input wire  [2:0]                   ALUControl ,
  input wire                          PCSrc      , 
  input wire                          MemtoReg   , 
  input wire                          ALUSrc     , 
  input wire                          RegDst     , 
  input wire                          RegWrite   , 
  input wire                          Jmp        , 
  
  /* Outputs */
  output wire [INSTRUCTION_WIDTH-1:0] PC         , 
  output wire [DATA_WIDTH-1:0]        ALUOut     ,
  output wire [DATA_WIDTH-1:0]        WriteData  ,
  output wire                         Zero
);

/* Internal Signals */
  wire [INSTRUCTION_WIDTH-1:0]  PCPlus4        ;
  wire [INSTRUCTION_WIDTH-1:0]  PCBranch       ; 
  wire [INSTRUCTION_WIDTH-1:0]  PCPlus4Branch  ; 
  wire [INSTRUCTION_WIDTH-1:0]  PCNrmlJump     ;

  wire [INSTRUCTION_WIDTH-1:0]  SignImm        ;
  wire [INSTRUCTION_WIDTH-1:0]  SignImmShifted ;
  
  wire [INSTRUCTION_WIDTH-5:0]  InstrShifted   ;
  
  wire [DATA_WIDTH-1:0]         SrcA           ;
  wire [DATA_WIDTH-1:0]         SrcB           ;
  
  wire [DATA_WIDTH-1:0]         Result         ;
  
  wire [ADDRESS_WIDTH-1:0]      WriteReg       ;
    
/* Modules Instantiation */

/* Register File */
  register_file REG_FILE
( 
  .CLK (CLK)           , 
  .RST (Reset)         ,
  .A1  (Instr [25:21]) , 
  .A2  (Instr [20:16]) , 
  .A3  (WriteReg)      , 
  .WE3 (RegWrite)      , 
  .WD3 (Result)        , 
  .RD1 (SrcA)          , 
  .RD2 (WriteData)
);

/* Program Counter */
  program_counter PC0
(
  .CLK (CLK)        , 
  .RST (Reset)      ,
  .in  (PCNrmlJump) ,
  .out (PC) 
);

/* ALU */
  ALU ALU_1
(
  .in_0 (SrcA)       ,
  .in_1 (SrcB)       ,
  .sel  (ALUControl) , 
  .out  (ALUOut)     ,
  .zero (Zero)
);

/* Multiplexers */
/* 
  multiplexer_2x1 
(
  .in_0 (),
  .in_1 (),
  .sel  (),
  .out  ()
);  
*/
  multiplexer_2x1 MUX_PCSrc
(
  .in_0 (PCPlus4)       ,
  .in_1 (PCBranch)      ,
  .sel  (PCSrc)         ,
  .out  (PCPlus4Branch)
); 

  multiplexer_2x1 MUX_Jmp
(
  .in_0 (PCPlus4Branch)                   ,
  .in_1 ({PCPlus4 [31:28], InstrShifted}) ,
  .sel  (Jmp)                             ,
  .out  (PCNrmlJump) 
);  

  multiplexer_2x1 #(.DATA_WIDTH(ADDRESS_WIDTH)) MUX_RegDst
(
  .in_0 (Instr [20:16]) ,
  .in_1 (Instr [15:11]) ,
  .sel  (RegDst)        ,
  .out  (WriteReg)
);  

  multiplexer_2x1 MUX_ALUSrc
(
  .in_0 (WriteData) ,
  .in_1 (SignImm)   ,
  .sel  (ALUSrc)    ,
  .out  (SrcB)
);  

  multiplexer_2x1 MUX_MemtoReg
(
  .in_0 (ALUOut)   ,
  .in_1 (ReadData) ,
  .sel  (MemtoReg) ,
  .out  (Result)
); 

/* Adders */
/*  adder 
(
  .in_0 (),
  .in_1 (),
  .out  ()
);
*/
  adder ADDER_PCPlus4
(
  .in_0 (PC)                                         ,
  .in_1 ( {{(INSTRUCTION_WIDTH-3) {1'b0}}, 3'b100} ) ,    
  .out  (PCPlus4)
);

  adder ADDER_PCBranch
(
  .in_0 (SignImmShifted) ,
  .in_1 (PCPlus4)        ,
  .out  (PCBranch)
);

/* Sign Extenders */
/*
  sign_extend 
(
  .in  (), 
  .out ()
);
*/
  sign_extend SIGN_EXTEND_Instr
(
  .in  (Instr [15:0]) , 
  .out (SignImm)
);

/* Shifters */
/* shift_left 
(
  .in  (), 
  .out ()
);
*/
  shift_left SHIFT_SignImm
(
  .in  (SignImm)        , 
  .out (SignImmShifted)
);
 
  shift_left #(.DATA_WIDTH (28)) SHIFT_Instr
(
  .in  ({2'b00, Instr [25:0]}), 
  .out (InstrShifted)
);

endmodule