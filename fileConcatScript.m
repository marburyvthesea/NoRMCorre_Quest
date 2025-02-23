

numFiles = length(files);
ln = zeros(numFiles, 1);

Y1 = read_file(fullfile(files(1).folder, files(1).name));
Y1_32bit = uint32(Y1);


%%
% File path for the HDF5 file
file_path = 'test.h5';

% Dataset name
dataset_name = '/mov';

% Saving to HDF5 file
hdf5write(file_path, dataset_name, Y1_32bit);
%%
for i = 2:length(files)
    % Load existing data from HDF5 file
    existing_data = hdf5read(file_path, dataset_name);
    % data to concat 
    Yi = read_file(fullfile(files(i).folder, files(i).name));
    Yi_32bit = uint32(Yi);
    % Concatenate data
    combined_data = cat(3, existing_data, Yi_32bit);

    % Write combined data back to the HDF5 file
    hdf5write(file_path, dataset_name, combined_data);

end