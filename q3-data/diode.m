function err = diode(params,U,I)

Isat = params(1);
Vsat = params(2);

errVec = I-Isat*(1-exp(-U/Vsat));
err = sum(errVec.^2);