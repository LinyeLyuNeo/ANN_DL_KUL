% linear separable inputs
X = [ -0.5 -0.5 +0.3 -0.1;  ...
      -0.5 +0.5 -0.5 +1.0];
T = [1 1 0 0];
plotpv(X,T);


% % non-linear separable inputs
% X = [ -0.5 -0.5 +0.3 -0.1 -0.8; ...
%       -0.5 +0.5 -0.5 +1.0 +0.0 ];
% T = [1 1 0 0 0];
% plotpv(X,T);


net = perceptron;

% net = perceptron('hardlim','learnpn');
net = configure(net,X,T);

hold on
plotpv(X,T);
linehandle = plotpc(net.IW{1},net.b{1});


E = 1;
while (sse(E))
   [net,Y,E] = adapt(net,X,T);
   linehandle = plotpc(net.IW{1},net.b{1},linehandle);
   drawnow;
end

% make a prediction with one input
x = [0.7; 1.2];
y = net(x);
plotpv(x,y);
point = findobj(gca,'type','line');
point.Color = 'red';

% visualize results
hold on;
plotpv(X,T);
plotpc(net.IW{1},net.b{1});
hold off;


displayEndOfDemoMessage(mfilename)

% Summary:
% we can only train the perceptron perfectly when the inputs are linear separable



