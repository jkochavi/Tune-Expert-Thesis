function W = RLS_IIRcompute(data, alpha, lambda, L, M)
% RLS_IIRcompute This function carries out the training of an IIR adaptive
% filter using an RLS algorithm.
% data: An n-by-2 matrix containing the input to the unidentified system
% and the desired output of the filter. 
% alpha: A large integer between 1e4 and 1e10 to initialize P
% lambda: A number < 1. The forgetting factor.
% L: Number of delays in the denominator
% M: Number of delays in the numerator
x = data(:,1);        % Input vector
d = data(:,2);        % Desired output vector
n = size(data,1);     % Number of observations
P = alpha*eye(L+M+1); % Initialize P
W = zeros(L+M+1,n);   % Initialize weights
for k = L+M+1:n-1
    % Retrieve current input vector
    X_tilde = [flip(d(k-L:k-1)); flip(x(k-M:k))];  
    % Calculate intermediary term
    K = lambda^(-1)*P*X_tilde/...
        (1 + lambda^(-1)*X_tilde'*P*X_tilde);
    % Update the weight vectors
    W(:,k+1) = W(:,k) + K*(d(k) - X_tilde'*W(:,k));
    % Calculate new P matrix for next iteration
    P = lambda^(-1)*(P - K*X_tilde'*P);
end

end