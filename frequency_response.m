function [mag, phase, num, den] = frequency_response(x, model,freq_range)
%frequency_response Thie function computes the frequency response of a
%particular model given a location along the beam and a range of driving
%frequencies. 
%
% x: A location along the beam 
% model: The struct containing model parameters
% freq_range: the range of driving frequencies, in Hz

% Convert to rad/sec
freq_range = freq_range*2*pi;

% Compute the output vector
C = zeros(1,2*model.n);
for n = 1:model.n
    C(n) = phi(x,model.betas(n),model);
end

% Remove added input from the second piezo
if model.n_piezos == 2
    model.dynamics.ss.B = model.dynamics.ss.B*[1;0];
end

% Create a function handle for the frequency response vector
G = @(omega) C*...
    inv(eye(size(model.dynamics.ss.A,1))*1i.*omega - model.dynamics.ss.A)*...
    model.dynamics.ss.B;

% Initialize to zero
mag = zeros(length(freq_range),1);
% Inialize to zero
phase = zeros(length(freq_range),1);
% For each frequency in the specified range...
for w = 1:length(freq_range)
    % Evaluate the complex frequency response at that frequency
    H(w) = G(freq_range(w));
    % Compute the magnitude
    mag(w) = abs(H(w));
    % Compute the phase
    %phase(w) = angle(H(w));
    phase(w) = atan2(imag(H(w)),real(H(w)));
    if w>1 && abs(phase(w)-phase(w-1))>1.5*pi
        phase(w) = -1*phase(w);
    end
end
% Compute the analytical transfer function using invfreqs()
[num,den] = invfreqs(mag.*exp(1j*phase),...
    freq_range,model.n*2 - 2,model.n*2,[]);
end