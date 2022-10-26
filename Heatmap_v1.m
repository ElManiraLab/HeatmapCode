% % Import image you want the heatmap to be on 
% % Import heatmap data from excel for overlay
figure(1);
img = imread(''); %insert image file
MeLm = xlsread('','',''); % import excel data from 'file','sheet','cells'
MeLm2 = xlsread('','',''); % same here (more data can be added if needed)
% data of axon collaterals in hindbrain was manually traced in Coreldraw and
% transferred to excel as 40x70 (width x length)  matrix
% data cells in excel were labelled as brain outline = 1; descending axon = 2; collateral in
% HB = 3 for easier reference
% set both "brain outline" and "descending axon" as 0 -> smooth heatmap of collaterals
MeLm(MeLm<3) = (0);
MeLm2(MeLm2<3) = (0);

% summation of the heatmaps
% underlying image is larger than original heatmap -> new 100x40 matrix to
% fit new dimension and adjust image underneath
% was manually aligned
% can be adjusted by showing brain outline to have reference
% heatmap is placed onto new matrix -> C
% apply gaussian filter to make heatmap smoother
oldC = MeLm + MeLm2;
C = zeros(100,40);
C(31:100,1:40) = oldC;
gaussian_kernel = fspecial('gaussian',[100,100],.6);
density = imfilter(C, gaussian_kernel, 'replicate');

% heatmap_overlay is copied function from github
% aligns image with heatmap, colorbar property 'jet'
% Position sets figure size and position on the screen
% view to have medio- lateral direction of the brain scan
omask = heatmap_overlay(img, density, 'jet');
set(figure(1), 'Position', [500 500 800 800]);
imshow(omask,[]);
view(0, 90);
xlabel('medio- lateral','FontSize',20);ylabel('dorso- ventral','FontSize',20);title('MeLm', 'FontSize',20);
colormap(jet);
colorbar;