library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_not_gate is
end tb_not_gate;

architecture Behavioral of tb_not_gate is

    component not_gate is
        port (
            A : in  std_logic;
            F : out std_logic
        );
    end component;

    signal tb_A : std_logic := '0';
    signal tb_F : std_logic;

begin

    uut: not_gate
        port map (
            A => tb_A,
            F => tb_F
        );

    stim_proc: process
    begin
        report "--- Starting NOT Gate Simulation ---" severity note;
        
        tb_A <= '0';
        wait for 20 ns;
        assert (tb_F = '1') report "FAIL: NOT 0 should be 1" severity error;
        
        tb_A <= '1';
        wait for 20 ns; 
        assert (tb_F = '0') report "FAIL: NOT 1 should be 0" severity error;

        report "--- Simulation Completed ---" severity note;
        wait;
    end process;

end Behavioral;