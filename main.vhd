library ieee;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity main is
  port (
    clk : in std_logic;
    reset : in std_logic;
    SW : in std_logic_vector(3 downto 0);
    BUT : in std_logic_vector(2 downto 0);
    dp : out std_logic_vector(3 downto 0);
    LED0 : out std_logic_vector(6 downto 0);
    LED1 : out std_logic_vector(6 downto 0);
    LED2 : out std_logic_vector(6 downto 0);
    LED3 : out std_logic_vector(6 downto 0)
  );
end entity;

architecture main of main is
  component seven_dig
    port (
      n : in integer range 0 to 9;
      LED : out std_logic_vector(6 downto 0)
    );
  end component;
  component clock
    port (
      clk : in std_logic;
      reset : in std_logic;
      SW : in std_logic;
      BUT : in std_logic_vector(2 downto 0);
      dp : out std_logic_vector(3 downto 0);
      digit0 : out integer range 0 to 9;
      digit1 : out integer range 0 to 9;
      digit2 : out integer range 0 to 9;
      digit3 : out integer range 0 to 9
    );
  end component;

  component stopwatch is
    port (
      clk : in std_logic;
      bot : in std_logic_vector(2 downto 0);
      dot : out std_logic_vector(3 downto 0);
      num3 : out integer range 0 to 9;
      num2 : out integer range 0 to 9;
      num1 : out integer range 0 to 9;
      num0 : out integer range 0 to 9
    );
  end component;
  signal digit11, digit21, digit31, digit01 : integer range 0 to 9;
  signal digit12, digit22, digit32, digit02 : integer range 0 to 9;
  signal digit13, digit23, digit33, digit03 : integer range 0 to 9;
  signal digit14, digit24, digit34, digit04 : integer range 0 to 9;
  signal digit15, digit25, digit35, digit05 : integer range 0 to 9;
  signal digit0, digit1, digit2, digit3 : integer range 0 to 9;
  signal clk_1, clk_2 : std_logic;
  signal dcnt, dcnt2 : std_logic_vector(24 downto 0);
  signal dp1, dp2 : std_logic_vector(3 downto 0);
begin

  process (clk) begin
    if clk'event and clk = '1' then
      if dcnt = 49999999 then
        dcnt <= "0000000000000000000000000";
      else
        dcnt <= dcnt + 1;
      end if;
    end if;
  end process;
  process (clk) begin
    if clk'event and clk = '1' then
      if dcnt2 = 4999999 then
        dcnt2 <= "0000000000000000000000000";
      else
        dcnt2 <= dcnt2 + 1;
      end if;
    end if;
  end process;
  -- clk_1 <= dcnt(25); --1Hz		
  -- clk_2 <= dcnt(23); --10Hz		

  clk_1 <= clk;
  clk_2 <= clk;
  CLOCK_0 : clock port map(clk_1, reset, SW(0), BUT, dp1, digit01, digit11, digit21, digit31);
  STOPWATCH_0 : stopwatch port map(clk_2, BUT, dp2, digit02, digit12, digit22, digit32);

  digit0 <= digit02 when SW(1) = '1' else
    digit01;

  digit1 <= digit12 when SW(1) = '1' else
    digit11;

  digit2 <= digit22 when SW(1) = '1' else
    digit21;

  digit3 <= digit32 when SW(1) = '1' else
    digit31;

  dp <= dp2 when SW(1) = '1' else
    dp1;

  SEVEN_SEG_0 : seven_dig port map(digit0, LED0);
  SEVEN_SEG_1 : seven_dig port map(digit1, LED1);
  SEVEN_SEG_2 : seven_dig port map(digit2, LED2);
  SEVEN_SEG_3 : seven_dig port map(digit3, LED3);
end architecture;