close all; clc; clearvars;

nm_to_cm = 1e-7;

% High res neon spectrum data
high_res_neon_data = table2array(readtable("high res spectrum.csv"));

high_res_iodine_data = table2array(readtable('iodine spectrum 500-660 high res.csv'));



% Neon spectrum reading and peak detection
high_res_lambda = high_res_neon_data(:,1);
high_res_intensity = high_res_neon_data(:,2);
LM = islocalmax(high_res_intensity,'MinProminence',600);
high_res_max = high_res_lambda(LM);

% Iodine spectrum reading and peak detection
high_res_iodine_lambda = high_res_iodine_data(:,1);
high_res_iodine_intensity = high_res_iodine_data(:,2);
LM_iodine = islocalmax(high_res_iodine_intensity,'MinProminence',850);
high_res_iodine_max = high_res_iodine_lambda(LM_iodine);

max_transition = 1/(min(high_res_iodine_max)*nm_to_cm)

wave_num = flip(1./(high_res_iodine_lambda(LM_iodine)*nm_to_cm));
nu = 1:length(wave_num);
wave_index = 1:numel(wave_num);
delta_G = diff(wave_num);
nu_tag = 1:length(delta_G);

% Creating the model function
lin_model = 'a*x + b';

% Initial point guess
startPoints = [1, 1];

% Performing fits according to a linear model
f1 = fit(nu', wave_num, lin_model, 'Start', startPoints)
f1.a
f1.b

f2 = fit(nu_tag', delta_G, lin_model, 'Start', startPoints);
f2.a
f2.b

% Plotting results

figure(1)
hold on
grid on
plot(high_res_lambda, high_res_intensity, high_res_lambda(LM), high_res_intensity(LM),'ro')
title('High Resolution Neon Spectrum')
xlabel('\lambda (nm)')

figure (2)
hold on
grid on
plot(high_res_iodine_lambda, high_res_iodine_intensity, high_res_iodine_lambda(LM_iodine), high_res_iodine_intensity(LM_iodine),'ro')
title('High Resolution Iodine Spectrum')
xlabel('\lambda (nm)')

figure (3)
hold on
grid on
plot(f1, nu, wave_num)
xlabel('\nu')
ylabel('G (cm^{-1})')

figure (4)
hold on
grid on
plot(f2, nu_tag, delta_G)
title('Birge - Sponer')
xlabel('\nu''')
ylabel('\DeltaG (cm^{-1})')


