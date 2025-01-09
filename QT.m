function quantumTeleportation()
    %%Generate random complex numbers for alpha and beta keeping in mind that |alpha|^2 + |beta|^2 = 1
    [alpha, beta] = generateRandomQubitState(); %%Alice's state to teleport

    %%State vector
    psiA = [alpha; beta];

    %%Create Bell state (entangled state between Bob and Alice's qubit)
    bellState = createBellState();

    %%Alice's initial qubit state plotted
    figure;
    subplot(1, 2, 1);
    plotBlochSphere(psiA);
    title('Initial Random State |psi>');

    %%Apply Hadamard to Alice's qubit
    H = hadamardGate();
    psiA = H * psiA;
    
    %%Alice's state after Hadamard plotted
    subplot(1, 2, 2);
    plotBlochSphere(psiA);
    title('Alice''s State after Hadamard');

    %%Pause to show intermediate state plot (user's preference)
    pause(2);

    %%Full system: Alice's qubit + Bell state between Bob and Alice
    psiAB = kron(psiA, bellState); %%Combine Alice's state with Bell state

    %%Apply CNOT gate between Alice's and Bob's qubits
    CNOT = cnotGate();
    CNOT_4D = kron(CNOT, eye(2)); %%Extend CNOT to act on full 4-dimensional space
    psiAB = CNOT_4D * psiAB; %%CNOT gate applied to entangled system

    %%Alice's state after CNOT gate and entanglement step plotted
    figure;
    subplot(1, 2, 1);
    plotBlochSphere(psiAB(1:2)); %%Alice's state after CNOT and entanglement
    title('Alice''s State After CNOT and Entanglement');

    %%Apply Hadamard to Alice's qubit (entanglement step)
    %%Apply Hadamard only to the first two components of psiAB (Alice's qubit)
    aliceState = psiAB(1:2); %%Extract Alice's qubit state (first 2 components of psiAB)
    aliceState = H * aliceState;

    %%Recombine Alice's state with Bob's entangled state
    psiAB(1:2) = aliceState; %%Update Alice's qubit part in the full system

    %%State of Alice and Bob after Hadamard and entanglement plotted
    subplot(1, 2, 2);
    plotBlochSphere(psiAB(1:2)); %%Alice's updated state
    title('Alice''s Updated State (after entanglement step)');

    %%Pause to show intermediate state plot (user preference)
    pause(2);

    %%Simulate Alice's Bell state measurement (random outcome)
    outcome = randi([0, 3]); %%Randomly select 0, 1, 2, or 3 (referencing possible Bell state outcomes)

    %%Define Pauli-X and Pauli-Z gates
    X = [0, 1; 1, 0]; %%Pauli-X gate (NOT gate)
    Z = [1, 0; 0, -1]; %%Pauli-Z gate (phase flip)

    %%Depending on Alice's measurement, Bob applies a correction
    if outcome == 0 %% |Φ+> state
        correctedState = psiAB(3:4); %%No correction
    elseif outcome == 1 %% |Φ-> state
        correctedState = X * psiAB(3:4); %%X gate to Bob's qubit
    elseif outcome == 2 %% |Ψ+> state
        correctedState = Z * psiAB(3:4); %%Z gate to Bob's qubit
    else  %% |Ψ-> state
        correctedState = X * Z * psiAB(3:4); %%Apply both X and Z gates to Bob's qubit
    end

    %%Final teleported state plotted (Bob's qubit)
    figure;
    plotBlochSphere(correctedState); %%Final state after teleportation
    title('Final Teleported State (Bob''s State)');
end

%%Creating the Bell state (Entangled pair: Bob and Alice's qubit)
function bellState = createBellState()
    bellState = 1/sqrt(2) * [1; 0; 0; 1]; %%Bell state |Φ+>
end

%%Creating Hadamard gate
function H = hadamardGate()
    H = 1/sqrt(2) * [1 1; 1 -1]; %%Hadamard matrix
end

%%Creating CNOT gate
function CNOT = cnotGate()
    CNOT = [1 0 0 0; 0 1 0 0; 0 0 0 1; 0 0 1 0]; %%CNOT gate matrix
end

%%Plotting quantum state on the Bloch sphere
function plotBlochSphere(psi)
    psi = psi / norm(psi); %%Normalize the quantum state norm(psi) = (sqrt((alpha^2 + beta^2)))

    alpha = psi(1);
    beta = psi(2);
    
    %%Calculating spherical coordinates (theta, phi)
    theta = 2 * acos(abs(alpha)); %%Polar angle
    phi = angle(beta) - angle(alpha); %%Azimuthal angle

    %%Bloch Sphere
    [x, y, z] = sphere(100); %%Create a unit sphere
    surf(x, y, z, 'EdgeColor', 'none'); %%Sphere plotting
    hold on;

    %%Plot the state vector (on the Bloch sphere)
    quiver3(0, 0, 0, sin(theta)*cos(phi), sin(theta)*sin(phi), cos(theta), 'LineWidth', 2, 'MaxHeadSize', 2, 'Color', 'r');
    
    %%Defining axis
    axis equal;
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    grid on;
    hold off;
end

%%Function to generate random quantum state for Alice's qubit
function [alpha, beta] = generateRandomQubitState()
    %%Generate random complex numbers for alpha and beta
    theta = 2 * pi * rand(); %%Random phase for alpha and beta
    r = rand(); %%Random amplitude for alpha
    alpha = r * exp(1i * theta); %%Random complex number for alpha
    beta = sqrt(1 - abs(alpha)^2) * exp(1i * (theta + pi/2)); %%Ensure |alpha|^2 + |beta|^2 = 1
end

%%Visualization of quantum teleportation simulation
quantumTeleportation();