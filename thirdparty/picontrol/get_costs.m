function [state_cost, ctrl_cost] = get_costs(files,T,F)

state_cost = inf(numel(F),T);
ctrl_cost = inf(numel(F),T);
for f=1:numel(F);
    d = csvread(files{F(f)},1);
    state_cost(f,1:T) = d(1:T,2);
    ctrl_cost(f,1:T) = d(1:T,3);
end