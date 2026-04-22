#!/usr/bin/env bash
set -e

make
cat data/logs_C.txt | ./analyzer 
