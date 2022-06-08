function k_return = k(model)
%k A function that calculates the constant, k. 

E_b = model.beam.E;       
E_p = model.piezo.E;       
t_b = model.beam.t;       
t_p = model.piezo.t;      
d_31 = model.piezo.d31;   
I_b = model.beam.I;       
% Substitue all values into the equation for gamma
gamma = 3*E_p*((t_b/2 + t_p)^2 - (t_b/2)^2);
gamma = gamma/(2*(E_p*((t_b/2 + t_p)^3 - (t_b/2)^3) + E_b*(t_b/2)^3));
gamma = gamma*d_31/t_p;
% Substitue gamma into the equation for k and return value
k_return = E_b*I_b*gamma;

end