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
    
    class ViewController: UIViewController, UITextFieldDelegate {
        
        var mode: Mode = .flashCard {
            didSet {
                updateUI()
            }
        }
            	
        var state: State = .question
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            updateUI()
        }
        
        @IBOutlet weak var imageView: UIImageView!
        @IBOutlet weak var answerLabel: UILabel!
        
        @IBOutlet weak var modeSelector: UISegmentedControl!
        @IBOutlet weak var textField: UITextField!
        
        @IBAction func showAnswer(_ sender: Any) {
            state = .answer
            
            updateUI()
        }
        
        @IBAction func next(_ sender: Any) {
            currentElementIndex += 1
                if currentElementIndex ==
                   elementList.count {
                    currentElementIndex = 0
                }
                state = .question
            updateUI()
        }
        
        
        @IBAction func switchModes(_ sender: Any) {
            if modeSelector.selectedSegmentIndex == 0 {
                mode = .flashCard
            } else {
                mode = .quiz
                updateUI()
            }
        }
        
        let elementList = ["Carbon", "Gold", "Chlorine", "Sodium"]
        var currentElementIndex = 0
        
        func updateFlashCardUI (elementName: String) {
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
        
        var answerIsCorrect = false
        var correctAnswerCount = 0

        func updateQuizUI (elementName: String) {
            switch state {
                case .question:
                    answerLabel.text = ""
                case .answer:
                    if answerIsCorrect {
                        answerLabel.text = "Correct!"
                    } else {
                        answerLabel.text = "❌"
                    }
                }
        }
        
        func updateUI() {
            let elementName =
               elementList[currentElementIndex]
            let image = UIImage(named: elementName)
            imageView.image = image
            textField.text = " "
            switch mode {
            case .flashCard:
                updateFlashCardUI(elementName: elementName)
            case .quiz:
                updateQuizUI(elementName: elementName)
                }
            

            func textFieldShouldReturn(_ textField:
               UITextField) -> Bool {

                let textFieldContents = textField.text!

                if textFieldContents.lowercased() == elementList[currentElementIndex].lowercased() {
                    answerIsCorrect = true
                    correctAnswerCount += 1
                } else {
                    answerIsCorrect = false
                }
                state = .answer
                updateUI()
                return true
            }
        }
        
    }
    
