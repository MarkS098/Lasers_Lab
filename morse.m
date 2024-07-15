close all; clc; clearvars;

Ang = char(197);
% Constants
DXe = 14548;
DBe = 3431.1; 
rXe = 2.772;
rBe = 3.11;
betaX = 1.698;
betaB = 1.773;
T_tag = 17010.3;
kX = 42.75;


% Morse function
r = linspace(2, 6, 1000);
UB_morse = DBe*(1 - exp(-betaB*(r - rBe))).^2 + T_tag;
UX_morse = DXe*(1 - exp(-betaX*(r - rXe))).^2;


figure (1)
hold on
grid on
plot(r, UB_morse, r, UX_morse)
title('Morse potential curves for the X and B states')
legend('B state','X state')
xlabel(['r (' Ang ')'])
ylabel('U (cm^{ -1})')
