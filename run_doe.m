% load parameters in

% Flag 0 if running the DOE, 1 if running only 1 test case
flag = 0;

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

if flag == 0
    A = csvread('DOE.csv',1,0);
    kp = A(2:end,1);
    kd = A(2:end,2);
    n = size(A,1) - 1;
else

    kp = (wn^2 - a0)/b0;
    kd = (2 * zeta * wn - a1) / b0;
    n = 1;
end


t_rise = zeros(n,1);
t_set = zeros(n,1);
overshoot = zeros(n,1);

% pass in each row to model
for i = 1:n
    info = response(kp(i), kd(i),P,flag);
    t_rise(i) = info.RiseTime;
    t_set(i) = info.SettlingTime;
    overshoot(i) = info.Overshoot;
end

if flag == 0
    % export table
    T = table(kp, kd, t_rise, t_set, overshoot);
    writetable(T,'output.csv');
end

