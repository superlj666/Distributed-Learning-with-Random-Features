function [lambda, sigma] = best_parameters(data_name)
    if strcmp(data_name, 'SUSY')    
        lambda = 2^1;
        sigma = 2^2.5;
    elseif strcmp(data_name, 'covtype')    
        lambda = 2^-6;
        sigma = 2^1;
    elseif strcmp(data_name, 'HIGGS')
        lambda = 2^-6;
        sigma = 2^3;
    end
end