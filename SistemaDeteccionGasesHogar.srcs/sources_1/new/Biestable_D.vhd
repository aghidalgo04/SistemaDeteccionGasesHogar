library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Biestable_D is
    Port ( CLK : in STD_LOGIC;
           D : in STD_LOGIC;
           Q : out STD_LOGIC);
end Biestable_D;

architecture Behavioral of Biestable_D is
    signal qAux: STD_LOGIC := '0';
begin
    qAux <= D WHEN CLK = '1' AND CLK'EVENT ELSE qAux;
    Q <= qAux;
end Behavioral;
