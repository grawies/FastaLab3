
%% fit parameters of diode equation
% I chew many many times on the data,
% salivating lots, swallowing,
% and throw it up so that the given lab code can digest it
% like a baby bird.

format long;
data = load('utanljus.orig.txt');
U = data(:,2);
I = data(:,3);
initialz = rand(1,2);
options = optimset('Display','notify');
params = fminsearch(@diode,initials,options,U,I);
Isat = params(1);
V0 = params(2);

Ifit = Isat * (1 - exp(-V/V0));

idealityFactor = V0 * 1.60218e-19 / 1.3806488e-23 / 300;

%% nice it up!

plot(V,I,'r*');
hold on;
plot(V,Ifit,'k');
xlabel('Averaged current I_a_v [A]','FontSize',12)
ylabel('Voltage U [V]','FontSize',12)
%legend('cooling','heating')
grid on
title('Voltage over superconducting material','FontSize',12)
