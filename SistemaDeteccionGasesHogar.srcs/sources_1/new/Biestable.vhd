library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Biestable is
    Port ( CLK : in STD_LOGIC;
           Q : out STD_LOGIC);
end Biestable;

architecture Behavioral of Biestable is
    signal qAux : STD_LOGIC := '0';
begin
    qAux <= NOT(qAux) WHEN CLK = '1' AND CLK'EVENT;
    Q <= qAux;
end Behavioral;
