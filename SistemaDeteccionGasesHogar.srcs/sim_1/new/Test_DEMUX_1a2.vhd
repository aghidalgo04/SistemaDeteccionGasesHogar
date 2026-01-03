library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Test_DEMUX_1a2 is
--  Port ( );
end Test_DEMUX_1a2;

architecture Behavioral of Test_DEMUX_1a2 is
    component DEMUX_1a2
        Port ( 
           entrada : in STD_LOGIC_VECTOR (11 downto 0);
           salida_M : out STD_LOGIC_VECTOR (11 downto 0);
           salida_C : out STD_LOGIC_VECTOR (11 downto 0);
           S : in STD_LOGIC
        );
    end component;
    
    signal tEntrada, tSalida_M, tSalida_C : STD_LOGIC_VECTOR(11 downto 0);
    signal tS: STD_LOGIC;
begin
    tS <= '0' after 0 ns,
          '1' after 40 ns,
          '0' after 80 ns,
          '1' after 120 ns,
          '0' after 160 ns,
          '1' after 200 ns;
     tEntrada <= "101100011110" after 0 ns,
                 "001011101001" after 80 ns,
                 "011110011011" after 160 ns;
                 
     demux_inst: DEMUX_1a2
     PORT MAP(
        entrada => tEntrada,
        salida_M => tSalida_M,
        salida_C => tSalida_C,
        S => tS
     );
end Behavioral;
