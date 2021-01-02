% This function is the ODEs fromation for Problem B2-part-2
function dydx = ODEsB2_2(x,y, m_dot, AF)
%       VARIABLES CONVERSION
%       y(1) = [F] Fuel concentration
%       y(2) = [Ox] Oxidizer(air) concentration, Also [O2] = 0.21[Ox]
%       y(3) = [Pr] Product concentration
%       y(4) = T      K
%       y(5) = Rho    kg/m3

hfF = 4e+07;        %Formation enthalpy of fuel (J/kg)
Cp = 1200;          %specific heat of mixture (J/kg-K)
Ru = 8.314;         %J/mol-K       Ru = 8.314*1000 J/kmol-K
MW = 29e-03;        %kg
A = pi*(3e-02)^2;   %m2


P = (y(5)*Ru*y(4))/MW;    %Pressure (Pa)
wF = ((-6.19e09)*exp(-15098/y(4))*((y(1))^(0.1))*((0.21*y(2))^(1.65)) );
dFdx = (wF*A*y(5))/m_dot;
dOxdx = (AF*wF*A*y(5))/m_dot;
dPrdx = (-(AF+1)*wF*A*y(5))/m_dot;
vx = (m_dot)/(A*y(5));    %m/s


dRhodx = (y(5)*Ru*1000*hfF*wF)/((vx*Cp)*(P*(1+(vx^2/(Cp*y(5)))) - y(5)*(vx^2))); 
%dRhodx=(-MW*hfF*wF)/((MW*(vx^3)/Ru)-(y(4)*vx))
%dRhodx = (y(5)*Ru*1000*hfF*wF)/((vx*Cp)*(P - y(5)*(vx^2)));
dTdx = (vx^2 * dRhodx)/(y(5)*Cp) - (MW*hfF*wF)/(y(5)*Cp*vx);  
%dTdx = (-MW*hfF*wF)/(y(5)*vx);

dydx = [dFdx; dOxdx; dPrdx; dTdx; dRhodx];