//
//  ViewController.swift
//  ElementQuiz
//
//  Created by SD on 12/01/2023.
//

import UIKit

enum Mode {
    case flashCard
    case quiz
}

enum State {
    case question
    case answer
}
    
    class ViewController: UIViewController {
        
        var mode: Mode = .flashCard
        var state: State = .question
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            updateFlashCardUI()
        }
        
        @IBOutlet weak var imageView: UIImageView!
        @IBOutlet weak var answerLabel: UILabel!
        
        @IBOutlet weak var modeSelector: UISegmentedControl!
        @IBOutlet weak var textField: UITextField!
        
        @IBAction func showAnswer(_ sender: Any) {
            state = .answer
            
            updateFlashCardUI()
        }
        
        @IBAction func next(_ sender: Any) {
            currentElementIndex += 1
                if currentElementIndex ==
                   elementList.count {
                    currentElementIndex = 0
                }
                state = .question
                updateFlashCardUI()
        }
        
        let elementList = ["Carbon", "Gold", "Chlorine", "Sodium"]
        var currentElementIndex = 0
        
        func updateFlashCardUI() {
            let elementName =
               elementList[currentElementIndex]
            let image = UIImage(named: elementName)
            imageView.image = image
            if state == .answer {
                answerLabel.text = elementName
            } else {
                answerLabel.text = "?"
            }
        
        }
        
        
        
    }
    
