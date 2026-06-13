library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder1to2 is
    port (
        A : in  std_logic;
        E : in  std_logic;
        F : out std_logic_vector(1 downto 0)
    );
end decoder1to2;

architecture Behavioral of decoder1to2 is

	component and_gate is
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
	
	u1: not_gate
		port map (
		 	A => A,
            F => n0
        );
		
	u2: and_gate
		port map (
			A => A,
			B => E,
        	F => F(0)
        );
		
	u3: and_gate
        port map (
            A => n0,
            B => E,
            F => F(1)
        );
        
end Behavioral;