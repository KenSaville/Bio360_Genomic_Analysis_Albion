#!/bin/bash

fafile=$1

clustalo -i $fafile -o $fafile.aln --outfmt=clu --force

boxshade -in=$fafile.aln -out=$fafile.html -def -dev=e
