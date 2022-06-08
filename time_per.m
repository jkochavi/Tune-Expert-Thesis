function simtime = time_per(freq_range, T0, Tf)
F0 = freq_range(1);
Ff = freq_range(end);
TpF = @(F) exp(-1*((F0/Ff)*(F-F0) - log(T0-Tf))) + Tf;
simtime = ceil(sum(TpF(freq_range))); % seconds

end