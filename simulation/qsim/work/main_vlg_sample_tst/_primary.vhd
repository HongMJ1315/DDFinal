library verilog;
use verilog.vl_types.all;
entity main_vlg_sample_tst is
    port(
        BUT             : in     vl_logic_vector(2 downto 0);
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        SW              : in     vl_logic_vector(3 downto 0);
        sampler_tx      : out    vl_logic
    );
end main_vlg_sample_tst;
