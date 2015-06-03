#!/usr/bin/python

from __future__ import division, print_function

from matplotlib import pyplot as plt

import pandas as pd

distances = [
    0.316,
    0.333,
    0.354,
    0.378,
    0.408,
    0.447,
    0.500,
    0.577,
    0.707,
    1.000,
]


def mean_zero_ref():
    data = pd.read_csv("Measurements/utanljus.txt", sep='\t')
    u_0 = data[data.u == 0]

    return u_0.i.mean()


def mean_zero(distance):
    data = pd.read_csv("Measurements/{:.3f}m.txt".format(distance), sep='\t')
    u_0 = data[data.u == 0]

    return u_0.i.mean()

mean_ref = mean_zero_ref()
means = map(mean_zero, distances)

fig = plt.figure()
plt.plot(distances, means, color='b')
plt.axhline(mean_ref, color='r')
plt.xlabel('Distance d [m]')
plt.ylabel('Current i [A]')
fig.savefig('plots/distancedepence.pdf')
