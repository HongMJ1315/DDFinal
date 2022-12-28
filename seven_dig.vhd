library ieee;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity seven_dig is
  port (
    n : in integer range 0 to 9;
    LED : out std_logic_vector(6 downto 0)
  );
end seven_dig;

architecture Behavioral of seven_dig is
begin
  LED <= "0000001" when n = 0 else
    "1001111" when n = 1 else
    "0010010" when n = 2 else
    "0000110" when n = 3 else
    "1001100" when n = 4 else
    "0100100" when n = 5 else
    "0100000" when n = 6 else
    "0001111" when n = 7 else
    "0000000" when n = 8 else
    "0000100" when n = 9 else
    "1111111";
end Behavioral;