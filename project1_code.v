module project_1 (A,B,D,C,CLK,CARRYIN,OPMODE,BCIN,RSTA,RSTB,RSTM,RSTP,RSTC,RSTD,RSTCARRYIN,RSTOPMODE,CEA,CEB,CEM,CEP,CEC,CED,CECARRYIN,CEOPMODE,PCIN,BCOUT,PCOUT,P,M,CARRYOUT,CARRYOUTF);
parameter A0REG=0;
parameter A1REG=1;
parameter B0REG=0;
parameter B1REG=1;
parameter CREG=1;
parameter MREG=1;
parameter DREG=1;
parameter PREG=1;
parameter CARRYINREG=1;
parameter CARRYOUTREG=1;
parameter OPMODEREG=1;
parameter CARRINYSEL="OPMODE5";
parameter B_INPUT = "DIRECT";
parameter RSTTYPE ="SYNC";

parameter EXAMPLE_GIT;


input CLK,RSTA,RSTB,RSTM,RSTP,RSTC,RSTD,RSTCARRYIN,RSTOPMODE,CEA,CEB,CEP,CEC,CED,CEM,CARRYIN,CECARRYIN,CEOPMODE;
input [17:0]A,B,D,BCIN;
input [7:0] OPMODE;
input [47:0]C,PCIN;
output [17:0] BCOUT;
output  [47:0] PCOUT,P;
output  CARRYOUT,CARRYOUTF;
output  [35:0] M;

wire [17:0] B_MUX;
wire[17:0] A_REG;
wire[17:0] B_REG;
wire[17:0] D_REG;
wire [47:0] C_REG;
wire [7:0] OPMODE_REG;
wire [17:0] result_REG;
wire [17:0] A_REG2;
wire [35:0] multiply_REG;
wire CARRY_IN_MUX;
wire CARRYIN_REG;
reg [17:0] add_sub;
reg [17:0] result;
reg[35:0] multiply;
reg[47:0] X;
reg [47:0]Z;
reg [47:0] add_sub_2;
reg cout;
assign B_MUX= (B_INPUT == "DIRECT")? B: (B_INPUT == "CASCADE")? BCIN:0;
assign  CARRY_IN_MUX= (CARRINYSEL=="OPMODE5")? OPMODE_REG[5]: (CARRINYSEL=="CARRYIN")?CARRYIN:1'b0;
ff #(.width(18),.DREG(A0REG),.RSTTYPE(RSTTYPE)) A0( CLK,CEA ,RSTA,A,A_REG);
ff #(.width(18),.DREG(B0REG),.RSTTYPE(RSTTYPE)) B0( CLK,CEB ,RSTB,B_MUX,B_REG);
ff #(.width(48),.DREG(CREG),.RSTTYPE(RSTTYPE)) C_ff ( CLK,CEC ,RSTC,C,C_REG);
ff #(.width(18),.DREG(DREG),.RSTTYPE(RSTTYPE)) D_ff( CLK,CED ,RSTD,D,D_REG);
ff #(.width(8),.DREG(OPMODEREG),.RSTTYPE(RSTTYPE)) OPMODE_ff ( CLK,CEOPMODE ,RSTOPMODE,OPMODE,OPMODE_REG);
ff #(.width(18),.DREG(B1REG),.RSTTYPE(RSTTYPE)) B1 ( CLK,CEB ,RSTB,result,result_REG);
ff #(.width(18),.DREG(A1REG),.RSTTYPE(RSTTYPE)) A1( CLK,CEA ,RSTA,A_REG,A_REG2);
ff #(.width(36),.DREG(MREG),.RSTTYPE(RSTTYPE)) M_ff( CLK,CEM ,RSTM,multiply,multiply_REG);
ff #(.width(1),.DREG(CARRYINREG),.RSTTYPE(RSTTYPE)) CARRYIN_ff( CLK,CECARRYIN ,RSTCARRYIN,CARRY_IN_MUX,CARRYIN_REG);
ff #(.width(48),.DREG(PREG),.RSTTYPE(RSTTYPE)) P_ff( CLK,CEP ,RSTP,add_sub_2,P);
ff #(.width(1),.DREG(CARRYOUTREG),.RSTTYPE(RSTTYPE)) CARRYOUT_ff( CLK,CECARRYIN ,RSTCARRYIN,cout,CARRYOUT);
assign CARRYOUTF=CARRYOUT;
assign PCOUT= P;
assign BCOUT= result_REG;
assign M=multiply_REG;
always@(*)
begin
    
if(!OPMODE_REG[6])
add_sub= D_REG+B_REG;
else
add_sub=D_REG-B_REG;

if(OPMODE_REG[4])
result= add_sub;
else
result= B_REG;

end


always@(*)
begin
    multiply=A_REG2*result_REG;
end

always@ (*)
begin
case(OPMODE_REG[1:0])
2'b00:X=0;
2'b01:X=multiply_REG;
2'b10:X=P;
2'b11:X={D_REG,A_REG2,result_REG};
endcase    

end
always@(*)
begin
    case(OPMODE_REG[3:2])
    2'b00:Z=0;
    2'b01:Z=PCIN;
    2'b10:Z=P;
    2'b11:Z=C_REG;


endcase
end
always@(*)
begin
    if(!OPMODE_REG[7])
    
 {cout,add_sub_2}= X+Z+CARRYIN_REG;
 else
  {cout,add_sub_2}=Z-(X+CARRYIN_REG);  
end



endmodule
