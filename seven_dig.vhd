library ieee;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity seven_dig is
  port (
    n : in integer range 0 to 9;
    LED : out std_logic_vector(7 downto 0)
  );
end seven_dig;

architecture Behavioral of seven_dig is
begin
  LED <= "00000011" when n = 0 else
    "10011111" when n = 1 else
    "00100101" when n = 2 else
    "00001101" when n = 3 else
    "10011001" when n = 4 else
    "01001001" when n = 5 else
    "01000001" when n = 6 else
    "00011111" when n = 7 else
    "00000001" when n = 8 else
    "00001001" when n = 9 else
    "11111111";
end Behavioral;