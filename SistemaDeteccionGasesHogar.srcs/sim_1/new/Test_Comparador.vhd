library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Test_Comparador is
--  Port ( );
end Test_Comparador;

architecture Behavioral of Test_Comparador is
    component Comparador
        Port ( 
           CO2       : in STD_LOGIC_VECTOR(11 downto 0);
           Metano    : in STD_LOGIC_VECTOR(11 downto 0);
           s_vent    : out STD_LOGIC;
           s_led_zum : out STD_LOGIC;
           ESP       : out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component;
    
    -- Señales internas para conectar al componente
    signal tCO2, tMetano : STD_LOGIC_VECTOR(11 downto 0);
    signal t_s_vent, t_s_led_zum : STD_LOGIC;
    signal tESP : STD_LOGIC_VECTOR(1 downto 0);

begin
    -- GENERACIÓN DE ESTÍMULOS
    -- Umbrales CO2: >2500 (Aviso), >3500 (Ventilación)
    -- Umbrales Metano: >500 (Aviso), >700 (Ventilación)
    
    -- Secuencia para CO2:
    -- 0ns:   100  (000001100100) -> Todo OK
    -- 40ns:  3000 (101110111000) -> AVISO (Supera 2500)
    -- 80ns:  4000 (111110100000) -> VENTILACIÓN (Supera 3500)
    -- 120ns: 100  (Volvemos a normal para probar Metano)
    tCO2 <= "000001100100" after 0 ns,
            "101110111000" after 40 ns,
            "111110100000" after 80 ns,
            "000001100100" after 120 ns;

    -- Secuencia para Metano:
    -- 0ns a 120ns: 100 (000001100100) -> Se mantiene bajo mientras probamos CO2
    -- 160ns: 600 (001001011000) -> AVISO (Supera 500)
    -- 200ns: 800 (001100100000) -> VENTILACIÓN (Supera 700)
    tMetano <= "000001100100" after 0 ns,
               "001001011000" after 160 ns,
               "001100100000" after 200 ns;

    -- INSTANCIACIÓN DEL COMPONENTE (Unit Under Test)
    uut: Comparador
     PORT MAP(
        CO2 => tCO2,
        Metano => tMetano,
        s_vent => t_s_vent,
        s_led_zum => t_s_led_zum,
        ESP => tESP
     );

end Behavioral;
