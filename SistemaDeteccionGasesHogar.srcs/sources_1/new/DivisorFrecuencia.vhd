library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DivisorFrecuencia is
    GENERIC(N: integer := 23);
    Port ( CLK_10MHz : in STD_LOGIC;
           CLK_1Hz : out STD_LOGIC);
end DivisorFrecuencia;

architecture Behavioral of DivisorFrecuencia is
    component Biestable
    Port ( 
        CLK : in STD_LOGIC;
        Q : out STD_LOGIC
    );
    end component;
    
    signal qSig : STD_LOGIC_VECTOR(0 to N);
begin
    general: for i in 0 to N GENERATE
        primero: if i = 0 GENERATE
            I1_Bies: Biestable
            PORT MAP(
                CLK => CLK_10MHz,
                Q => qSig(0)
            );
        end GENERATE;
        medio: if i > 0 AND i <= N GENERATE
            I_Bies: Biestable
            PORT MAP(
                CLK => qSig(i - 1),
                Q => qSig(i)
            );
        end GENERATE;
    end GENERATE;
    
    CLK_1Hz <= qSig(N);
end Behavioral;
