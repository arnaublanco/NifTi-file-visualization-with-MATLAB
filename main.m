%%% NifTi Visualization Tutorial %%%

% Data retrieval %

path_anat = 'anat.nii.gz'; % Path to anatomical NifTi file
path_func = 'func.nii.gz'; % Path to functional Nifti file

Vf = niftiread(path_func); % Load NifTi file
info = niftiinfo(path_func); % Load header info
Vm = mean(Vf,4); % (4D) width x height x depth x time -> (3D) width x height x depth

vmax = max(Vm,[],'all'); % Maximum value in the whole scan
vmin = min(Vm,[],'all'); % Minimum value in the whole scan

Vf_prime = ((Vm-vmin)./(vmax-vmin)); % Normalization -> values between 0 and 1
dim = size(Vf_prime); % Dimensions of the volume

%% Data visualization %

% Slices of the volume
sliceX = 30;
sliceY = 60;
sliceZ = 35;

horizontal = Vf_prime(:,:,sliceZ); % Horizontal view
frontal = reshape(Vf_prime(:,sliceY,:),[dim(1) dim(3)]); % Frontal view
sagittal = reshape(Vf_prime(sliceX,:,:),[dim(2) dim(3)]); % Sagittal view

% Show views of the brain
subplot(2,2,1); imshow(imrotate(frontal,90)); title('Frontal');
subplot(2,2,2); imshow(imrotate(sagittal,90)); title('Sagittal');
subplot(2,2,3); imshow(imrotate(horizontal,90)); title('Horizontal');

%% BOLD Signal Visualization

% Coordenates (x,y,z)
x = 30;
y = 30;
z = 30;

voxel = reshape(Vf(x,y,z,:),1,size(Vf,4)); % Reshape Vf for the plot

% Plot the BOLD signal
plot(1:size(voxel,2),voxel);
title('Voxel ('+string(x)+','+string(y)+','+string(z)+')');
xlabel('Time (s)');
ylabel('Voltage (mV)');
hold on