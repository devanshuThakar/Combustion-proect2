phi = 0.25;
xH2O = 0.1*1e-02; %mole fraction of H2O
b = (xH2O + xH2O*2.38/phi)/(1-xH2O);
To = 1000; %K
P = 101325*1; %Initial pressure atm

xCO = 1/(1+9.52 + b);
xO2 = (1/(2*phi))/(1+9.52 + b);
xN2 = (3.76/(2*phi))/(1+9.52 + b);

XH2O = (xH2O*P)/(1000*8.314*To);
XCO =  (xCO*P)/(1000*8.314*To);
XO2 =  (xO2*P)/(1000*8.314*To);
XN2 =  (xN2*P)/(1000*8.314*To);
XCO2 = 0;

yo = [XCO; XO2; XH2O; XN2; XCO2; To; P];
[t,y] = ode15s(@ODEsA2, [0,0.1], yo);
answer = [t, y(:,1), y(:,2), y(:,3), y(:,4), y(:,5), y(:,6), y(:,7)];