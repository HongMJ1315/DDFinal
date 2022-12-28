library verilog;
use verilog.vl_types.all;
entity main_vlg_check_tst is
    port(
        dp              : in     vl_logic_vector(3 downto 0);
        LED0            : in     vl_logic_vector(6 downto 0);
        LED1            : in     vl_logic_vector(6 downto 0);
        LED2            : in     vl_logic_vector(6 downto 0);
        LED3            : in     vl_logic_vector(6 downto 0);
        sampler_rx      : in     vl_logic
    );
end main_vlg_check_tst;
