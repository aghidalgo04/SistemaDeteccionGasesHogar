library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Test_Registro12Bits is
--  Port ( );
end Test_Registro12Bits;

architecture Behavioral of Test_Registro12Bits is
    component Registro12Bits
        GENERIC(N: integer := 12);
        Port ( 
            CLK : in STD_LOGIC;
            entrada : in STD_LOGIC_VECTOR (N-1 downto 0);
            salida : out STD_LOGIC_VECTOR (N-1 downto 0)
         );
    end component;
    
    signal tCLK : STD_LOGIC;
    signal tEntrada, tSalida : STD_LOGIC_VECTOR(11 downto 0);
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
                  '1' after 300 ns;
     
     tEntrada <= "101100011110" after 0 ns,
                 "001011101001" after 80 ns,
                 "011110011011" after 160 ns;
                 
     inst_registro12Bits: Registro12Bits
     PORT MAP(
        CLK => tCLK,
        entrada => tEntrada,
        salida => tSalida
     );          
      
end Behavioral;
