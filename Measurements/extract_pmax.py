#!/usr/bin/python

from __future__ import division, print_function

from matplotlib import pyplot as plt

import pandas as pd

distances_str = [
    '0.316',
    '0.333',
    '0.354',
    '0.378',
    '0.408',
    '0.447',
    '0.500',
    '0.577',
    '0.707',
    '1.000',
]

distances = [float(d) for d in distances_str]

Pmax = [0]*len(distances)

for k in range(len(distances_str)):
    # load data for given distance
    data = pd.read_csv(distances_str[k]+"m.txt", sep='\t')
    realdata = data[data.iav != 'NAN']
    iav = realdata.iav.to_dict()
    u = realdata.u.to_dict()

    # calculate power outputs u*i
    p = [0]*len(u.keys())
    idx = 0
    for key in u.keys():
        p[idx] = -u[key]*float(iav[key])
        idx+=1

    # store the maximum value
    Pmax[k] = max(p)
    
# Pmax is now the required list of output powers
# let's save it.
commaseparatedpowers = ["{:.8f}, ".format(power) for power in Pmax]

f = open('distancepowers.m','w')
f.write('dist = ' + str(distances) + ';\n')
f.write('power = [' + ''.join(commaseparatedpowers) + '];\n')
f.close()


