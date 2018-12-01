#!/bin/bash


cat aoc201801.txt| tr '\n' ' '| sed  s/^/'0 '/ | bc
