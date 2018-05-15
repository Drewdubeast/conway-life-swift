//
//  Board.swift
//  ConwayLife
//
//  Created by Drew Wilken on 11/7/17.
//  Copyright © 2017 Drew Wilken. All rights reserved.
//

import Foundation

class Board {
    var generation: Int
    let size:Int
    var nodes:[[Node]] = [] // a 2d array of square cells, indexed by [row][column]
    init(size:Int) {
        generation = 0
        self.size = size
        for row in 0 ..< size {
            var nodeRow:[Node] = []
            for col in 0 ..< size {
                let node = Node(row: row, col: col)
                nodeRow.append(node)
            }
            nodes.append(nodeRow)
        }

    }
    func calculateIsAliveForNode(_ node: Node) {
        node.isAlive = ((arc4random()%2) == 0) // 1-in-2 chance for a node to be alive
    }
    func resetBoard() {
        //set generation to 0
        generation = 0
        
        // assign all nodes to be dead
        for row in 0 ..< size {
            for col in 0 ..< size {
                calculateIsAliveForNode(nodes[row][col])
            }
        }
        // count number of neighboring people
        for row in 0 ..< size {
            for col in 0 ..< size {
                nodes[row][col].numNeighboringPeople = self.calculateNumNeighborAliveNodesForNode(row, col)
            }
        }
    }
    
    //
    //
    //function that checks for the amount of neighbors in a 2D array that a node has
    //used everytime we run a generation
    //
    //
    //Also, had to use my own 'mod' because normal mod didn't work correctly
    //on negative numbers, so instead of x-1%10 I had to do a huge thing like:
    //(((x-1)%10) + 10) % 10) and this would return what I wanted. Annoying, but easy to fix
    //
    //
    func calculateNumNeighborAliveNodesForNode(_ row: Int,_ col: Int) -> Int {
        var count = 0
        if (nodes[row][((((col+1)%size) + size ) % size)].isAlive != false ) {
            count = count + 1
        }
        if (nodes[row][((((col-1)%size) + size ) % size)].isAlive != false) {
            count = count + 1
        }
        if (nodes[((((row+1)%size) + size ) % size)][col].isAlive != false) {
            count = count+1
        }
        if (nodes[((((row-1)%size) + size ) % size)][col].isAlive != false) {
            count = count+1
        }
        if (nodes[((((row+1)%size) + size ) % size)][((((col+1)%size) + size ) % size)].isAlive != false) {
            count = count+1
        }
        if (nodes[((((row+1)%size) + size ) % size)][((((col-1)%size) + size ) % size)].isAlive != false) {
            count = count+1
        }
        if (nodes[((((row-1)%size) + size ) % size)][((((col-1)%size) + size ) % size)].isAlive != false) {
            count = count+1
        }
        if (nodes[((((row-1)%size) + size ) % size)][((((col+1)%size) + size ) % size)].isAlive != false) {
            count = count+1
        }
        return count;
    }
    
    //runs one generation, checks neighbors, follows Conway's rules
    func runGeneration() -> Void {
        var neighbors: Int
        var newGen = nodes
        for row in 0...size-1 {
            for col in 0...size-1 {
                neighbors = nodes[row][col].numNeighboringPeople
                if (nodes[row][col].isAlive == false) { //node isn't alive
                    if (nodes[row][col].numNeighboringPeople == 3) { //born, because 3 neighbors
                        newGen[row][col].isAlive = true
                    }
                }
                else {
                    if (neighbors < 2) { //kill the man, because undercrowding
                        newGen[row][col].isAlive = false
                    }
                    if (neighbors > 3) { //kill the man, because overcrowding
                        newGen[row][col].isAlive = false
                    }
                }
            }
        }
        generation += 1; //next generation
        
        //set new array as the nodes array
        nodes = newGen
        
        //find new neighbor amount for each node
        for row in 0 ..< size {
            for col in 0 ..< size {
                nodes[row][col].numNeighboringPeople = self.calculateNumNeighborAliveNodesForNode(row, col)
            }
        }
    }
}
