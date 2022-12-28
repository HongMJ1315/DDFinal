library verilog;
use verilog.vl_types.all;
entity main is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        SW              : in     vl_logic_vector(3 downto 0);
        BUT             : in     vl_logic_vector(2 downto 0);
        LED0            : out    vl_logic_vector(7 downto 0);
        LED1            : out    vl_logic_vector(7 downto 0);
        LED2            : out    vl_logic_vector(7 downto 0);
        LED3            : out    vl_logic_vector(7 downto 0)
    );
end main;
