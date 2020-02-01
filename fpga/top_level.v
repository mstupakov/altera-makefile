module top_level (
  input   CLOCK_50,
  input  [1:0] KEY,
  output [7:0] LED
);

  reg data = 1'b1;
  reg [32:0] counter;
  reg state;

  assign LED[0] = state;
  assign LED[1] = data;

  always @ (posedge CLOCK_50) begin
    counter <= counter + 1;
    state <= counter[20];
  end

  assign LED[3] = KEY[0];
  assign LED[4] = !KEY[1];

  PwmGenerator
  #(.F(50_000_000), .HZ(1), .D(75)) pwm_1
  (
    .clk(CLOCK_50),
    .rst(1),

    .pin(LED[5])
  );

  PwmGenerator
  #(.F(50_000_000), .HZ(2), .D(25)) pwm_2
  (
    .clk(CLOCK_50),
    .rst(1),

    .pin(LED[6])
  );

  PwmGenerator
  #(.F(50_000_000), .HZ(1), .D(25)) pwm_3
  (
    .clk(CLOCK_50),
    .rst(1),

    .pin(LED[7])
  );

endmodule
