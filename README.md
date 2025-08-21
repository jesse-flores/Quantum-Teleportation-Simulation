# Quantum Teleportation Simulation in MATLAB

This project is a MATLAB simulation of the **quantum teleportation protocol**, a fundamental process in quantum information science. It provides a visual and interactive way to understand how the quantum state of a particle can be transferred from one location (Alice) to another (Bob) without physically moving the particle itself. The simulation uses the Bloch sphere to visualize the state of the qubits at each key step.

## Features

  - **Quantum State Generation:** Creates a random quantum state (qubit) to be teleported.
  - **Bell State Creation:** Establishes a shared, entangled pair of qubits between Alice and Bob.
  - **Quantum Gate Operations:** Applies essential quantum gates—Hadamard and CNOT—to manipulate the qubits.
  - **Bloch Sphere Visualization:** Plots the quantum state on a 3D Bloch sphere, allowing you to see how the state vector changes throughout the process.
  - **Simulated Measurement:** Simulates Alice's measurement of her qubits, which determines the classical information she sends to Bob.
  - **Bob's Correction:** Bob applies a corresponding Pauli gate (X, Z, or both) to his qubit based on Alice's measurement.
  - **Verification:** The final plot confirms that Bob's qubit is now in the same state as Alice's original qubit, proving successful teleportation.

## Next Steps

As a simulation, this project provides a solid foundation for understanding the core concepts of quantum teleportation. Future enhancements could include:

  - Visualizing all three qubits on a single, higher-dimensional plot to better represent the full system state.
  - Implementing more types of Bell states and their corresponding correction protocols.
  - Adding a more detailed step-by-step breakdown within the MATLAB output itself to make the process clearer for learners.

## Setup & Compilation

This project is a single script designed to run in **MATLAB**. There are no external libraries or complex compilation steps required.

### Prerequisites

1.  **MATLAB:** A working installation of MATLAB is the only prerequisite. This simulation was tested on MATLAB R2023a but should be compatible with most recent versions.

### Compilation

There is no compilation needed. The project runs directly from the MATLAB environment.

The simulation will produce several figures showing the Bloch sphere at different stages. It will also pause for a few seconds between some of the plots to give you time to observe the intermediate states.

-----

## Teaching Quantum Teleportation with this Project (a walkthrough)

This simulation is an excellent educational tool for visualizing the abstract concepts of quantum mechanics. Here is a guided walkthrough you can use to teach the protocol using the code and its output.

### 1\. The Initial State and Entanglement

  - **Code:** `[alpha, beta] = generateRandomQubitState();` and `bellState = createBellState();`
  - **Concept:** Explain that quantum teleportation isn't "Star Trek" teleportation. It doesn't move a physical object. Instead, it transfers the **quantum state** of a particle. We start with two key ingredients:
    1.  **The state to be teleported:** A single qubit held by Alice, with an unknown state $∣ψ⟩=α∣0⟩+β∣1⟩$. The `generateRandomQubitState` function creates this for us.
    2.  **The entangled pair:** A pair of qubits, one for Alice and one for Bob, linked together in a special Bell state, specifically the $∣Φ+⟩$ state. This entangled link is the key resource that makes teleportation possible.
  - **Visualization:** The first plot shows Alice's initial random qubit state on the Bloch sphere. Point out the coordinates `(x, y, z)` represent the state's values.

### 2\. The Entangling Operations

  - **Code:** `psiAB = kron(psiA, bellState);` followed by `CNOT_4D * psiAB;` and `H * aliceState;`
  - **Concept:** Explain that Alice's two qubits (her half of the entangled pair and the qubit to be teleported) are now treated as a single two-qubit system. She applies two crucial gates to them:
    1.  **CNOT (Controlled-NOT) Gate:** This gate links the two qubits. It flips the state of her second qubit only if her first qubit is $|1⟩$.
    2.  **Hadamard Gate:** This gate puts the first qubit into a superposition of $|0⟩$ and $|1⟩$.
  - **Visualization:** The second and third plots show the effect of these gates on Alice's qubits. Explain that while this seems complex, it's a necessary step to encode the information of the original state into the entangled system.

### 3\. The Measurement and Classical Link

  - **Code:** `outcome = randi([0, 3]);` and the `if/elseif` block.
  - **Concept:** After applying the gates, Alice performs a **Bell state measurement** on her two qubits. This measurement collapses their state into one of four possible outcomes, each corersponding to a different Bell state. The crucial insight is that this outcome contains all the information needed to reconstruct the original state on Bob's side. Alice then simply sends this two-bit result (00, 01, 10, or 11) to Bob.
  - **Analogy:** Compare this to a "secret key." Alice's measurement doesn't send the state itself; it sends a key that Bob needs to unlock the correct state from his entangled qubit.

### 4\. Bob's Correction and the Final State

  - **Code:** `correctedState = ...` followed by the various Pauli gate applications.
  - **Concept:** Bob receives Alice's two bits. Based on the "key" he was sent, he knows exactly which simple correction gate he needs to apply to his qubit.
      - If the outcome was `00`, no correction is needed.
      - If `01`, he applies a Pauli-X gate.
      - If `10`, he applies a Pauli-Z gate.
      - If `11`, he applies both X and Z gates.
  - **Visualization:** The final plot diplays Bob's qubit on the Bloch sphere after he's applied his correction. The visual evidence should show that this final state is identical to Alice's original state from the very first plot. This confirms that the teleportation was successful.

### 5\. Discussion

  - **Key Takeaway:** Emphasize that the original state is **destroyed** on Alice's side during the measurement. The no-cloning theorem prevents us from simply making a copy. The protocol transfers the state by consuming the original and a shared entangled pair. The **state** is teleported, but the **qubit** remains in its physical location.
  - **Speed Limit:** Remind students that even though the state appears to "teleport," the process is limited by the speed of light because Alice must send her measurement results to Bob via a classical channel.

## License

This project is open source and available under the [MIT License](LICENSE).
