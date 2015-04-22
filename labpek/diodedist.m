function err = diodedist(params,d,P)

k = params(1);
x0 = params(2);

errVec = P-k./(d+x0).^2;
err = sum(errVec.^2);