% This function is the ODEs fromation for Problem B2-part-2
function dydt = ODEsA1(t,y)
%       VARIABLES CONVERSION
%       y(1) = [F] Fuel concentration
%       y(2) = [Ox] Oxidizer(air) concentration, Also [O2] = 0.21[Ox]
%       y(3) = [Pr] Product concentration
%       y(4) = T
%       y(5) = V

hfF = 4e+07;    %Formation enthalpy of fuel (J/kg)
Cp = 1200;      %specific heat of mixture (J/kg-K)
wF = ( (-6.19e09)*exp(-15098/y(4))*((y(1))^(0.1))*((0.21*y(2))^(1.65)) );
dTdt = (-hfF * wF)/(Cp*(y(1) + y(2) + y(3)));

dydt = [wF - (y(1)*dTdt)/y(4);
    16*wF - (y(2)*dTdt)/y(4); 
    -17*wF - (y(3)*dTdt)/y(4); 
    dTdt; 
    (y(5)*(dTdt))/y(4)];

