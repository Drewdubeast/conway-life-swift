//
//  ViewController.swift
//  ConwayLife
//
//  Created by Drew Wilken on 11/5/17.
//  Copyright © 2017 Drew Wilken. All rights reserved.
//
//
// TODO: Fix the 'dead' variable - keeps getting all wonky
// TODO: Add a size slider/variable size to the app
// TODO: when size slider is changed, change 'next gen'
// button to 'apply' and let it reset the board.
// TODO: Create a 'ARE YOU SURE' alert for the clearing?
// TODO: Make recently dead nodes a different color, so we can see how much has been alive
//
import UIKit
import Charts

class ViewController: UIViewController {

   
    //view where the nodes will appear and interact with eachother
    @IBOutlet weak var gameView: UIView!
    
    //labels and buttons that display things
    @IBOutlet weak var generationLabel: UILabel!
    @IBOutlet weak var aliveLabel: UILabel!
    @IBOutlet weak var deadLabel: UILabel!
    @IBOutlet weak var contButton: UIButton!
    
    //apply button - appears when user changes value
    @IBOutlet weak var applyButton: UIButton!
    //slider for the size
    @IBOutlet weak var sizeSlider: UISlider!
    
    //displays size on slider
    @IBOutlet weak var sizeLabel: UILabel!
    
    
    //board size - can be set here
    var BOARD_SIZE:Int = 100
    
    var board:Board?
    var nodeButtons:[NodeButton] = []
    var alives: [ChartDataEntry] = []
    var alive = 0
    var timerRunning = false
    var timer: Timer?
    
    
    //the continue button was pressed - action
    @IBAction func contButtonPressed(_ sender: UIButton) {
        aliveLabel.isHidden = false
        deadLabel.isHidden = false
        if (!timerRunning) {
            contButton.setTitle("Pause", for: .normal)
            
            //create timer that calls our runGeneration method every .01 seconds - basically a fast way
            //to run the game
            timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(runGeneration), userInfo: nil, repeats: true)
            timerRunning = true
            
        }
        else {
            contButton.setTitle("Continuous", for: .normal)
            timer?.invalidate()
            timerRunning = false
        }
    }
    
    @IBAction func sizeSliderChanged(_ sender: UISlider) {
        sizeLabel.text = String(Int(sizeSlider.value))
        applyButton.isHidden = false
    }
    
    @IBAction func applyButtonPressed(_ sender: UIButton) {
        BOARD_SIZE = Int(sizeSlider.value)
        newSizeBoard()
        applyButton.isHidden = true
    }
    
    //The 'clear' button was pressed - basically clears the boared, resets the game.
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        resetBoard()
        //initializeBoard()
        //self.startNewGame()
        alives.removeAll()
        alive = 0
        
        //if the timer was running - then quit that shit
        if (timerRunning) { timer?.invalidate(); timerRunning = false}
        
        contButton.setTitle("Continous", for: .normal)
        generationLabel.text = "Generation: 0"
        aliveLabel.isHidden = true
        deadLabel.isHidden = true
    }
    
    //sends the data entries per generation to the chart view controller when
    //the user goes to this view
     override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is ChartViewController
        {
            let vc = segue.destination as? ChartViewController
            vc?.aliveEntriesPerGeneration = alives
        }
    }
    
    //Runs one generation of life - Updates all the nodes depending on if they
    //died or if they live
    @objc func runGeneration() {
        alive = 0
        //run the new generation
        board?.runGeneration()
        
        //let newGen: [[Node]] = (board?.runGeneration())!
        generationLabel.text = "Generation: \(board?.generation ?? 0)"
        
        //update node in the nodeButton opbject
        for row in 0 ... board!.size-1 {
            for col in 0 ... board!.size-1 {
                let node = board!.nodes[row][col]
                nodeButtons[row*(board!.size-1) + col].updateNode(node)
            }
        }

        //update nodes on the table by setting them a color according to life status
        for nodeButton in self.nodeButtons {
            if nodeButton.node.isAlive {
                nodeButton.backgroundColor = .red
                alive = alive + 1
            }
            else {
                nodeButton.backgroundColor = .darkGray
            }
        }
        aliveLabel.text = "Alive: \(String(alive))"
        deadLabel.text = "Dead: \(String(board!.size*board!.size - alive))"
        
        //add to the array of alive nodes
        plotPoints()
    }
    
    //the 'go' button was pressed - runs ONE generation
    @IBAction func goButtonPressed(_ sender: UIButton) {
        aliveLabel.isHidden = false
        deadLabel.isHidden = false
        runGeneration()
    }
    
    //original function - called when the view loads / page opens
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aliveLabel.isHidden = true
        deadLabel.isHidden = true
        
        //get the game board going - initialize
        initializeBoard()
        resetBoard()
    }
    
    //initializes the board, adds all the nodes to the board
    func initializeBoard() {
        for row in 0 ... board!.size-1 {
            for col in 0 ... board!.size-1 {
                let node = board!.nodes[row][col]
                let nodeSize:CGFloat = self.gameView.frame.width / CGFloat(BOARD_SIZE)
                let nodeButton = NodeButton(node, nodeSize, 0)
                self.gameView.addSubview(nodeButton)
                self.nodeButtons.append(nodeButton)
            }
        }
    }
    
    func newSizeBoard() {
        self.board = Board(size: BOARD_SIZE)
        nodeButtons.removeAll()
        initializeBoard()
        resetBoard()
    }
    
    //resets the board, randomizing each node to be alive or dead
    func resetBoard() {
        alive = 0
        alives.removeAll()
        self.board!.resetBoard()
        // iterates through each button and resets the text to the default value
        for nodeButton in self.nodeButtons {
            if nodeButton.node.isAlive {
                alive = alive + 1
                nodeButton.backgroundColor = .red
            }
            else {
                nodeButton.backgroundColor = .darkGray
            }
        }
        plotPoints()
    }
    
    //starts the new game, just calls the reset method once.
    func startNewGame() {
        //start new game
        self.resetBoard()
    }
    
    //adds points for each generation (x,y) = (generation, num_Alive) -- the 'alives' array which
    //will be passed to the other view which will make a graph based on these values
    func plotPoints() {
        alives.append(ChartDataEntry(x: Double((board?.generation)!) , y: Double(alive)))
        //print("\(alives)")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    required init?(coder aDecoder: NSCoder)
    {
        self.board = Board(size: BOARD_SIZE)
        super.init(coder: aDecoder)
    }


}

