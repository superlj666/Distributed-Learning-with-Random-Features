addpath('./utils/');
addpath('./libsvm/matlab/');
rand('state', 16);

% parameters
n_partitions = 1:3;
n_labeled = 200000;
n_unlabeled = 0:10000:50000;
data_name = 'SUSY';
D = 500;
lambda = 2^1;
sigma = 2^2.5;
n_repeat = 5;

load(['./data/', data_name]);
% feature mapping
t_rf = tic();
Z = random_fourier_features(X, D, sigma);
Z = [Z, ones(length(y), 1)];
time_rf = toc(t_rf);
            
error_matrix = zeros(n_repeat, length(n_unlabeled), length(n_partitions));
time_matrix = zeros(n_repeat, length(n_unlabeled), length(n_partitions));
for i_repeat = 1 : n_repeat    
    idx_rand = randperm(length(y));
    idx_train = idx_rand(1:ceil(5*length(y)/6));
    idx_test = setdiff(idx_rand, idx_train);
    Z_test = Z(idx_test, :);
    y_test = y(idx_test, :);
    
    for i_idx_unlabeled = 1 : length(n_unlabeled)
        i_unlabeled = n_unlabeled(i_idx_unlabeled);
        idx_train_labeled = idx_train(1:n_labeled);
        idx_train_unlabeled = idx_train(n_labeled+1:n_labeled+i_unlabeled);        
        % error_rate = linear_solver(Z_train, y_train, Z_test, y_test, lambda, 'binary')

        for i_partition = 1 : length(n_partitions)
            t = tic();
            len_partition = n_partitions(i_partition);
            labeled_partition = buffer(idx_train_labeled, len_partition);
            unlabeled_partition = buffer(idx_train_unlabeled, len_partition);
            
            w = zeros(D+1, 1);
            for i_part = 1 : len_partition                
                i_part_labeled = nonzeros(labeled_partition(i_part, :));
                i_part_unlabeled = nonzeros(unlabeled_partition(i_part, :));
        
                i_Z_train = Z([i_part_labeled; i_part_unlabeled], :);
                
                i_y_train_labeled = (length(i_part_labeled)+length(i_part_unlabeled))/length(i_part_labeled)*y(i_part_labeled, :);
                i_y_train_unlabeled = zeros(length(i_part_unlabeled), 1);
                i_y_train = [i_y_train_labeled; i_y_train_unlabeled];

                w = w + linear_train(i_Z_train, i_y_train, lambda);
            end
            training_time = (time_rf + toc(t))/len_partition;
            w = w ./ len_partition;
            y_predict = Z_test * w;
            error_rate = error_estimate(y_predict, y_test, 'binary');

            error_matrix(i_repeat, i_idx_unlabeled, i_partition) = error_rate;
            time_matrix(i_repeat, i_idx_unlabeled, i_partition) = training_time;

            fprintf('Finish repeat %d - partition %d - unlabeled size %.2f\n', i_repeat, len_partition, i_unlabeled);
        end
    end
end

save(['./results/Exp2/error_partitions_', data_name], 'D', 'lambda', ...
    'sigma', 'n_repeat', 'n_partitions', 'n_labeled', 'n_unlabeled', 'error_matrix', 'time_matrix');