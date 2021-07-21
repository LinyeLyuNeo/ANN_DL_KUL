load choles_all

X_rand = p;
shape = size(X_rand);
N = shape(1,1);
p = shape(1,2);

% Generate a 50x500 matrix of Gaussian random numbers (randn(50,500)) and try to reduce dimensions with PCA (interpret
% this as 500 datapoints of dimension 50).
% p = 500;
% N = 50;
% X_rand = randn(N,p);
X_rand_mean = mean(X_rand);
% � Zero-mean the data by subtracting the mean of the dataset from each datapoint.
% � Calculate the p � p dimensional covariance matrix of the zero-mean dataset.
X_rand_cov = cov(X_rand);



% � Calculate the eigenvectors and eigenvalues of this covariance matrix.
[V_rand_cov,D_rand_cov] = eig(X_rand_cov);

% Determine the dimension q of the reduced dataset by looking at the largest eigenvalues. 
eigenValues = diag(D_rand_cov);
[eigenValues,ind] = sort(eigenValues,"descend");

% The quality of the reduction depends on how close the sum of the largest q eigenvalues is to the sum of all p eigenvalues.
% sum_EigenValues = sum(eigenValues);
% q = 4;
% sum_QLargestEigenValues = sum(eigenValues(1:q));

% � Create the q � p projection matrix ET from the eigenvectors corresponding to the q largest eigenvalues, 
q = 4;
QLargestEigenValues = eigenValues(1:q);
ET = V_rand_cov(:,ind(1:q));
ET = ET';

% and reduce the dataset by multiplying it with this matrix.
X_rand_reduced = ET * (X_rand)';
X_rand_reduced = X_rand_reduced';


% To obtain the corresponding p-dimensional datapoints 
% multiply the new data with the transpose of the projection matrix.
X_rand_reconstructed = X_rand_reduced * ET;
X_rand_reconstructed = X_rand_reconstructed + X_rand_mean;


% Notice that this corresponds to choosing F in (2) such that F = E. If q is well chosen these regenerated datapoints should
% be fairly similar to the original datapoints, thus capturing most of the information in the dataset. Remember to add the
% mean again when comparing with the original data instead of the zero-mean data.

% X_rand_diff = X_rand_reconstructed - X_rand;

RMS = (sqrt(mean(mean((X_rand_reconstructed-X_rand).^2))))
