function [beta_vals] = get_betas(range,L)
% get_betas The purpose of this function is to numerically solve for beta,
%  a component of the modal frequency. The user will specify the range of 
%  beta values they wish to obtain, and the function will return an array
%  containing those values.
%
%  range: How many values of beta you wish to receive.
%  L: The length of the beam.
%
%  Example: betas = get_betas(6, 18);
%  This will return the first six values of beta for a beam length of 18 
%  inches. 
syms B           % Create symbolic variable for solving for beta
format long      % Format output in long
beta_vals = [];  % Define the output array that will contain values of beta
x = 0;           % Initialize x = 0 
step = 1/(10*L); % Define the step size (a reasonably small value WRT L)
precision = 20;  % Decimal precision for output

while size(beta_vals) < range % While we still have values to compute...
    % Attempt to find a numerical solution using vpasolve()
    sol = round(abs(double(vpasolve(cos(L*B)*cosh(L*B) == -1, B, x))),precision);
    % vpasolve() will return an empty sym if unsuccessful...
    % If a solution exists...
    if (isempty(sol) == false)
        % Check if it has already been obtained (if it is in the list
        % already)
        if (ismembertol(sol, beta_vals,10^(-1*precision)) == false)   
            beta_vals(end + 1) = sol; % Add the solution to the list
        end
    end
    x = x + step; % Increment x for next calculation
end
clear B step precision % Clear variables to clean up the workspace
end