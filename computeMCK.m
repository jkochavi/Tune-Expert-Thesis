function [M, C, K] = computeMCK(args)
% computeMCK The purpose of this function is to numerically solve for the
% M, C, and K matrices that compose the equations of motion for a beam
% system. The user will input a particular system model, which is composed
% of any given number of retroreflectors and piezo-electric patches.
% Contained in the input structure are all the physical properties of the
% system, which includes the cantilever beam, the retroreflector(s), and
% piezo-electric patch(es). 
%
% Example: [M, C, K] = computeMCK(model);
% This will return 3 matrices, M, C, and K, with the numerically solved
% matrices that comprise the model's equations of motion.
M = zeros(args.n);  % Initialize as all zeros
C = zeros(args.n);  % Initialize as all zeros
K = zeros(args.n);  % Initialize as all zeros
betas = args.betas; % Pull the betas from model parameters
% Create a 1xN array of phi functions that will be traversed in the 
% integral calculations. Here, args.n represents the specified modes, or
% degrees of freedom that are being solved.
% Next, we integrate with respect to x to obtain the ij elements of the 
% M, C, and K matrices.
for i = 1:args.n
    for j = 1:args.n
        M(i,j) = integral(@(x) phi(x,betas(i),args).*phi(x, betas(j),args).*P(x,args),0,args.beam.L);
        for z = 1:length(args.retref.x)
            M(i,j) = M(i,j) + phi(args.retref.x(z),betas(i),args)*phi(args.retref.x(z), betas(j),args)*args.retref.m;
        end
        C(i,j) = args.C.*integral(@(x) phi(x,betas(i),args).*phi(x,betas(j),args),0,args.beam.L);
        K(i,j) = betas(i).^4.*integral(@(x) phi(x,betas(i),args).*phi(x,betas(j),args).*G(x,args),0,args.beam.L);
    end
end
clear betas % Clear the variables we created to clean up the workspace.
end