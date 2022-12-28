library ieee;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity todigits is
  port (
    h : in integer range 0 to 23;
    m : in integer range 0 to 59;
    digit1 : out integer range 0 to 9;
    digit2 : out integer range 0 to 9;
    digit3 : out integer range 0 to 9;
    digit4 : out integer range 0 to 9
  );
end entity;

architecture arch of todigits is
begin
  digit1 <= h/10;
  digit2 <= h mod 10;
  digit3 <= m/10;
  digit4 <= m mod 10;
end architecture;