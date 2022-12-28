library verilog;
use verilog.vl_types.all;
entity main_vlg_check_tst is
    port(
        LED0            : in     vl_logic_vector(7 downto 0);
        LED1            : in     vl_logic_vector(7 downto 0);
        LED2            : in     vl_logic_vector(7 downto 0);
        LED3            : in     vl_logic_vector(7 downto 0);
        sampler_rx      : in     vl_logic
    );
end main_vlg_check_tst;
