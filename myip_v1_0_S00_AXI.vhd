library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity myip_v1_0_S00_AXI is
	generic (
		C_S_AXI_DATA_WIDTH : integer := 32;
		C_S_AXI_ADDR_WIDTH : integer := 4
	);
	port (
		S_AXI_ACLK      : in  std_logic;
		S_AXI_ARESETN   : in  std_logic;
		S_AXI_AWADDR    : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT    : in  std_logic_vector(2 downto 0);
		S_AXI_AWVALID   : in  std_logic;
		S_AXI_AWREADY   : out std_logic;
		S_AXI_WDATA     : in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB     : in  std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID    : in  std_logic;
		S_AXI_WREADY    : out std_logic;
		S_AXI_BRESP     : out std_logic_vector(1 downto 0);
		S_AXI_BVALID    : out std_logic;
		S_AXI_BREADY    : in  std_logic;
		S_AXI_ARADDR    : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT    : in  std_logic_vector(2 downto 0);
		S_AXI_ARVALID   : in  std_logic;
		S_AXI_ARREADY   : out std_logic;
		S_AXI_RDATA     : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP     : out std_logic_vector(1 downto 0);
		S_AXI_RVALID    : out std_logic;
		S_AXI_RREADY    : in  std_logic;
		o_led           : out std_logic_vector(7 downto 0);
		btn             : in  std_logic
	);
end myip_v1_0_S00_AXI;

architecture arch_imp of myip_v1_0_S00_AXI is

	component HW1
		port (
			i_clk     : in  std_logic;
			i_rst_n   : in  std_logic;
			i_limit   : in  std_logic_vector(7 downto 0);
			o_count   : out std_logic_vector(7 downto 0)
		);
	end component;

	signal rst_hw1 : std_logic;
	signal slv_reg0 : std_logic_vector(31 downto 0);

begin

	rst_hw1 <= S_AXI_ARESETN and (not btn);

	hw1_inst : HW1
		port map (
			i_clk   => S_AXI_ACLK,
			i_rst_n => rst_hw1,
			i_limit => slv_reg0(7 downto 0),
			o_count => o_led
		);

	-- AXI default response assignments
	S_AXI_AWREADY <= '0';
	S_AXI_WREADY  <= '0';
	S_AXI_BRESP   <= (others => '0');
	S_AXI_BVALID  <= '0';
	S_AXI_ARREADY <= '0';
	S_AXI_RDATA   <= (others => '0');
	S_AXI_RRESP   <= (others => '0');
	S_AXI_RVALID  <= '0';

end arch_imp;
