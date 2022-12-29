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
  signal digit0, digit1, digit2, digit3 : integer range 0 to 9;
  signal clk_1 : std_logic;
  signal dcnt : std_logic_vector(24 downto 0);
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
  -- clk_1 <= dcnt(24); --500Hz		

  clk_1 <= clk; --500Hz		
  CLOCK_0 : clock port map(clk_1, reset, SW(0), BUT, dp, digit0, digit1, digit2, digit3);
  SEVEN_SEG_0 : seven_dig port map(digit0, LED0);
  SEVEN_SEG_1 : seven_dig port map(digit1, LED1);
  SEVEN_SEG_2 : seven_dig port map(digit2, LED2);
  SEVEN_SEG_3 : seven_dig port map(digit3, LED3);
end architecture;