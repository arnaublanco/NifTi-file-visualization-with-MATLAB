%%% NifTi Visualization Tutorial %%%

% Data retrieval %

path = ''; % Path to NifTi file

V = niftiread(path); % Load NifTi file
info = niftiinfo(path); % Load header info

% Data visualization %

% Coordenates (x,y,z)
x = 30;
y = 30;
z = 30;

voxel = double(reshape(V(x,y,z,:),1,size(V,4)));
plot(1:size(voxel,2),voxel);
title('Voxel ('+string(x)+','+string(y)+','+string(z)+')');
hold on