library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2to1 is
    port (
        A : in  std_logic_vector(1 downto 0);
        S : in  std_logic;
        F : out std_logic
    );
end mux2to1;

architecture Behavioral of mux2to1 is

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
	
	component or_gate is
        port (
            A : in  std_logic;
            B : in  std_logic; 
			F : out std_logic
        );
    end component;	
	
    signal n0, n1, n2 : std_logic;
    
begin
	
	u1: not_gate
		port map (
		 	A => S,
    		F => n0
    	);
	
	u2: and_gate
		port map (
			A => A(0),
			B => n0,		
            F => n1
        );
		
	u3: and_gate
        port map (
            A => A(1),
            B => S,
            F => n2
        );
		
	u4: or_gate
        port map (
            A => n1,
            B => n2,
            F => F
        );

end Behavioral;