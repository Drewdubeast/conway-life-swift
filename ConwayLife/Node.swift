//
//  Node.swift
//  ConwayLife
//
//  Created by Drew Wilken on 11/7/17.
//  Copyright © 2017 Drew Wilken. All rights reserved.
//
//  A simple node class - represents one 'person' in Conway's Game of Life
//

import Foundation

class Node {
    let row:Int
    let col:Int
    // give these default values that we will re-assign later with each generation
    var numNeighboringPeople = 0 
    var isAlive = false
    init(row:Int, col:Int) {
        //store the row and column of the square in the grid
        self.row = row
        self.col = col
    }
}
