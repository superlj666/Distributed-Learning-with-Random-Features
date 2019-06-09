function Z = random_fourier_features(X, D, sigma)
    % creates Gaussian random features
    % Inputs:
    % X the datapoints to use to generate those features (n x d)
    % D the number of features to make
    d = size(X, 2);
    W = normrnd(0, 1/sigma, [d, D]);
    b = 2*pi*rand(1, D);
    Z = sqrt(2/D)*cos(X*W + b);
end