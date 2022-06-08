function [W, e] = FIRcompute(data, m, mu)
input = data(:,1);                     % Input vector
plant_output = data(:,2);              % Output vector
W = zeros(m+1,1);                      % Initialize weights
index = 1;                             % Starting index 
e = zeros(1,length(input)-m);          % Initialize error vector
for n = m+1:length(input)              % For all samples...
    X = flip(input(n-m:n));            % Get input vector
    e(index) = plant_output(n) - W'*X; % Calculate error 
    W = W + 2*mu*e(index)*X;           % Get new weights
    index = index + 1;                 % Increment sample index 
end
end