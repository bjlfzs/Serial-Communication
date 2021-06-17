`timescale 1ns/1ns
`define clk_period 20

module uart_input;

reg Clk;
reg Rst;
reg [7:0]data_byte;
reg send_en;
reg [2:0]baud_set;

wire Rs232_Tx;
wire state;
wire Tx_Done;	
wire [7:0]data_w;
wire check1;
	uart Test(
		.Clk(Clk),		//50MHz
		.Rst(Rst),		//复位信号
		.data_byte(data_byte),	//输入信号
		.send_en(send_en),		//使能端,高脉冲启动
		.baud_set(),	//波特率设置端（9600/19200/...）
	 
		.Rs232_Tx(Rs232_Tx),	//1输出
		.data_w(data_w),
		.check1(check1)
	);
	
	initial 	Clk <= 0;
	always #(`clk_period/2)	 Clk = ~Clk;
	initial
		begin
			Rst = 1'b0;
			send_en = 1'd0;
			baud_set = 3'd4;
			data_byte=8'd 0;
			#(`clk_period *20 + 1)
			Rst = 1'b1;
			#(`clk_period * 50);
			data_byte=8'b10011110;
			send_en = 1'd1;
			#(`clk_period);
			send_en = 1'd0;
			@(negedge Tx_Done)
			#(`clk_period*5000);
				send_en = 1'd1;
				data_byte=8'h55;
			#(`clk_period);
				send_en=1'd0;
			@(negedge Tx_Done)
			#(`clk_period*5000);
			$stop;	
		end
endmodule 