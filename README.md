# Home Gas Detection System (SDGH)

The **Home Gas Detection System (SDGH)** is an embedded real-time monitoring solution designed to detect hazardous concentrations of Methane ($CH_4$) and Carbon Dioxide ($CO_2$). Developed in VHDL for the Basys 3 FPGA, the system prevents accidents such as "backdrafting" in chimneys or domestic gas leaks by triggering localized safety protocols.

## Overview

The primary objective of the SDGH is to analyze analog sensor data in real-time and manage digital control outputs to ensure domestic safety. The system is built entirely in **VHDL**, utilizing the FPGA's processing power to handle high-frequency ADC sampling and multiplexed visual outputs. The architecture features a modular design where concurrent components manage sensor digitization, threshold comparison, and data stability.

The system operates based on two detection states:
* **Warning Mode:** Triggers a visual LED signal and an auditory alarm (buzzer) when gas levels exceed the initial safety threshold.
* **Ventilation Mode:** Signals a critical alert requiring immediate airflow when concentrations reach dangerous levels.

---

## System Architecture

The following diagram illustrates the internal modularity of the VHDL design. It shows the hierarchical structure where the `top_module` integrates the `xadc` interface, data stabilization registers, and the BCD conversion logic.

### Component Diagram
![Diagram](https://github.com/aghidalgo04/SistemaDeteccionGasesHogar/blob/main/imgs/Diagrama%20SDGH.drawio.png)

> **Diagram Description:** This visual represents the RTL (Register-Transfer Level) interconnection. The signal enters through the `xadc` module, is demultiplexed into $CH_4$ and $CO_2$ paths, stored in `Registro12Bits` for stability, and finally processed by the `Comparador` to determine alarm states.

---

## Hardware Implementation

The hardware setup utilizes the Basys 3 board's onboard resources and external analog sensors. Due to the FPGA's 1V input limit on the JXADC ports, a custom voltage divider was implemented.

### Final Hardware Photo
![Hardware](https://github.com/aghidalgo04/SistemaDeteccionGasesHogar/blob/main/imgs/HardwareSDGH.jpeg)

> **Photo Description:** The final prototype captures the Basys 3 FPGA connected to the MQ-135 sensor via the JA Pmod ports. It highlights the custom voltage divider circuit (using 4kΩ and 1kΩ resistors) which scales the sensor's 5V output down to the safe 1V range required for accurate digital conversion.

---

## Key Features

### Gas Monitoring & Safety
* **CO2 Detection:** Monitors air quality using the MQ-135 sensor.
* **Methane Detection:** Integrated logic for MQ-4 sensor monitoring and comparison.
* **Adaptive Thresholds:** Distinct constants for Warning and Ventilation states (e.g., CO2 Warning at 2500 units; Ventilation at 3500 units).
* **Safety Protocols:** Automatic activation of a buzzer and warning LED upon detection of harmful gas density.

### Real-Time Hardware Processing
* **XADC Control:** High-speed analog-to-digital conversion using the XADC Wizard in Continuous/Single Channel mode.
* **Digital Filtering:** 12-bit registers ensure data stability before visualization to prevent flickering from sensor noise.
* **Efficient Decoding:** Uses the Double-Dabble algorithm for binary-to-decimal conversion to optimize hardware performance.
* **Frequency Scaling:** Divides the 100MHz system clock to a 1Hz update rate for human-readable display updates.

---

## Software Structure (VHDL Modules)

The project follows a structural model integrated into a `top_module`.

* **`xadc.vhd`**: Manages the Analog-to-Digital IP core and sensor input ports.
* **`Comparador.vhd`**: Logic block comparing sensor values against safety constants.
* **`display.vhd`**: Handles temporal multiplexing for the 7-segment display at approximately 100Hz.
* **`bin12ToBCD.vhd`**: Core logic for converting 12-bit binary data to BCD format.
* **`DivisorFrecuencia.vhd`**: Generates the 1Hz signal for data sampling cycles.
* **`Registro12Bits.vhd`**: D-Flip-Flop based storage for synchronized data processing.

---

## Testing

Verification was conducted through both simulation and physical hardware testing:
* **Functional Simulation:** Testbenches validated the `Comparador` thresholds and visual outputs.
* **Voltage Accuracy:** Tests with 3V and 5V inputs verified the voltage divider's accuracy in converting analog signals to the FPGA's 0-1V range.
* **Synchronization:** Resolved timing issues between the XADC output and the display by synchronizing the LED alarm and Display updates on the 1Hz clock edge.

---

