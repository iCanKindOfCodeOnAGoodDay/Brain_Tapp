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

// ading multi theme support

// adding animation on screen on load
// adding animation on screen when new color pallet selected
// using the color pallets for the colors on screen instead of using constants to define each 'button's' color

import UIKit
import AVFoundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        intitColorPallets()
        playSoundMP3(sound: "lose")
  
        // Do any additional setup after loading the view.
//        topLeftView.backgroundColor = UIColor.white
//        topRightView.backgroundColor = UIColor.white
//        bottomLeftView.backgroundColor = UIColor.black
//        bottomRightView.backgroundColor = UIColor.black
        setFourViewsToWhite()
        gamePlayMessagesBox.backgroundColor = UIColor.clear
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

    
    var topLeftColorKey = #colorLiteral(red: 0.9921568627, green: 0, blue: 0.3764705882, alpha: 1)
    var topRightColorKey = #colorLiteral(red: 0.06666666667, green: 0.4745098039, blue: 1, alpha: 1)
    var bottomLeftColorKey = #colorLiteral(red: 0.1176470588, green: 0.8745098039, blue: 0.6352941176, alpha: 1)
    var bottomRightColorKey = #colorLiteral(red: 0.9647058824, green: 0.9803921569, blue: 0.4392156863, alpha: 1)
    

    var colorPallets: [[_ColorLiteralType]] = [
//        colorGroup0, colorGroup1, colorGroup2, colorGroup3, colorGroup4, colorGroup5, colorGroup6, colorGroup7. colorGroup8, colorGroup9, colorGroup10, colorGroup11, colorGroup12, colorGroup13, colorGroup14, colorGroup15, colorGroup16, colorGroup17, colorGroup18, colorGroup19, colorGroup20, colorGroup21,
    ]
    
    var indexForIteratingTheColorPallets = 0
    
    func changeTheme(){
        if(indexForIteratingTheColorPallets < colorPallets.count - 1){
            indexForIteratingTheColorPallets = indexForIteratingTheColorPallets + 1
        } else {
            indexForIteratingTheColorPallets = 0
        }
     
        topLeftColorKey = colorPallets[indexForIteratingTheColorPallets][0]
        topRightColorKey = colorPallets[indexForIteratingTheColorPallets][1]
        bottomLeftColorKey = colorPallets[indexForIteratingTheColorPallets][2]
        bottomRightColorKey = colorPallets[indexForIteratingTheColorPallets][3]
    }
    
    
 

    func intitColorPallets(){
        colorPallets.append(colorGroup0)
        colorPallets.append(colorGroup1)
        colorPallets.append(colorGroup2)
        colorPallets.append(colorGroup3)
        colorPallets.append(colorGroup4)
        colorPallets.append(colorGroup5)
        colorPallets.append(colorGroup6)
        colorPallets.append(colorGroup7)
        colorPallets.append(colorGroup8)
        colorPallets.append(colorGroup9)
        colorPallets.append(colorGroup10)
        colorPallets.append(colorGroup11)
        colorPallets.append(colorGroup12)
        colorPallets.append(colorGroup13)
        colorPallets.append(colorGroup14)
        colorPallets.append(colorGroup15)
        colorPallets.append(colorGroup16)
        colorPallets.append(colorGroup17)
        colorPallets.append(colorGroup18)
        colorPallets.append(colorGroup19)
        colorPallets.append(colorGroup20)
        colorPallets.append(colorGroup21)
    }

    
  let colorGroup0 = [
    #colorLiteral(red: 0.9916704297, green: 0.000231181024, blue: 0.3763501942, alpha: 1),  #colorLiteral(red: 0.06666666667, green: 0.4745098039, blue: 1, alpha: 1), #colorLiteral(red: 0.1176470588, green: 0.8745098039, blue: 0.6352941176, alpha: 1), #colorLiteral(red: 0.9647058824, green: 0.9803921569, blue: 0.4392156863, alpha: 1),
    ]
    
    let colorGroup1 = [
        #colorLiteral(red: 0.05911300331, green: 0.1888224185, blue: 0.2514714003, alpha: 1),  #colorLiteral(red: 1, green: 0.3303389847, blue: 0.3934669495, alpha: 1),  #colorLiteral(red: 0.98600775, green: 0.7472785115, blue: 0.3501231074, alpha: 1),  #colorLiteral(red: 0.929158628, green: 0.8650338054, blue: 0.7671177983, alpha: 1),
    ]
    
    let colorGroup2 = [
        #colorLiteral(red: 0.8392156863, green: 0.07450980392, blue: 0.3333333333, alpha: 1),  #colorLiteral(red: 0.9764705882, green: 0.2901960784, blue: 0.1607843137, alpha: 1),  #colorLiteral(red: 0.9882352941, green: 0.8862745098, blue: 0.1647058824, alpha: 1),  #colorLiteral(red: 0.1882352941, green: 0.8901960784, blue: 0.8745098039, alpha: 1),
    ]
    
    let colorGroup3 = [
        #colorLiteral(red: 0.1490196078, green: 0, blue: 0.1058823529, alpha: 1),  #colorLiteral(red: 0.5058823529, green: 0, blue: 0.2039215686, alpha: 1),  #colorLiteral(red: 1, green: 0, blue: 0.3607843137, alpha: 1),  #colorLiteral(red: 1, green: 0.9647058824, blue: 0, alpha: 1),
    ]
    
    let colorGroup4 = [
        #colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.09019607843, alpha: 1),  #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1),  #colorLiteral(red: 0.8549019608, green: 0, blue: 0.2156862745, alpha: 1),  #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1),
    ]
    
    let colorGroup5 = [
        #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1),  #colorLiteral(red: 0.9764705882, green: 0.9529411765, blue: 0.9529411765, alpha: 1),  #colorLiteral(red: 0.968627451, green: 0.8509803922, blue: 0.8509803922, alpha: 1),  #colorLiteral(red: 0.9490196078, green: 0.3215686275, blue: 0.5294117647, alpha: 1),
    ]
    
    let colorGroup6 = [
        #colorLiteral(red: 0.9450980392, green: 0.1019607843, blue: 0.4823529412, alpha: 1),  #colorLiteral(red: 0.5960784314, green: 0.1294117647, blue: 0.462745098, alpha: 1),  #colorLiteral(red: 0.2431372549, green: 0, blue: 0.1215686275, alpha: 1),  #colorLiteral(red: 1, green: 0.8980392157, blue: 0.6784313725, alpha: 1),
    ]
    
    let colorGroup7 = [
        #colorLiteral(red: 0.05098039216, green: 0.07058823529, blue: 0.5098039216, alpha: 1),  #colorLiteral(red: 0.9333333333, green: 0.9294117647, blue: 0.9294117647, alpha: 1),  #colorLiteral(red: 0.9411764706, green: 0.8705882353, blue: 0.2117647059, alpha: 1),  #colorLiteral(red: 0.8431372549, green: 0.07450980392, blue: 0.07450980392, alpha: 1),
    ]
    
    let colorGroup8 = [
        #colorLiteral(red: 0.9254901961, green: 0.9725490196, blue: 0.9764705882, alpha: 1),  #colorLiteral(red: 0.02352941176, green: 0.5529411765, blue: 0.662745098, alpha: 1),  #colorLiteral(red: 0.4941176471, green: 0.09019607843, blue: 0.09019607843, alpha: 1),  #colorLiteral(red: 0.8980392157, green: 0.3450980392, blue: 0.02745098039, alpha: 1),
    ]
    
    let colorGroup9 = [
        #colorLiteral(red: 0.6039215686, green: 0.1254901961, blue: 0.5490196078, alpha: 1),  #colorLiteral(red: 0.8823529412, green: 0.07058823529, blue: 0.6, alpha: 1),  #colorLiteral(red: 1, green: 0.9176470588, blue: 0.9176470588, alpha: 1),  #colorLiteral(red: 0.9607843137, green: 0.7764705882, blue: 0.9254901961, alpha: 1),
    ]
    
    let colorGroup10 = [
        #colorLiteral(red: 0.6, green: 0.08235294118, blue: 0.3058823529, alpha: 1),  #colorLiteral(red: 1, green: 0.7882352941, blue: 0.2352941176, alpha: 1),  #colorLiteral(red: 1, green: 0.8666666667, blue: 0.8, alpha: 1),  #colorLiteral(red: 1, green: 0.7333333333, blue: 0.8, alpha: 1),
    ]
    
    let colorGroup11 = [
        #colorLiteral(red: 1, green: 0.7882352941, blue: 0.5882352941, alpha: 1),  #colorLiteral(red: 1, green: 0.5176470588, blue: 0.4549019608, alpha: 1),  #colorLiteral(red: 0.6235294118, green: 0.3725490196, blue: 0.5019607843, alpha: 1),  #colorLiteral(red: 0.3450980392, green: 0.2392156863, blue: 0.4470588235, alpha: 1),
    ]
    
    let colorGroup12 = [
        #colorLiteral(red: 0.1294117647, green: 0.1411764706, blue: 0.2392156863, alpha: 1),  #colorLiteral(red: 1, green: 0.4862745098, blue: 0.4862745098, alpha: 1),  #colorLiteral(red: 1, green: 0.8156862745, blue: 0.5098039216, alpha: 1),  #colorLiteral(red: 0.5333333333, green: 0.8823529412, blue: 0.9490196078, alpha: 1),
    ]
    
    
    let colorGroup13 = [
        #colorLiteral(red: 1, green: 0.9647058824, blue: 0.8549019608, alpha: 1),  #colorLiteral(red: 0.5176470588, green: 0.9490196078, blue: 0.8392156863, alpha: 1),  #colorLiteral(red: 0.9882352941, green: 0.4196078431, blue: 0.2470588235, alpha: 1),  #colorLiteral(red: 0.1490196078, green: 0.1450980392, blue: 0.1450980392, alpha: 1),
    ]
    
    let colorGroup14 = [
        #colorLiteral(red: 0.2078431373, green: 0.8156862745, blue: 0.7294117647, alpha: 1),  #colorLiteral(red: 0.9725490196, green: 0.768627451, blue: 0.2274509804, alpha: 1),  #colorLiteral(red: 0.7882352941, green: 0.2392156863, blue: 0.1058823529, alpha: 1),  #colorLiteral(red: 0.01568627451, green: 0.1960784314, blue: 0.1803921569, alpha: 1),
    ]
    
    let colorGroup15 = [
        #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1),  #colorLiteral(red: 0.231372549, green: 0.03529411765, blue: 0.2666666667, alpha: 1),  #colorLiteral(red: 0.3725490196, green: 0.09411764706, blue: 0.3294117647, alpha: 1),  #colorLiteral(red: 0.1019607843, green: 0.7333333333, blue: 0.6117647059, alpha: 1),
    ]
    
    let colorGroup16 = [
        #colorLiteral(red: 0.8, green: 0.9411764706, blue: 0.7647058824, alpha: 1),  #colorLiteral(red: 0.737254902, green: 0.6392156863, blue: 0.7921568627, alpha: 1),  #colorLiteral(red: 0.4862745098, green: 0.2784313725, blue: 0.537254902, alpha: 1),  #colorLiteral(red: 0.2901960784, green: 0.05490196078, blue: 0.3607843137, alpha: 1),
    ]
    
    let colorGroup17 = [
        #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1),  #colorLiteral(red: 0.8, green: 0.9176470588, blue: 0.7333333333, alpha: 1),  #colorLiteral(red: 0.2470588235, green: 0.2470588235, blue: 0.2666666667, alpha: 1),  #colorLiteral(red: 0.9921568627, green: 0.7960784314, blue: 0.6196078431, alpha: 1),
    ]
    
    let colorGroup18 = [
        #colorLiteral(red: 0.9843137255, green: 0.9254901961, blue: 0.9254901961, alpha: 1),  #colorLiteral(red: 0.568627451, green: 0.8196078431, blue: 0.5450980392, alpha: 1),  #colorLiteral(red: 0.8823529412, green: 0.1137254902, blue: 0.4549019608, alpha: 1),  #colorLiteral(red: 0.2666666667, green: 0, blue: 0.2784313725, alpha: 1),
    ]
    
    let colorGroup19 = [
        #colorLiteral(red: 1, green: 0.6039215686, blue: 0.462745098, alpha: 1),  #colorLiteral(red: 1, green: 0.9176470588, blue: 0.8588235294, alpha: 1),  #colorLiteral(red: 0.4039215686, green: 0.6078431373, blue: 0.6078431373, alpha: 1),  #colorLiteral(red: 0.3882352941, green: 0.4509803922, blue: 0.4509803922, alpha: 1),
    ]
    
    let colorGroup20 = [
        #colorLiteral(red: 0.6352941176, green: 0.8235294118, blue: 1, alpha: 1),  #colorLiteral(red: 0.9960784314, green: 0.9764705882, blue: 0.937254902, alpha: 1),  #colorLiteral(red: 1, green: 0.5254901961, blue: 0.368627451, alpha: 1),  #colorLiteral(red: 0.9960784314, green: 0.8941176471, blue: 0.2509803922, alpha: 1),
    ]
    
    let colorGroup21 = [
        #colorLiteral(red: 1, green: 0, blue: 0.4588235294, alpha: 1),  #colorLiteral(red: 0.09019607843, green: 0.1529411765, blue: 0.4549019608, alpha: 1),  #colorLiteral(red: 0.4666666667, green: 0.8509803922, blue: 0.4392156863, alpha: 1),  #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1),
    ]
    
    
    
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
                    self.setFourViewsToWhite()

                    self.winLabel.text = "🎉"
                    self.gamePlayMessagesBox.backgroundColor = UIColor.white
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self.gamePlayMessagesBox.backgroundColor = UIColor.white

          
                    
                        self.trainUser()
                        self.guessIndex = 0
                        
                    }
                    
                    
                }
                
            
        }
    }
    

