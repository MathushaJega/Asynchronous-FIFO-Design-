# Asynchronous FIFO with CDC Logic

## **Project Overview**
This project implements a **Dual-Clock Asynchronous FIFO** designed to safely transfer data between independent clock domains. It utilizes a **Circular Buffer** architecture to manage memory addresses efficiently.

---

## **Key Features**
* **Circular Buffer Architecture:** Efficiently manages memory addresses using binary pointers for local access while maintaining data integrity.
* **Metastability Mitigation:** Employs **2-stage register synchronizers** to ensure stable signal sampling across clock boundaries.
* **Pointer Synchronization:** Implements **Gray Code conversion** for write and read pointers, ensuring single-bit transitions during domain crossing.
* **Robust Status Logic:** Generates accurate `full` and `empty` flags to provide back-pressure and prevent data overflow or underflow.

---

## **Hardware Architecture**
The design consists of five main sub-modules working together:

* **`fifo_mem`**: The core memory array where `data_in` is stored and `data_out` is retrieved.
* **`wptr_handler`**: Manages the binary write pointer and converts it to Gray Code for synchronization.
* **`rptr_handler`**: Manages the binary read pointer and generates the `empty` flag.
* **`synchronizer`**: Two-stage flip-flop chains that safely pass Gray Code pointers between asynchronous domains.

---

## **Signal Interface**

| Signal | Type | Description |
| :--- | :--- | :--- |
| **wclk / rclk** | Input | Independent Write and Read clock domains. |
| **wrst_n / rrst_n** | Input | Active-low resets for each clock domain. |
| **w_en / r_en** | Input | Enable signals for writing to and reading from the buffer. |
| **data_in [7:0]** | Input | 8-bit data input bus. |
| **data_out [7:0]** | Output | 8-bit data output bus. |
| **full / empty** | Output | Status flags indicating FIFO capacity. |

---

## **Verification Strategy**
The design was validated using a **SystemVerilog Testbench**:
* **Clock Mismatch**: Tested with a 20ns Write period and a 70ns Read period to stress-test the `full` flag.
* **Data Integrity**: Implemented a **SystemVerilog Queue** as a golden reference to ensure the "First-In, First-Out" order is preserved.
