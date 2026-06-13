library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_cla_block is
end tb_cla_block;

architecture Behavioral of tb_cla_block is

    --------------------------------------------------------------------
    -- Component Declaration
    --------------------------------------------------------------------
    component cla_block is
        port (
            A   : in  std_logic_vector(3 downto 0);
            B   : in  std_logic_vector(3 downto 0);
            CIN : in  std_logic;
            PG  : out std_logic;
            GG  : out std_logic;
            SUM : out std_logic_vector(3 downto 0)
        );
    end component;

    --------------------------------------------------------------------
    -- Testbench Signals
    --------------------------------------------------------------------
    signal A_tb   : std_logic_vector(3 downto 0) := (others => '0');
    signal B_tb   : std_logic_vector(3 downto 0) := (others => '0');
    signal CIN_tb : std_logic := '0';

    signal PG_tb  : std_logic;
    signal GG_tb  : std_logic;
    signal SUM_tb : std_logic_vector(3 downto 0);

    --------------------------------------------------------------------
    -- Expected Results
    --------------------------------------------------------------------
    signal expected_full  : unsigned(4 downto 0);
    signal expected_sum   : std_logic_vector(3 downto 0);
    signal expected_cout  : std_logic;

    --------------------------------------------------------------------
    -- Actual CLA Carry Out
    --------------------------------------------------------------------
    signal actual_cout : std_logic;

begin

    --------------------------------------------------------------------
    -- Instantiate DUT
    --------------------------------------------------------------------
    uut : cla_block
        port map (
            A   => A_tb,
            B   => B_tb,
            CIN => CIN_tb,
            PG  => PG_tb,
            GG  => GG_tb,
            SUM => SUM_tb
        );

    --------------------------------------------------------------------
    -- Expected Arithmetic Result
    --------------------------------------------------------------------
    expected_full <=
        unsigned('0' & A_tb) +
        unsigned('0' & B_tb) +
        unsigned("0000" & CIN_tb);

    expected_sum  <= std_logic_vector(expected_full(3 downto 0));
    expected_cout <= expected_full(4);

    --------------------------------------------------------------------
    -- CLA Carry Out Equation
    --------------------------------------------------------------------
    actual_cout <= GG_tb or (PG_tb and CIN_tb);

    --------------------------------------------------------------------
    -- Stimulus Process
    --------------------------------------------------------------------
    stim_proc : process
    begin

        ----------------------------------------------------------------
        -- Initial settle time
        ----------------------------------------------------------------
        wait for 50 ns;

        report "========================================" severity note;
        report "STARTING 4-BIT STRUCTURAL CLA TESTBENCH" severity note;
        report "========================================" severity note;

        ----------------------------------------------------------------
        -- TEST CASE 1
        -- 2 + 4 = 6
        ----------------------------------------------------------------
        A_tb   <= "0010";
        B_tb   <= "0100";
        CIN_tb <= '0';

        wait for 25 ns;

        assert (SUM_tb = expected_sum)
            report "TC1 FAILED: Incorrect SUM"
            severity error;

        assert (actual_cout = expected_cout)
            report "TC1 FAILED: Incorrect COUT"
            severity error;

        ----------------------------------------------------------------
        -- TEST CASE 2
        -- 2 + 2 = 4
        ----------------------------------------------------------------
        A_tb   <= "0010";
        B_tb   <= "0010";
        CIN_tb <= '0';

        wait for 25 ns;

        assert (SUM_tb = expected_sum)
            report "TC2 FAILED: Incorrect SUM"
            severity error;

        assert (actual_cout = expected_cout)
            report "TC2 FAILED: Incorrect COUT"
            severity error;

        ----------------------------------------------------------------
        -- TEST CASE 3
        -- 7 + 1 + 1 = 9
        ----------------------------------------------------------------
        A_tb   <= "0111";
        B_tb   <= "0001";
        CIN_tb <= '1';

        wait for 25 ns;

        assert (SUM_tb = expected_sum)
            report "TC3 FAILED: Incorrect SUM"
            severity error;

        assert (actual_cout = expected_cout)
            report "TC3 FAILED: Incorrect COUT"
            severity error;

        ----------------------------------------------------------------
        -- TEST CASE 4
        -- 15 + 15 + 1 = 31
        ----------------------------------------------------------------
        A_tb   <= "1111";
        B_tb   <= "1111";
        CIN_tb <= '1';

        wait for 25 ns;

        assert (SUM_tb = expected_sum)
            report "TC4 FAILED: Incorrect SUM"
            severity error;

        assert (actual_cout = expected_cout)
            report "TC4 FAILED: Incorrect COUT"
            severity error;

        assert (GG_tb = '1')
            report "TC4 FAILED: GG should be asserted"
            severity error;

        ----------------------------------------------------------------
        -- TEST CASE 5
        -- Full propagation case
        ----------------------------------------------------------------
        A_tb   <= "1010";
        B_tb   <= "0101";
        CIN_tb <= '1';

        wait for 25 ns;

        assert (PG_tb = '1')
            report "TC5 FAILED: PG should be asserted"
            severity error;

        assert (SUM_tb = expected_sum)
            report "TC5 FAILED: Incorrect SUM"
            severity error;

        assert (actual_cout = expected_cout)
            report "TC5 FAILED: Incorrect COUT"
            severity error;

        ----------------------------------------------------------------
        -- Exhaustive Verification
        ----------------------------------------------------------------
        report "Starting exhaustive verification..." severity note;

        for c_idx in 0 to 1 loop

            if c_idx = 0 then
                CIN_tb <= '0';
            else
                CIN_tb <= '1';
            end if;

            for a_idx in 0 to 15 loop

                A_tb <= std_logic_vector(to_unsigned(a_idx, 4));

                for b_idx in 0 to 15 loop

                    B_tb <= std_logic_vector(to_unsigned(b_idx, 4));

                    ----------------------------------------------------------------
                    -- IMPORTANT:
                    -- Structural NAND implementation requires long settle time
                    ----------------------------------------------------------------
                    wait for 25 ns;

                    ----------------------------------------------------
                    -- Verify SUM
                    ----------------------------------------------------
                    assert (SUM_tb = expected_sum)
                        report "SUM mismatch: A=" &
                               integer'image(a_idx) &
                               " B=" &
                               integer'image(b_idx) &
                               " CIN=" &
                               integer'image(c_idx)
                        severity failure;

                    ----------------------------------------------------
                    -- Verify Carry Out
                    ----------------------------------------------------
                    assert (actual_cout = expected_cout)
                        report "COUT mismatch: A=" &
                               integer'image(a_idx) &
                               " B=" &
                               integer'image(b_idx) &
                               " CIN=" &
                               integer'image(c_idx)
                        severity failure;

                end loop;
            end loop;
        end loop;

        ----------------------------------------------------------------
        -- Simulation Complete
        ----------------------------------------------------------------
        report "========================================" severity note;
        report "ALL TESTS PASSED SUCCESSFULLY" severity note;
        report "========================================" severity note;

        wait;

    end process;

end Behavioral;