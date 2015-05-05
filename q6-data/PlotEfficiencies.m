%% manually input radii [cm] and maximal observed power output [W]

R = [31.6 33.3 35.4 37.8 40.8 44.7 50.0 57.7 70.7 100.0];
Pout = fliplr([4.795 4.795 5.784 6.418 6.940 7.440 7.440 8.819 9.152 10.17]*0.001);

%% calculate efficiency

% say 60 W lamp
% 5% goes into visible range
% area of solar cell A
% distance to lamp R
% % of visible light reaching cell:
% A / (4*pi*R^2)
A = 6;
lampEff = 1.0;
Pin = 60 * lampEff * A ./ (2*pi*R.^2);

effi = Pout./Pin;

%% nice it up!

plot(R,effi,'r*');
ylabel('Efficiency \eta','FontSize',12)
xlabel('Lamp distance R [cm]','FontSize',12)

grid on
title('estimated real efficiency of solar cell','FontSize',12)