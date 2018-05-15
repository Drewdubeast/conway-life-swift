//
//  NodeButton.swift
//  ConwayLife
//
//  Created by Drew Wilken on 11/7/17.
//  Copyright © 2017 Drew Wilken. All rights reserved.
//

import Foundation
import UIKit


class NodeButton : UIButton {
    
    let nodeSize:CGFloat
    let nodeMargin:CGFloat
    var node:Node
    
    //initialize the new node, giving it a size and dimensions
    init(_ nodeModel:Node,_ nodeSize:CGFloat,_ nodeMargin:CGFloat) {
        self.node = nodeModel
        self.nodeSize = nodeSize
        self.nodeMargin = nodeMargin
        let x = CGFloat(self.node.col) * (nodeSize + nodeMargin)
        let y = CGFloat(self.node.row) * (nodeSize + nodeMargin)
        let nodeFrame = CGRect(x: x, y: y, width: nodeSize, height: nodeSize)
        super.init(frame: nodeFrame)
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //simple function to update the node
    func updateNode(_ node: Node) {
        self.node = node
    }
}
