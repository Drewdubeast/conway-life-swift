# CONWAY'S GAME OF LIFE #

## Overview ##

My little implementation for the Conway Game of Life. This was a little day project I came up with for my Data Mining and Machine Learning course. 

## Rules ##

Each node on the graph is basically a "cell" that is living or dead. Each generation passes and the amount of neighbors that a cell has determines whether or not the cell lives or dies in the next generation.

1. Any live cell with fewer than two live neighbors dies, as if caused by under population.
2. Any live cell with two or three live neighbors lives on to the next generation.
3. Any live cell with more than three live neighbors dies, as if by overpopulation.
4. Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.

## App ##

In my little fun app, I included a size scroller, and you can specify the size of the gameboard. You can also let it run infinitely, or just run a single generation. 

## Charts ##

I also included a little chart of the amount living/dead for each generation. The chart is accessible via the chart button.

## Author ##

Drew Wilken (@drewdubeast)

This was my first iOS app ever, and was kinda fun!
