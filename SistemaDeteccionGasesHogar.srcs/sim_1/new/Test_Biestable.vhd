library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Test_Biestable is
--  Port ( );
end Test_Biestable;

architecture Behavioral of Test_Biestable is
    component Biestable
    Port ( 
        CLK : in STD_LOGIC;
        Q : out STD_LOGIC
    );
    end component;
    
    signal tCLK, tQ : STD_LOGIC;
begin

    tCLK <= '0' after 0 ns,
            '1' after 40 ns,
            '0' after 80 ns,
            '1' after 120 ns;
    
    inst_biestable: Biestable
    PORT MAP(
        CLK => tCLK,
        Q => tQ
    );
    
end Behavioral;
