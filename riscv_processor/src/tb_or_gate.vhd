library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_or_gate is
end tb_or_gate;

architecture Behavioral of tb_or_gate is

    component or_gate is
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

    uut: or_gate
        port map (
            A => tb_A,
            B => tb_B,
            F => tb_F
        );

    stim_proc: process
    begin
        report "--- Starting OR Gate Simulation ---" severity note;
        
        tb_A <= '0'; tb_B <= '0';
        wait for 20 ns;
        assert (tb_F = '0') report "FAIL: 0 OR 0 should be 0" severity error;
        
        tb_A <= '0'; tb_B <= '1';
        wait for 20 ns; 
        assert (tb_F = '1') report "FAIL: 0 OR 1 should be 1" severity error;
        
        tb_A <= '1'; tb_B <= '0';
        wait for 20 ns; 
        assert (tb_F = '1') report "FAIL: 1 OR 0 should be 1" severity error;
        
        tb_A <= '1'; tb_B <= '1';
        wait for 20 ns; 
        assert (tb_F = '1') report "FAIL: 1 OR 1 should be 1" severity error;

        report "--- Simulation Completed ---" severity note;
        wait;
    end process;

end Behavioral;