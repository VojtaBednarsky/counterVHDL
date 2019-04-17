library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;    -- for +/- arithmetic operations

entity top is
    port(
        clk_i : in std_logic;
        btn_i : in std_logic_vector(1-1 downto 0);
        sw_i  : in std_logic_vector(1-1 downto 0);
        
        led_o        : out std_logic_vector(4-1 downto 0);
        disp_digit_o : out std_logic_vector(4-1 downto 0);
        disp_sseg_o  : out std_logic_vector(7-1 downto 0)
    );
end top;

architecture Behavioral of top is
    signal reset     : std_logic;
    signal startstop : std_logic;
    signal carry_0   : std_logic;
    signal carry_1   : std_logic;
    signal carry_2   : std_logic;
    signal carry_3   : std_logic;
    signal carry_4   : std_logic;
    signal carry_5   : std_logic;
    signal vystup_1  : std_logic_vector(4-1 downto 0);
    signal vystup_2  : std_logic_vector(4-1 downto 0);
    signal vystup_3  : std_logic_vector(4-1 downto 0);
    signal vystup_4  : std_logic_vector(4-1 downto 0);
    signal vystup_5  : std_logic_vector(4-1 downto 0);
begin
    reset <= btn_i(0);
    
    START_STOP: entity work.start_stop
        port map(
            a_i => '0',
            b_i => clk_i,
            c_i => sw_i(0),
            y_o => startstop
        );
    
    DELIC_F: entity work.delic_f
        port map(
            clk_i => startstop,
            rst_n_i => '1',
            carry_n_o => carry_0
        );

    CITAC_1: entity work.citac_0_9
        port map(
            clk_i => carry_0,
            rst_n_i => reset,
            carry_n_o => carry_1,
            citac_0_9_o => vystup_1
        );

    CITAC_2: entity work.citac_0_9
        port map(
            clk_i => carry_1,
            rst_n_i => reset,
            carry_n_o => carry_2,
            citac_0_9_o => vystup_2
        );
        
    CITAC_3: entity work.citac_0_9
        port map(
            clk_i => carry_2,
            rst_n_i => reset,
            carry_n_o => carry_3,
            citac_0_9_o => vystup_3
        );
        
    CITAC_4: entity work.citac_0_5
        port map(
            clk_i => carry_3,
            rst_n_i => reset,
            carry_n_o => carry_4,
            citac_0_5_o => vystup_4
        );

    CITAC_5: entity work.citac_0_4
        port map(
            clk_i => carry_4,
            rst_n_i => reset,
            citac_0_4_o => vystup_5
        );

    DEKODER: entity work.dekoder
        port map(
            in_i => vystup_5,
            y_o => led_o
        );

    DISPMUX: entity work.disp_mux
        port map(
            data3_i => vystup_4,
            data2_i => vystup_3,
            data1_i => vystup_2,
            data0_i => vystup_1,
            clk_i => clk_i,
            an_o => disp_digit_o,
            sseg_o => disp_sseg_o
        );

end Behavioral;