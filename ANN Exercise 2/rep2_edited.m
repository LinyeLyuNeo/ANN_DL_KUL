%%%%%%%%%%%
% rep2.m
% A script which generates n random initial points 
%and visualises results of simulation of a 2d Hopfield network 'net'
%%%%%%%%%%

T = [1 1; -1 -1; 1 -1]';
net = newhop(T);


% generate a grid of starting points from x,y (-1,1)
i_x = -1:0.1:1;
i_y = -1:0.1:1;

n = size(i_x);
m = size(i_y);

% initalize the arrays for recording 
start_record = zeros(2, n(2)*m(2));
finish_record = zeros(2, n(2)*m(2));
count_record = zeros(1, n(2)*m(2));

figure 
for i = 1:n(2)
    
    for j = 1:m(2)

        b = (i-1)*m(2)+j;
        a = {[i_x(i);i_y(j)]};
        [y,Pf,Af] = sim(net,{1 50},{},a);   % simulation of the network for 50 timesteps              
        record=[cell2mat(a) cell2mat(y)];   % formatting results  
        start=cell2mat(a);                  % formatting results 
        finish=cell2mat(y(:,end));
        count=num2Attractor2D(record);
        
        start_record(1,b)=start(1,1);
        start_record(2,b)=start(2,1);
        finish_record(1,b)=finish(1,1); 
        finish_record(2,b)=finish(2,1); 
        count_record(b)=count;
        plot(start(1,1),start(2,1),'bx',record(1,:),record(2,:),'r'); % plot evolution
        hold on;
        plot(record(1,50),record(2,50),'gO');  % plot the final point with a green circle
        
        

    end  
end

new_start_record = start_record';
new_finish_record = finish_record';
new_count_record = count_record';

figure
histogram(new_count_record)
xlabel('# Iterations'), ylabel('# Initial Points')

X1_train=new_start_record(:,1);
X2_train=new_start_record(:,2);
T_train=new_count_record;

F = scatteredInterpolant(X1_train,X2_train,T_train);

xlin = linspace(min(X1_train),max(X1_train),100);
ylin = linspace(min(X2_train),max(X2_train),100);

f1 = figure('Name','Surface of # Iterations')
[X1_M,X2_M] = meshgrid(xlin,ylin);
T_M = F(X1_M,X2_M);
mesh(X1_M,X2_M,T_M);
title('Surface of # Iterations')
xlabel('X'), ylabel('Y'), zlabel('# Iterations')
legend('Sample data','Interpolated query data','Location','Best')


