%   REACDAT
%   "motor_induccion"
%   Este script se ha de ejecutar junto con el modelo mi_modelo_MI.slx

%   $Revision: 0.1 
%  Gerardo Tirado 06-03-23

% -------------------------------
% Resistencia ohmica del 
% bobinado del rotor
% -------------------------------
Rr = 1.009;
%[Rr]= Ohmios

% Resistencia ohmica del estator
Rs = 1.725;
%[Rs]= Ohmios

% Inductancia del estator
Ls= 0.1473;
%[Ls]= Henrio = voltio/(Amperio/s.)

% Inductancia de magnetizacion 
Lm = 0.1271;
%[Lm]= Henrio = voltio/(Amperio/s.)

%Frecuencia basica de las fases del motor de induccion
fb=60;
%[fb]= 1/s.

% Numero de polos que producen el campo magnetico giratorio
n= 4;

%Momento de inercia 
J= 0.0400;
%[J]= Newton x metro x (s.^2/rad)

%Inductacia del rotor
Lr= 0.1473;
%[Lr]= Henrio = voltio/(Amperio/s.)

%Coeficiente de pérdidas
sg=(1-((Lm*Lm)/(Ls*Lr)));


%Constante de tiempo del rotor
Tr= Lr/Rr;
%[Tr]= s.

%Coeficiente de pérdida de carga
fd = 0.75;  

%Constante de magnetizacion
kt = (3*Lm*n)/(4*Lr);


% Estimacion con redes neuronales para velocidad del rotor y flujos
%  magnéticos del rotor

% Creación de los datos de entrada y salida de las redes neuronales
RSTT=timeseries2timetable(out.rotor_speed);
CTT=timeseries2timetable(out.currents);
VTT=timeseries2timetable(out.voltages);

InputDataWR=[VTT.Data,CTT.Data];

RSFFNN=timeseries2timetable(out.rotorSpeedFFNN);
FluxR=timeseries2timetable(out.rotorFlux);

InputDataFluxR=[VTT.Data,CTT.Data,RSFFNN.Data];

% Transformación de los datos de entrada y salida en celdas de array 
% para su uso en las redes recurrentes.
[T,~]=tonndata(RSTT.Data,false,false);
[W,~]=tonndata(InputDataWR,false,false);

[S,~]=tonndata(FluxR.Data,false,false);
[F,~]=tonndata(InputDataFluxR,false,false);

