function modelDynamics = statespace(model)
% statespace Compute M, C, and K matrices.
[modelDynamics.M,...
 modelDynamics.C,...
 modelDynamics.K] = computeMCK(model);
% Compute the dynamical "A" matrix for state space form
modelDynamics.ss.A = [zeros(model.n),...
                      eye(model.n);                            
                      -1*modelDynamics.M\modelDynamics.K,...
                      -1*modelDynamics.M\modelDynamics.C];
% Compute the dynamical "B" matrix for state space form
M_tilde = [zeros(model.n)       zeros(model.n)
           inv(modelDynamics.M) inv(modelDynamics.M)];
modelDynamics.ss.B = M_tilde*Q_tilde(model);
% The lines below compute multiple output matrices for the state space form
% The state space will change depending on the measurement location.
% Therefore, the lines below compute a different "C" matrix for each
% location measured along the beam
if model.n_retrefs
    for z = 1:model.n_retrefs
        for n = 1:model.n
            modelDynamics.ss.C(z,n) = phi(model.retref.x(z),...
                                          model.betas(n),model);
        end
    end
else
    for n = 1:model.n
            modelDynamics.ss.C(1,n) = phi(model.beam.L, ...
                                          model.betas(n),model);
    end
end
modelDynamics.ss.C = [modelDynamics.ss.C,...
                      zeros(size(modelDynamics.ss.C,1),model.n)];
modelDynamics.ss.D = zeros(size(modelDynamics.ss.C,1),...
                           size(modelDynamics.ss.B,2));
% Compute a vector of the natural frequencies considered in the model
modelDynamics.freqs = unique(round(abs(imag(eig(modelDynamics.ss.A))/ ...
    (2*pi)),...
    4,'significant'),'rows');
end