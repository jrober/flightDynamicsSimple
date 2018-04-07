% load parameters in
% A = csvread('DOE.csv',1,0);

% kp = A(:,1);
% kd = A(:,2);


zeta = 0.707;
tr = 2.23;
wn = 1/2 * pi /(tr * sqrt(1-zeta^2));
wn = 2.2/tr;

P.m = 5;
P.k = 3;
P.b = 0.5;

b0 = 1/P.m;
a1 = P.b/P.m;
a0 = P.k/P.m;

P.x0 = 0;
P.xdot0 = 0;
P.x_c = 0.15;


kp = (wn^2 - a0)/b0;
kd = (2 * zeta * wn - a1) / b0;


% n = size(A,1);

n = 1;

t_rise = zeros(n,1);
t_set = zeros(n,1);
overshoot = zeros(n,1);

% pass in each row to model
for i = 1:n
    info = response(kp, kd,P,1);
end

% export table
% T = table(kp_chi, ki_chi, kp_phi, kd_phi, ki_phi, t_rise, t_set, overshoot);
% writetable(T,'LHC_5000_output.csv');