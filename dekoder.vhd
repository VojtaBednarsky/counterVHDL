library ieee;
use ieee.std_logic_1164.all;

entity dekoder is
    port(
        in_i : in std_logic_vector(4-1 downto 0);
        y_o : out std_logic_vector(4-1 downto 0)
    );
end dekoder;

architecture Behavioral of dekoder is
begin
    y_o <= "1111" when (in_i = "0000") else --0
           "1110" when (in_i = "0001") else --1
           "1100" when (in_i = "0010") else --2
           "1000" when (in_i = "0011") else --3
           "0000" when (in_i = "0100");     --4 min
           
end Behavioral;