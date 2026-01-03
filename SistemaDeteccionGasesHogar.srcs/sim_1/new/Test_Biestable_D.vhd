library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Test_Biestable_D is
--  Port ( );
end Test_Biestable_D;

architecture Behavioral of Test_Biestable_D is
    component Biestable_D
    Port ( 
        CLK : in STD_LOGIC;
        D : in STD_LOGIC;
        Q : out STD_LOGIC
    );
    end component;
    
    signal tCLK, tD, tQ : STD_LOGIC;
begin
    tCLK <= '0' after 0 ns,
            '1' after 20 ns,
            '0' after 40 ns,
            '1' after 60 ns,
            '0' after 80 ns,
            '1' after 100 ns,
            '0' after 120 ns,
            '1' after 140 ns,
            '0' after 160 ns,
            '1' after 180 ns,
            '0' after 200 ns,
            '1' after 220 ns,
            '0' after 240 ns,
            '1' after 260 ns,
            '0' after 280 ns,
            '1' after 300 ns,
            '0' after 320 ns,
            '1' after 340 ns,
            '0' after 360 ns,
            '1' after 380 ns,
            '0' after 400 ns,
            '1' after 420 ns;
          
     tD <= '0' after 0 ns,
           '1' after 40 ns,
           '0' after 80 ns,
           '1' after 120 ns,
           '0' after 160 ns,
           '1' after 200 ns,
           '0' after 240 ns,
           '1' after 280 ns;
           
      
      inst: Biestable_D
      PORT MAP(
        CLK => tCLK,
        D => tD,
        Q => tQ
      );

end Behavioral;
