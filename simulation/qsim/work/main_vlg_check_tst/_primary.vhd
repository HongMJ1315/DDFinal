library verilog;
use verilog.vl_types.all;
entity main_vlg_check_tst is
    port(
        dp              : in     vl_logic_vector(3 downto 0);
        ring            : in     vl_logic;
        SEG0            : in     vl_logic_vector(6 downto 0);
        SEG1            : in     vl_logic_vector(6 downto 0);
        SEG2            : in     vl_logic_vector(6 downto 0);
        SEG3            : in     vl_logic_vector(6 downto 0);
        sampler_rx      : in     vl_logic
    );
end main_vlg_check_tst;
