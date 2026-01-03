library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--use IEEE.NUMERIC_STD.ALL;

entity DEMUX_1a2 is
    Port ( entrada : in STD_LOGIC_VECTOR (11 downto 0);
           salida_M : out STD_LOGIC_VECTOR (11 downto 0);
           salida_C : out STD_LOGIC_VECTOR (11 downto 0);
           S : in STD_LOGIC);
end DEMUX_1a2;

architecture Behavioral of DEMUX_1a2 is
begin 
    salida_M <= entrada when S = '0' else (others => '0');
    salida_C <= entrada when S = '1' else (others => '0');
end Behavioral;
