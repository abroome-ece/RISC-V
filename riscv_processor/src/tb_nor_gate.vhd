library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_nor_gate is
end tb_nor_gate;

architecture Behavioral of tb_nor_gate is

    component nor_gate is
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

    uut: nor_gate
        port map (
            A => tb_A,
            B => tb_B,
            F => tb_F
        );

    stim_proc: process
    begin
        report "--- Starting NOR Gate Simulation ---" severity note;
        
        tb_A <= '0'; tb_B <= '0';
        wait for 20 ns;
        assert (tb_F = '1') report "FAIL: 0 NOR 0 should be 1" severity error;
        
        tb_A <= '0'; tb_B <= '1';
        wait for 20 ns; 
        assert (tb_F = '0') report "FAIL: 0 NOR 1 should be 0" severity error;
        
        tb_A <= '1'; tb_B <= '0';
        wait for 20 ns; 
        assert (tb_F = '0') report "FAIL: 1 NOR 0 should be 0" severity error;
        
        tb_A <= '1'; tb_B <= '1';
        wait for 20 ns; 
        assert (tb_F = '0') report "FAIL: 1 NOR 1 should be 0" severity error;

        report "--- Simulation Completed ---" severity note;
        wait;
    end process;

end Behavioral;