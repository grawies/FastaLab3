
%% fit parameters of diode equation
% I chew many many times on the data,
% salivating lots, swallowing,
% and throw it up so that the given lab code can digest it
% like a baby bird.

format long;
data = load('utanljus.orig.txt');
V = data(:,2);
I = data(:,3);
initials = rand(1,2);
options = optimset('Display','notify');
params = fminsearch(@diode,initials,options,V,I);
Isat = params(1);
V0 = params(2);

Ifit = Isat * (1 - exp(-V/V0));

idealityFactor = V0 * 1.60218e-19 / 1.3806488e-23 / 293.15;

%% nice it up!

plot(V,I,'r.');
hold on;
plot(V,Ifit,'k');
ylabel('Current I [A]','FontSize',12)
xlabel('Voltage U [V]','FontSize',12)

grid on
title('IV-plot of unilluminated diode','FontSize',12)
legend('experimental data', 'fitted equation')