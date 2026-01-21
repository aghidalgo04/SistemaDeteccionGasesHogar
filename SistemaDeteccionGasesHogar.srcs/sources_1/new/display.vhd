library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Necesario para el contador

entity display is
    port ( 
        clk    : in  STD_LOGIC;
        bin_in : in  STD_LOGIC_VECTOR(11 DOWNTO 0);
        an     : out STD_LOGIC_VECTOR(3 DOWNTO 0);
        seg    : out STD_LOGIC_VECTOR(6 DOWNTO 0);
        dp     : out STD_LOGIC
    );
end display;

architecture Behavioral of display is

    -- 1. Declaramos el componente que ya tienes hecho
    component display12Bit is
        port (
            bin_in : in  std_logic_vector(11 downto 0);
            seg0   : out std_logic_vector(6 downto 0); -- Unidades
            seg1   : out std_logic_vector(6 downto 0); -- Decenas
            seg2   : out std_logic_vector(6 downto 0); -- Centenas
            seg3   : out std_logic_vector(6 downto 0)  -- Millares
        );
    end component;

    -- Señales para conectar la salida del componente interno
    signal s0, s1, s2, s3 : std_logic_vector(6 downto 0);

    -- Contador para el refresco del display.
    -- Un contador de 20 bits con un reloj de 100MHz hace que el bit 19 cambie 
    -- aprox cada 10ms (100Hz), lo cual es bueno para evitar parpadeo.
    -- Si tu reloj es de 50MHz, también funcionará bien.
    signal refresh_counter : unsigned(19 downto 0) := (others => '0');
    
    -- Selector de 2 bits derivado del contador
    signal digit_select : std_logic_vector(1 downto 0);

begin

    -- 2. Instanciamos tu módulo original
    u_decoder_core : display12Bit
    port map (
        bin_in => bin_in,
        seg0   => s0,
        seg1   => s1,
        seg2   => s2,
        seg3   => s3
    );

    -- 3. Proceso del contador de refresco
    process(clk)
    begin
        if rising_edge(clk) then
            refresh_counter <= refresh_counter + 1;
        end if;
    end process;

    -- Usamos los 2 bits más significativos para seleccionar qué dígito encender.
    -- Esto crea la multiplexación en el tiempo.
    digit_select <= std_logic_vector(refresh_counter(19 downto 18));

    -- 4. Multiplexor de Ánodos y Segmentos
    process(digit_select, s0, s1, s2, s3)
    begin
        -- Valor por defecto para el punto decimal (apagado = '1' en lógica negativa)
        dp <= '1'; 

        case digit_select is
            when "00" =>
                -- Activamos el dígito 0 (Unidades)
                -- Nota: Los ánodos suelen ser activos a nivel BAJO ('0' enciende)
                an <= "1110"; 
                seg <= s0;
                
            when "01" =>
                -- Activamos el dígito 1 (Decenas)
                an <= "1101";
                seg <= s1;
                
            when "10" =>
                -- Activamos el dígito 2 (Centenas)
                an <= "1011";
                seg <= s2;
                
            when "11" =>
                -- Activamos el dígito 3 (Millares)
                an <= "0111";
                seg <= s3;
                
            when others =>
                an <= "1111"; -- Apagar todo por seguridad
                seg <= "1111111";
        end case;
    end process;

end Behavioral;