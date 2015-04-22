#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import division, print_function, unicode_literals

from itertools import (
    chain,
)

import os

import numpy as np
from matplotlib import (
    rc,
)
rc(
    'font', **{
        'family': 'sans-serif',
        'sans-serif': ['Helvetica', ]
    }
)
## for Palatino and other serif fonts use:
#rc('font',**{'family':'serif','serif':['Palatino']})
rc(
    'text', usetex=True, **{
        'latex.unicode': True,
    }
)

import pandas as pd

from scipy import signal


data_location = '../data/'
plot_location = '.'


def read_csv(plotname):
    return pd.read_csv(
        os.path.join(data_location, '{}.csv'.format(plotname)),
        index_col=0,
    )


def save(ax, name, **kwargs):
    """
    kwargs :: dict
        to override the kwargs of fig.savefig(.)
    """
    ax.get_figure().savefig(
        os.path.join(
            plot_location,
            '{}.pdf'.format(name),
        ),
        **dict(
            chain(
                {
                    'dpi': 1200,
                    'format': 'pdf',
                }.items(),
                kwargs.items()
            )
        )
    )


def plot(data, title=None):
    ax = data.plot(
        legend=False,
        title=title,
    )
    ax.set_xlabel(
        r'$\beta\, [\textit{\u00B0}\,]$'
    )
    ax.set_ylabel(
        r'$R\, [s^{-1}]$'
    )

    return ax


def peaks(name, data):
    ax = plot(data)

    peaks = pd.Series(
        data.index[
            signal.find_peaks_cwt(
                data.intensity,
                widths=np.arange(1, 32)
            )
        ]
    )

    def postprocess(intensity, peaks):
        """
        Parameters
        ----------
        intensity :: pd.Series
        peaks :: pd.Series
            index is default enumeration
            values is the raw intensity peaks (which are to be corrected)

        Returns
        -------
        postprocessed_peaks :: pd.Series
            index is default enumeration
            values is the corrected intensity peaks.

        """
        neighborhoods = pd.concat(
            {
                0.1: intensity.shift(-1),
                0.0: intensity.shift(0),
                -0.1: intensity.shift(1),
            },
            axis=1
        )
        peak_neighborhoods = neighborhoods.ix[peaks]
        peak_corrections = peak_neighborhoods.idxmax(axis=1)

        postprocessed_peaks = peaks + peak_corrections.reset_index()[0]

        return postprocessed_peaks

    postprocessed_peaks = postprocess(data.intensity, peaks)

    def line(peak):
        ax.text(
            peak,
            1.01*ax.axis()[3],
            r'${}$\u00B0'.format(peak),
            horizontalalignment='center',
            verticalalignment='bottom',
            fontsize='small',
        )
        ax.axvline(peak)

    map(line, postprocessed_peaks)

    save(ax, '{name}peaks'.format(name=name))


def ordinary(name, data):
    ax = plot(data)

    save(ax, name)


def main(name):
    data = read_csv(name)
    ordinary(name, data)
    peaks(name, data)


if __name__ == '__main__':
    import argparse

    parser = argparse.ArgumentParser(
        description="Render PDF of the csv data(with peaks and other information)"
    )
    parser.add_argument('plotname', metavar='plotname', type=str)

    args = parser.parse_args()

    main(
        name=args.plotname,
    )
