% Load data "bias60.mat".
clc;
clear;
% Create a figure.
figure(1);
set(gcf,'Position',[100 100 1000 360]);

% Create a heatmap.
r = linspace(0.5,1,101);
gamma = linspace(0,1,101);
r_size = length(r);
gamma_size = length(gamma);
mat_rf = zeros(r_size, gamma_size);
for i=1:gamma_size
    for j=1:gamma_size
        r_i = r(i);
        gamma_j = gamma(j);
        mat_rf(j,i) = ((2*r_i-1)*gamma_j+1)/(2*r_i+gamma_j);
        %mat_rf(j,i) = r_i/(2*r_i + gamma_j);
    end
end

mat_rf2 = zeros(r_size, gamma_size);
for i=1:gamma_size
    for j=1:gamma_size
        r_i = r(i);
        gamma_j = gamma(j);
        mat_rf2(j,i) = (2*r_i+gamma_j-1)/(2*r_i+gamma_j);
    end
end

mat_rate = zeros(r_size, gamma_size);
for i=1:r_size
    for j=1:gamma_size
        r_i = r(i);
        gamma_j = gamma(j);
        mat_rate(j,i) = (2*r_i)/(2*r_i+gamma_j);
    end
end

subplot('Position',  [0.05, 0.2, 0.25, 0.7]);
imagesc(mat_rf);
set(gca, 'YDir', 'normal')
shading interp
xlabel('\it r', 'Interpreter', 'latex', 'fontsize', 20);
xticks(1:20:101)
xticklabels(0.5:0.1:1)
ylabel('\it \gamma', 'Interpreter', 'tex', 'fontsize', 20, 'Rotation', 15, 'position',[-13 50]);
yticks(1:10:101)
yticklabels(0:0.1:1)
colormap(jet(4096)) 
caxis([0 1])
title('M=O(N^c) with \alpha=1', 'Interpreter', 'tex', 'fontsize', 13);

subplot('Position',  [0.35, 0.2, 0.25, 0.7]);
imagesc(mat_rf2);
set(gca, 'YDir', 'normal')
shading interp
xlabel('\it r', 'Interpreter', 'latex', 'fontsize', 20);
xticks(1:20:101)
xticklabels(0.5:0.1:1)
ylabel('\it \gamma', 'Interpreter', 'tex', 'fontsize', 20, 'Rotation', 15, 'position',[-13 50]);
yticks(1:10:101)
yticklabels(0:0.1:1)
colormap(jet(4096)) 
caxis([0 1])
title('M=O(N^c) with \alpha=\gamma', 'Interpreter', 'tex', 'fontsize', 13);

subplot('Position',  [0.65, 0.2, 0.25, 0.7]);
imagesc(mat_rate);
set(gca, 'YDir', 'normal')
shading interp
xlabel('\it r', 'Interpreter', 'latex', 'fontsize', 20);
xticks(1:20:101)
xticklabels(0.5:0.1:1)
ylabel('\it \gamma', 'Interpreter', 'tex', 'fontsize', 20, 'Rotation', 15, 'position',[-13 50]);
yticks(1:10:101)
yticklabels(0:0.1:1)
colormap(jet(4096)) 
caxis([0 1])
title('Learning rate O(N^{-c})', 'Interpreter', 'tex', 'fontsize', 13);


hcb = colorbar('Position', [0.93  0.2  0.02  0.7]);
set(get(hcb,'Title'),'String','c')

%saveas(gcf,'fast_rate.png');
saveas(gcf,'compatibility','epsc')