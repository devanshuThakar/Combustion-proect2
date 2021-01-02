%This is MATLAB file to solve for problem B2-part-1
air_fuel = 16;
phi = [0.1, 0.15, 0.2,0.5,0.75,1,1.25, 1.5];
Ru = 8.314;                             %Universal Gas Constant (J/Kmol-K)
%Pin = (1.01325e+05)*[0.2,0.5,1, 1.5,2];                   %Constant pressure
Pin = (1.01325e05)*0.2;
%Tin = [800, 900, 1000,1100];                    % Initial Temperature (K)
Tin = 1000;
hfF = 4e+07;    %Formation enthalpy of fuel (J/kg)
m_dot = 0.2656;      % mass-flowrate kg/s
Cp = 1200;      %specific heat of mixture (J/kg-K)
MW = 29e-03;                   % kg
A = pi*(3e-02)^2;              %m2
%flowLength=zeros(length(Pin),length(Tin), length(phi));
%flowLength=zeros(length(phi),0);

for i=1:length(Pin)
    for j=1:length(Tin)
        for k=1:length(phi)
            Rhoin = (Pin(i)*MW)/(8.314*Tin(j));    %kg/m3       
            % x denotes mole-fraction, X-denotes concentration
            % Setting the initial mole-fraction and concentration
            XPr = 0;
            xF = 1/((air_fuel)/phi(k) + 1);
            xOx = ((air_fuel)/phi(k))/((air_fuel)/phi(k) + 1);
            XF = (xF*Pin(i))/(Ru * Tin(j));
            XOx  = (xOx * Pin(i))/(Ru * Tin(j));
            XO2 = 0.21*(XOx);

            YF = xF;
            YOx = xOx;
            YPr = 0;
            yo = [XF; XOx; XPr; Tin(j); Rhoin];
            AF = air_fuel/phi(k);
            [x,y] = ode45(@(x,y) ODEsB2_2(x,y, m_dot, AF), [0,1], yo);
            index = 0;
            count=1;
            while(index==0 && count <= length(x))
                if(y(count,1) <= XF*0.01)
                    index = count;
                end
                count = count + 1;
            end 
            %flowLength(i,j,k)=x(index);
            flowLength(k)=x(index);
            %disp("The flow-length is " + x(index) + " m"); 
        end
    end
end
