module ff( clk,en ,rst,D,Q);
parameter width=1;
parameter DREG=0;
parameter RSTTYPE="SYNC";
input clk,rst,en;
input [width-1:0]D;
output [width-1:0]Q;
reg [width-1:0] tmp;
generate
    if(RSTTYPE=="SYNC")
    begin
 always@(posedge clk)
begin
         
   if(rst)

    tmp<=0;
    else if(en)
    tmp<=D;
   end 
end
     
else
begin
always@(posedge clk,posedge rst)
begin
   if(rst)

    tmp<=0;
    else if(en)
    tmp<=D; 

   end 
end
   endgenerate
   assign Q = (DREG)? tmp:D;

endmodule
