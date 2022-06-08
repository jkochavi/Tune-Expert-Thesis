function dz = odeFun(t, z, model, v, v_time)
% odeFun A function to assemble the solution in state-space form to be used
% with ODE45.

u = interp1(v_time, v', t)';      % Interpolate to get forcing vector
dz = model.dynamics.ss.A*z + ...
     model.dynamics.ss.B*u;       % Assemble state-space form

end