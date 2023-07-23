//
//  ViewController.swift
//  brain_game
//
//  Created by Scott Quashen on 7/17/23.
//
// adding high score (login capability, ledderboard,  and premium content (sounds, images) is the next iteration)
// adding sounds 🔥
// adding animations 🔥
// adding app icons
// ready for publishing 7.21.23

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        playSoundMP3(sound: "lose")
  
        // Do any additional setup after loading the view.
        topLeftView.backgroundColor = UIColor.black
        topRightView.backgroundColor = UIColor.black
        bottomLeftView.backgroundColor = UIColor.black
        bottomRightView.backgroundColor = UIColor.black
        gamePlayMessagesBox.backgroundColor = UIColor.gray
        winLabel.text = ""
        
    }
    
    var player: AVAudioPlayer?

    func playSound(sound: String) {
         let url = Bundle.main.url(forResource: sound, withExtension:"wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player?.play()
    }
    
    func playSoundMP3(sound: String) {
         let url = Bundle.main.url(forResource: sound, withExtension:"mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player?.play()
    }
    
    
    @IBOutlet weak var brainsEaterLogo: UIImageView!
    
    @IBOutlet weak var gamePlayMessagesBox: UIView!
    // so that we can update the button color or the color of the game messaging while the app is training the user on each pattern and to make game play more intiutive
    
    @IBOutlet weak var gamePlayMessagesLabel: UILabel!
    // so that we can show steps and provide button text when ready which goes with the functionality control flow of the button depending on game state
  
    
    @IBOutlet weak var winLabel: UILabel!
    
    var isGameOver = false
    // not used yet
    
    var trainingMode = false
    // for control flow
    
    
    @IBOutlet weak var topLeftView: UIView!
    
    @IBOutlet weak var topRightView: UIView!
    
    @IBOutlet weak var bottomLeftView: UIView!
    
    @IBOutlet weak var bottomRightView: UIView!
    
    
    
    func gameOver(){
        brainsEaterLogo.alpha = 1.0
        playSoundMP3(sound: "lose")
        solutionsList = []
        generateNewStartingPattern()
        self.gamePlayMessagesLabel.text = "💀"

    }

    func generateNewStartingPattern(){
        justLeveledUp = false
        print("just leveled up = \(justLeveledUp)")
        growPattern()
        growPattern()
        growPattern()
 
    }
    
    @IBAction func startGameButton(_ sender: Any) {

        justLeveledUp = false
        guessIndex = 0
                trainUser()
    }
    
    
    @IBAction func topLeftButton(_ sender: Any) {
        checkGuess(guess: buttonNames.topLeft)
        print("top left pressed")
        modeCheckerForDebugging()

    }
    
    @IBAction func topRightButton(_ sender: Any) {
        checkGuess(guess: buttonNames.topRight)
        print("top right tapped")
        modeCheckerForDebugging()

    }
    
    @IBAction func bottomLeftButton(_ sender: Any) {
            checkGuess(guess: buttonNames.bottomLeft)
        print("bottom left tapped")
        modeCheckerForDebugging()

    }
    
    
    @IBAction func bottomRightButton(_ sender: Any) {
            checkGuess(guess: buttonNames.bottomRight)
        print ("bottom right tapped")
        modeCheckerForDebugging()
    }
    
    func modeCheckerForDebugging(){
        print("training mode = \(trainingMode)")
        print("justWon = \(justLeveledUp)")
    }



    
    enum buttonNames {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
    }
    

    
    var solutionsList = [buttonNames.topLeft, buttonNames.topRight, buttonNames.bottomLeft]
    
    var possibleNextRandomStep = [0, 1, 2, 3]
    
    /// now there will be no duplicates in the pattern
    /// bottom left is duplicating, rarely, but it is still....
    
    func growPattern(){
        var randomNum =  possibleNextRandomStep.randomElement()
        if(randomNum == 0){
            solutionsList.append(buttonNames.topLeft)
//            possibleNextRandomStep = [1,2,3]
            // we can allow duplicates now with the sound playing it is easy enough to follow and improves the UX
            possibleNextRandomStep = [0,1,2,3]

        } else if(randomNum == 1){
            solutionsList.append(buttonNames.topRight)
//            possibleNextRandomStep = [0,2,3]
            possibleNextRandomStep = [0,1,2,3]


        } else if (randomNum == 2){
            solutionsList.append(buttonNames.bottomLeft)
//            possibleNextRandomStep = [0, 1 ,3]
            possibleNextRandomStep = [0,1,2,3]


        } else  {
            solutionsList.append(buttonNames.bottomRight)
//            possibleNextRandomStep = [0, 1,2]
            possibleNextRandomStep = [0,1,2,3]


        }
    }

    
    let topLeftColorKey = UIColor.red
    let topRightColorKey = UIColor.blue
    let bottomLeftColorKey = UIColor.green
    let bottomRightColorKey = UIColor.yellow
    
    var justLeveledUp = false
    
    
    func checkIfTheUserJustLeveledUp(submittedAnswer: buttonNames){
            
            if(solutionsList[solutionsList.count - 1] == submittedAnswer ){
                if(guessIndex  == solutionsList.count - 1){
                    justLeveledUp = true
                                    growPattern()
                    setFourViewsToWhite()
                    
                    print("just leveled up = \(justLeveledUp)")
                    
                      playSoundMP3(sound: "win")
                    self.gamePlayMessagesLabel.text = ""
                    self.brainsEaterLogo.alpha = 1.0
                    self.setFourViewsToBlack()

                    self.winLabel.text = ""
                    self.gamePlayMessagesBox.backgroundColor = UIColor.black
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self.gamePlayMessagesBox.backgroundColor = UIColor.black
                        self.brainsEaterLogo.alpha = 0.0

          
                    
                        self.trainUser()
                        self.guessIndex = 0
                        
                    }
                    
                    
                }
                
            
        }
    }
    

func animateSolutionForTrainingMode(stepSolution: buttonNames){
    gamePlayMessagesBox.backgroundColor = UIColor.black

    if(stepSolution == buttonNames.topLeft){
   
        topLeftView.backgroundColor = topLeftColorKey
        topRightView.backgroundColor = UIColor.white
        bottomLeftView.backgroundColor = UIColor.white
        bottomRightView.backgroundColor = UIColor.white
    }
 else   if(stepSolution == buttonNames.topRight){

     topRightView.backgroundColor  = topRightColorKey
        topLeftView.backgroundColor = UIColor.white
        bottomLeftView.backgroundColor = UIColor.white
        bottomRightView.backgroundColor = UIColor.white
    }
 else   if(stepSolution == buttonNames.bottomLeft){

     bottomLeftView.backgroundColor   = bottomLeftColorKey
        topLeftView.backgroundColor = UIColor.white
        topRightView.backgroundColor = UIColor.white
        bottomRightView.backgroundColor = UIColor.white
    }
    else if (stepSolution == buttonNames.bottomRight){
  
        bottomRightView.backgroundColor = bottomRightColorKey
        topLeftView.backgroundColor = UIColor.white
        topRightView.backgroundColor = UIColor.white
        bottomLeftView.backgroundColor = UIColor.white
    }

    }
    
    
    func setFourViewsToWhite(){
        topLeftView.backgroundColor = UIColor.white
        topRightView.backgroundColor = UIColor.white
        bottomLeftView.backgroundColor = UIColor.white
        bottomRightView.backgroundColor = UIColor.white

    }
    
    func setFourViewsToBlack(){
        topLeftView.backgroundColor = UIColor.black
        topRightView.backgroundColor = UIColor.black
        bottomLeftView.backgroundColor = UIColor.black
        bottomRightView.backgroundColor = UIColor.black

    }

    // the loop below should be replaced with a more "readable" loop for this particular use case
    
    func trainUser(){
        winLabel.text = ""
        var eachStepOrder = 0
        var counter = 0
        trainingMode = true
        brainsEaterLogo.alpha = 0.0
        print("training mode should be on let us check training mode =\(trainingMode)")
        
        for pattern in solutionsList {
            
            if(solutionsList[eachStepOrder] == buttonNames.topLeft){
                /// call update on a delay, multiplied by 1 second per value of each step order
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(eachStepOrder)) {
                    self.playSound(sound: "note1")
//                    self.playSoundMP3(sound: "guitar")


                    print("each step order =: \(eachStepOrder)")
                    self.animateSolutionForTrainingMode(stepSolution: buttonNames.topLeft)
                    print("top left button is step solution")
                    counter = counter + 1
                    self.gamePlayMessagesLabel.text = String(counter)
                    
                }
            } else if (solutionsList[eachStepOrder] == buttonNames.topRight){
                print("each step order =: \(eachStepOrder)")

                DispatchQueue.main.asyncAfter(deadline: .now() + Double(eachStepOrder)) {
                    self.playSound(sound: "note2")
//                    self.playSoundMP3(sound: "synth")

                    self.animateSolutionForTrainingMode(stepSolution:    buttonNames.topRight)
                    print("top right is step solution")

                    counter = counter + 1
                    self.gamePlayMessagesLabel.text = String(counter)


                }
            } else if (solutionsList[eachStepOrder] == buttonNames.bottomLeft){
                print("each step order =: \(eachStepOrder)")

                DispatchQueue.main.asyncAfter(deadline: .now() + Double(eachStepOrder)) {
                    self.playSound(sound: "note3")
//                    self.playSoundMP3(sound: "drum")


                    print("bottom left is step solution")
                    
                    self.animateSolutionForTrainingMode(stepSolution: buttonNames.bottomLeft)

                    counter = counter + 1
                    self.gamePlayMessagesLabel.text = String(counter)
                    
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(eachStepOrder)) {
                    self.playSound(sound: "note4")
//                    self.playSoundMP3(sound: "bass")


                    print("each step order =: \(eachStepOrder)")
                    print("bottom right is step solution")
                    self.animateSolutionForTrainingMode(stepSolution: buttonNames.bottomRight)
                    counter = counter + 1
                    self.gamePlayMessagesLabel.text = String(counter)
                    
                }
            }
            eachStepOrder = eachStepOrder + 1
            print("incrementing each step order: \(eachStepOrder)")
           
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(solutionsList.count) + 0.2) {
            print("just finished training mutating training mode to false and setting all colors white")
            self.setFourViewsToWhite()

            // wait until all training is animated then turn training mode to false
            print("training mode = \(self.trainingMode) switching to false")
            self.trainingMode = false
            self.justLeveledUp = false
            self.gamePlayMessagesLabel.text = "💀"
            
        }
        
    }
    
  
        
        var guessIndex = 0

    func checkGuess(guess: buttonNames){
        if(trainingMode == false) {
            
            
            if(justLeveledUp == false){
                
                if(guess == solutionsList[guessIndex]){
                    self.gamePlayMessagesLabel.text = "\(guessIndex + 1)"

                    print("user got the answer right at index\(guessIndex )")
                    
                    if(guess == buttonNames.topLeft){
                        playSound(sound: "note1")
//                        playSoundMP3(sound: "guitar")

                        topLeftView.backgroundColor = UIColor.red
                        topRightView.backgroundColor = UIColor.white
                        bottomLeftView.backgroundColor = UIColor.white
                        bottomRightView.backgroundColor = UIColor.white
                        checkIfTheUserJustLeveledUp(submittedAnswer: guess)

                        
                        
                    } else if (guess == buttonNames.topRight){
                        playSound(sound: "note2")
//                        playSoundMP3(sound: "synth")


                        topLeftView.backgroundColor = UIColor.white
                        topRightView.backgroundColor = UIColor.yellow
                        bottomLeftView.backgroundColor = UIColor.white
                        bottomRightView.backgroundColor = UIColor.white
                        checkIfTheUserJustLeveledUp(submittedAnswer: guess)

                    } else if (guess == buttonNames.bottomLeft){
                        playSound(sound: "note3")
//                        playSoundMP3(sound: "drum")


                        topLeftView.backgroundColor = UIColor.white
                        topRightView.backgroundColor = UIColor.white
                        bottomLeftView.backgroundColor = UIColor.green
                        bottomRightView.backgroundColor = UIColor.white
                        checkIfTheUserJustLeveledUp(submittedAnswer: guess)

                    } else {
                        playSound(sound: "note4")
//                        playSoundMP3(sound: "bass")


                            topLeftView.backgroundColor = UIColor.white
                            topRightView.backgroundColor = UIColor.white
                            bottomLeftView.backgroundColor = UIColor.white
                            bottomRightView.backgroundColor = UIColor.blue
                        checkIfTheUserJustLeveledUp(submittedAnswer: guess)

                        }
                    guessIndex = guessIndex + 1

                } else {
                    gameOver()
                    guessIndex = 0
                    print("calling game over")
                    topLeftView.backgroundColor = UIColor.black
                    topRightView.backgroundColor = UIColor.black
                    bottomLeftView.backgroundColor = UIColor.black
                    bottomRightView.backgroundColor = UIColor.black
                    
                }
            }
        }
    }
}
    
  
    

