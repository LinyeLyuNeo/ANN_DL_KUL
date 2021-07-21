load threes -ascii
colormap('gray')
% Compute the mean 3 and display it.
mean_threes = mean(threes);
imagesc(reshape(mean_threes,16,16),[0,1])

% Compute the covariance matrix of the whole dataset of 3s (note that the Matlab function cov subtracts the mean automatically,
% subtracting it beforehand is not incorrect however).
threes_cov = cov(threes);

% Compute the eigenvalues and eigenvectors of this covariance
% matrix. Plot the eigenvalues (plot(diag(D) where D is the diagonal matrix of eigenvalues).

[V,D] = eig(threes_cov);
figure('Name','Plot of Eigenvalues') 
plot(diag(D));

% plot the reconstruction error as a function of q

q = 50;
reconstruction_error = zeros(1,q);
for i = 1:q
    
    reconstruction_error(i) = mypca(threes,mean_threes,V,D,i);
end
figure('Name','Reconstruction Error vs Q') 
plot(reconstruction_error)

% Use the Matlab function cumsum to create a vector whose i-th element is the sum of all but the i largest eigenvalues for
% i = 1 : 256. Compare the first 50 elements of this vector to the vector of reconstruction errors calculated previously.
eigenValues = diag(D);
[eigenValues,ind] = sort(eigenValues,"descend");

sum_largest_eigenValues = ones(1,50)*sum(eigenValues);

for i = 1:50
    sum_largest_eigenValues(i) = sum_largest_eigenValues(i) - eigenValues(i);
end

figure('Name','Vector Value vs Q') 
plot(sum_largest_eigenValues(1:50))