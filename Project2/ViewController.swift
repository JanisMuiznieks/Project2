//
//  ViewController.swift
//  Project2
//
//  Created by janis.muiznieks on 25/04/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var questionsAsked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion(action: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showScore))
    }
    func askQuestion(action: UIAlertAction!){
        countries.shuffle()
        
        correctAnswer = Int.random(in: 0...2)
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        title = "What is the flag of \(countries[correctAnswer].uppercased())   Your score: \(score)"
        
        questionsAsked += 1
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct. Well done!"
            score += 1
        } else {
            title = "Wrong. That was the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }
        if questionsAsked == 10 {
            let finalQuestion = UIAlertController(title: "Congratulations!", message: "You scored \(score) out of 10 points!", preferredStyle: .alert)
            finalQuestion.addAction(UIAlertAction(title: "Play again!", style: .default, handler: nil))
            
            present(finalQuestion, animated: true)
            
            questionsAsked = 0
            score = 0
        } else {
        let ac = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Countine", style: .default, handler: askQuestion))
        present(ac, animated: true)
        }
    }
    @objc func showScore(){
        let vc = UIActivityViewController(activityItems: ["My score is \(score)"], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}

