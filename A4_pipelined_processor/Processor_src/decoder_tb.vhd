library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decoder_tb is
end decoder_tb;

architecture arch of decoder_tb is

    Component decoder is
    port(       instruction : in std_logic_vector(31 downto 0);
                clock       : in  std_logic;
                alu_op_code : out std_logic_vector(5 downto 0);
                reg_dst     : out std_logic; --Determines how the destination register is specified (rt or rd)
                reg_write   : out std_logic; --write to register file
                alu_src     : out std_logic; --source for second ALU input(rt or sign-extended immediate field)
                mem_write   : out std_logic; --write input address/data to memory
                mem_read    : out std_logic; --read input address from memory
                jump        : out std_logic; --Enables loading the jump target address into the PC
                branch      : out std_logic --Combined with a condition test boolean to enable loading the branch target address into the PC
    );  
    end Component;

    constant clk_period : time := 1 ns;
    signal instruction : std_logic_vector(31 downto 0):=(others=>'0');
    signal clk       : std_logic := '0';
    signal alu_op_code : std_logic_vector(5 downto 0):=(others=>'0');
    signal reg_dst : std_logic := '0';
    signal reg_write : std_logic := '0';
    signal alu_src : std_logic := '0';
    signal mem_write : std_logic := '0';
    signal mem_read : std_logic := '0';
    signal jump : std_logic := '0';
    signal branch : std_logic := '0';    

    BEGIN

        dut: decoder 
            PORT MAP(instruction,
                       clk,
                alu_op_code,
                reg_dst,
                reg_write,
                alu_src,
                mem_write,
                mem_read,
                jump,
                branch);           
    
    clk_process: process
      begin
        clk<='0';
        wait for clk_period/2;
        clk<='1';
        wait for clk_period/2;
      end process;
      
        test_process: process

            BEGIN
                --001000 00000 01011 0000011111010000
                --addi $rs $rt 2000
                instruction<=x"200B07D0";
                wait for clk_period;
                ASSERT (alu_op_code = "100000") REPORT "alu_op_code mismatch" SEVERITY ERROR;
                ASSERT (reg_dst='1') REPORT "reg_dst mismatch" SEVERITY ERROR;
                ASSERT (reg_write='1') REPORT "reg_write mismatch" SEVERITY ERROR;
                ASSERT (alu_src='1') REPORT "alu_src mismatch" SEVERITY ERROR;
                ASSERT (mem_write='0') REPORT "mem_write mismatch" SEVERITY ERROR;
                ASSERT (mem_read='0') REPORT "mem_read mismatch" SEVERITY ERROR;
                ASSERT (jump='0') REPORT "jump mismatch" SEVERITY ERROR;
                ASSERT (branch='0') REPORT "branch mismatch" SEVERITY ERROR;
  
                --001000 00000 01111 0000000000000100
                instruction<=x"200F0004";
                wait for clk_period;
                ASSERT (alu_op_code = "100000") REPORT "alu_op_code mismatch" SEVERITY ERROR;
                ASSERT (reg_dst='1') REPORT "reg_dst mismatch" SEVERITY ERROR;
                ASSERT (reg_write='1') REPORT "reg_write mismatch" SEVERITY ERROR;
                ASSERT (alu_src='1') REPORT "alu_src mismatch" SEVERITY ERROR;
                ASSERT (mem_write='0') REPORT "mem_write mismatch" SEVERITY ERROR;
                ASSERT (mem_read='0') REPORT "mem_read mismatch" SEVERITY ERROR;
                ASSERT (jump='0') REPORT "jump mismatch" SEVERITY ERROR;
                ASSERT (branch='0') REPORT "branch mismatch" SEVERITY ERROR;

                --001000 00000000010000000000000011
                instruction<=x"20010003";
                wait for clk_period;
                ASSERT (alu_op_code = "100000") REPORT "alu_op_code mismatch" SEVERITY ERROR;
                ASSERT (reg_dst='1') REPORT "reg_dst mismatch" SEVERITY ERROR;
                ASSERT (reg_write='1') REPORT "reg_write mismatch" SEVERITY ERROR;
                ASSERT (alu_src='1') REPORT "alu_src mismatch" SEVERITY ERROR;
                ASSERT (mem_write='0') REPORT "mem_write mismatch" SEVERITY ERROR;
                ASSERT (mem_read='0') REPORT "mem_read mismatch" SEVERITY ERROR;
                ASSERT (jump='0') REPORT "jump mismatch" SEVERITY ERROR;
                ASSERT (branch='0') REPORT "branch mismatch" SEVERITY ERROR;

                --001000 00000000100000000000000100
                instruction<=x"20020004";
                wait for clk_period;
                ASSERT (alu_op_code = "100000") REPORT "alu_op_code mismatch" SEVERITY ERROR;
                ASSERT (reg_dst='1') REPORT "reg_dst mismatch" SEVERITY ERROR;
                ASSERT (reg_write='1') REPORT "reg_write mismatch" SEVERITY ERROR;
                ASSERT (alu_src='1') REPORT "alu_src mismatch" SEVERITY ERROR;
                ASSERT (mem_write='0') REPORT "mem_write mismatch" SEVERITY ERROR;
                ASSERT (mem_read='0') REPORT "mem_read mismatch" SEVERITY ERROR;
                ASSERT (jump='0') REPORT "jump mismatch" SEVERITY ERROR;
                ASSERT (branch='0') REPORT "branch mismatch" SEVERITY ERROR;

                --000000 00001000100001100000 100100
                instruction<=x"00221824";
                wait for clk_period;
                ASSERT (alu_op_code = "100100") REPORT "alu_op_code mismatch" SEVERITY ERROR;
                ASSERT (reg_dst='1') REPORT "reg_dst mismatch" SEVERITY ERROR;
                ASSERT (reg_write='1') REPORT "reg_write mismatch" SEVERITY ERROR;
                ASSERT (alu_src='0') REPORT "alu_src mismatch" SEVERITY ERROR;
                ASSERT (mem_write='0') REPORT "mem_write mismatch" SEVERITY ERROR;
                ASSERT (mem_read='0') REPORT "mem_read mismatch" SEVERITY ERROR;
                ASSERT (jump='0') REPORT "jump mismatch" SEVERITY ERROR;
                ASSERT (branch='0') REPORT "branch mismatch" SEVERITY ERROR; 

                --001000 00000010100000000000000000
                instruction<=x"200A0000";
                wait for clk_period;
                ASSERT (alu_op_code = "100000") REPORT "alu_op_code mismatch" SEVERITY ERROR;
                ASSERT (reg_dst='1') REPORT "reg_dst mismatch" SEVERITY ERROR;
                ASSERT (reg_write='1') REPORT "reg_write mismatch" SEVERITY ERROR;
                ASSERT (alu_src='1') REPORT "alu_src mismatch" SEVERITY ERROR;
                ASSERT (mem_write='0') REPORT "mem_write mismatch" SEVERITY ERROR;
                ASSERT (mem_read='0') REPORT "mem_read mismatch" SEVERITY ERROR;
                ASSERT (jump='0') REPORT "jump mismatch" SEVERITY ERROR;
                ASSERT (branch='0') REPORT "branch mismatch" SEVERITY ERROR; 

                --000000 01010011110000000000 011000
                instruction<=x"014F0018";
                wait for clk_period;
                ASSERT (alu_op_code = "011000") REPORT "alu_op_code mismatch" SEVERITY ERROR;
                ASSERT (reg_dst='1') REPORT "reg_dst mismatch" SEVERITY ERROR;
                ASSERT (reg_write='1') REPORT "reg_write mismatch" SEVERITY ERROR;
                ASSERT (alu_src='0') REPORT "alu_src mismatch" SEVERITY ERROR;
                ASSERT (mem_write='0') REPORT "mem_write mismatch" SEVERITY ERROR;
                ASSERT (mem_read='0') REPORT "mem_read mismatch" SEVERITY ERROR;
                ASSERT (jump='0') REPORT "jump mismatch" SEVERITY ERROR;
                ASSERT (branch='0') REPORT "branch mismatch" SEVERITY ERROR; 

                --000000 00000000000110000000 010010
                instruction<=x"00006012";
                wait for clk_period;
                ASSERT (alu_op_code = "010010") REPORT "alu_op_code mismatch" SEVERITY ERROR;
                ASSERT (reg_dst='1') REPORT "reg_dst mismatch" SEVERITY ERROR;
                ASSERT (reg_write='1') REPORT "reg_write mismatch" SEVERITY ERROR;
                ASSERT (alu_src='0') REPORT "alu_src mismatch" SEVERITY ERROR;
                ASSERT (mem_write='0') REPORT "mem_write mismatch" SEVERITY ERROR;
                ASSERT (mem_read='0') REPORT "mem_read mismatch" SEVERITY ERROR;
                ASSERT (jump='0') REPORT "jump mismatch" SEVERITY ERROR;
                ASSERT (branch='0') REPORT "branch mismatch" SEVERITY ERROR;

                --000000 01011011000110100000 100000
               instruction<=x"016C6820";
                wait for clk_period;
                ASSERT (alu_op_code = "100000") REPORT "alu_op_code mismatch" SEVERITY ERROR;
                ASSERT (reg_dst='1') REPORT "reg_dst mismatch" SEVERITY ERROR;
                ASSERT (reg_write='1') REPORT "reg_write mismatch" SEVERITY ERROR;
                ASSERT (alu_src='0') REPORT "alu_src mismatch" SEVERITY ERROR;
                ASSERT (mem_write='0') REPORT "mem_write mismatch" SEVERITY ERROR;
                ASSERT (mem_read='0') REPORT "mem_read mismatch" SEVERITY ERROR;
                ASSERT (jump='0') REPORT "jump mismatch" SEVERITY ERROR;
                ASSERT (branch='0') REPORT "branch mismatch" SEVERITY ERROR;

                --101011 01101000100000000000000000
               instruction<=x"ADA20000";
                wait for clk_period;
                ASSERT (alu_op_code = "100000") REPORT "alu_op_code mismatch" SEVERITY ERROR;
                ASSERT (reg_dst='X') REPORT "reg_dst mismatch" SEVERITY ERROR;
                ASSERT (reg_write='0') REPORT "reg_write mismatch" SEVERITY ERROR;
                ASSERT (alu_src='1') REPORT "alu_src mismatch" SEVERITY ERROR;
                ASSERT (mem_write='1') REPORT "mem_write mismatch" SEVERITY ERROR;
                ASSERT (mem_read='0') REPORT "mem_read mismatch" SEVERITY ERROR;
                ASSERT (jump='0') REPORT "jump mismatch" SEVERITY ERROR;
                ASSERT (branch='0') REPORT "branch mismatch" SEVERITY ERROR;

                --000100 00001000000000000000001001
               instruction<=x"20400012";
                wait for clk_period;
                ASSERT (alu_op_code = "000100") REPORT "alu_op_code mismatch" SEVERITY ERROR;
                ASSERT (reg_dst='X') REPORT "reg_dst mismatch" SEVERITY ERROR;
                ASSERT (reg_write='0') REPORT "reg_write mismatch" SEVERITY ERROR;
                ASSERT (alu_src='0') REPORT "alu_src mismatch" SEVERITY ERROR;
                ASSERT (mem_write='0') REPORT "mem_write mismatch" SEVERITY ERROR;
                ASSERT (mem_read='0') REPORT "mem_read mismatch" SEVERITY ERROR;
                ASSERT (jump='0') REPORT "jump mismatch" SEVERITY ERROR;
                ASSERT (branch='1') REPORT "branch mismatch" SEVERITY ERROR;

                --000000 01010011110000000000 011000
               instruction<=x"20400012";
                wait for clk_period;
                ASSERT (alu_op_code = "011000") REPORT "alu_op_code mismatch" SEVERITY ERROR;
                ASSERT (reg_dst='1') REPORT "reg_dst mismatch" SEVERITY ERROR;
                ASSERT (reg_write='1') REPORT "reg_write mismatch" SEVERITY ERROR;
                ASSERT (alu_src='0') REPORT "alu_src mismatch" SEVERITY ERROR;
                ASSERT (mem_write='0') REPORT "mem_write mismatch" SEVERITY ERROR;
                ASSERT (mem_read='0') REPORT "mem_read mismatch" SEVERITY ERROR;
                ASSERT (jump='0') REPORT "jump mismatch" SEVERITY ERROR;
                ASSERT (branch='0') REPORT "branch mismatch" SEVERITY ERROR;

                --000010 00000000000000000000010110
                instruction<=x"08000016";
                wait for clk_period;
                ASSERT (alu_op_code = "111111") REPORT "alu_op_code mismatch" SEVERITY ERROR;
                ASSERT (reg_dst='0') REPORT "reg_dst mismatch" SEVERITY ERROR;
                ASSERT (reg_write='0') REPORT "reg_write mismatch" SEVERITY ERROR;
                ASSERT (alu_src='0') REPORT "alu_src mismatch" SEVERITY ERROR;
                ASSERT (mem_write='0') REPORT "mem_write mismatch" SEVERITY ERROR;
                ASSERT (mem_read='0') REPORT "mem_read mismatch" SEVERITY ERROR;
                ASSERT (jump='1') REPORT "jump mismatch" SEVERITY ERROR;
                ASSERT (branch='0') REPORT "branch mismatch" SEVERITY ERROR;               

                --000101 00001000000000000000001001
                instruction<=x"14200009";
                wait for clk_period;
                ASSERT (alu_op_code = "000101") REPORT "alu_op_code mismatch" SEVERITY ERROR;
                ASSERT (reg_dst='X') REPORT "reg_dst mismatch" SEVERITY ERROR;
                ASSERT (reg_write='0') REPORT "reg_write mismatch" SEVERITY ERROR;
                ASSERT (alu_src='0') REPORT "alu_src mismatch" SEVERITY ERROR;
                ASSERT (mem_write='0') REPORT "mem_write mismatch" SEVERITY ERROR;
                ASSERT (mem_read='0') REPORT "mem_read mismatch" SEVERITY ERROR;
                ASSERT (jump='0') REPORT "jump mismatch" SEVERITY ERROR;
                ASSERT (branch='1') REPORT "branch mismatch" SEVERITY ERROR; 
  end process;

end arch;