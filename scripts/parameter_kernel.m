addpath('./utils/');
addpath('./libsvm/matlab/');
rand('state', 16);

data_name = 'HIGGS';
load(['./data/', data_name]);
n_repeat = 5;
n_sample = 1000;
% parameter candidate
% sigma_can = -2:1:6;
% lambda_can = -50:5:10;
%sigma_can = 0:0.2:6;
sigma_can = 0:0.5:6;
lambda_can = -50:4:8;

error_matrix = zeros(length(sigma_can), length(lambda_can));

for i_repeat = 1 : n_repeat
    rand_idx = randperm(length(y), n_sample);
    y = y(rand_idx);
    X = X(rand_idx, :);
    threshold = ceil(2*length(y)/3);
    X_train = X(1:threshold, :);
    y_train = y(1:threshold, :);
    X_test = X(threshold + 1:end, :);
    y_test = y(threshold + 1:end, :);

    for i_sigma = 1 : length(sigma_can)
        for i_lambda = 1 : length(lambda_can)
            error_rate = kernel_solver(X_train, y_train, X_test, y_test, 2.^sigma_can(i_sigma),...
                2.^lambda_can(i_lambda), 'binary');
            error_matrix(i_sigma, i_lambda) = error_matrix(i_sigma, i_lambda) + error_rate;
            fprintf('sigma = %.6f, lambda = %.6f. Error rate is %.3f\n',...
                   sigma_can(i_sigma), lambda_can(i_lambda), error_rate);
        end
    end
end
error_matrix = error_matrix ./ n_repeat;

save(['./results/parameters/parameters_', data_name], 'sigma_can', 'lambda_can', 'error_matrix');

%clear all;
%load(['./results/parameters/parameters_ijcnn1']);

[x, y] = find(error_matrix == min(error_matrix(:)));
fprintf('Best parameter for %s: sigma = %.6f, lambda = %.6f. Error rate is %.3f\n',...
    data_name, sigma_can(x), lambda_can(y), min(error_matrix(:)));

imagesc(error_matrix);
hcb = colorbar;
colormap jet;
xticks(1:length(lambda_can));
xticklabels(lambda_can);
xlabel('lambda: 2^x');
yticks(1:length(sigma_can));
yticklabels(sigma_can); 
ylabel('sigma: 2^y');
set(gca, 'YDir', 'normal')
set(get(hcb,'Title'),'String','Error')
%caxis([0 1]);
title(sprintf('%d-fold CV for %s with %d samples', ...
    n_repeat, data_name, n_sample), 'Interpreter', 'none', 'fontsize', 13);
saveas(gcf,['./results/parameters/kernel_', data_name],'epsc')
