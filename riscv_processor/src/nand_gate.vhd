library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity nand_gate is
    port (
        A : in  std_logic;
        B : in  std_logic;
        F : out std_logic
    );
end nand_gate;

architecture Behavioral of nand_gate is

    constant GATE_DELAY : time := 1 ns; 

begin

    F <= A nand B after GATE_DELAY;

end Behavioral;