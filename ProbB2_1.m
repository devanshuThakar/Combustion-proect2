%This is MATLAB file to solve for problem B2-part-1
air_fuel = 16;
phi = 0.2;
Ru = 8.314;                                %Universal Gas Constant (J/Kmol-K)
Pin = (1.01325e+05)*0.2;                   %Constant pressure
Tin = 1000;                                %Initial Temperature (K)
MW = 29e-03;                               %kg
A = pi*(3e-02)^2;                          %m2
Rhoin = (Pin*MW)/(8.314*Tin);              %kg/m3
hfF = 4e+07;                               %Formation enthalpy of fuel (J/kg)
m_dot = 1;                                 % mass-flowrate kg/s
Cp = 1200;                                 %specific heat of mixture (J/kg-K)

% x denotes mole-fraction, X-denotes concentration
% Setting the initial mole-fraction and concentration
XPr = 0;
xF = 1/((air_fuel)/phi + 1);
xOx = ((air_fuel)/phi)/((air_fuel)/phi + 1);

XF = (xF*Pin)/(Ru * Tin);
XOx  = (xOx * Pin)/(Ru * Tin);
XO2 = 0.21*(XOx);

YF = xF;
YOx = xOx;
YPr = 0;
yo = [XF; XOx; XPr; Tin; Rhoin];

massFlow = 0;

[x,y] = ode45(@(x,y) ODEsB2_1(x,y, m_dot), [0,0.1], yo);
while(massFlow == 0)
    m_dot = m_dot - 0.0001;
    [x,y] = ode45(@(x,y) ODEsB2_1(x,y, m_dot), [0,0.1], yo);
     if (y(length(y(:,1)), 1) <= (0.01*XF))
        massFlow = m_dot;        
     end
end

velocity = massFlow/A*y(:,5);
disp("The mass-flow rate for 99% reaction is " + massFlow + " kg/m3.");