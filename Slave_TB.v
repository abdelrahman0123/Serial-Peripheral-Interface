`include "Slave.v"
module Slave_tb();
reg reset;
reg sclk;
reg MOSI;
wire MISO;
reg CS;
reg [7:0] slaveDataToSend;
wire [7:0] slaveDataReceived;

localparam PERIOD = 5;

assign slaveDataToSend = 8'b11010100;

initial begin
sclk = 0;
reset = 0;
MOSI = 0;
CS = 1;
#PERIOD CS = 0;
$display ("SlaveDataToSend = %b", slaveDataToSend);
$monitor ("%b | %b | %b", slaveDataReceived, MOSI, MISO);
#(PERIOD*17) if (slaveDataReceived == 8'b10101010) begin
	$display ("Success!");
	$finish;
end
else begin
	$display ("Failed!");
	$finish;
end
end
always begin
	#PERIOD sclk = ~sclk;
	MOSI = ~MOSI;
end


Slave S(
reset,
slaveDataToSend,
slaveDataReceived,
sclk,
CS,
MOSI,
MISO
);

endmodule
