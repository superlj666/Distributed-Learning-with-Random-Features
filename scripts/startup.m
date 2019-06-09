addpath('./utils/');
addpath('./libsvm/matlab/');
dataset_path = '/home/lijian/datasets/';

rand('state', 16);
% parameters
D = 50000;
sigma = 0.01;
lambda = 0.01;

data_preprocess([dataset_path, 'w3a'], 300);


rand_idx = randperm(length(y));
y = y(rand_idx);
X = X(rand_idx, :);

threshold = ceil(2*length(y)/3);
y = label_scale(y, 'binary');
X_train = X(1:threshold, :);
y_train = y(1:threshold, :);
X_test = X(threshold + 1:end, :);
y_test = y(threshold + 1:end, :);

% kernel leaner
%error_rate = kernel_solver(X_train, y_train, X_test, y_test, sigma, lambda, 'binary')

% linear learner
% error_rate = linear_solver(X_train, y_train, X_test, y_test, lambda, 'binary')


% random feature learner
% Z_train = random_fourier_features(X_train, D, sigma);
% Z_test = random_fourier_features(X_test, D, sigma);
% error_rate = linear_solver(Z_train, y_train, Z_test, y_test, lambda, 'binary')

% kernel approximation
% K = gaussian_kernel(X_train, X_train, sigma);
% kernel_approximation_error = norm(K - Z_train*Z_train', 'fro')/length(y_train)
