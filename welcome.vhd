library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity welcome is
    port(
        btn_i  : in std_logic_vector(2-1 downto 0);
        wel_1_o: out std_logic_vector(4-1 downto 0);
        wel_2_o: out std_logic_vector(4-1 downto 0);
        wel_3_o: out std_logic_vector(4-1 downto 0);
        wel_4_o: out std_logic_vector(4-1 downto 0)
    );
end welcome;

architecture Behavioral of welcome is
begin
    wel_1_o <= "1100";
    wel_2_o <= "1110";
    wel_3_o <= "1110";
    wel_4_o <= "1111";
end Behavioral;

