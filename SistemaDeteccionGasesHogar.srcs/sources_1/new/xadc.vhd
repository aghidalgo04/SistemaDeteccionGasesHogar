library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xadc is
    Port ( 
       clk : in STD_LOGIC;
       sw : in STD_LOGIC;
       JA : in STD_LOGIC_VECTOR(1 DOWNTO 0);
       led : out STD_LOGIC_VECTOR(15 DOWNTO 0)
     );
end xadc;

architecture Behavioral of xadc is
    signal channel_out : std_logic_vector(4 DOWNTO 0);
    signal daddr_in : STD_LOGIC_VECTOR(6 DOWNTO 0);
    signal do_out : STD_LOGIC_VECTOR(15 DOWNTO 0);
    signal anal_p, anal_n : STD_LOGIC;
    signal eoc, eos, alarm : std_logic;
    signal channel_aux: std_logic;
    
    
    COMPONENT xadc_wiz_0
      PORT (
        di_in : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        daddr_in : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
        den_in : IN STD_LOGIC;
        dwe_in : IN STD_LOGIC;
        drdy_out : OUT STD_LOGIC;
        do_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        dclk_in : IN STD_LOGIC;
        reset_in : IN STD_LOGIC;
        vp_in : IN STD_LOGIC;
        vn_in : IN STD_LOGIC;
        vauxp5 : IN STD_LOGIC;
        vauxn5 : IN STD_LOGIC;
        channel_out : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
        eoc_out : OUT STD_LOGIC;
        alarm_out : OUT STD_LOGIC;
        eos_out : OUT STD_LOGIC;
        busy_out : OUT STD_LOGIC 
      );
    END COMPONENT;
begin
    daddr_in <= "00" & channel_out;
xadc_inst : xadc_wiz_0
  PORT MAP (
    di_in => "0000000000000000",
    daddr_in => daddr_in,
    den_in => '1',
    dwe_in => '0',
    drdy_out => open,
    do_out => led,
    dclk_in => clk,
    reset_in => sw,
    vp_in => '0',
    vn_in => '0',
    vauxp5 => JA(0),
    vauxn5 => JA(1),
    channel_out => channel_out,
    eoc_out => eoc,
    alarm_out => alarm,
    eos_out => eos,
    busy_out => open
  );

end Behavioral;
