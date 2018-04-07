function xdotReturn = dynamics(t,y,P)

% Make the state something a little more readable
x = y(1);
xdot = y(2);


x_c = P.x_c; % meters


force = PID(x_c, x, xdot, P);

xdotReturn = [...
    xdot;...
    force/P.m - P.k/P.m * x - P.b/P.m * xdot;...
]; % assign derivatives of states to xdot
end


function force = PID(x_c, x, xdot, P)

    error = x_c - x;

    force = P.kp*error - P.kd*xdot + x * P.k;

end

