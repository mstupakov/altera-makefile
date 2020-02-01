library ieee;

use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity PwmGenerator is
  generic (F : integer := 1; HZ : integer := 1;
           D : integer range 1 to 99 := 1);
  port (
    clk : in  std_logic;
    rst : in  std_logic;
    pin : out std_logic);
end PwmGenerator;

architecture behav of PwmGenerator is
  constant value   : integer := F / HZ ;
  constant duty    : integer := value / 100 * D;
  signal   timer   : integer range 0 to value := value - 1;
  signal   counter : integer range 0 to duty := duty - 1;
begin

  process (clk, rst)
  begin

    if rst = '0' then
      timer <= value;

    elsif rising_edge(clk) then
      if timer /= 0 then
        timer <= timer - 1;

        if counter /= 0 then
          counter <= counter - 1;
        end if;
      else
        timer <= value;
        counter <= duty;
      end if;
    end if;

  end process;

    pin <= '1' when counter /= 0 else '0';
end behav;
