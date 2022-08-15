module mips_tb;

  reg     clk, rst;
  wire    [15:0] test_value;

  mips U1 (clk, rst, test_value);
  
  initial
    begin
      rst <= 1; #5; rst <= 0; #5; rst <= 1; 
    end

  always
    begin
      clk <= 0; # 25; clk <= 1; #25;
    end
    
endmodule
