function [d_phi_n] = d_phi(x, b, args)
% d_phi Function that calculates the derivative of the mode shape function
% given a specific value of beta.
%
% This function receives two parameters: x and b. x may be a number,
% symbolic variable, or an anonymous variable to be used inside a function
% handle. b represents beta, which is numerically solved for outside of
% this function using get_betas(). 

L = args.beam.L; % Assign local variable for clarity
% Calculate sigma based on the inputted beta
sigma = (sinh(b*L) + sin(b*L))/(cosh(b*L) + cos(b*L));
% Substitute sigma into phi_n and return
d_phi_n = sigma*(b*sinh(b*x) + b*sin(b*x)) - b*cosh(b*x) + b*cos(b*x);

end