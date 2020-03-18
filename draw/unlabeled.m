% Load data "bias60.mat".
clc;
clear;

% Create a figure.
figure(1);
set(gcf,'Position',[100 100 1000 360]);

% Create a heatmap.
r = linspace(0.5,1,1001);
gamma = linspace(0,1,1001);
r_size = length(r);
gamma_size = length(gamma);
mat_rf = zeros(r_size, gamma_size);

mat_partition = zeros(r_size, gamma_size);
for i=1:r_size
    for j=1:gamma_size
        r_i = r(i);
        gamma_j = gamma(j);
        mat_partition(j,i) = min(2*r_i+2*gamma_j-1, 3*r_i-1)/(2*r_i+gamma_j);
    end
end

mat_N_star = zeros(r_size, gamma_size);
for i=1:r_size
    for j=1:gamma_size
        r_i = r(i);
        gamma_j = gamma(j);
        mat_N_star(j,i) = r_i/(2*r_i+gamma_j);
    end
end

mat_partition2 = zeros(r_size, gamma_size);
for i=1:r_size
    for j=1:gamma_size
        r_i = r(i);
        gamma_j = gamma(j);
        mat_partition2(j,i) = (2*r_i-1)/(2*r_i+gamma_j);
    end
end

% mat_rate = zeros(r_size, gamma_size);
% for i=1:r_size
%     for j=1:gamma_size
%         r_i = r(i);
%         gamma_j = gamma(j);
%         mat_rate(j,i) = (2*r_i)/(2*r_i+gamma_j);
%     end
% end

subplot('Position',  [0.05, 0.2, 0.25, 0.7]);
imagesc(mat_partition2);
set(gca, 'YDir', 'normal')
shading interp
xlabel('\it r', 'Interpreter', 'latex', 'fontsize', 20);
xticks(1:200:length(r))
xticklabels(0.5:0.1:1)
ylabel('\it \gamma', 'Interpreter', 'tex', 'fontsize', 20, 'Rotation', 15, 'position',[-150 500]);
yticks(1:100:length(gamma))
yticklabels(0:0.1:1)
colormap(jet(4096)) 
caxis([0 1])
title('m=O(N^c) without unlabeled data', 'Interpreter', 'tex', 'fontsize', 13);

subplot('Position',  [0.35, 0.2, 0.25, 0.7]);
imagesc(mat_partition);
set(gca, 'YDir', 'normal')
shading interp
xlabel('\it r', 'Interpreter', 'latex', 'fontsize', 20);
xticks(1:200:length(r))
xticklabels(0.5:0.1:1)
ylabel('\it \gamma', 'Interpreter', 'tex', 'fontsize', 20, 'Rotation', 15, 'position',[-150 500]);
yticks(1:100:length(gamma))
yticklabels(0:0.1:1)
colormap(jet(4096)) 
caxis([0 1])
title('m=O(N^c) with unlabeled data', 'Interpreter', 'tex', 'fontsize', 13);

subplot('Position',  [0.65, 0.2, 0.25, 0.7]);
imagesc(mat_N_star);
set(gca, 'YDir', 'normal')
shading interp
xlabel('\it r', 'Interpreter', 'latex', 'fontsize', 20);
xticks(1:200:length(r))
xticklabels(0.5:0.1:1)
ylabel('\it \gamma', 'Interpreter', 'tex', 'fontsize', 20, 'Rotation', 15, 'position',[-150 500]);
yticks(1:100:length(gamma))
yticklabels(0:0.1:1)
colormap(jet(4096)) 
caxis([0 1])
title('Total sample size N^*=N^{1+c}', 'Interpreter', 'tex', 'fontsize', 13);

hcb = colorbar('Position', [0.93  0.2  0.02  0.7]);
set(get(hcb,'Title'),'String','c')

%saveas(gcf,'fast_rate.png');
saveas(gcf,'unlabeled','epsc')
