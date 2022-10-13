library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;



entity JKFFPED is
    Port ( J : in STD_LOGIC;
           K : in STD_LOGIC;
           Q : out STD_LOGIC;
           Qbar : out STD_LOGIC;
           Clear : in STD_LOGIC;
           Preset : in STD_LOGIC;
           clk : in std_logic );
end JKFFPED;



architecture Behavioral of JKFFPED is

--divisor clock

    signal clk_dividido: STD_LOGIC:='1';
    signal counter: integer range 0 to 100000000;
    signal temp: std_logic := '0';
begin
    divisor_clk: process(clk)
        begin

            if rising_edge(clk) then
                if counter = 100_000_000 then
                    counter <=0;
                    clk_dividido <= not (clk_dividido);
                else
                    counter <= counter + 1;
                end if; 
            end if;

    end process;

--FLIP-FLOP JK
  Q <= temp;
  Qbar <= not(temp);
    process (clk_dividido) 
    begin
        if (Clear='1'and Preset='1') then   
            temp <= '0';
        elsif (Clear='0'and Preset='1')then
            temp <= '1';
        elsif (Clear='1'and Preset='0') then
            temp <= '0';
        elsif rising_edge(clk_dividido)  then                 
                if (J='0' and K='0') then
                    temp <= not(temp);
                end if;
                if (J='0' and K='1') then
                    temp <= '1';
                end if;
                if (J='1' and K='0') then
                    temp <= '0';
                end if;
                if (J='1' and K='1') then
                    temp <= temp;
            end if;
        end if;   
    end process;

end Behavioral;

