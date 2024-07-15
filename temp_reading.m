close all; clc; clearvars;

% Tungsten lamp data
tungsten_data = table2array(readtable("tungsten spectrum.csv"));

% Variable temperature data
temp50_data = table2array(readtable("iodine temp 50 575-585.csv"));
temp55_data = table2array(readtable("iodine temp 55 575-585.csv"));
temp60_data = table2array(readtable("iodine temp 60 575-585.csv"));
temp65_data = table2array(readtable("iodine temp 65 575-585.csv"));
temp70_data = table2array(readtable("iodine temp 70 575-585.csv"));
temp75_data = table2array(readtable("iodine temp 75 575-585.csv"));
temp80_data = table2array(readtable("iodine temp 80 575-585.csv"));

figure (3)
hold on
grid on
plot(tungsten_data(:,1), tungsten_data(:,2))
title('Tungsten Spectrum')
xlabel('\lambda (nm)')

figure (4)
hold on
grid on
plot(temp50_data(:,1),temp50_data(:,2))
title(['Temperature = 50 C', char(176)])
xlabel('\lambda (nm)')

figure (5)
hold on
grid on
plot(temp55_data(:,1),temp55_data(:,2))
title(['Temperature = 55 C', char(176)])
xlabel('\lambda (nm)')

figure (6)
hold on
grid on
plot(temp60_data(:,1),temp60_data(:,2))
title(['Temperature = 60 C', char(176)])
xlabel('\lambda (nm)')

figure (7)
hold on
grid on
plot(temp65_data(:,1),temp65_data(:,2))
title(['Temperature = 65 C', char(176)])
xlabel('\lambda (nm)')

figure (8)
hold on
grid on
plot(temp70_data(:,1),temp70_data(:,2))
title(['Temperature = 70 C', char(176)])
xlabel('\lambda (nm)')

figure (9)
hold on
grid on
plot(temp75_data(:,1),temp75_data(:,2))
title(['Temperature = 75 C', char(176)])
xlabel('\lambda (nm)')

figure (10)
hold on
grid on
plot(temp80_data(:,1),temp80_data(:,2))
title(['Temperature = 80 C', char(176)])
xlabel('\lambda (nm)')