--Vedi Gh

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity fifo_ctrl is
	generic(ADDR_WIDTH : natural := 4;
		DATA_WIDTH : integer := 4
		);

	port(
		clk, reset : in std_logic;
		rd, wr : in std_logic;
		empty, full : out std_logic;
		w_addr : out std_logic_vector(ADDR_WIDTH-1 downto 0);
		r_addr : out std_logic_vector(ADDR_WIDTH-1 downto 0);
		
		--New Added
		w_count: out std_logic_vector(DATA_WIDTH-1 downto 0);
		almost_full: out std_logic;
		almost_empty: out std_logic
		);
	end fifo_ctrl;

architecture arch of fifo_ctrl is
	constant AM_FULL : integer := integer(0.75*real(2**DATA_WIDTH));
	constant AM_EMPTY : integer := integer(0.25*real(2**DATA_WIDTH));

	signal w_ptr_reg: std_logic_vector(ADDR_WIDTH-1 downto 0);
	signal w_ptr_next : std_logic_vector(ADDR_WIDTH-1 downto 0);
	signal w_ptr_succ : std_logic_vector(ADDR_WIDTH-1 downto 0);
	signal r_ptr_reg: std_logic_vector(ADDR_WIDTH-1 downto 0);
	signal r_ptr_next : std_logic_vector(ADDR_WIDTH-1 downto 0);
	signal r_ptr_succ : std_logic_vector(ADDR_WIDTH-1 downto 0);
	signal full_reg : std_logic;
	signal full_next : std_logic;
	signal empty_reg : std_logic;
	signal empty_next : std_logic;
	signal wr_op: std_logic_vector(1 downto 0);
	
	--New Added
	signal w_count_reg: std_logic_vector(DATA_WIDTH-1 downto 0);
	signal w_count_next: std_logic_vector(DATA_WIDTH-1 downto 0);
	signal almost_full_reg: std_logic;
	signal almost_full_next: std_logic; 
	signal almost_empty_reg: std_logic;
	signal almost_empty_next: std_logic;
begin

--register for read and write pointers
process (clk, reset)
begin
	if (reset = '1') then
		w_ptr_reg <= (others => '0');
		r_ptr_reg <= (others => '0');
		full_reg  <= '0';
		empty_reg <= '1';
		
		--New Added
		w_count_reg <= "0000";
		almost_full_reg <= '0';
		almost_empty_reg <= '0';

	elsif (clk'event and clk = '1') then
		w_ptr_reg <= w_ptr_next;
		r_ptr_reg <= r_ptr_next;
		full_reg  <= full_next;
		empty_reg <= empty_next;
		
		--New Added
		w_count_reg <= w_count_next;
		almost_full_reg <= almost_full_next;
		almost_empty_reg <= almost_empty_next;
	end if;
end process;

--successive pointer values
	w_ptr_succ <= std_logic_vector(unsigned(w_ptr_reg) + 1);
	r_ptr_succ <= std_logic_vector(unsigned(r_ptr_reg) + 1);

--next-state logic for read and write pointers
	wr_op <= wr & rd;

process(w_ptr_reg, w_ptr_succ, r_ptr_reg, r_ptr_succ, wr_op, empty_reg, full_reg,w_count_reg)
begin
	w_ptr_next <= w_ptr_reg;
	r_ptr_next <= r_ptr_reg;
	full_next  <= full_reg;
	empty_next <= empty_reg;

	--New Added
	w_count_next <= w_count_reg;
	almost_full_next <= almost_full_reg;
	almost_empty_next <= almost_empty_reg;

	case wr_op is
        	when "00" =>                   -- no op
        	when "01" =>                   -- read
           		if (empty_reg /= '1') then  -- not empty
              			r_ptr_next <= r_ptr_succ;
             			full_next  <= '0';
	
				--New Added
				w_count_next <= w_count_reg - "0001";

				if (w_count_next = AM_FULL) then	--almost full 75% of 256 word
					almost_full_next <= '1';
				elsif (w_count_next = AM_EMPTY) then
					almost_empty_next <= '1';
				else 
					almost_full_next <= '0';
					almost_empty_next <= '0';
				end if;

              		if (r_ptr_succ = w_ptr_reg) then
              			empty_next <= '1';

				--New Added
				w_count_next <= "0000";
              		end if;
           		end if;
		when "10" =>                   -- write
           		if (full_reg /= '1') then   -- not full
              			w_ptr_next <= w_ptr_succ;
              			empty_next <= '0';
				
			--New Added
			w_count_next <= w_count_reg + "0001";

			if (w_count_next = AM_FULL) then	--almost full 75% of 256 word
				almost_full_next <= '1';
			elsif (w_count_next = AM_EMPTY) then
				almost_empty_next <= '1';
			else 
				almost_full_next <= '0';
				almost_empty_next <= '0';
			end if;
			
              		if (w_ptr_succ = r_ptr_reg) then
                 		full_next <= '1';

			--New Added
			w_count_next <= "1111";
              		end if;
           		end if;
        	when others =>                 -- write/read;
           		w_ptr_next <= w_ptr_succ;
           		r_ptr_next <= r_ptr_succ;
     	end case;
end process;

--output
	w_addr <= w_ptr_reg;
	r_addr <= r_ptr_reg;
	full   <= full_reg;
	empty  <= empty_reg;
		
	--New Added
	w_count <= w_count_reg;
	almost_full <= almost_full_reg;
	almost_empty <= almost_empty_reg;
end arch;


























