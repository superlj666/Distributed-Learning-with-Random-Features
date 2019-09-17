# DC_RF

## Intro
Experiments for paper "Distributed Learning with Random Features" (https://arxiv.org/abs/1906.03155).

## 1. Code structure
### folder: ./
- Exp1_partitions.m: Demonstrate variation of classification error and training time in terms of the number of partitions.
- Exp1_partitions_draw: Load results produced by Exp1_partitions and draw plot with filled bound.
- Exp1_rf.m: Demonstrate variation of classification error and training time in terms of the number of random features.
- Exp1_rf_draw: Load results produced by Exp1_rf and draw plot with filled bound.
### folder: ./script
- parameter_kernel.m: Tune $\sigma$ in gaussian kernel $K(x, x') = \exp^{-{\|x-x'\|}/{2\sigma^2}}$ and regulariztion paramter $\lambda$ for KRR.
- parameter_rf.m: Tune $\sigma$ in gaussian kernel $K(x, x') = \exp^{-{\|x-x'\|}/{2\sigma^2}}$ and regulariztion paramter $\lambda$ for RR with random features.
- startup.m: Test script when introduce new functions.
### folder: ./utils
- data_preprocess.m: Select a part of data and regularize labels, and then save in './data/' folder.
- error_estimate.m: Estimate classification error for binary class and RMSE for regression.
- gaussian_kernel.m: Produce Gaussian kernel interms of two blocks of data and $\sigma$.
- kernel_solver.m: KRR learner including training and testing.
- linear_solver.m: RR with random features including training and testing.
- random_fourier_features.m: RFF with random Gaussian matrix, based on
Rahimi, Ali, and Benjamin Recht. "Random features for large-scale kernel machines." In Advances in neural information processing systems, pp. 1177-1184. 2007.
### folder: ./draw
- fast_rate.m: Draw for Figure 1.
- unlabeled.m: Draw for Figure 2.
- compatibility.m: Draw for Figure 1.
### folder: ./data
Save preprocessed data.
### folder: ./results
Save results produced by scripts.

## 2. Run
1. Run data_preprocess.m to randomly sample a part of samples and regularize data.
2. Run parameter_kernel.m to select favorable parameter set.
3. Run Exp1_partitions.m and Exp1_partitions_draw.m to report classification error and training time in terms of partitions.
4. Run Exp1_rf.m and Exp1_rf_draw.m to report classification error and training time in terms of the number of random features.

<!--## TODO: More experiments are running.-->