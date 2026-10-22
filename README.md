<div align="center">

# 🧠 8×8 Synchronous RAM in Verilog

**A clean, simulation-verified 8-location × 8-bit RAM with asynchronous reset,**
**built with Verilog-2001, simulated using Icarus Verilog and GTKWave.**

![Verilog](https://img.shields.io/badge/HDL-Verilog-blue?style=for-the-badge)
![Simulator](https://img.shields.io/badge/Sim-Icarus%20Verilog-orange?style=for-the-badge)
![Waveform](https://img.shields.io/badge/Waves-GTKWave-green?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-lightgrey?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Basic%20TB%20Verified-brightgreen?style=for-the-badge)

</div>

---

## 📖 Overview

`ram8_8` is a small single-port-style memory block: **8 words × 8 bits**, one write path and one read path, controlled by a single `wr_enb` signal. It is a classic building block for learning memory design, and this repo uses it as a base to grow into a **parity-protected RAM** verified with **self-checking testbenches**.

## ✨ Features

- 8 × 8 memory array (`reg [7:0] mem [7:0]`)
- Synchronous write, **registered (synchronous) read**
- **Asynchronous active-high reset** that clears all memory locations
- Separate `wr_addr` and `rd_addr` ports
- Clock generation + stimulus testbench with VCD dump for GTKWave
- One-command build & run with `make`

## 🔌 Port Description

| Port       | Dir    | Width | Description                                   |
|------------|--------|-------|-----------------------------------------------|
| `clk`      | input  | 1     | System clock (rising-edge triggered)          |
| `rst`      | input  | 1     | Asynchronous reset, active high               |
| `wr_enb`   | input  | 1     | `1` = write, `0` = read                       |
| `wr_addr`  | input  | 4     | Write address (valid range 0–7)               |
| `rd_addr`  | input  | 4     | Read address (valid range 0–7)                |
| `data_in`  | input  | 8     | Data to be written                            |
| `data_out` | output | 8     | Read data, updates on the next rising edge    |

## ⚙️ How It Works

| `rst` | `wr_enb` | Action on clock edge                    |
|:-----:|:--------:|-----------------------------------------|
|   1   |    x     | Clear all memory locations (async)      |
|   0   |    1     | `mem[wr_addr] <= data_in`               |
|   0   |    0     | `data_out <= mem[rd_addr]`              |

## 📂 Repository Structure

```
verilog-ram-8x8/
├── rtl/
│   └── ram8_8.v          # Design
├── tb/
│   └── ram8_8_tb.v       # Testbench
├── docs/
│   └── waveform.png      # Simulation output
├── sim/                  # Generated .vcd / .out (git-ignored)
├── Makefile
├── LICENSE
└── README.md
```

## 🚀 Getting Started

**Prerequisites:** [Icarus Verilog](https://steveicarus.github.io/iverilog/) and [GTKWave](https://gtkwave.sourceforge.net/)

```bash
git clone https://github.com/<your-username>/verilog-ram-8x8.git
cd verilog-ram-8x8

make          # compile + run simulation
make wave     # open waveform in GTKWave
make clean    # remove generated files
```

## 🧪 Test Scenario

| Time (ns) | Action                                   |
|-----------|------------------------------------------|
| 0–10      | Reset asserted                           |
| 10–20     | Write `0x05` to address `4`              |
| 20–30     | Write `0x0A` to address `5`              |
| 30–40     | Read address `4` → expect `0x05`         |
| 40+       | Read address `5` → expect `0x0A`         |

## 📊 Simulation Output

![Waveform](docs/waveform.png)

**What to notice:**
- `data_out` is `XX` until the first read, because the output register is not reset (see Roadmap).
- After the read of address 4, `data_out` shows `05`; after the read of address 5, it shows `0a`.
- The one-cycle delay between changing `rd_addr` and seeing the data is the **registered read** behavior.

## 🔍 Design Notes

- **Reset loop bug fixed:** the original loop ran `i < 7`, leaving `mem[7]` uncleared. It now runs `i < 8`.
- **Address width:** the address ports are 4 bits but only 8 locations exist, so addresses 8–15 are out of range. Planned fix is to narrow them to 3 bits (`[2:0]`).
- **`data_out` is not reset**, so it is `X` until the first read.

## 🗺️ Roadmap

- [x] 8×8 RAM with async reset
- [x] Basic directed testbench + VCD waveform
- [ ] Reset `data_out`, narrow addresses to 3 bits
- [ ] **Parity generator & checker** (store a 9th bit per word, flag errors on read)
- [ ] **Self-checking testbench** with a reference model, `task`s, and automatic PASS/FAIL
- [ ] Randomized + corner-case tests (back-to-back writes, read-after-write, reset mid-operation)
- [ ] Error-injection test to prove the parity checker catches single-bit flips
- [ ] GitHub Actions CI running the simulation on every push
- [ ] Synthesis check with Yosys

### Planned parity extension

```
 data_in ──► [ parity gen ] ──► mem[addr] = {parity, data}
                                      │
 data_out ◄── [ parity check ] ◄──────┘──► parity_err flag
```

## 🤝 Contributing

Issues and pull requests are welcome. Please keep the style consistent and include a testbench update with any RTL change.

## 📜 License

Released under the [MIT License](LICENSE).

---

<div align="center">⭐ If this helped you, consider starring the repo!</div>
