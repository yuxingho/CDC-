module slow2fast(i_clk_s, i_pluse_s, i_clk_f, o_pluse_f);
input i_clk_s;//慢時鐘
input i_pluse_s;//慢時鐘域下的脈衝訊號
input i_clk_f;//快時鐘
output o_pluse_f;

//打兩拍
reg r_pluse_s_d0;//進行延遲
reg r_pluse_s_d1;
//打兩拍
always @(posedge i_clk_f)begin
	r_pluse_s_d0 <= i_pluse_s;
	r_pluse_s_d1 <= r_pluse_s_d0;
end

assign o_pluse_f = r_pluse_s_d1;

endmodule 
