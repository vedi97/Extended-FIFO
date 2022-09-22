--Vedi Gh

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fifo_tb is
--  Port ( );
end fifo_tb;

architecture Behavioral of fifo_tb is
	constant ADDR_WIDTH : integer := 4;
	constant DATA_WIDTH : integer := 4;
	constant CP : time := 10ns;

	signal clk_tb: std_logic;
	signal reset_tb: std_logic;
	signal rd_tb: std_logic;
	signal wr_tb: std_logic;
	signal w_data_tb : std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal empty_tb : std_logic;
	signal full_tb : std_logic;
	signal r_data_tb : std_logic_vector(DATA_WIDTH - 1 downto 0);
	signal w_count_tb: std_logic_vector(DATA_WIDTH -1 downto 0);
	signal almost_full_tb: std_logic;
	signal almost_empty_tb: std_logic;
	
	component fifo is
		port(
			clk, reset : in std_logic;
			rd, wr : in std_logic;
			w_data : in std_logic_vector(DATA_WIDTH - 1 downto 0);
			empty : out std_logic;
			full : out std_logic;
			r_data : out std_logic_vector(DATA_WIDTH - 1 downto 0);
			w_count: out std_logic_vector(DATA_WIDTH -1 downto 0);
			almost_full: out std_logic;
			almost_empty: out std_logic
			);
	end component fifo;

begin

	fifo_i : fifo
	port map(
		 clk => clk_tb,
		 reset => reset_tb, 
		 rd => rd_tb,
		 wr => wr_tb,
		 w_data => w_data_tb,
		 empty => empty_tb,
		 full => full_tb, 
		 r_data => r_data_tb,
		 w_count => w_count_tb,
		 almost_full => almost_full_tb,
		 almost_empty => almost_empty_tb
		);

	process
	begin
		clk_tb <= '1';
		wait for CP/2;
		clk_tb <= '0';
		wait for CP/2;
	end process;

	process
	begin
		reset_tb <= '1';

		wait for CP;
		reset_tb <= '0';

--write #1
		wait for CP;
		wr_tb <= '1';
		rd_tb <= '0';
		w_data_tb <= "0001";

--write #2
		wait for CP;
		wr_tb <= '1';
		rd_tb <= '0';
		w_data_tb <= "0010";
--wirte #3
		wait for CP;
		wr_tb <= '1';
		rd_tb <= '0';
		w_data_tb <= "0011";
--write #4
		wait for CP;
		wr_tb <= '1';
		rd_tb <= '0';
		w_data_tb <= "0100";
--write $5
		wait for CP;
		wr_tb <= '1';
		rd_tb <= '0';
		w_data_tb <= "0101";
--write #15
		wait for CP;
		wr_tb <= '1';
		rd_tb <= '0';
		w_data_tb <= "1111";
--write #14
		wait for CP;
		wr_tb <= '1';
		rd_tb <= '0';
		w_data_tb <= "1110";
--write #13
		wait for CP;
		wr_tb <= '1';
		rd_tb <= '0';
		w_data_tb <= "1101";
--write #12
		wait for CP;
		wr_tb <= '1';
		rd_tb <= '0';
		w_data_tb <= "1100";
--write #11
		wait for CP;
		wr_tb <= '1';
		rd_tb <= '0';
		w_data_tb <= "1011";
--write #10
		wait for CP;
		wr_tb <= '1';
		rd_tb <= '0';
		w_data_tb <= "1010";
--write #09
		wait for CP;
		wr_tb <= '1';
		rd_tb <= '0';
		w_data_tb <= "1001";
--write #08
		wait for CP;
		wr_tb <= '1';
		rd_tb <= '0';
		w_data_tb <= "1000";
--write #07
		wait for CP;
		wr_tb <= '1';
		rd_tb <= '0';
		w_data_tb <= "0111";
--write #06
		wait for CP;
		wr_tb <= '1';
		rd_tb <= '0';
		w_data_tb <= "0110";

--write #3
		wait for CP;
		wr_tb <= '1';
		rd_tb <= '0';
		w_data_tb <= "0011";
--write #1
		wait for CP;
		wr_tb <= '1';
		rd_tb <= '0';
		w_data_tb <= "0001";
--read
		wait for CP;
		wr_tb <= '0';
		rd_tb <= '1';
--read
		wait for CP;
		wr_tb <= '0';
		rd_tb <= '1';
--read
		wait for CP;
		wr_tb <= '0';
		rd_tb <= '1';
--read
		wait for CP;
		wr_tb <= '0';
		rd_tb <= '1';
--read
		wait for CP;
		wr_tb <= '0';
		rd_tb <= '1';
--read
		wait for CP;
		wr_tb <= '0';
		rd_tb <= '1';
--read
		wait for CP;
		wr_tb <= '0';
		rd_tb <= '1';
--read
		wait for CP;
		wr_tb <= '0';
		rd_tb <= '1';
--read
		wait for CP;
		wr_tb <= '0';
		rd_tb <= '1';
--read
		wait for CP;
		wr_tb <= '0';
		rd_tb <= '1';
		wait;
	end process;
end Behavioral;

