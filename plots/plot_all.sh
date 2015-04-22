#!/usr/bin/env bash
echo -e "A\nB\nC\nD\nNaCl" | xargs -P 0 -I{} ./plot.py {}
