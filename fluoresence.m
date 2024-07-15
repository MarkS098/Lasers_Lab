close all; clc; clearvars;
format long

% Conversion constant
nm_to_cm = 1e-7;
extension_str = 'mm.csv';
% File reading and name manipulation
files_wide = dir(['Wide scans\*', extension_str]);
file_names_wide = string(fullfile({files_wide.name}));

% Creating the model function
lin_model = 'a*x + b';

% Initial point guess
startPoints = [1, 1];

for j=1:numel(file_names_wide)
    data = table2array(readtable(file_names_wide(j), "VariableNamingRule", "preserve"));
    lambda_data = data(:,1);
    intensity_data = data(:,2);

    % Identifying the local maxima i.e. peak locations
    LM = islocalmax(intensity_data,'MinProminence',0.5,'MinSeparation',10);

    % Setting the data for a Birge-Sponer plot using the Stokes lines
    if j == 2
        wave_num = flip(1./(lambda_data(LM)*nm_to_cm));
        nu = 1:length(wave_num);
        wave_index = 1:numel(wave_num);
        delta_G = flip(rmoutliers(diff(wave_num)));
        nu_2tag = 1:length(delta_G);
    end

    figure (j)
    hold on
    grid on

    plot(lambda_data, intensity_data, lambda_data(LM), intensity_data(LM),'ro')
    xlabel('\lambda (nm)')
    ylabel('Intensity')

end

% Fitting for Birge-Sponer
f1 = fit(nu', wave_num, lin_model, 'Start', startPoints);
f1.a
f1.b

f2 = fit(nu_2tag', delta_G, lin_model, 'Start', startPoints);
f2.a
f2.b

figure (j + 1)
hold on
grid on
plot(f1, nu, wave_num)
xlabel('\nu')
ylabel('G (cm^{-1})')

figure (j + 2)
hold on
grid on
plot(f2, nu_2tag, delta_G)
title('Birge - Sponer')
xlabel('\nu''')
ylabel('\DeltaG (cm^{-1})')
