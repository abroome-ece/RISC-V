library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cla_block is
    port (
        A   : in  std_logic_vector(3 downto 0);
        B   : in  std_logic_vector(3 downto 0);
        CIN : in  std_logic;
        PG  : out std_logic;
        GG  : out std_logic;
        SUM : out std_logic_vector(3 downto 0)
    );
end cla_block;

architecture Behavioral of cla_block is

    component four_and_gate is
        port (
            A : in  std_logic_vector(3 downto 0);
            F : out std_logic
        );
    end component;

    component four_or_gate is
        port (
            A : in  std_logic_vector(3 downto 0);
            F : out std_logic
        );
    end component;

    component xor_gate is
        port (
            A : in  std_logic;
            B : in  std_logic;
            F : out std_logic
        );
    end component;

    component and_gate is
        port (
            A : in  std_logic;
            B : in  std_logic;
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

    signal p, g : std_logic_vector(3 downto 0);

    -- c(0) = CIN
    -- c(1) = carry into bit1
    -- c(2) = carry into bit2
    -- c(3) = carry into bit3
    -- c(4) = carry out of bit3
    signal c : std_logic_vector(4 downto 0);

    signal n : std_logic_vector(10 downto 0);

    signal u5_in  : std_logic_vector(3 downto 0);
    signal u7_in  : std_logic_vector(3 downto 0);
    signal u8_in  : std_logic_vector(3 downto 0);
    signal u9_in  : std_logic_vector(3 downto 0);
    signal u11_in : std_logic_vector(3 downto 0);
    signal u12_in : std_logic_vector(3 downto 0);
    signal u14_in : std_logic_vector(3 downto 0);
    signal u15_in : std_logic_vector(3 downto 0);
    signal u20_in : std_logic_vector(3 downto 0);

begin

    --------------------------------------------------------------------
    -- Initial carry input
    --------------------------------------------------------------------
    c(0) <= CIN;

    --------------------------------------------------------------------
    -- Propagate generation
    -- p(i) = A(i) xor B(i)
    --------------------------------------------------------------------
    PRO_GEN : for i in 0 to 3 generate
    begin
        u1 : xor_gate
            port map (
                A => A(i),
                B => B(i),
                F => p(i)
            );
    end generate PRO_GEN;

    --------------------------------------------------------------------
    -- Generate generation
    -- g(i) = A(i) and B(i)
    --------------------------------------------------------------------
    GEN_GEN : for i in 0 to 3 generate
    begin
        u2 : and_gate
            port map (
                A => A(i),
                B => B(i),
                F => g(i)
            );
    end generate GEN_GEN;

    --------------------------------------------------------------------
    -- Sum generation
    -- SUM(i) = p(i) xor c(i)
    --------------------------------------------------------------------
    SUM_GEN : for i in 0 to 3 generate
    begin
        u_sum : xor_gate
            port map (
                A => p(i),
                B => c(i),
                F => SUM(i)
            );
    end generate SUM_GEN;

    --------------------------------------------------------------------
    -- Intermediate vectors
    --------------------------------------------------------------------
    u5_in  <= p(1) & p(0) & CIN & '1';

    u7_in  <= n(1) & n(2) & g(1) & '0';

    u8_in  <= p(2) & p(1) & p(0) & CIN;

    u9_in  <= p(2) & p(1) & g(0) & '1';

    u11_in <= n(3) & n(4) & n(5) & g(2);

    u12_in <= p(3) & p(2) & p(1) & p(0);

    u14_in <= p(3) & p(2) & p(1) & g(0);

    u15_in <= p(3) & p(2) & g(1) & '1';

    u20_in <= n(7) & n(8) & n(9) & g(3);

    --------------------------------------------------------------------
    -- Carry C1
    -- c(1) = g0 + p0*CIN
    --------------------------------------------------------------------
    u3 : and_gate
        port map (
            A => p(0),
            B => CIN,
            F => n(0)
        );

    u4 : or_gate
        port map (
            A => g(0),
            B => n(0),
            F => c(1)
        );

    --------------------------------------------------------------------
    -- Carry C2
    -- c(2) = g1 + p1*g0 + p1*p0*CIN
    --------------------------------------------------------------------
    u5 : four_and_gate
        port map (
            A => u5_in,
            F => n(1)
        );

    u6 : and_gate
        port map (
            A => p(1),
            B => g(0),
            F => n(2)
        );

    u7 : four_or_gate
        port map (
            A => u7_in,
            F => c(2)
        );

    --------------------------------------------------------------------
    -- Carry C3
    -- c(3) = g2 + p2*g1 + p2*p1*g0 + p2*p1*p0*CIN
    --------------------------------------------------------------------
    u8 : four_and_gate
        port map (
            A => u8_in,
            F => n(3)
        );

    u9 : four_and_gate
        port map (
            A => u9_in,
            F => n(4)
        );

    u10 : and_gate
        port map (
            A => p(2),
            B => g(1),
            F => n(5)
        );

    u11 : four_or_gate
        port map (
            A => u11_in,
            F => c(3)
        );

    --------------------------------------------------------------------
    -- Group Propagate
    -- PG = p3*p2*p1*p0
    --------------------------------------------------------------------
    u12 : four_and_gate
        port map (
            A => u12_in,
            F => n(6)
        );

    --------------------------------------------------------------------
    -- Group Generate
    -- GG = g3 + p3*g2 + p3*p2*g1 + p3*p2*p1*g0
    --------------------------------------------------------------------
    u14 : four_and_gate
        port map (
            A => u14_in,
            F => n(7)
        );

    u15 : four_and_gate
        port map (
            A => u15_in,
            F => n(8)
        );

    u16 : and_gate
        port map (
            A => p(3),
            B => g(2),
            F => n(9)
        );

    u20 : four_or_gate
        port map (
            A => u20_in,
            F => n(10)
        );

    --------------------------------------------------------------------
    -- Outputs
    --------------------------------------------------------------------
    PG <= n(6);
    GG <= n(10);

end Behavioral;