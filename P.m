function P = P(x,args)
% P A function that computes an element of the equations of motion.
% This function is scalable based on both the number of the retroreflectors
% and piezo patches included in the model. It uses two for-loops to
% contruct a single equation with respect to x. x may be either a symbolic
% variable, a number, or an anonymous variable to be used inside a function
% handle.

beam = args.beam;           % Assign local variable for clarity
piezo = args.piezo;         % Assign local variable for clarity
P = beam.rho*beam.A;        % Calculate initial value
for h = 1:args.n_piezos     % For each piezo, add its discrete mass effect on the beam
    P = P + 2*piezo.rho*piezo.A*(heaviside(x-piezo.x(h)) - heaviside(x-piezo.x(h)-piezo.L));
end
end

