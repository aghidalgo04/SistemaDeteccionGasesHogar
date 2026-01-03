library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Comparador is
    Port ( CO2 : in STD_LOGIC_VECTOR(11 downto 0);
           Metano : in STD_LOGIC_VECTOR(11 downto 0);
           s_vent : out STD_LOGIC;
           s_led_zum : out STD_LOGIC;
           ESP : out STD_LOGIC_VECTOR(1 downto 0)
         );
end Comparador;

architecture Behavioral of Comparador is
    constant UMBRAL_CO2_AVISO: integer := 2500;
    constant UMBRAL_CO2_VENT: integer := 3500;
    constant UMBRAL_MET_AVISO: integer := 500;
    constant UMBRAL_MET_VENT: integer := 700;
begin
    s_led_zum <= '1' WHEN (unsigned(CO2) > UMBRAL_CO2_AVISO) OR (unsigned(Metano) > UMBRAL_MET_AVISO) else '0';
    s_vent <= '1' WHEN (unsigned(CO2) > UMBRAL_CO2_VENT) OR (unsigned(Metano) > UMBRAL_MET_VENT) else '0';
    ESP <= "10" WHEN (unsigned(CO2) > UMBRAL_CO2_VENT) OR (unsigned(Metano) > UMBRAL_MET_VENT) else 
           "01" WHEN (unsigned(CO2) > UMBRAL_CO2_AVISO) OR (unsigned(Metano) > UMBRAL_MET_AVISO) else 
           "00";
end Behavioral;
