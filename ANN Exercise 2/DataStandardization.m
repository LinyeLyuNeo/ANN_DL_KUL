function  vars = DataStandardization(data)
    mu = mean(data);
    sig = std (data);
    vars = (data-mu)./sig;
end
