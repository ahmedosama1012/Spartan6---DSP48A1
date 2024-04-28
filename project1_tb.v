module project_1_tb();
parameter A0REG=0;
parameter A1REG=0;
parameter B0REG=0;
parameter B1REG=0;
parameter CREG=0;
parameter MREG=0;
parameter DREG=0;
parameter PREG=0;
parameter CARRYINREG=0;
parameter CARRYOUTREG=0;
parameter OPMODEREG=0;
parameter CARRINYSEL="OPMODE5";
parameter B_INPUT = "DIRECT";
parameter RSTTYPE ="ASYNC";

reg CLK,RSTA,RSTB,RSTM,RSTP,RSTC,RSTD,RSTCARRYIN,RSTOPMODE,CEA,CEB,CEP,CEC,CED,CEM,CARRYIN,CECARRYIN,CEOPMODE;
reg [17:0]A,B,D,BCIN;
reg [7:0] OPMODE;
reg [47:0]C,PCIN;

wire [17:0] BCOUT;
wire  [47:0] PCOUT,P;
wire  CARRYOUT,CARRYOUTF;
wire  [35:0] M;
 project_1 #(A0REG,A1REG,B0REG,B1REG,CREG,MREG,DREG,PREG,CARRYINREG,CARRYOUTREG,OPMODEREG,CARRINYSEL,B_INPUT,RSTTYPE) P1(A,B,D,C,CLK,CARRYIN,OPMODE,
 	BCIN,RSTA,RSTB,RSTM,RSTP,RSTC,RSTD,RSTCARRYIN,RSTOPMODE,CEA,CEB,CEM,CEP,CEC,CED,CECARRYIN,CEOPMODE,PCIN,BCOUT,PCOUT,P,M,CARRYOUT,CARRYOUTF);
 initial begin
	CLK=0;
	forever begin
	#1 CLK=~CLK;
	end
	end

initial begin
//Reset all registers && initial values.
RSTA=1'b1;
RSTB=1'b1;
RSTM=1'b1;
RSTP=1'b1;
RSTC=1'b1;
RSTD=1'b1;
RSTCARRYIN=1'b1;
RSTOPMODE=1'b1;
//Enables
CEA=1'b0;
CEB=1'b0;
CEM=1'b0;
CEP=1'b0;
CEC=1'b0;
CED=1'b0;
CECARRYIN=1'b0;
CEOPMODE=1'b0;
//inputs
A=1'b0;
B=1'b0;
BCIN=1'b0;
C=1'b0;
D=1'b0;
PCIN=1'b0;
OPMODE=1'b0;
CARRYIN=1'b0;
#20;
RSTA=1'b0;
RSTB=1'b0;
RSTM=1'b0;
RSTP=1'b0;
RSTC=1'b0;
RSTD=1'b0;
RSTCARRYIN=1'b0;
RSTOPMODE=1'b0;
CEA=1'b1;
CEB=1'b1;
CEM=1'b1;
CEP=1'b1;
CEC=1'b1;
CED=1'b1;
CECARRYIN=1'b1;
CEOPMODE=1'b1;
#10;
RSTA=1'b0;
RSTB=1'b0;
RSTM=1'b0;
RSTP=1'b0;
RSTC=1'b0;
RSTD=1'b0;
RSTCARRYIN=1'b0;
RSTOPMODE=1'b0;
OPMODE=8'b10100111;
B=4;
PCIN=10;
A=1'b0;
BCIN=0;
C=0;
D=0;
CARRYIN=1'b0;
#20;
//test that the value of pre_adder will pass to post_adder and the value of C&Carry_in will be passed.
OPMODE=8'b00011101;
B=4'd10;
D=4'd9;
A=4'd3;
C=4'd3;
CARRYIN=1'b1;
#20;
//test that the value of pre_subtractor will pass to post_subtractor and the value of PCin&Carry_in will be passed.
OPMODE=8'b11010101;
B=4'd10;
D=5'd20;
A=4'd6;
PCIN=10'd600;
CARRYIN=1'b0;
#20;
//test Zero condition.
OPMODE=8'b11010000;
#10;
//Passing B to multiplier passing P to post_adder
OPMODE=8'b11001010; 
B=4'd14;
A=4'd10;
#20;
//
OPMODE=8'b00111111;
B=5;
A=0;
D=0;
C=3;
CARRYIN=0;
#20;

OPMODE=8'b00111111;
B=18'b1111_1111_1111_1111_11;
A=18'b1111_1111_1111_1111_11;
D=18'b1111_1111_1111_1111_11;
C=0;
#20;
OPMODE=8'b00101111;
B=18'b1111_1111_1111_1111_11;
A=18'b1111_1111_1111_1111_11;
D=18'b1111_1111_1111_1111_11;
C=0;
#20;
RSTA=1'b1;
RSTB=1'b1;
RSTM=1'b1;
RSTP=1'b1;
RSTC=1'b1;
RSTD=1'b1;
RSTCARRYIN=1'b1;
RSTOPMODE=1'b1;
#20;
RSTA=1'b0;
RSTB=1'b0;
RSTM=1'b0;
RSTP=1'b0;
RSTC=1'b0;
RSTD=1'b0;
RSTCARRYIN=1'b0;
RSTOPMODE=1'b0;
OPMODE=8'b10100111;
B=4;
PCIN=10;
A=1'b0;
BCIN=0;
C=0;
D=0;
CARRYIN=1'b0;
#20;


 $stop;

end
initial begin
$monitor("CLK=%b,rst=%b,enable=%b,OPMODE=%b,A=%d,B=%d,C=%d,D=%d,CARRYIN=%b,BCIN=%b,PCIN=%b,BCOUT=%d,M=%d,P=%d,PCOUT=%d,CARRYOUT=%b,CARRYOUTF=%b",CLK,RSTA,CEA,OPMODE,A,B,C,D,CARRYIN,BCIN,PCIN,BCOUT,M,P,PCOUT,CARRYOUT,CARRYOUTF);
end
endmodule
