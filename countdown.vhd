library ieee;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity countdown is
  port (
    clk : in std_logic;
    reset : in std_logic;
    sec : in std_logic;
    sw : in std_logic;
    bot : in std_logic_vector(2 downto 0);
    ring : out std_logic;
    dot : out std_logic_vector(3 downto 0);
    num3 : out integer range 0 to 9;
    num2 : out integer range 0 to 9;
    num1 : out integer range 0 to 9;
    num0 : out integer range 0 to 9
  );
end entity;

architecture rtl of countdown is
  component digits is
    port (
      BIN : in integer range 0 to 9999;
      num3 : out integer range 0 to 9;
      num2 : out integer range 0 to 9;
      num1 : out integer range 0 to 9;
      num0 : out integer range 0 to 9
    );
  end component;
  signal cnt1 : std_logic_vector(13 downto 0);
  signal cntdown : std_logic_vector(13 downto 0);
  signal stats : std_logic;
  signal play : std_logic;
  signal now0, now1, now2, now3 : integer range 0 to 9;
  signal cnt : std_logic_vector(21 downto 0);
  signal ok : std_logic;

begin
  process (bot(1), bot(2), reset)
  begin
    if bot(2) = '0' or reset = '1'then
      cnt1 <= "00000000000000";

    elsif bot(1)'event and bot(1) = '0' and sw = '1' then
      if cnt1 = 9999 then
        cnt1 <= "00000000000000";
      else
        cnt1 <= cnt1 + 1;
      end if;
    end if;
  end process;

  process (bot(2), bot(0), reset)
  begin
    if bot(2) = '0' or reset = '1' then
      stats <= '0';
    else
      if bot(0)'event and bot(0) = '0' and sw = '1' then
        stats <= not stats;
      end if;
    end if;
  end process;

  process (stats, sec, cnt1)
  begin
    if sec'event and sec = '1' then
      if stats = '1' then
        if cntdown = 0 then
          cntdown <= "00000000000000";
        else
          cntdown <= cntdown - 1;
        end if;
      else
        cntdown <= cnt1;
      end if;
    end if;
  end process;

  process (clk, reset)
  begin
    if reset = '1' then
      cnt <= "0000000000000000000000";
    else
      if clk'event and clk = '1' then
        if cnt = 227273 then
          -- if cnt = 5 then --for test
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
  u1 : digits port map(Conv_integer(cntdown), now3, now2, now1, now0);

  process (now0, now1, now2, now3, clk)
  begin
    if now0 = 0 and now1 = 0 and now2 = 0 and now3 = 0 then
      ok <= '1';
    else
      ok <= '0';
    end if;
  end process;
  dot <= "1" & stats & "1" & sec;
  ring <= clk when play = '1' and ok = '1' else '0'; --for test
  num3 <= now3;
  num2 <= now2;
  num1 <= now1;
  num0 <= now0;
end architecture;