format long
data = load('utanljus.txt');
U = data(:,2);
I = data(:,3);
initials=rand(1,2);
options=optimset('Display','iter');
params=fminsearch(@diode,initials,options,U,I)