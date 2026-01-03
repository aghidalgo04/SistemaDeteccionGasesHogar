library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Registro12Bits is
    GENERIC(N: integer := 12);
    Port ( 
        CLK : in STD_LOGIC;
        entrada : in STD_LOGIC_VECTOR (N-1 downto 0);
        salida : out STD_LOGIC_VECTOR (N-1 downto 0)
     );
end Registro12Bits;

architecture Behavioral of Registro12Bits is
    component Biestable_D
    Port ( CLK : in STD_LOGIC;
           D : in STD_LOGIC;
           Q : out STD_LOGIC);
    end component;
begin
    general: for i in 0 to N-1 GENERATE
        Bies_Todo: Biestable_D
        PORT MAP(
            CLK => CLK,
            D => entrada(i),
            Q => salida(i)
        );
    end GENERATE;
end Behavioral;
