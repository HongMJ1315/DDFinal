library ieee;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity clock is
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
end entity;
architecture clock of clock is
  signal m : integer range 0 to 59;
  signal h : integer range 0 to 23;
  signal d0 : integer range 0 to 9;
  signal d1 : integer range 0 to 9;
  signal d2 : integer range 0 to 9;
  signal d3 : integer range 0 to 9;
  component todigits is
    port (
      h : in integer range 0 to 23;
      m : in integer range 0 to 59;
      digit1 : out integer range 0 to 9;
      digit2 : out integer range 0 to 9;
      digit3 : out integer range 0 to 9;
      digit4 : out integer range 0 to 9
    );
  end component;
  signal tm1, tm2 : integer range 0 to 59;
  signal th1, th2 : integer range 0 to 23;
  signal th12, th22 : integer range 0 to 23;
  signal ff, secc, clk2 : std_logic;
  signal dcnt : std_logic_vector(6 downto 0);
begin
  process (clk, reset)
  begin
    if reset = '1' then
      dcnt <= "0000000";
      secc <= '0';
    else
      if clk'event and clk = '1' then
        secc <= not secc;
        if dcnt = 5 then
          dcnt <= "0000000";
        else
          dcnt <= dcnt + 1;
        end if;
      end if;
    end if;
  end process;
  -- clk2 <= dcnt(3); --500Hz		
  clk2 <= clk; --500Hz		
  process (clk2, reset, SW, BUT, h, m)
  begin
    if reset = '1' then -- reset
      th1 <= 0;
      tm1 <= 0;
    else
      if rising_edge(clk2) then
        if m = 59 then
          if h = 23 then
            th1 <= 0;
          else
            th1 <= h + 1;
          end if;
          tm1 <= 0;
        else
          tm1 <= m + 1;
          th1 <= h;
        end if;
      end if;
    end if;
  end process;
  process (reset, BUT(0))
  begin
    if reset = '1' then -- reset
      th2 <= 0;
    else
      if rising_edge(BUT(0)) then
        if h = 23 then
          th2 <= 0;
        else
          th2 <= h + 1;
        end if;
      end if;
    end if;
  end process;

  process (reset, BUT(1))
  begin
    if reset = '1' then -- reset
      tm2 <= 0;
    else
      if rising_edge(BUT(1)) then
        if m = 59 then
          tm2 <= 0;
        else
          tm2 <= m + 1;
        end if;
      end if;
    end if;
  end process;

  process (BUT(2), reset, ff)
  begin
    if reset = '1' then
      ff <= '0';
    else
      if rising_edge(BUT(2)) then
        ff <= not ff;
      end if;
    end if;
  end process;

  h <= th12 when SW = '1' else th22;
  m <= tm2 when SW = '1' else tm1;
  dp <= '0' & secc & '0' & ff;
  todig1 : todigits port map(h, m, digit0, digit1, digit2, digit3);

end architecture;