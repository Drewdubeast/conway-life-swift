//
//  CollectionViewController.swift
//  ConwayLife
//
//  Created by Drew Wilken on 11/7/17.
//  Copyright © 2017 Drew Wilken. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    
    var arr: [[Int]] = [[0,0,0,0,0,0,0,0,0,0,0],
                        [0,0,0,0,0,0,0,0,0,0,0],
                        [0,0,0,0,0,0,0,0,0,0,0],
                        [0,0,0,0,0,0,0,0,0,0,0],
                        [0,0,0,0,0,0,0,0,0,0,0],
                        [0,0,0,0,0,0,0,0,0,0,0],
                        [0,0,0,0,0,0,0,0,0,0,0],
                        [0,0,0,0,0,0,0,0,0,0,0],
                        [0,0,0,0,0,0,0,0,0,0,0],
                        [0,0,0,0,0,0,0,0,0,0,0]]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    func main() {
        populate()
        for i in 0...1000{
            arr = runGeneration()
        }
        print()
        
        printArr()
        
    }
    //prints the current array
    func printArr() {
        for k in 0...9 {
            for i in 0...9 {
                //table.text = table.text! + String(arr[k][i])
                print("\(arr[k][i])", terminator: " ")
                
            }
            //table.text = table.text! + "\n"
            print()
        }
    }
    //runs one generation. Doesn't edit current array - returns a new array.
    func runGeneration() -> [[Int]]{
        var neighbors: Int
        var newGen = arr
        for k in 0...9 {
            for i in 0...9 {
                neighbors = checkNeighbors(arr, k, i)
                if (arr[k][i] == 0) {
                    if (neighbors == 3) { //born
                        newGen[k][i] = 1
                    }
                }
                else {
                    if (neighbors < 2) { //kill the man
                        newGen[k][i] = 0
                    }
                    if (neighbors > 3) { //kill the man
                        newGen[k][i] = 0
                    }
                }
            }
        }
        return newGen
    }
    //Checks the neighbors of the current node
    func checkNeighbors(_ arr: [[Int]],_ k: Int,_ i: Int) -> Int {
        var count = 0
        if (arr[k][((((i+1)%10) + 10 ) % 10)] != 0) {
            count = count + 1
        }
        if (arr[k][((((i-1)%10) + 10 ) % 10)] != 0) {
            count = count + 1
        }
        if (arr[((((k+1)%10) + 10 ) % 10)][i] != 0) {
            count = count+1
        }
        if (arr[((((k-1)%10) + 10 ) % 10)][i] != 0) {
            count = count+1
        }
        if (arr[((((k+1)%10) + 10 ) % 10)][((((i+1)%10) + 10 ) % 10)] != 0) {
            count = count+1
        }
        if (arr[((((k+1)%10) + 10 ) % 10)][((((i-1)%10) + 10 ) % 10)] != 0) {
            count = count+1
        }
        if (arr[((((k-1)%10) + 10 ) % 10)][((((i-1)%10) + 10 ) % 10)] != 0) {
            count = count+1
        }
        if (arr[((((k-1)%10) + 10 ) % 10)][((((i+1)%10) + 10 ) % 10)] != 0) {
            count = count+1
        }
        return count;
    }
    //populates the 10x10 array with 0s and 1s for the population
    func populate() {
        for k in 0...9 {
            for i in 0...9 {
                arr[k][i] = Int(arc4random_uniform(2))
                print("\(arr[k][i])", terminator: " ")
                
            }
            print()
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
