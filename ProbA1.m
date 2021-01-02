%This is MATLAB file to solve for problem A1
air_fuel = 16;
phi = 1;
Ru = 8.314*1000;                                          %Universal Gas Constant (J/Kmol-K)
P = (1.01325e+05)*[1];%,2,5,25];                             %Constant pressure
To = [600];%, 700, 800, 900, 1000];                          % Initial Temperature (K)
Vo = 0.008;                                               % Initial volume (m3)
time = zeros(length(To),length(P));

% x denotes mole-fraction, X-denotes concentration
% Setting the initial mole-fraction and concentration
XPr = 0;
xF = 1/((air_fuel)/phi + 1);
xOx = ((air_fuel)/phi)/((air_fuel)/phi + 1);

for i = 1:length(To)
    for j = 1:length(P)
        XF = (xF*P(j))/(Ru * To(i));
        XOx  = (xOx * P(j))/(Ru * To(i));
        XO2 = 0.21*(XOx);
        yo = [XF; XOx; XPr; To(i); Vo];
        [t,y] = ode15s(@ODEsA1, [0,10], yo);
        index = 0;
        k=1;
        while (index == 0 && k<length(y(:,1)))
            if(y(k,1) < yo(1)*1e-03)
                index = k;
            end
            k = k + 1;
        end 
        time(i,j) = t(index)
    end
end

a = plot(t, y(:,1), '-o', t, y(:,2), '-o', t, y(:,3),'-o');
title('Concentration and and time at To=600K and P=1atm');
xlabel('Time t(s)');
ylabel('Concnetration (kmol/m3)');
legend('F','Ox', 'Pr');
% hold(a)