#!/bin/bash

python3 queens.py cbc
rm -f queens-mip-cbc-cpython.csv
mv queens-mip-cbc.csv queens-mip-cbc-cpython.csv

python3 queens.py gurobi
rm -f queens-mip-grb-cpython.csv
mv queens-mip-gurobi.csv queens-mip-grb-cpython.csv

pypy3 queens.py cbc
rm -f queens-mip-cbc-pypy.csv
mv queens-mip-cbc.csv queens-mip-cbc-pypy.csv

pypy3 queens.py gurobi
rm -f queens-mip-grb-pypy.csv
mv queens-mip-gurobi.csv queens-mip-grb-pypy.csv

python3 queens-gurobi.py

python3 queens-pulp.py
rm -f queens-pulp-cpython.csv
mv queens-pulp.csv queens-pulp-cpython.csv

pypy3 queens-pulp.py
rm -f queens-pulp-pypy.csv
mv queens-pulp.csv queens-pulp-pypy.csv

for inst in ./data/bmcp/*.col;
do
    python3 bmcp.py $inst gurobi | grep RRR | cut -d ':' -f 2 >> bmcp-mip-grb-cpython.csv
    pypy3 bmcp.py $inst gurobi | grep RRR | cut -d ':' -f 2 >> bmcp-mip-grb-pypy.csv

    python3 bmcp.py $inst cbc | grep RRR | cut -d ':' -f 2 >> bmcp-mip-cbc-cpython.csv
    pypy3 bmcp.py $inst cbc | grep RRR | cut -d ':' -f 2 >> bmcp-mip-cbc-pypy.csv
done

pypy3 summarize.py

txt2tags -t tex bench-results.t2t
txt2tags -t rst bench-results.t2t

