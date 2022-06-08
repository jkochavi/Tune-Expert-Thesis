function G = G(x,args)
% G A function that computes an element of the equautions of motion.
% This function is scalable based on the number of piezos included in the
% model. It uses a for-loop to construct a function with respect to x. x
% may be either a symbolic variable, a number, or an anonymous variable to
% be used inside a function handle.

beam = args.beam;       % Assign local variable for clarity 
piezo = args.piezo;     % Assign local variable for clarity
G = beam.E*beam.I;      % Calculate initial value
for h = 1:args.n_piezos % For each piezo, add its discrete stiffness change
    G = G + piezo.E*piezo.I*(heaviside(x-piezo.x(h)) - heaviside(x-piezo.x(h)-piezo.L));
end

end

