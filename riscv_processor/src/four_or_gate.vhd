library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity four_or_gate is
    port (
        A : in  std_logic_vector(3 downto 0);
        F : out std_logic
    );
end four_or_gate;

architecture Structual of four_or_gate is

	component or_gate is
	        port (
	            A : in  std_logic;
	            B : in  std_logic;
	            F : out std_logic
	        );
	end component;
	
	    signal n0, n1 : std_logic;
		
begin
	
	u1: or_gate
        port map (
            A => A(0),
            B => A(1),
            F => n0
        );
		
	u2: or_gate
        port map (
            A => A(2),
            B => A(3),
            F => n1
        );
		
	u3: or_gate
        port map (
            A => n0,
            B => n1,
            F => F
        );
		
end Structual;