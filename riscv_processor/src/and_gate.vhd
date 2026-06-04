library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity and_gate is
    port (
        A : in  std_logic;
        B : in  std_logic;
        F : out std_logic
    );
end and_gate;

architecture Behavioral of and_gate is

	component nand_gate is
	        port (
	            A : in  std_logic;
	            B : in  std_logic;
	            F : out std_logic
	        );
	end component;
	
	component not_gate is
	        port (
	            A : in  std_logic;
	            F : out std_logic
	        );
	end component;
	
	    signal n0 : std_logic;
		
begin
	
	u1: nand_gate
        port map (
            A => A,
            B => B,
            F => n0
        );
		
	u2: not_gate
        port map (
            A => n0,
            F => F
        );
		
end Behavioral;