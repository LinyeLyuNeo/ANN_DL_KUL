function [count] = num2Attractor3D(record)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
count = 0;
n = size(record);
for i = 1:(n(2)-1)
    % check if reach the attractor
    if record(1,i) == record(1,i+1) && record(2,i) == record(2,i+1)&& record(3,i) == record(3,i+1)
        break
    end
    count = count + 1;
end



