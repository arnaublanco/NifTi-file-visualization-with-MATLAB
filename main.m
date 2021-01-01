%%% NifTI Visualization Tutorial %%%

clear all;
close all;

%% Data retrieval - Anatomical image %

path_anat = "anat.nii.gz"; % Path to anatomical NifTi file

Va = niftiread(path_anat); % Load NifTI file

Vmax = max(Va,[],'all'); % Maximum value in the whole scan
Vmin = min(Va,[],'all'); % Minimum value in the whole scan

Va_prime = (Va-Vmin)./(Vmax-Vmin); % Normalization -> values between 0 and 1
dim = size(Va_prime); % Dimensions of the volume

%% Data visualization %

% 3D visualization %
figure;
volshow(Va);

% 2D visualization %
% Slices of the volume
sliceX = 100;
sliceY = 100;
sliceZ = 100;

frontal = Va_prime(:,:,sliceZ); % Frontal view
sagittal = reshape(Va_prime(sliceX,:,:),[dim(2) dim(3)]); % Sagittal view
horizontal = reshape(Va_prime(:,sliceY,:),[dim(1) dim(3)]); % Horizontal view

% Show views of the brain
figure;
subplot(2,2,1); imshow(imrotate(frontal,-90)); title('Frontal');
subplot(2,2,2); imshow(imrotate(sagittal,-90)); title('Sagittal');
subplot(2,2,3); imshow(imrotate(horizontal,-90)); title('Horizontal');

%% Data retrieval - Functional image %

path_func = "func.nii.gz"; % Path to anatomical NifTi file

Vf = niftiread(path_func); % Load NifTi file
Vfm = mean(Vf,4);

Vmax = max(Vfm,[],'all'); % Maximum value in the whole scan
Vmin = min(Vfm,[],'all'); % Minimum value in the whole scan

Vf_prime = (Vfm-Vmin)./(Vmax-Vmin); % Normalization -> values between 0 and 1
dim = size(Vf_prime); % Dimensions of the volume

%% Data visualization %%

% 3D visualization %
figure;
alpha = (0:255)/256;
alpha(1:100) = 0;
volshow(Vfm,'Alphamap',alpha');

% 2D visualization %
% Slices of the volume
sliceX = 40;
sliceY = 35;
sliceZ = 32;

frontal = Vf_prime(:,:,sliceZ); % Frontal view
sagittal = reshape(Vf_prime(sliceX,:,:),[dim(2) dim(3)]); % Sagittal view
horizontal = reshape(Vf_prime(:,sliceY,:),[dim(1) dim(3)]); % Horizontal view

% Show views of the brain
figure;
subplot(2,2,1); imshow(imrotate(frontal,90)); title('Frontal');
subplot(2,2,2); imshow(imrotate(sagittal,90)); title('Sagittal');
subplot(2,2,3); imshow(imrotate(horizontal,90)); title('Horizontal');

% Alternative %
%frontal = Vf(:,:,sliceZ); % Frontal view
%sagittal = reshape(Vf(sliceX,:,:),[dim(2) dim(3)]); % Sagittal view
%horizontal = reshape(Vf(:,sliceY,:),[dim(1) dim(3)]); % Horizontal view

%subplot(2,2,1); imshow(imrotate(frontal,90),[Vmin Vmax])); title('Frontal');
%subplot(2,2,2); imshow(imrotate(sagittal,90),[Vmin Vmax])); title('Sagittal');
%subplot(2,2,3); imshow(imrotate(horizontal,90),[Vmin Vmax])); title('Horizontal');

%% BOLD signal - Visualization %%

% Coordenates (x,y,z)
x = 40;
y = 30;
z = 25;

% Reshape Vf for the plot
voxel = reshape(Vf(x,y,z,:),[1 222]);

% Plot the BOLD signal
figure;
plot(4:size(voxel,2),voxel(4:end));
title('Voxel ('+string(x)+','+string(y)+','+string(z)+')');
xlabel('Time (s)');
ylabel('Voltage (mV)');