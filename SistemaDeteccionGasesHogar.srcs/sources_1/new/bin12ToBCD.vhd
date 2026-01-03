library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bin12ToBCD is
    port (
        bin : in  std_logic_vector(11 downto 0);
        bcd_m : out std_logic_vector(3 downto 0);
        bcd_c : out std_logic_vector(3 downto 0);
        bcd_d : out std_logic_vector(3 downto 0);
        bcd_u : out std_logic_vector(3 downto 0)
    );
end entity;

architecture rtl of bin12ToBCD is
    signal bin_u   : unsigned(11 downto 0);
    signal div_m   : unsigned(11 downto 0); -- bin_u / 1000
    signal rem_1   : unsigned(11 downto 0); -- bin_u mod 1000
    signal div_c   : unsigned(11 downto 0); -- rem_1 / 100
    signal rem_2   : unsigned(11 downto 0); -- rem_1 mod 100
    signal div_d   : unsigned(11 downto 0); -- rem_2 / 10
    signal div_u   : unsigned(11 downto 0); -- rem_2 mod 10;
begin
    bin_u  <= unsigned(bin);
    div_m  <= bin_u / 1000;
    rem_1  <= bin_u mod 1000;
    div_c  <= rem_1 / 100;
    rem_2  <= rem_1 mod 100;
    div_d  <= rem_2 / 10;
    div_u  <= rem_2 mod 10;

    bcd_m <= std_logic_vector(div_m(3 downto 0));
    bcd_c <= std_logic_vector(div_c(3 downto 0));
    bcd_d <= std_logic_vector(div_d(3 downto 0));
    bcd_u <= std_logic_vector(div_u(3 downto 0));
end architecture;