%%% NifTi Visualization Tutorial %%%

clear all;
close all;

%% Data retrieval - Anatomical image %

path_anat = 'anat.nii.gz'; % Path to anatomical NifTi file

Va = niftiread(path_anat); % Load NifTi file
Va_info = niftiinfo(path_anat); % Load header info

vmax = max(Vm,[],'all'); % Maximum value in the whole scan
vmin = min(Vm,[],'all'); % Minimum value in the whole scan

Va_prime = ((Va-vmin)./(vmax-vmin)); % Normalization -> values between 0 and 1
dim = size(Va_prime); % Dimensions of the volume

%% Data visualization %

% Slices of the volume
sliceX = 30;
sliceY = 60;
sliceZ = 35;

horizontal = Va_prime(:,:,sliceZ); % Horizontal view
frontal = reshape(Va_prime(:,sliceY,:),[dim(1) dim(3)]); % Frontal view
sagittal = reshape(Va_prime(sliceX,:,:),[dim(2) dim(3)]); % Sagittal view

% Show views of the brain
subplot(2,2,1); imshow(imrotate(frontal,90)); title('Frontal');
subplot(2,2,2); imshow(imrotate(sagittal,90)); title('Sagittal');
subplot(2,2,3); imshow(imrotate(horizontal,90)); title('Horizontal');

%% BOLD Signal Visualization %

path_func = 'func.nii.gz'; % Path to functional Nifti file

Vf = niftiread(path_func); % Load NifTi file
Vf_info = niftiinfo(path_func); % Load header info

% Coordenates (x,y,z)
x = 30;
y = 40;
z = 50;

voxel = reshape(Vf(x,y,z,:),1,size(Vf,4)); % Reshape Vf for the plot

% Plot the BOLD signal
plot(1:size(voxel,2),voxel);
title('Voxel ('+string(x)+','+string(y)+','+string(z)+')');
xlabel('Time (s)');
ylabel('Voltage (mV)');