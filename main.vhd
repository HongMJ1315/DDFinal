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
    ring : out std_logic;
    SEG0 : out std_logic_vector(6 downto 0);
    SEG1 : out std_logic_vector(6 downto 0);
    SEG2 : out std_logic_vector(6 downto 0);
    SEG3 : out std_logic_vector(6 downto 0);
    check : out std_logic
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

  component alarm is
    port (
      clk : in std_logic;
      sec : in std_logic;
      reset : in std_logic;
      now0 : in integer range 0 to 9;
      now1 : in integer range 0 to 9;
      now2 : in integer range 0 to 9;
      now3 : in integer range 0 to 9;
      BUT : in std_logic_vector(2 downto 0);
      ring : out std_logic;
      tar0 : out integer range 0 to 9;
      tar1 : out integer range 0 to 9;
      tar2 : out integer range 0 to 9;
      tar3 : out integer range 0 to 9
    );
  end component;

  component countdown is
    port (
      clk : in std_logic;
      reset : in std_logic;
      sec : in std_logic;
      bot : in std_logic_vector(2 downto 0);
      ring : out std_logic;
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
  signal ring1, ring2 : std_logic;
  signal dcnt, dcnt2 : std_logic_vector(24 downto 0);
  signal dcnttest : std_logic_vector(9 downto 0);
  signal dp1, dp2, dp3 : std_logic_vector(3 downto 0);
begin

  process (clk, reset) begin
    if clk'event and clk = '1' then
      if dcnt = 49999999 then
        dcnt <= "0000000000000000000000000";
      else
        dcnt <= dcnt + 1;
      end if;
    end if;
  end process;
  process (clk, reset) begin
    if clk'event and clk = '1' then
      if dcnt2 = 4999999 then
        dcnt2 <= "0000000000000000000000000";
      else
        dcnt2 <= dcnt2 + 1;
      end if;
    end if;
  end process;
  process (clk, reset) begin
    if clk'event and clk = '1' then
      if dcnttest = 10 then
        dcnttest <= "0000000000";
      else
        dcnttest <= dcnttest + 1;
      end if;
    end if;
  end process;
  -- clk_1 <= dcnt(25); --1Hz		
  -- clk_2 <= dcnt(23); --10Hz		

  clk_1 <= clk; --for test
  clk_2 <= dcnttest(3); --for test
  check <= dcnttest(3);
  CLOCK_0 : clock port map(clk_1, reset, SW(0), BUT, dp1, digit01, digit11, digit21, digit31);
  STOPWATCH_0 : stopwatch port map(clk_2, BUT, dp2, digit02, digit12, digit22, digit32);
  ALARM_0 : alarm port map(clk, clk_1, reset, digit01, digit11, digit21, digit31, BUT, ring1, digit03, digit13, digit23, digit33);
  CNTDOWN : countdown port map(clk, reset, clk_2, BUT, ring2, dp3, digit04, digit14, digit24, digit34);
  digit0 <=
    digit02 when SW(1) = '1' else
    digit03 when SW(2) = '1' else
    digit04 when SW(3) = '1' else
    digit01;

  digit1 <=
    digit12 when SW(1) = '1' else
    digit13 when SW(2) = '1' else
    digit14 when SW(3) = '1' else
    digit11;

  digit2 <=
    digit22 when SW(1) = '1' else
    digit23 when SW(2) = '1' else
    digit24 when SW(3) = '1' else
    digit21;

  digit3 <=
    digit32 when SW(1) = '1' else
    digit33 when SW(2) = '1' else
    digit34 when SW(3) = '1' else
    digit31;

  dp <=
    dp2 when SW(1) = '1' else
    "0000" when SW(2) = '1' else
    dp3 when SW(3) = '1' else
    dp1;
  ring <=
    ring1 when SW(2) = '1' else
    ring2 when SW(3) = '1' else
    '0';

  SEVEN_SEG_0 : seven_dig port map(digit0, SEG0);
  SEVEN_SEG_1 : seven_dig port map(digit1, SEG1);
  SEVEN_SEG_2 : seven_dig port map(digit2, SEG2);
  SEVEN_SEG_3 : seven_dig port map(digit3, SEG3);
end architecture;