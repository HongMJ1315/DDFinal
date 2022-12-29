library verilog;
use verilog.vl_types.all;
entity main is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        SW              : in     vl_logic_vector(3 downto 0);
        BUT             : in     vl_logic_vector(2 downto 0);
        dp              : out    vl_logic_vector(3 downto 0);
        ring            : out    vl_logic;
        SEG0            : out    vl_logic_vector(6 downto 0);
        SEG1            : out    vl_logic_vector(6 downto 0);
        SEG2            : out    vl_logic_vector(6 downto 0);
        SEG3            : out    vl_logic_vector(6 downto 0);
        check           : out    vl_logic
    );
end main;
