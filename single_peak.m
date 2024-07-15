close all; clc; clearvars;

% Constants
nm_to_cm = 1e-7; % nm to cm conversion factor
cm_to_angstrom = 1e8; % cm to angstrom conversion factor
mu = 1.054e-25; % kg
c = 3e10; % cm/s
h = 6.626e-30; % planck constant in cm
anti_stokes_const = 514;
stokes_const = 134;

% File reading and name manipulation
extension_str = '.csv';
files_peaks = dir(['Single peak\*', extension_str]);
file_names_peaks = string(fullfile({files_peaks.name}));

for i=1:numel(file_names_peaks)
    data = table2array(readtable(file_names_peaks(i), "VariableNamingRule", "preserve"));
    lambda_data = data(:,1);
    intensity_data = data(:,2);

    % Identifying the local maxima i.e. peak locations
    LM = islocalmax(intensity_data,'MinProminence',7,'SamplePoints',lambda_data,'MinSeparation',0.01);
    LM_lambda = (lambda_data(LM));

    % Stokes vs Anti Stokes condition, using the lasers wavelength as a
    % divider

    if numel(LM_lambda) == 2
        if max(lambda_data) < 630
            B_anti_stokes(:,i) = abs(diff(1./(LM_lambda*nm_to_cm)))/anti_stokes_const;
        else
            B_stokes(:,i) = abs(diff(1./(LM_lambda*nm_to_cm)))/stokes_const;
        end
    end

    figure (i)
    hold on
    grid on

    plot(lambda_data, intensity_data, LM_lambda, intensity_data(LM), 'ro')
    xlabel('\lambda (nm)')
    ylabel('Intensity')

end

% Removing zeros and outlying values from the rotational constants and
% calculating the mean
mean_B_anti_stokes = mean(rmoutliers(nonzeros(B_anti_stokes)));
mean_B_stokes = mean(rmoutliers(nonzeros(B_stokes)));
mean_B = (mean_B_anti_stokes + mean_B_stokes)/2

% Calculating the internuclear distance
re = sqrt(h/(8*pi*c*mu*mean_B))*cm_to_angstrom