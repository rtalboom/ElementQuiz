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
    case score
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
        
        @IBOutlet weak var nextButton: UIButton!
        @IBOutlet weak var showAnswerButton: UIButton!
        
        @IBAction func showAnswer(_ sender: Any) {
            state = .answer
            
            updateUI()
        }
        
        @IBAction func next(_ sender: Any) {
            currentElementIndex += 1
            if currentElementIndex >= elementList.count
               {
                currentElementIndex = 0
                if mode == .quiz {
                    state = .score
                    updateUI()
                    return
                }
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
        
        func updateFlashCardUI(elementName: String) {
            modeSelector.selectedSegmentIndex = 0
            textField.isHidden = true
            showAnswerButton.isHidden = false
             textField.resignFirstResponder()
            let elementName =
               elementList[currentElementIndex]
            let image = UIImage(named: elementName)
            imageView.image = image
            if state == .answer {
                answerLabel.text = elementName
            } else {
                answerLabel.text = "?"
            }
            nextButton.isEnabled = true
            nextButton.setTitle("Next Element", for: .normal)

        }
        
        var answerIsCorrect = false
        var correctAnswerCount = 0

        func updateQuizUI(elementName: String) {
            modeSelector.selectedSegmentIndex = 1
            textField.isHidden = false
            showAnswerButton.isHidden = true
            if currentElementIndex == elementList.count - 1 {
                nextButton.setTitle("Show Score",
                   for: .normal)
            } else {
                nextButton.setTitle("Next Question",
                   for: .normal)
            }
            switch state {
            case .question:
                nextButton.isEnabled = false
            case .answer:
                nextButton.isEnabled = true
            case .score:
                nextButton.isEnabled = false
            }
            
            textField.isHidden = false
            switch state {
            case .question:
                textField.isEnabled = true
                textField.text = ""
                textField.becomeFirstResponder()
            case .answer:
                textField.isEnabled = false
                textField.resignFirstResponder()
            case .score:
                textField.isHidden = true
                textField.resignFirstResponder()
            }

            switch state {
            case .question:
                answerLabel.text = ""
                textField.resignFirstResponder()
            case .answer:
                if answerIsCorrect {
                    answerLabel.text = "Correct!"
                } else {
                    answerLabel.text = "❌"
                }
            case .score:
                answerLabel.text = ""
            print("Your score is \(correctAnswerCount)out of \(elementList.count).")
            }

            if state == .score {
                displayScoreAlert()
            }
        }
        
        func updateUI() {
            let elementName = elementList[currentElementIndex]
            let image = UIImage(named: elementName)
            imageView.image = image
            textField.text = " "
            switch mode {
            case .flashCard:
                updateFlashCardUI(elementName: elementName)
            case .quiz:
                updateQuizUI(elementName: elementName)
            }
            
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
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
        
        
        func displayScoreAlert() {
            let alert = UIAlertController(title: "Quiz Score", message: "Your score is \(correctAnswerCount) out of \(elementList.count).",preferredStyle: .alert)
            let dismissAction =
               UIAlertAction(title: "OK",
               style: .default, handler:
               scoreAlertDismissed(_:))
            alert.addAction(dismissAction)
            present(alert, animated: true,
               completion: nil)
        }
        func scoreAlertDismissed(_ action: UIAlertAction) {
            mode = .flashCard
        }
        	
        func setupFlashCards() {
            state = .question
            currentElementIndex = 0
            switch mode {
            case .flashCard:
                setupFlashCards()
            case .quiz:
                setupQuiz()
            }
            updateUI()
        }

        func setupQuiz() {
            state = .question
            currentElementIndex = 0
            answerIsCorrect = false
            correctAnswerCount = 0
        }
    }
        
