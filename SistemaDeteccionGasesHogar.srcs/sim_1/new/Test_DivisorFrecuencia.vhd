library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Test_DivisorFrecuencia is
end Test_DivisorFrecuencia;

architecture Behavioral of Test_DivisorFrecuencia is
    component DivisorFrecuencia
        GENERIC(N: integer := 23);
        Port ( CLK_10MHz : in STD_LOGIC;
               CLK_1Hz : out STD_LOGIC);
    end component;
    
    signal tCLK_10MHz, tCLK_1Hz: STD_LOGIC;
begin
--    tCLK_10MHz <= '0' after 0 ns,
--                  '1' after 20 ns,
--                  '0' after 40 ns,
--                  '1' after 60 ns,
--                  '0' after 80 ns,
--                  '1' after 100 ns,
--                  '0' after 120 ns,
--                  '1' after 140 ns,
--                  '0' after 160 ns,
--                  '1' after 180 ns,
--                  '0' after 200 ns,
--                  '1' after 220 ns,
--                  '0' after 240 ns,
--                  '1' after 260 ns,
--                  '0' after 280 ns,
--                  '1' after 300 ns,
--                  '0' after 320 ns,
--                  '1' after 340 ns,
--                  '0' after 360 ns,
--                  '1' after 380 ns,
--                  '0' after 400 ns,
--                  '1' after 420 ns;

-- Generador de reloj simulado (10 MHz => periodo 100 ns)
    clk_gen : process
    begin
        while true loop
            tCLK_10MHz <= '0';
            wait for 50 ns;
            tCLK_10MHz <= '1';
            wait for 50 ns;
        end loop;
    end process;
               
     Inst: DivisorFrecuencia
     PORT MAP(
        CLK_10MHz => tCLK_10MHz,
        CLK_1Hz => tCLK_1Hz
     );
end Behavioral;
