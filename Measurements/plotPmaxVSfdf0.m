%% fit
% load distance and max powers
distancepowers

% fit parameters to equation Pmax(d) = k / (d+delta)^2 =: f(d)
initials = rand(1,2);
options = optimset('Display','iter');
params = fminsearch(@diodedist,initials,options,dist,power);
k = params(1);
delta = params(2);

% calculate 'x-values'
f = @(d) k ./ (d+delta).^2;
fdf0 = f(dist)/f(0);

% 'fit' a line Pmax = slope*d to data, for comparison
slope = mean(power./fdf0)

%% plot
% plot!
figure()
set(gca,'FontSize',12)

plot(fdf0, power, 'ro')
hold on
plot([0 max(fdf0)*1.05], [0 max(fdf0)*1.05*slope], 'b')

grid on
xlabel('f(d)/f(0)')
ylabel('P_{max} [W]')
title('Power output P_{max} vs nonlinear fitted function f(d)/f(0)')
legend('data','linear fit')