func animateSolutionForTrainingMode(stepSolution: buttonNames){
    gamePlayMessagesBox.backgroundColor = UIColor.white

    if(stepSolution == buttonNames.topLeft){
        gamePlayMessagesBox.backgroundColor = topLeftColorKey
   
        topLeftView.backgroundColor = topLeftColorKey
        topRightView.backgroundColor = UIColor.white
        bottomLeftView.backgroundColor = UIColor.white
        bottomRightView.backgroundColor = UIColor.white
    }
 else   if(stepSolution == buttonNames.topRight){
     gamePlayMessagesBox.backgroundColor = topRightColorKey

     topRightView.backgroundColor  = topRightColorKey
        topLeftView.backgroundColor = UIColor.white
        bottomLeftView.backgroundColor = UIColor.white
        bottomRightView.backgroundColor = UIColor.white
    }
 else   if(stepSolution == buttonNames.bottomLeft){
     gamePlayMessagesBox.backgroundColor = bottomLeftColorKey


     bottomLeftView.backgroundColor   = bottomLeftColorKey
        topLeftView.backgroundColor = UIColor.white
        topRightView.backgroundColor = UIColor.white
        bottomRightView.backgroundColor = UIColor.white
    }
    else if (stepSolution == buttonNames.bottomRight){
        gamePlayMessagesBox.backgroundColor = bottomRightColorKey

  
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
        print("training mode should be on let us check training mode =\(trainingMode)")
        
        for pattern in solutionsList {
            
            if(solutionsList[eachStepOrder] == buttonNames.topLeft){
                gamePlayMessagesBox.backgroundColor = topLeftColorKey

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
                    self.gamePlayMessagesBox.backgroundColor = self.topRightColorKey
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
                    self.gamePlayMessagesBox.backgroundColor = self.bottomLeftColorKey
                    self.playSound(sound: "note3")
//                    self.playSoundMP3(sound: "drum")


                    print("bottom left is step solution")
                    
                    self.animateSolutionForTrainingMode(stepSolution: buttonNames.bottomLeft)

                    counter = counter + 1
                    self.gamePlayMessagesLabel.text = String(counter)
                    
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(eachStepOrder)) {
                    self.gamePlayMessagesBox.backgroundColor = self.bottomRightColorKey

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
                        gamePlayMessagesBox.backgroundColor = topLeftColorKey
                        playSound(sound: "note1")
//                        playSoundMP3(sound: "guitar")

                        topLeftView.backgroundColor = topLeftColorKey
                        topRightView.backgroundColor = UIColor.white
                        bottomLeftView.backgroundColor = UIColor.white
                        bottomRightView.backgroundColor = UIColor.white
                        checkIfTheUserJustLeveledUp(submittedAnswer: guess)

                        
                        
                    } else if (guess == buttonNames.topRight){
                        gamePlayMessagesBox.backgroundColor = topRightColorKey
                        playSound(sound: "note2")
//                        playSoundMP3(sound: "synth")


                        topLeftView.backgroundColor = UIColor.white
                        topRightView.backgroundColor = topRightColorKey
                        bottomLeftView.backgroundColor = UIColor.white
                        bottomRightView.backgroundColor = UIColor.white
                        checkIfTheUserJustLeveledUp(submittedAnswer: guess)

                    } else if (guess == buttonNames.bottomLeft){
                        gamePlayMessagesBox.backgroundColor = bottomLeftColorKey
                        playSound(sound: "note3")
//                        playSoundMP3(sound: "drum")


                        topLeftView.backgroundColor = UIColor.white
                        topRightView.backgroundColor = UIColor.white
                        bottomLeftView.backgroundColor = bottomLeftColorKey
                        bottomRightView.backgroundColor = UIColor.white
                        checkIfTheUserJustLeveledUp(submittedAnswer: guess)

                    } else {
                        gamePlayMessagesBox.backgroundColor = bottomRightColorKey
                        playSound(sound: "note4")
//                        playSoundMP3(sound: "bass")


                            topLeftView.backgroundColor = UIColor.white
                            topRightView.backgroundColor = UIColor.white
                            bottomLeftView.backgroundColor = UIColor.white
                            bottomRightView.backgroundColor = bottomRightColorKey
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
    
  
    

