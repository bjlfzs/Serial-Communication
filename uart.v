module uart(
	Clk,		//50MHz
	Rst,		//复位信号
	data_byte,	//输入信号
	send_en,		//使能端,高脉冲启动
	baud_set,	//波特率设置端（9600/19200/...）
	
	Rs232_Tx,	//1输出
	data_w,	//2读入
	check1		//字符检查
);

input Clk;
input Rst;
input [7:0]data_byte;
input send_en;
input [2:0]baud_set;

output Rs232_Tx;
output [7:0]data_w;
output check1;

wire led;
wire Rx_Done;

	uart_byte_tx uart_byte_tx(
		.Clk(Clk),
		.Rst_n(Rst),
		.data_byte(data_byte),
		.send_en(send_en),
		.baud_set(3'd0),
		
		.Rs232_Tx(Rs232_Tx),
		.Tx_Done(),
		.uart_state(led)
	);
	

	uart_byte_rx uart_byte_rx(
		.Clk(Clk),
		.Rst_n(Rst),
		.baud_set(3'd0),
		.Rs232_Rx(Rs232_Tx),
		
		.data_byte(data_w),
		.check1(check1),
		.Rx_Done(Rx_Done)
	);
endmodule