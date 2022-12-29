library ieee;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity alarm is
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
end entity;

architecture alarm of alarm is

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
  signal tm : integer range 0 to 59;
  signal th : integer range 0 to 23;
  signal play : std_logic;
  signal cnt : std_logic_vector(21 downto 0);
  signal ok : std_logic;

  signal dig0, dig1, dig2, dig3 : integer range 0 to 9;
begin
  process (reset, BUT(0))
  begin
    if reset = '1' then -- reset
      th <= 0;
    else
      if rising_edge(BUT(0)) then
        if th = 23 then
          th <= 0;
        else
          th <= th + 1;
        end if;
      end if;
    end if;
  end process;

  process (reset, BUT(1))
  begin
    if reset = '1' then -- reset
      tm <= 0;
    else
      if rising_edge(BUT(1)) then
        if tm = 59 then
          tm <= 0;
        else
          tm <= tm + 1;
        end if;
      end if;
    end if;
  end process;

  process (clk, reset)
  begin
    if reset = '1' then
      cnt <= "0000000000000000000000";
    else
      if clk'event and clk = '1' then
        -- if cnt = 227273 then
        if cnt = 5 then --for test
          cnt <= "0000000000000000000000";
        else
          cnt <= cnt + 1;
        end if;
      end if;
    end if;
  end process;

  process (sec, reset)
  begin
    if reset = '1' then
      play <= '0';
    else
      if sec'event and sec = '1' then
        play <= not play;
      end if;
    end if;
  end process;

  process (now0, now1, now2, now3)
  begin
    if now0 = dig0 and now1 = dig1 and now2 = dig2 and now3 = dig3 then
      ok <= '1';
    else
      ok <= '0';
    end if;
  end process;
  --   ring <= cnt(21) when play = '1' and ok = '1' else '0';
  ring <= cnt(2) when play = '1' and ok = '1' else '0'; --for test
  TODIGIT_0 : todigits port map(th, tm, dig0, dig1, dig2, dig3);
  tar0 <= dig0;
  tar1 <= dig1;
  tar2 <= dig2;
  tar3 <= dig3;
end architecture;