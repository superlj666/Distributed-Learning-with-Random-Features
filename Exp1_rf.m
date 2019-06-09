addpath('./utils/');
addpath('./libsvm/matlab/');
rand('state', 16);

% parameters
n_rf = [1,50:50:3000];
n_partition = 500;
D = 500;
n_repeat = 5;
data_name = 'HIGGS';
[lambda, sigma] = best_parameters(data_name);

load(['./data/', data_name]);
            
error_matrix = zeros(n_repeat, length(n_rf));
time_matrix = zeros(n_repeat, length(n_rf));

for i_rf = 1 : length(n_rf)
    len_rf = n_rf(i_rf);
    % feature mapping
    t_rf_start = tic();
    Z = random_fourier_features(X, len_rf, sigma);
    Z = [Z, ones(length(y), 1)];
    t_rf = toc(t_rf_start);
    
    for i_repeat = 1 : n_repeat   
        t = tic();
        idx_rand = randperm(length(y));
        idx_train = idx_rand(1:ceil(5*length(y)/6));
        idx_test = setdiff(idx_rand, idx_train);
        Z_train = Z(idx_train, :);
        Z_test = Z(idx_test, :);
        y_train = y(idx_train, :);
        y_test = y(idx_test, :);
        % error_rate = linear_solver(Z_train, y_train, Z_test, y_test, lambda, 'binary')

        step_part = ceil(length(y_train)/n_partition);
        w = zeros(len_rf+1, 1);
        for i_part = 1 : n_partition
            idx_start = (i_part - 1)*step_part + 1;
            idx_end = min(i_part*step_part, length(y_train));
            i_Z_train = Z_train(idx_start:idx_end, :);
            i_y_train = y_train(idx_start:idx_end);            
            
            w = w + linear_train(i_Z_train, i_y_train, lambda);
        end
        training_time = (t_rf + toc(t))/n_partition;
        w = w ./ n_partition;
        y_predict = Z_test * w;
        error_rate = error_estimate(y_predict, y_test, 'binary');
        
        error_matrix(i_repeat, i_rf) = error_rate;
        time_matrix(i_repeat, i_rf) = training_time;
        
        fprintf('Finish repeat %d - rf %d\n', i_repeat, len_rf);
    end
end

save(['./results/Exp1/error_rfs_', data_name], 'n_repeat', 'lambda', ...
    'sigma', 'n_repeat', 'n_rf', 'error_matrix', 'time_matrix');