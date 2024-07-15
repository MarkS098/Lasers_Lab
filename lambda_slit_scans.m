close all; clc; clearvars;

table_arr = [1:10];
max_loc = zeros(numel(table_arr),1);
slit_arr = zeros(numel(table_arr),1);
lambda_max = zeros(numel(table_arr),1);
FWHH = zeros(numel(table_arr),1);

for i=1:numel(table_arr)
    % File name according to naming convention
    slit_arr(i) = i*100;

    % Converting the table to array
    read_data = table2array(readtable([num2str(i*100),'.csv']));

    % Wavelength and intensity values
    lambda = read_data(:,1);
    intensity = read_data(:,2);
    lambdas(:,i) = lambda;
    spectra_arr(:,i) = intensity;


    % Location of the index of the maximum intensity
    max_loc = find(intensity == max(intensity));

    % Storing the value
    lambda_max(i) = lambda(max_loc);

    % Find the half max value.
    halfMax = (min(intensity) + max(intensity))/2;

    % Find where the data first drops below half the max.
    index1 = find(intensity >= halfMax, 1, 'first');

    % Find where the data last rises above half the max.
    index2 = find(intensity >= halfMax, 1, 'last');
    fwhm = index2-index1 + 1; % FWHM in indexes.

    % OR, if you have an x vector
    FWHH(i) = lambda(index2) - lambda(index1);

end

% Creating the model function
lin_model = 'a*x + b';

% Initial point guess
startPoints = [1, 1];

% Performing the fits according to a linear model
f1 = fit(slit_arr, lambda_max, lin_model, 'Start', startPoints);
f2 = fit(slit_arr, FWHH, lin_model, 'Start', startPoints);

reciprocal_dispersion = f2.a/10^-3;

% Plotting figures
figure (1)
hold on
grid on
plot(f1,slit_arr, lambda_max)
ylim([0.9999*min(lambda_max),1.0001*max(lambda_max)])
xlim([0.9*min(slit_arr),1.01*max(slit_arr)])
ylabel('\lambda (nm)')
xlabel('d (\mum)')
legend('Data','Fitted','Location','northwest')
title(['D^{-1} = ',num2str(reciprocal_dispersion),' nm/mm'])

figure (2)
hold on
grid on
plot(f2,slit_arr, FWHH)
ylim([0.9999*min(FWHH),1.0001*max(FWHH)])
xlim([0.9*min(slit_arr),1.01*max(slit_arr)])
ylabel('FWHH (nm)')
xlabel('d (\mum)')
legend('Data','Fitted','Location','northwest')

figure (3)
hold on
grid on
plot(lambdas(:,2),spectra_arr(:,2))
title('Slit Width: d = 200 \mum')
xlabel('\lambda (nm)')


figure (4)
hold on
grid on
plot(lambdas(:,5),spectra_arr(:,5))
title('Slit Width: d = 500 \mum')
xlabel('\lambda (nm)')

figure (5)
hold on
grid on
plot(lambdas(:,8),spectra_arr(:,8))
title('Slit Width: d = 800 \mum')
xlabel('\lambda (nm)')

