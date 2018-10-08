%% Calcultions for Phase One 

syms q1 q2 q1dot q1dotdot q2dot q2dotdot m1 m2 I1 I2 lc1 lc2 l1 g bf1 bf2 tau1; 
% first we must calculate the potential energy of the system. 
% from the diagram we can setup the following equations 

% first arm 
K1 = 0.5*m1*((-lc1*sin(q1)*q1dot)^2 + (lc1*cos(q1)*q1dot)^2) + 0.5*I1*q1dot^2;
P1 = m1*g*lc1*sin(q1);

%second arm
K2 = 0.5*m2*((-lc2*sin(q1+q2)*(q1dot+q2dot)- l1*sin(q1)*q1dot)^2 + (lc2*cos(q1+q2)*(q1dot+q2dot)+ l1*cos(q1)*q1dot)^2) + 0.5*I2*(q1dot+q2dot)^2;
P2 = m2*g*(l1*sin(q1)+lc2*sin(q1+q2));

K = K1 +K2;
P = P1+P2; 
L = K-P; 

% our mechanical system has 2 degrees of freedom q1,q2 therefor
% the euler lagrang fomulations are as follows 
% q1 

% we have euler lagrangian equation relating potential engerys to kinetic
% engeries for the double pendulum system 
% lagrange equations follow the form D(q)*qdotdot +N(q,qdot) = tau
d11 = m1*lc1^2 +m2*(l1^2 + lc2^2 +2*l1*lc2*cos(q2))+I1+I2; 
d12 = m2*(lc2+l1*lc2*cos(q2))+I2;
d21 = d12;
d22 = m2*lc2^2 + I2; 
d_q = [ d11 d12;d21 d22];
qdotdot = [q1dotdot;q2dotdot]; 
h = -m2*l1*lc2*sin(q1); 
n1 = 2*h*q1dot*q2dot + h*q2dot^2 + bf1*q1dot + (m1*lc1 + m2*l1)*g*cos(q1) + m2*lc2*g*cos(q1+q2); 
n2 = -h*q1dot^2 + bf2*q2dot + m2*lc2*g*cos(q1+q2);
N_q_qdot = [n1;n2];
tau = [tau1;0];

euler_lagrange = d_q*qdotdot + N_q_qdot == tau;
isolate(euler_lagrange(1,1),q1dotdot);
Q1DotDot = rhs(isolate(subs(isolate(euler_lagrange(1,1),q1dotdot),q2dotdot,rhs(isolate(euler_lagrange(2,1),q2dotdot))),q1dotdot));
Q2DotDot = rhs(isolate(subs(isolate(euler_lagrange(1,1),q2dotdot),q1dotdot,rhs(isolate(euler_lagrange(2,1),q1dotdot))),q2dotdot));
syms k u1 u2 x1dot x2dot x3dot x4dot x1 x2 x3 x4; 
Xdot = [x3;x4;subs(Q1DotDot,[q1,q2,q1dot,q2dot,tau1],[x1,x2,x3,x4,k*u1]);subs(Q2DotDot,[q1,q2,q1dot,q2dot,tau1],[x1,x2,x3,x4,k*u1])];
X = [ x1; x2 ;x3;x4];
Tau = [u1;u2];
A = jacobian(Xdot,X);
B = jacobian(Xdot,Tau);
A1 = subs(A,[x1 x2 x3 x4],[pi 0 0 0]);
B1 = subs(B,[x1 x2 x3 x4],[pi 0 0 0]);