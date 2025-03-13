module fast2slow2(i_clk_f, i_pluse_f, i_clk_s, o_pluse_s, i_reset);
input i_reset;
input i_clk_f; //快時鐘
input i_pluse_f; //快時鐘域的脈衝信號
input i_clk_s; //慢時鐘
output o_pluse_s; //慢時鐘域的脈衝信號

reg r_temp;
//在快時鐘域下監測輸入脈衝為1的時候翻轉
always @(posedge i_clk_f or negedge i_reset)begin
	if(!i_reset)
		r_temp <= 1'b0;
	else if(i_pluse_f == 1'b1)
		r_temp <= ~r_temp;
	else
		r_temp <= r_temp;
end

//打三拍，才能XOR
reg r_temp_d0;
reg r_temp_d1;
reg r_temp_d2;
always @(posedge i_clk_s or negedge i_reset)begin
	if(!i_reset)begin
		r_temp_d0 <= 1'b0;
		r_temp_d1 <= 1'b0;
		r_temp_d2 <= 1'b0;
	end
	else begin
		r_temp_d0 <= r_temp;
		r_temp_d1 <= r_temp_d0;
		r_temp_d2 <= r_temp_d1;
	end
end

//後兩拍值進行XOR
assign o_pluse_s = r_temp_d1 ^ r_temp_d2;

endmodule