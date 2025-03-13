module fast2slow(i_clk_f, i_pluse_f, i_clk_s, o_pluse_s, i_reset);
input i_reset;
input i_clk_f; //快時鐘
input i_pluse_f; //快時鐘域的脈衝信號
input i_clk_s; //慢時鐘
output o_pluse_s; //慢時鐘域的脈衝信號

//要把快時鐘域的脈衝信號同步到慢時鐘域
reg [2:0]r_pluse ; //打拍暫存器

//在快時鐘域下進行打拍
//r_pluse[0] <= i_pluse_f;
//r_pluse[1] <= r_pluse[0];
//r_pluse[2] <= r_pluse[1];
always @(posedge i_clk_f or negedge i_reset)begin
	if(!i_reset)
		r_pluse[2:0] <= 'd0;
	else 
		r_pluse[2:0] <= {r_pluse[1:0], i_pluse_f};
end

wire w_pluse;
assign w_pluse = |r_pluse; //r_pluse[0] | r_pluse[1] | r_pluse[2]

reg r_pluse_d0;
reg r_pluse_d1;
always @(posedge i_clk_s or negedge i_reset)begin
	if(!i_reset)
	begin
		r_pluse_d0 <= 'd0;
		r_pluse_d1 <= 'd0;
	end
	else 
	begin
		r_pluse_d0 <= w_pluse;
		r_pluse_d1 <= r_pluse_d0;
	end
end

assign o_pluse_s = r_pluse_d1;

endmodule
