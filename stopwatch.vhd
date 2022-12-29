library ieee;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
entity stopwatch is
  port (
    clk : in std_logic;
    bot : in std_logic_vector(2 downto 0);
    dot : out std_logic_vector(3 downto 0);
    num3 : out integer range 0 to 9;
    num2 : out integer range 0 to 9;
    num1 : out integer range 0 to 9;
    num0 : out integer range 0 to 9
  );

end stopwatch;

architecture stopwatch of stopwatch is

  component digits is
    port (
      BIN : in integer range 0 to 9999;
      num3 : out integer range 0 to 9;
      num2 : out integer range 0 to 9;
      num1 : out integer range 0 to 9;
      num0 : out integer range 0 to 9
    );

  end component;

  type INT_array is array (0 to 10) of integer range 0 to 9;
  type time_array is array (0 to 10) of std_logic_vector(13 downto 0);
  type LOGIC_array is array (0 to 10) of std_logic_vector(3 downto 0);
  signal timer : time_array;
  signal cnt : std_logic_vector(22 downto 0);
  signal cnt1 : std_logic_vector(13 downto 0);
  signal tmp : std_logic_vector(13 downto 0);
  signal tcnt : std_logic_vector(3 downto 0);
  signal cyc : std_logic := '0';
  signal sw : std_logic := '0';
begin
  process (clk, bot(2))
  begin
    if bot(2) = '0' then
      cnt1 <= "00000000000000";

    elsif clk'event and clk = '1' then
      if cnt1 = 9999 then
        cnt1 <= "00000000000000";
      else
        cnt1 <= cnt1 + 1;
      end if;
    end if;
  end process;
  process (bot(0), bot(2))
  begin
    if bot(2) = '0' then
      sw <= '0';
    else
      if bot(0)'event and bot(0) = '0' then
        sw <= not sw;
      end if;
    end if;
  end process;
  -- 按下bot時，將cnt1的值存到timer(0)~timer(9)的哪裡，並且在reset為0時歸零
  process (bot(1), bot(2), cyc, sw)
  begin
    if bot(2) = '0' then
      tcnt <= "0000";
      cyc <= '0';
      timer(0) <= "00000000000000";
      timer(1) <= "00000000000000";
      timer(2) <= "00000000000000";
      timer(3) <= "00000000000000";
      timer(4) <= "00000000000000";
      timer(5) <= "00000000000000";
      timer(6) <= "00000000000000";
      timer(7) <= "00000000000000";
      timer(8) <= "00000000000000";
      timer(9) <= "00000000000000";
      -- 按下bot時，且cyc為0，將cnt1的值存到timer(0)~timer(9)的哪裡
    elsif bot(1)'event and bot(1) = '0' then
      if sw = '0' and cyc = '0' then
        if tcnt = 0 then
          timer(0) <= cnt1;
        elsif tcnt = 1 then
          timer(1) <= cnt1;
        elsif tcnt = 2 then
          timer(2) <= cnt1;
        elsif tcnt = 3 then
          timer(3) <= cnt1;
        elsif tcnt = 4 then
          timer(4) <= cnt1;
        elsif tcnt = 5 then
          timer(5) <= cnt1;
        elsif tcnt = 6 then
          timer(6) <= cnt1;
        elsif tcnt = 7 then
          timer(7) <= cnt1;
        elsif tcnt = 8 then
          timer(8) <= cnt1;
        elsif tcnt = 9 then
          timer(9) <= cnt1;
        end if;
      end if;
      -- 若重複則將cyc設為1 不重複紀錄
      if tcnt = 9 then
        tcnt <= "0000";
        cyc <= '1';
      else tcnt <= tcnt + 1;
      end if;
    end if;
  end process;

  -- 讓七段顯示器的小數位以2進位顯示
  dot <= "1110" when tcnt = 0 else
    "1101" when tcnt = 1 else
    "1100" when tcnt = 2 else
    "1011" when tcnt = 3 else
    "1010" when tcnt = 4 else
    "1001" when tcnt = 5 else
    "1000" when tcnt = 6 else
    "0111" when tcnt = 7 else
    "0110" when tcnt = 8 else
    "0101" when tcnt = 9;

  -- 顯示時間被存在timer(0)~timer(9)的哪裡 
  tmp <= cnt1 when sw = '0' else
    timer(0) when tcnt = 0 else
    timer(1) when tcnt = 1 else
    timer(2) when tcnt = 2 else
    timer(3) when tcnt = 3 else
    timer(4) when tcnt = 4 else
    timer(5) when tcnt = 5 else
    timer(6) when tcnt = 6 else
    timer(7) when tcnt = 7 else
    timer(8) when tcnt = 8 else
    timer(9) when tcnt = 9;

  -- 將tmp的值轉成十進位
  u1 : digits port map(Conv_integer(tmp), num3, num2, num1, num0);

end stopwatch;