library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder2to4 is
    port (
        A : in  std_logic_vector(1 downto 0);
        E : in  std_logic;
        F : out std_logic_vector(3 downto 0)
    );
end decoder2to4;

architecture Behavioral of decoder2to4 is

	component decoder1to2 is
        port (
            A : in  std_logic;
            B : in  std_logic;
            F : out std_logic
        );
    end component;

    signal n0, n1 : std_logic;
    
begin
	
	u1: not_gate
		port map (
		 	A => A(1),
            F => n0
        );
		
	u2: and_gate
		port map (
			A => n0,
			B => E,
			F => n1
		
	u2: decoder1to2
		port map (
			A => A(0),
			E => n1,
            F => F(1) & F(0)
        );
		
	u3: decoder1to2
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