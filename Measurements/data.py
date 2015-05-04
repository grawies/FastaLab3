from __future__ import division, print_function

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


def mean_zero(distance):
    data = pd.read_csv("{:.3f}m.txt".format(distance), sep='\t')
    u_0 = data[data.u == 0]

    return u_0.i.mean()


means = map(mean_zero, distances)
