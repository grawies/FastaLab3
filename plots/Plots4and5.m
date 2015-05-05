
%%
F = @(k, D) k(1)*(k(2)+D).^(-2);

d = (1:10)'.^(-1/2);


P_10000 = zeros(10,1);

filenames = ['1.000m.txt'; '0.707m.txt'; '0.577m.txt'; '0.500m.txt'; '0.447m.txt'; '0.408m.txt'; '0.378m.txt'; '0.354m.txt'; '0.333m.txt'; '0.316m.txt'];

for i = 1:10
    
    M = dlmread(filenames(i,:));
    
    P_10000(i) = max(M(:,5))*10000;
    
end


k0 = [0 0];

[k,resnorm,~,exitflag,output] = lsqcurvefit(F,k0,d,P_10000/10000);


figure(1)
hold on
xlabel('d^{-2} [m^{-2}]');
ylabel('P_{max} [W]');

x = 0:0.1:10;
plot(x, k(1)*(k(2)+((x)'.^(-1/2))).^(-2))
scatter((1:10)',P_10000/10000)


%%

Im = nan(2501,10);
Pm = nan(2501,10);

filenames = ['1.000m.txt'; '0.707m.txt'; '0.577m.txt'; '0.500m.txt'; '0.447m.txt'; '0.408m.txt'; '0.378m.txt'; '0.354m.txt'; '0.333m.txt'; '0.316m.txt'];

for i = 1:10
    
    M = dlmread(filenames(i,:));

    Im(:,i) = M(:,4);
    Pm(:,i) = M(:,5);
    
end

Um = M(:,2);


figure(2)
hold on
grid on
xlabel('U [V]');
ylabel('I [A]');
axis([min(Um) max(Um) min(min(Im)) max(max(Im))]);
plot(Um,Im);

figure(3)
hold on
grid on
xlabel('V [J]');
ylabel('P [W]');
axis([min(Um) max(Um) min(min(Pm)) max(max(Pm))]);
plot(Um,Pm);