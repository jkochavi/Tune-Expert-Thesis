function [W, e] = LMS_IIRcompute(data, step_params, dims)
%LMS_IIRcompute
%data - Nx2 vector of [input, desired output] for N samples
%mu - Constant step size
%dims - 1x2 vector of [M, L] 
x = data(:,1);          % Input vector
d = data(:,2);          % Desired output vector
M = dims(1);            % Numerator filter order
L = dims(2);            % Denominator filter order
index = 1;              % Starting index
e = zeros(1,length(x)); % Inialize error vector
W = zeros(L+M+1,1);     % Initialize weights
alpha = step_params(1); % Parameter in normalized LMS 
delta = step_params(2); % Parameter in normalized LMS
for n = L+1:length(x)
    X = [flip(d(n-L:n-1)); flip(x(n-M:n))]; % Obtain input vector
    e(index) = d(n) - W'*X;                 % Store error signal
    mu = alpha/(delta + X'*X);              % Compute new step size
    W = W + 2*mu*e(index)*X;                % Update weights
    index = index + 1;                      % Increment index
end
end