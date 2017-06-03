//
//  ViewController.swift
//  TicTacToe
//
//  Created by Tony Stark on 2/14/17.
//  Copyright © 2017 Augustine Akoto Larbi-Ampofo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var playerOneScore: UILabel!
    @IBOutlet weak var playerTwoScore: UILabel!
    
    //setting noughts as current player
    var currentPlayer = 1
    var boardState = [0,0,0,0,0,0,0,0,0]
    var p_one_score = 0
    var p_two_score = 0
    var startGame = true

    //possible winning strategies
    let winningPermutationsArray = [ [0,1,2], [3,4,5], [6,7,8],
                                     [0,3,6], [1,4,7], [2,5,8],
                                     [0,4,8], [2,4,6]
    
                                    ]
    
    @IBOutlet var playAgainButt: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      playAgainButt.layer.cornerRadius = 6.0
       
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func makeMove(_ sender: UIButton) {
        
    if(boardState[sender.tag-1] == 0){
            boardState[sender.tag-1] = currentPlayer
            
            if(currentPlayer == 1){
                sender.setImage(UIImage(named:"nought.png"), for: UIControlState())
                //we create a new current player after the current player plays his turn
                currentPlayer = 2
            }
                
            else{
                sender.setImage(UIImage(named:"cross.png"), for: UIControlState())
                currentPlayer = 1
            }
        }
        
    else{
        let controller : UIAlertController = UIAlertController(
            title: "Alert!",
            message: "You cannot play this tile. It is already occupied.",
            preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction : UIAlertAction = UIAlertAction(
            title: "Okay",
            style: UIAlertActionStyle.default,
            handler: {(alert: UIAlertAction!) in controller.dismiss(animated: true, completion: nil) })
        controller.addAction(okAction)
        self.present(controller, animated: true, completion: nil)
        }

        
        //loop through winning permutation array to find a match
        
                for permutation in winningPermutationsArray
                    {
                        if (boardState[permutation[0]] != 0 && boardState[permutation[0]] == boardState[permutation[1]] && boardState[permutation[1]] == boardState[permutation[2]] )
                            {
                                startGame = false
                                playAgainButt.isHidden = false
                                
                                if(boardState[permutation[0]] == 1){
                                    //Me won
                                    let controller : UIAlertController = UIAlertController(
                                        title: "YeAHHH! I Have Won",
                                        message: "Me won.",
                                        preferredStyle: UIAlertControllerStyle.alert)
                                    
                                    let okAction : UIAlertAction = UIAlertAction(
                                        title: "OKK!",
                                        style: UIAlertActionStyle.default,
                                        handler: {(alert: UIAlertAction!) in controller.dismiss(animated: true, completion: nil) })
                                    controller.addAction(okAction)
                                    self.present(controller, animated: true, completion: nil)
                                    
                                //increment player score
                                    p_one_score += 1
                                    playerOneScore.text = ("\(p_one_score)")
                                }
                                
                                else{
                                    let controller : UIAlertController = UIAlertController(
                                        title: "Congrats My Opponent",
                                        message: "My Opponents has won.",
                                        preferredStyle: UIAlertControllerStyle.alert)
                                    
                                    let okAction : UIAlertAction = UIAlertAction(
                                        title: "OKK!",
                                        style: UIAlertActionStyle.default,
                                        handler: {(alert: UIAlertAction!) in controller.dismiss(animated: true, completion: nil) })
                                    controller.addAction(okAction)
                                    self.present(controller, animated: true, completion: nil)
                                  
                                    //increment player score
                                    p_two_score += 1
                                    playerTwoScore.text = ("\(p_two_score)")
                                }
                               
                
                            }
                
                    }
        
        //checking Tie Situation
        
        startGame = false
         for loop in boardState
         {
            if (loop == 0)
            {
                startGame = true
                break
            }
        }
        if startGame == false
        {
            let controller : UIAlertController = UIAlertController(
                title: "Game is Draw",
                message: "Tie Situation! No one Wins",
                preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction : UIAlertAction = UIAlertAction(
                title: "OKK!",
                style: UIAlertActionStyle.default,
                handler: {(alert: UIAlertAction!) in controller.dismiss(animated: true, completion: nil) })
            controller.addAction(okAction)
            self.present(controller, animated: true, completion: nil)
            playAgainButt.isHidden = false

        }
        
    }
    
    

    @IBAction func playAgain(_ sender: UIButton) {
        boardState = [0,0,0,0,0,0,0,0,0]
        startGame = true
        
        //winner of game starts the next game
        if(self.currentPlayer == 1){
            currentPlayer = 2
        }
        else if(self.currentPlayer == 2){
            currentPlayer = 1
        }
        
        playAgainButt.isHidden = true
        
        for count in 1...9
        {
            let button = view.viewWithTag(count) as! UIButton
            button.setImage(nil, for: UIControlState())
        }
        
    }
    
    
    
    //end
}

    


