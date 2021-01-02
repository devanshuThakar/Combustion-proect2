air_fuel = 16;
phi = 1;
Ru = 8.314*1000;             %Universal Gas Constant (J/mol-K)
P = 25.12*(1.01325e+05);        %Constant pressure
To = 753;              % Initial Temperature (K)
Vo = 0.008;             % Initial volume (m3)

% x denotes mole-fraction, X-denotes concentration
% Setting the initial mole-fraction and concentration
xPr=0;
XPr = 0;
xF = 1/((air_fuel)/phi + 1);
XF = (xF*P)/(Ru * To);
xOx = ((air_fuel)/phi)/((air_fuel)/phi + 1);
XOx  = (xOx * P)/(Ru * To);
XO2 = 0.21*(XOx);

%Setting the dependent vaiables

%Setting the independent variable


%Setting the production rates, denoted by wi
% wF = -(6.19e09)*exp(-15098/T) * (F)^(0.1) * (O2)^(1.65);
% wO2 = 0.21*16*wF;
% wPr = 17*wF;
yo = [XF; XOx; XPr; To]

[t,y] = ode15s(@ODEsEx6_1, [0,0.1], yo);
Fuel = y(:,1);
Product = y(:,3);
Temperature = y(:,4);
table(t, Fuel, Product,Temperature);
% plot(t,y(:,1),'-o', t,y(:,3),'-o',  t,y(:,4),'-o');
% title('Concentration and temperature');
% xlabel('Time t');
% ylabel('Concnetration');
% legend('y_1','y_3', 'y_4');