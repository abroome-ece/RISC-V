library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity not_gate is
    port (
        A : in  std_logic;
        F : out std_logic
    );
end not_gate;

architecture Behavioral of not_gate is

	component nand_gate is
	        port (
	            A : in  std_logic;
	            B : in  std_logic;
	            F : out std_logic
	        );
	    end component;

begin
	
	u1: nand_gate
        port map (
            A => A,
            B => A,
            F => F
        );
		
end Behavioral;