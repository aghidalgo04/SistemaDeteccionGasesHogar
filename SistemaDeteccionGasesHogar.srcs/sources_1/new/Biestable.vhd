library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Biestable is
    Port ( CLK : in STD_LOGIC;
           Q : out STD_LOGIC);
end Biestable;

architecture Behavioral of Biestable is
    signal qAux : STD_LOGIC := '0';
begin
    process(CLK)
    begin
        if rising_edge(CLK) then
            qAux <= not qAux;
        end if;
    end process;
    Q <= qAux;
end Behavioral;
