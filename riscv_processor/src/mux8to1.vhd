library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux8to1 is
    port (
        A : in  std_logic_vector(7 downto 0);
        S : in  std_logic_vector(2 downto 0);
        F : out std_logic
    );
end mux8to1;

architecture Behavioral of mux8to1 is

	component mux4to1 is
    port (
        A : in  std_logic_vector(3 downto 0);
        S : in  std_logic_vector(1 downto 0);
        F : out std_logic
    );
	end component;
	
	component mux2to1 is
    port (
        A : in  std_logic_vector(1 downto 0);
        S : in  std_logic;
        F : out std_logic
    );
	end component;
	
	signal n2, n3 : std_logic_vector(3 downto 0);
	
	signal n4, n5: std_logic_vector(1 downto 0);
	
    signal n0, n1 : std_logic;
    
begin
					 
	n2 <= A(3) & A(2) & A(1) & A(0);
	
	n3 <= A(7) & A(6) & A(5) & A(4);
	
	n4 <= n1 & n0;
	
	n5 <= s(1) & s(0);
	
	u1: mux4to1
		port map (
			A => n2,
			S => n5,
            F => n0
        );
		
	u2: mux4to1
		port map (
			A => n3,
			S => n5,
            F => n1
        );
		
	u3: mux2to1
        port map (
            A => n4,
            S => S(2),
            F => F
        );

end Behavioral;