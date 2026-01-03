library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity display12Bit is
    port (
        bin_in   : in  std_logic_vector(11 downto 0);
        seg0     : out std_logic_vector(6 downto 0);
        seg1     : out std_logic_vector(6 downto 0);
        seg2     : out std_logic_vector(6 downto 0);
        seg3     : out std_logic_vector(6 downto 0)
    );
end entity;

architecture structural of display12Bit is
    component bcdTo7Seg
        port (
            bcd : in  std_logic_vector(3 downto 0);
            seg : out std_logic_vector(6 downto 0)
        );
    end component;
    
    component bin12ToBCD
        port (
            bin      : in  std_logic_vector(11 downto 0);
            bcd_m    : out std_logic_vector(3 downto 0);
            bcd_c    : out std_logic_vector(3 downto 0);
            bcd_d    : out std_logic_vector(3 downto 0);
            bcd_u    : out std_logic_vector(3 downto 0)
        );
    end component;

    signal d0u, d1d, d2c, d3k : std_logic_vector(3 downto 0);
begin
    bin2bcd_inst : bin12ToBCD
        port map (
            bin => bin_in,
            bcd_m => d3k,
            bcd_c => d2c,
            bcd_d => d1d,
            bcd_u => d0u
        );

    u0 : bcdTo7Seg 
    PORT MAP(
        bcd => d0u, 
        seg => seg0
    );
    
    u1 : bcdTo7Seg 
    PORT MAP(
        bcd => d1d, 
        seg => seg1
    );
    u2 : bcdTo7Seg 
    PORT MAP(
        bcd => d2c, 
        seg => seg2
    );
    u3 : bcdTo7Seg 
    PORT MAP(
        bcd => d3k, 
        seg => seg3
    );
end architecture;