// FULL ADDER

module adder(inp1,inp2,cin,cout,s);
 output cout,s;
 input inp1,inp2,cin;
  wire w[2:0];
  xor x1(w[0],inp1,inp2);
  xor x2(s,w[0],cin); 
  and x3(w[1],inp1,inp2);
  and x4(w[2],w[0],cin);
  xor x5(cout,w[1],w[2]);
 endmodule 
 
module  full_adder(inp1,inp2,cin,cout,s);
  output [3:0]s;  
  output cout;
  input cin;
  input [3:0]inp1,inp2;
  wire c[2:0];
  adder a1(inp1[0],inp2[0],cin,c[0],s[0]);
  adder a2(inp1[1],inp2[1],c[0],c[1],s[1]);
  adder a3(inp1[2],inp2[2],c[1],c[2],s[2]);
  adder a4(inp1[3],inp2[3],c[2],cout,s[3]);  
endmodule

//FULL Subtractor

module full_sub(input1,input2,o);
output [3:0]o,input4,input3;
input [3:0]input1,input2;
reg [3:0]input4;
always @(input2)
begin
input4=~input2;
end
full_adder add1(input4,4'b0001,0,co,input3);
full_adder add2(input1,input3,0,cout2,o);
endmodule
//And Module

module full_and(inp1,inp2,y);
 input [3:0]inp1,inp2;
 output [3:0]y;
 and a1(y[0],inp1[0],inp2[0]);
 and a2(y[1],inp1[1],inp2[1]);
 and a3(y[2],inp1[2],inp2[2]);
 and a4(y[3],inp1[3],inp2[3]);
 endmodule

//Or Module

module full_or(inpi1,inpi2,r);
 input [3:0]inpi1,inpi2;
 output [3:0]r;
 or r1(r[0],inpi1[0],inpi2[0]);
 or r2(r[1],inpi1[1],inpi2[1]);
 or r3(r[2],inpi1[2],inpi2[2]);
 or r4(r[3],inpi1[3],inpi2[3]);
endmodule

//Mux Module
module mux2_1(inp1,inp2,s,ou);
input inp1,inp2,s;
output ou;
wire [2:0]w;

and g1(w[0],inp1,s);
not g2(w[1],s);
and g3(w[2],inp2,w[1]);
or  g4(ou,w[0],w[2]);
endmodule

module mux4_1(inp1,inp2,inp3,inp4,s1,s2,outpu);
input inp1,inp2,inp3,inp4,s1,s2;
output outpu;

mux2_1 m1(inp1,inp2,s1,y1);
mux2_1 m2(inp3,inp4,s1,y2);
mux2_1 m3(y1,y2,s2,outpu);
endmodule

//module memory

module memory(data1,data2,add);
output [3:0]data1;
output [3:0]data2;
input [3:0]add;
input cl;
reg [3:0]data1,data2;
reg [3:0]memodata[15:0];

initial 
	begin	
        memodata[0] = 4'b0000;
	memodata[1] = 4'b0001;
	memodata[2] = 4'b0001;
	memodata[3] = 4'b0100;
	memodata[4] = 4'b0011;
	memodata[5] = 4'b0001;
	memodata[6] = 4'b1000;
	memodata[7] = 4'b0001;
	memodata[8] = 4'b0011;
	memodata[9] = 4'b0001;
	memodata[10] = 4'b1100;
	memodata[11] = 4'b0001;
	memodata[12] = 4'b1000;
	memodata[13] = 4'b0001;
	memodata[14] = 4'b1011;
	memodata[15] = 4'b0001;
end
always @(add)
begin
	data1 = memodata[add];
	data2 = memodata[add+1];
end
endmodule

//program counter 1

module proc(ou,en,reset,c,p1);
output [3:0] ou;
reg    [3:0] ou;
input [3:0]p1;
input  en,reset,c;
always @(posedge c or reset)
begin
	if(reset == 1'b1)
	begin
		ou = 4'b0000;
	end
      else if(en == 1'b1)
	begin
		ou = p1 + 2;
	end
	
end
endmodule

//module program counter 2

module proc2(p,en,reset,cl,data2);
input en,reset,cl;
input [3:0]data2;
output [3:0]p;
reg [3:0]p;
always @(posedge cl or reset)
begin
	if(reset == 1'b1)
	begin
	     p = 4'b0000;
        end
        else if(en == 1'b1)
	begin
	      p = data2;
	end
end  
endmodule

//moduule program counter 3
module proc3(po,en,reset,clc,data2,p3);
input en,reset,clc;
input [3:0]data2,p3;
output [3:0]po;
reg [3:0]po;
always @(posedge clc or reset)
begin
	if(reset == 1'b1)
	begin
	   po = 4'b0000;
        end
        else if(en == 1'b1)
	begin
	      po = p3 + data2;
	end
end  
endmodule

//module selection datA2

module da(data1,data2,outt);
input [3:0]data2,data1;
output [3:0]outt;
or o1(out1,data1[0]+data1[1],data1[1]+data1[2]);
or o2(out2,data1[2]+data1[3],out1);
mux2_1 m32(data2[0],1'b0,out2,outt[0]);

or o3(out3,data1[0]+data1[1],data1[1]+data1[2]);
or o4(out4,data1[2]+data1[3],out3);
mux2_1 m42(data2[1],1'b0,out4,outt[1]);

or o5(out5,data1[0]+data1[1],data1[1]+data1[2]);
or o6(out6,data1[2]+data1[3],out5);
mux2_1 m332(data2[2],1'b0,out5,outt[2]);

or o7(out7,data1[0]+data1[1],data1[1]+data1[2]);
or o8(out8,data1[2]+data1[3],out7);
mux2_1 m423(data2[3],1'b0,out8,outt[3]);
endmodule


//module Alu
module alu(data1,input1,input2,sum,sum0,sum1,sum2,sum3);

input [3:0]input1,input2,data1;
output [3:0]sum,sum0,sum1,sum2,sum3;
full_adder f1(input1,input2,0,cout,sum0);
full_sub fs(input1,input2,sum1);
full_and fa(input1,input2,sum2);
full_or fr(input1,input2,sum3);
mux4_1 su0(sum2[0],sum0[0],sum1[0],sum3[0],data1[1],data1[0],sum[0]);
mux4_1 su1(sum2[1],sum0[1],sum1[1],sum3[1],data1[1],data1[0],sum[1]);
mux4_1 su2(sum2[2],sum0[2],sum1[2],sum3[2],data1[1],data1[0],sum[2]);
mux4_1 su3(sum2[3],sum0[3],sum1[3],sum3[3],data1[1],data1[0],sum[3]);

endmodule

//Test bench

module top;
 wire [3:0]data1,data2;
 wire [3:0]pc1,pc2,pc3,progc;
 wire [3:0]out;
 wire [3:0]sum,sum1,sum0,sum2,sum3,sumt;
 reg [3:0]accu;
 reg [3:0]pc;
 reg reset,clk,en;
 wire cnt;
memory m(data1,data2,pc);
proc p1(pc1,en,reset,clk,pc);
proc2 p2(pc2,en,reset,clk,data2);
proc3 p3(pc3,en,reset,clk,data2,pc);
not n1(x,data1[3]);
not n2(t,data1[2]*data1[3]);
mux2_1 mum1(pc1[0],pc2[0],x,h1);
mux2_1 mum3(h1,pc3[0],t,progc[0]);
mux2_1 mum2(pc1[1],pc2[1],x,h2);
mux2_1 mum4(h2,pc3[1],t,progc[1]);
mux2_1 mum51(pc1[2],pc2[2],x,h3);
mux2_1 mum53(h3,pc3[2],t,progc[2]);
mux2_1 mum41(pc1[3],pc2[3],x,h4);
mux2_1 mum23(h4,pc3[3],t,progc[3]);
da d2(data1,accu,out);
alu a(data1,out,data2,sum,sum0,sum1,sum2,sum3);
mux2_1 mum322(accu[0],sum[0],data1[3],sumt[0]);
mux2_1 mum32322(accu[1],sum[1],data1[3],sumt[1]);
mux2_1 mum222(accu[2],sum[2],data1[3],sumt[2]);
mux2_1 mum2222(accu[3],sum[3],data1[3],sumt[3]);

initial begin
	$monitor("data1=%b data2=%b,pc=%b clk=%b ac=%b",data1,data2,progc,clk,sumt);       
	accu=4'b0000;
	pc=4'b0000;	
	reset=1'b1;
	reset=1'b0;
	#1 en=1'b1;
	#1 clk=1'b0;
	 
	#1 clk=1'b1;
	#1 clk=1'b0;
	#1 clk=1'b1;
	#1 clk=1'b0;
	#1 clk=1'b1;
	#1 clk=1'b0;
	#1 clk=1'b1;
	#1 clk=1'b0;
	#1 clk=1'b1;
	#1 en=1'b0;

$finish;
end
always @(posedge clk)
begin
accu=sumt;
end
always @(posedge clk)
begin
#2
pc=progc;
end
always @(reset)
begin
if(reset==1'b1)
accu=4'b0000;
end
endmodule
