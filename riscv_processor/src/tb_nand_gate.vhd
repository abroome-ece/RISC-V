library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_nand_gate is
end tb_nand_gate;

architecture Behavioral of tb_nand_gate is

    component nand_gate is
        port (
            A : in  std_logic;
            B : in  std_logic;
            F : out std_logic
        );
    end component;

    signal tb_A : std_logic := '0';
    signal tb_B : std_logic := '0';
    signal tb_F : std_logic;

begin

    uut: nand_gate
        port map (
            A => tb_A,
            B => tb_B,
            F => tb_F
        );

    stim_proc: process
    begin
        report "--- Starting NAND Gate Simulation ---" severity note;
        
        -- Test Case 1: 0 NAND 0 = 1
        report "Testing A=0, B=0..." severity note;
        tb_A <= '0'; tb_B <= '0';
        wait for 20 ns; -- Wait for gate delay to pass
        assert (tb_F = '1') report "FAIL: 0 NAND 0 should be 1" severity error;
        
        -- Test Case 2: 0 NAND 1 = 1
        report "Testing A=0, B=1..." severity note;
        tb_A <= '0'; tb_B <= '1';
        wait for 20 ns; 
        assert (tb_F = '1') report "FAIL: 0 NAND 1 should be 1" severity error;
        
        -- Test Case 3: 1 NAND 1 = 0
        report "Testing A=1, B=1..." severity note;
        tb_A <= '1'; tb_B <= '1';
        wait for 20 ns; 
        assert (tb_F = '0') report "FAIL: 1 NAND 1 should be 0" severity error;
        
        -- Test Case 4: 1 NAND 0 = 1
        report "Testing A=1, B=0..." severity note;
        tb_A <= '1'; tb_B <= '0';
        wait for 20 ns; 
        assert (tb_F = '1') report "FAIL: 1 NAND 0 should be 1" severity error;

        report "--- Simulation Completed ---" severity note;
        wait;
    end process;

end Behavioral;