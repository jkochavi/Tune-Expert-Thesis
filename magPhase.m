function [M, phi, freq_range] = magPhase(filename)
% magPhase This function estimates the magnitude and phase of the response
% of the system using an LMS algorithm. The implementation of this function
% is dependent on an existing file containing time response data for a sine
% sweep of the physical system. This procedure is carried out with the
% physical hardware using Simulink Realtime. The format of the data file is
% specified below:
% Format is | Time per freq | Freq | Input | Output | 
% This file outputes three vectors: Magnitude, phase (radians), and the
% range of frequencies evaluated. 
if isstring(filename)                                                % If string...
    data = readmatrix(filename);                                     % Read csv file
else                                                                 % Otherwise it's an array
    data = filename;                                                 % Store array
end                                                                  %
A_in = max(data(:,3));                                               % Amplitude of input signal
freq_range = unique(data(:,2));                                      % Range of frequencies
M = zeros(1,length(freq_range));                                     % Initialize to # of frequencies tested
phi = zeros(1,length(freq_range));                                   % Initialize to # of frequencies tested
for f = 1:length(freq_range)                                         % For each frequency tested,
    output_data = data(find(data(:,2) == freq_range(f)),:);          %     Grab the output data for that frequency
    t = linspace(0,output_data(1,1),size(output_data,1));            %     Generate a linear time domain
    Phi = [sin(2*pi*freq_range(f)*t); cos(2*pi*freq_range(f)*t)]';   %     Compute the input matrix
    c_estimated = c_bar(output_data(:,4),Phi);                       %     Estimate parameters
    A_0 = sqrt(c_estimated(1)^2 + c_estimated(2)^2);                 %     Calculate intermediary value
    phi_0 = atan2(c_estimated(2),c_estimated(1));                    %     Calculate intermediary value
    M(f) = A_0/A_in;                                                 %     Calculate magnitude at that frequency
    phi(f) = phi_0;                                                  %     Calculate phase at that frequency
    if f>1 && abs(phi(f)-phi(f-1)) > 1.5*pi
        phi(f) = -1*phi(f);
    end
end
end