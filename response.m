function stepINFO = response(kp, kd, P, plot_flag)

% Assign control gains to struct
P.kp = kp;
P.kd = kd;


% initial conditions
x0 = [P.x0; P.xdot0];

% solve nonlinear dynamics with gains
[t,y] = ode45(@(t,y) dynamics(t,y,P),[0,50],x0);

% Plot course and altitude responses
if plot_flag == 1
    figure(1);
    plot(t,y(:,1));
    title('position');
    figure(2);
    plot(t,y(:,2));
    title('velocity');
end
    
% get stepinfo
stepINFO = stepinfo(y(:,1),t,P.x_c);


end