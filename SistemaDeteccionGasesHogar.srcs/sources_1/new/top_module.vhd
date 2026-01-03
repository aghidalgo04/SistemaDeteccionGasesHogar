library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_module is
    Port ( 
        CLK : in STD_LOGIC;
        sw : in STD_LOGIC;
        JA : in STD_LOGIC_VECTOR(1 DOWNTO 0)        
    );
end top_module;

architecture Behavioral of top_module is
    component DivisorFrecuencia
        GENERIC(N: integer := 22);
        Port ( 
            CLK_10MHz : in STD_LOGIC;
            CLK_1Hz : out STD_LOGIC
        );
    end component;
    
    component DEMUX_1a2
        Port (
           entrada : in STD_LOGIC_VECTOR (11 downto 0);
           salida_M : out STD_LOGIC_VECTOR (11 downto 0);
           salida_C : out STD_LOGIC_VECTOR (11 downto 0);
           S : in STD_LOGIC
        );
    end component;
    
    component Registro12Bits
        GENERIC(N: integer := 12);
        Port ( 
            CLK : in STD_LOGIC;
            entrada : in STD_LOGIC_VECTOR (N-1 downto 0);
            salida : out STD_LOGIC_VECTOR (N-1 downto 0)
        );
    end component;
    
    component xadc
        Port ( 
           clk : in STD_LOGIC;
           sw : in STD_LOGIC;
           JA : in STD_LOGIC_VECTOR(1 DOWNTO 0);
           led : out STD_LOGIC_VECTOR(15 DOWNTO 0)
         );
    end component;
    
    component display12Bit
        port(
            bin_in   : in  std_logic_vector(11 downto 0);
            seg0     : out std_logic_vector(6 downto 0);
            seg1     : out std_logic_vector(6 downto 0);
            seg2     : out std_logic_vector(6 downto 0);
            seg3     : out std_logic_vector(6 downto 0)
        );
     end component;
    
    signal sCLK_1Hz, sCLK_1Hz_inv : STD_LOGIC;
    signal led_value : STD_LOGIC_VECTOR(15 DOWNTO 0);
    signal xadc_value, salida_metano, salida_co2, salida_reg_met, salida_reg_co2: STD_LOGIC_VECTOR(11 DOWNTO 0);
    signal sSeg0_0, sSeg1_0, sSeg2_0, sSeg3_0, sSeg0_1, sSeg1_1, sSeg2_1, sSeg3_1: STD_LOGIC_VECTOR(6 DOWNTO 0);
begin
    inst_divisorFrecuencia: DivisorFrecuencia
    PORT MAP(
        CLK_10MHz => CLK,
        CLK_1Hz => sCLK_1Hz
    );
    
    inst_xadc: xadc
    PORT MAP(
        clk => sCLK_1Hz,
        sw => sw,
        JA => JA,
        led => led_value
    );
    
    xadc_value <= led_value(15 DOWNTO 4);
    
    inst_demux: DEMUX_1a2
    PORT MAP(
        entrada => xadc_value,
        salida_M => salida_metano,
        salida_C => salida_co2,
        S => sCLK_1Hz
    );
    
    sCLK_1Hz_inv <= not(sCLK_1Hz);
    
    inst_registroM : Registro12Bits
    PORT MAP(
        CLK => sCLK_1Hz_inv,
        entrada => salida_metano,
        salida => salida_reg_met
    );
    
    inst_registroC : Registro12Bits
    PORT MAP(
        CLK => sCLK_1Hz,
        entrada => salida_metano,
        salida => salida_reg_co2
    );
    
    inst_display0 : display12Bit
    PORT MAP(
        bin_in => salida_reg_met,
        seg0 => sSeg0_0,
        seg1 => sSeg1_0,
        seg2 => sSeg2_0,
        seg3 => sSeg3_0
    );
    
    inst_display1 : display12Bit
    PORT MAP(
        bin_in => salida_reg_co2,
        seg0 => sSeg0_1,
        seg1 => sSeg1_1,
        seg2 => sSeg2_1,
        seg3 => sSeg3_1
    );

end Behavioral;
