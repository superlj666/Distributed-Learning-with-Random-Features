addpath('./utils/');
addpath('./libsvm/matlab/');
rand('state', 16);

% parameters
n_partitions = [1,50:50:3000];
D = 500;
n_repeat = 5;
data_name = 'HIGGS';
[lambda, sigma] = best_parameters(data_name);

load(['./data/', data_name]);
% feature mapping
t_rf = tic();
Z = random_fourier_features(X, D, sigma);
Z = [Z, ones(length(y), 1)];
time_rf = toc(t_rf);
            
error_matrix = zeros(n_repeat, length(n_partitions));
time_matrix = zeros(n_repeat, length(n_partitions));
for i_repeat = 1 : n_repeat    
    idx_rand = randperm(length(y));
    idx_train = idx_rand(1:ceil(5*length(y)/6));
    idx_test = setdiff(idx_rand, idx_train);
    Z_train = Z(idx_train, :);
    Z_test = Z(idx_test, :);
    y_train = y(idx_train, :);
    y_test = y(idx_test, :);
    % error_rate = linear_solver(Z_train, y_train, Z_test, y_test, lambda, 'binary')
    
    for i_partition = 1 : length(n_partitions)
        t = tic();
        len_partition = n_partitions(i_partition);
        step_part = ceil(length(y_train)/len_partition);
        w = zeros(D+1, 1);
        for i_part = 1 : len_partition
            idx_start = (i_part - 1)*step_part + 1;
            idx_end = min(i_part*step_part, length(y_train));
            i_Z_train = Z_train(idx_start:idx_end, :);
            i_y_train = y_train(idx_start:idx_end);            
            
            w = w + linear_train(i_Z_train, i_y_train, lambda);
        end
        training_time = (time_rf + toc(t))/len_partition;
        w = w ./ len_partition;
        y_predict = Z_test * w;
        error_rate = error_estimate(y_predict, y_test, 'binary');
        
        error_matrix(i_repeat, i_partition) = error_rate;
        time_matrix(i_repeat, i_partition) = training_time;
        
        fprintf('Finish repeat %d - partition %d\n', i_repeat, len_partition);
    end
end

save(['./results/Exp1/error_partitions_', data_name], 'D', 'lambda', ...
    'sigma', 'n_repeat', 'n_partitions', 'error_matrix', 'time_matrix');