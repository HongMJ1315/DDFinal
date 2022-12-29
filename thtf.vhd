library ieee;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity thtf is
  port (
    h : in integer range 0 to 23;
    m : in integer range 0 to 59;
    dot : out std_logic;
    digit1 : out integer range 0 to 9;
    digit2 : out integer range 0 to 9;
    digit3 : out integer range 0 to 9;
    digit4 : out integer range 0 to 9
  );
end entity;

architecture arch of thtf is
  signal th : integer range 0 to 23;
begin
  th <= h mod 12;
  digit1 <= th/10;
  digit2 <= th mod 10;
  digit3 <= m/10;
  digit4 <= m mod 10;
  dot <= '1' when h >= 12 else
    '0';
end architecture;