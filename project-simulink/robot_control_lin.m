function Xdot = robot_control_lin(t,X,...
    x_star,y_star,theta_star,...
    xd_star,yd_star,...
    xdd_star,ydd_star,...
    a,delta)


x=X(1);
y=X(2);
theta=X(3);

xstar=x_star(t);
ystar=y_star(t);
thetastar=theta_star(t);

xdotstar=xd_star(t);
ydotstar=yd_star(t);

xddotstar=xdd_star(t);
yddotstar=ydd_star(t);

vstar=sqrt(xdotstar^2+ydotstar^2);
wstar=(yddotstar*xdotstar-ydotstar*xddotstar)/(vstar^2);


ex=xstar-x;
ey=ystar-y;
etheta=delta_angle(thetastar,theta);
% etheta=thetastar-theta;


k1=2*delta*a;
k3=k1;
k2=(a^2-wstar^2)/vstar;

v=vstar*cos(etheta)+k1*ex;
w=wstar+k2*ey+k3*etheta;

Xdot=[
    v*cos(theta);
    v*sin(theta);
    w
    ];
t
end
