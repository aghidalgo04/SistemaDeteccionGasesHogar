library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Test_Display12Bit is
--  Port ( );
end Test_Display12Bit;

architecture Behavioral of Test_Display12Bit is
    component display12Bit
         port(
            bin_in : in  std_logic_vector(11 downto 0);
            seg0 : out std_logic_vector(6 downto 0);
            seg1 : out std_logic_vector(6 downto 0);
            seg2 : out std_logic_vector(6 downto 0);
            seg3 : out std_logic_vector(6 downto 0)
        );
    end component;
    
    signal sSeg0, sSeg1, sSeg2, sSeg3 : STD_LOGIC_VECTOR(6 DOWNTO 0);
    signal sEnt : STD_LOGIC_VECTOR(11 DOWNTO 0);
begin    
    sEnt <= "011100001100" after 10 ns;
    
    inst_display : display12Bit
    PORT MAP(
        bin_in => sEnt,
        seg0 => sSeg0,
        seg1 => sSeg1,
        seg2 => sSeg2,
        seg3 => sSeg3
    );
    
end Behavioral;
