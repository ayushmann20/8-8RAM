SRC = rtl/ram8_8.v
TB  = tb/ram8_8_tb.v

all: run

build:
	mkdir -p sim
	iverilog -o sim/ram8_8.out $(SRC) $(TB)

run: build
	vvp sim/ram8_8.out

wave: run
	gtkwave sim/ram8_8.vcd &

clean:
	rm -rf sim/*.out sim/*.vcd
