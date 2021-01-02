function dydt = ODEsA1(t,y)
%       VARIABLES CONVERSION
%       y(1) = [F] Fuel concentration
%       y(2) = [Ox] Oxidizer(air) concentration, Also [O2] = 0.21[Ox]
%       y(3) = [Pr] Product concentration
%       y(4) = T

hfF = 4e+07*29;    %Formation enthalpy of fuel (J/kmol)
Cp = 1200*29;      %specific heat of mixture (J/kmol-K)
Ru = 8.314*1000;   % J/kmol-K
wF = ( (-6.19e09)*exp(-15098/y(4))*((y(1))^(0.1))*((0.21*y(2))*(1.65)) );

dydt = [wF;
    16*wF; 
    -17*wF; 
    (-hfF * ( (-6.19e09)*exp(-15098/y(4))*((y(1))^(0.1))*((0.21*y(2))*(1.65)) ))/((Cp-Ru)*(y(1) + y(2) + y(3)))];
