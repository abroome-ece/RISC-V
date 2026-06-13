library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor_gate is
    port (
        A : in  std_logic;
        B : in  std_logic;
        F : out std_logic
    );
end xor_gate;

architecture Behavioral of xor_gate is

	component and_gate is
        port (
            A : in  std_logic;
            B : in  std_logic;
            F : out std_logic
        );
    end component;
	
    component or_gate is
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
	
	

    signal n0, n1, n2, n3 : std_logic;
    
begin
	
	u1: not_gate
		port map (
		 	A => B,
            F => n0
        );
		
	u2: not_gate
		port map (
		 	A => A,
            F => n1
        );
		
	u3: and_gate
        port map (
            A => A,
            B => n0,
            F => n2
        );
		
	u4: and_gate
        port map (
            A => n1,
            B => B,
            F => n3
        );
    
    u5: or_gate
        port map (
            A => n2,
            B => n3,
            F => F
        );
        
end Behavioral;