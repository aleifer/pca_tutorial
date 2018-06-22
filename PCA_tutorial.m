%PCA tutorial to go with Shlens 2014
% https://arxiv.org/abs/1404.1100
% by Andrew Leifer 
% leifer@princeton.edu 
% June 2018

%% Create perfectly oscillating mass on spring
t=1:1000;
xx=sin(pi.*t./100); 

sigma_noise=.1;

%matrix describing its true dimensions in 3D
XX= [xx; zeros(size(xx)); zeros(size(xx))];
XX=XX+sigma_noise*randn(size(XX));

figure;
plot3(XX(1,:),XX(2,:), XX(3,:),'o' )
axis equal;
title('Path of mass on spring with gaussian noise')

%% Generate three cameras

%Our natural camera basis is: 
BcamNat=[1 0 0; 0 1 0; 0 0 0];

%Randomly define three cameras
% (by generating random rotation matrices)
[RcamA,~]=qr(randn(3));
[RcamB,~]=qr(randn(3));
[RcamC,~]=qr(randn(3));
% then rotate the natural camera basis
BcamA=RcamA*BcamNat;
BcamB=RcamB*BcamNat; 
BcamC=RcamB*BcamNat;

% Make our measurements with the three cameras and store them in 
% in measurement matrix X 
X= [BcamA(:,1:2)'; BcamB(:,1:2)'; BcamC(:,1:2)';]*XX;


figure('Position', [100, 100, 1200, 600])
cam=1;
ax(cam)=subplot(1,3,cam);
plot(X(1*cam,:),X(1*cam+1,:),'o')
axis equal;
title(['Camera ' num2str(cam)])

cam=2;
ax(cam)=subplot(1,3,cam);
plot(X(1*cam,:),X(1*cam+1,:),'o')
axis equal;
title(['Camera ' num2str(cam)])

cam=3;
ax(cam)=subplot(1,3,cam);
plot(X(1*cam,:),X(1*cam+1,:),'o')
axis equal;
linkaxes(ax);
title(['Camera ' num2str(cam)])


%% Do PCA
[Y,PC,V] = pca1(X);

figure;
ylabel('variance')
xlabel('Principle Component')
plot(V,'o')


%% Plot the first three principle components
figure;
plot3(Y(1,:),Y(2,:), Y(3,:),'o' )
axis equal;
title('Path of mass on spring with gaussian noise along first three PCs')


%% for kicks plot the first principle component and the last two
figure;
plot3(Y(1,:),Y(5,:), Y(6,:),'o' )
axis equal;
title('Path of mass on spring with gaussian noise along first and last two PCs')

