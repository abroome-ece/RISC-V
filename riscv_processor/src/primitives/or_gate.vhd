library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity or_gate is
    port (
        A : in  std_logic;
        B : in  std_logic;
        F : out std_logic
    );
end or_gate;

architecture Behavioral of or_gate is

    component nand_gate is
        port (
            A : in  std_logic;
            B : in  std_logic;
            F : out std_logic
        );
    end component;

    signal nA : std_logic;
    signal nB : std_logic;
    
begin
    
    u1: nand_gate
        port map (
            A => A,
            B => A,
            F => nA
        );
        
    u2: nand_gate
        port map (
            A => B,
            B => B,
            F => nB
        );
        
    u3: nand_gate
        port map (
            A => nA,
            B => nB,
            F => F
        );
        
end Behavioral;