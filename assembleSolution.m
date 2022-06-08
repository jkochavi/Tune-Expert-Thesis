function solution = assembleSolution(x, Z, model)
%assembleSolution This function receives a specific location along the beam
%and an array of modal displacements. The function applies each modal
%weight, as determined by the characteristic equation, and assembles the
%complete solution for the displacement of the cantilevered beam.

% Retrieve betas from the model struct
betas = model.betas;
% Initialize to zero
solution = 0;
% For each mode,
for i = 1:model.n
    % Apply the modal weight to the modal displacement vector and add it to
    % the total displacement
    solution = solution + phi(x,betas(i),model)*Z(:,i);
end
end