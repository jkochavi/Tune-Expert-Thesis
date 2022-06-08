function Q_tilde_out = Q_tilde(model)
% Q_tilde This function computes some static elements of the dynamical "B"
% matrix in the state space based on the geometry of the piezos and their
% location along the beam. Q_tilde is an n-by-R matrix, where R is the
% number of retroreflectors. 

% Define the edge of the piezos closest to the fixed end of the beam
x1 = model.piezo.x;
% Define the edge of the piezos farthest from the fixed end of the beam
x2 = model.piezo.x + model.piezo.L;
% Store gain constant
k = model.piezo.k;
Q_tilde_out = zeros(model.n,length(x1));
% Compute for each mode specified
for x = 1:model.n_piezos
    for n = 1:model.n
        Q_tilde_out(n,x) = k*(d_phi(x2(x),model.betas(n),model) -...
                              d_phi(x1(x),model.betas(n),model));
    end
end
if isempty(Q_tilde_out)
    for n = 1:model.n
        Q_tilde_out(n,1) = phi(model.beam.L,model.betas(n),model);
    end
end
Q_tilde_out = [zeros(model.n,size(Q_tilde_out,2));Q_tilde_out];
end