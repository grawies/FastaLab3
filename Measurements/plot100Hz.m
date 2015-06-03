%% load data

%data = importdata('startup1.txt','\t',1);
%measurementdata = data.data;
measurementdata = load('startup1.txt');
t = measurementdata(:,1);
i = measurementdata(:,3);

%% plot data

plot(t,i);
grid on
axis([0 100 0.02 0.025])
set(gca,'FontSize',12)
xlabel('time [ms]')
ylabel('current [A]')
title('Measurement of current over time')

