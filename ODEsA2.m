function dydt = ODEsA2(t,y)
%VARIABLES CONVERSION
%  [CO] = y(1)
%  [O2] = y(2)
%  [H2O] = y(3)
%  [N2] = y(4)
%  [CO2] = y(5)
%   T = y(6)
%   P = y(7)

hfCO = -110541; %kJ/kmol at 298
CpCO = 36.271;  %kJ/kmol-K at 2000K

hfO2 = 0;       %kJ/kmol at 298
CpO2 = 37.788;  %kJ/kmol-K at 2000K

CpH2O = 51.143;  %kJ/kmol-K at 2000K

hfCO2 = -393546; %kJ/kmol at 298
CpCO2 =  60.433; %kJ/kmol-K at 2000K

CpN2 =  35.988; %kJ/kmol-K at 2000K

kf = (2.24e+12)* exp(-1.674e+08/(8.314*1000*y(6)));
kr = (5e+08)* exp(-1.674e+08/(8.314*1000*y(6)));

dCOdt = -kf * y(1) * (y(3)^0.5) * (y(2)^0.25) + kr*y(5);
dO2dt = (1/2)*dCOdt;
dCO2dt = -kr*y(5) + kf * y(1) * (y(3)^0.5) * (y(2)^0.25);
dH2Odt = 0;
dN2dt = 0;

SUM_w = 3*dO2dt + dCO2dt; %kmol/s
SUM_hw = (hfCO + CpCO*(y(6) - 298.15))*dCOdt + (CpO2*(y(6) - 298.15))*dO2dt + (hfCO2 + CpCO2*(y(6) - 298.15))*dCO2dt;
SUM_XiCpi = y(1)*CpCO + y(2)*CpO2 + y(3)*CpH2O + y(5)*CpCO2 + y(4)*CpN2; 
SUM_Xi = y(1) + y(2) + y(3) + y(4) + y(5);

dTdt = ((8.314*y(6)*SUM_w) - (SUM_hw))/(SUM_XiCpi - 8.314*SUM_Xi);
dPdt = (8.314*1000*y(6))*(SUM_w) + (8.314*1000*SUM_Xi*dTdt);

dydt = [dCOdt; dO2dt; dH2Odt; dN2dt; dCO2dt; dTdt; dPdt];