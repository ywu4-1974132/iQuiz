//
//  AnswerViewController.swift
//  iQuiz
//
//  Created by Sky Wu on 5/17/22.
//

import UIKit

class AnswerViewController: UIViewController {
    
    var questions: [Questions] = []
    var userChoice: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let question = questions[numQuestion]
        questionInput.text = "\(question.question)"
        correctAnswer.text = "The correct answer is \(question.multipleChoices[question.answer])"
        rightOrWrong.text = "Your answer was \(userChoice == question.answer ? "correct" : "wrong")."
        if userChoice == question.answer {
            score += 1
        }
        numQuestion += 1

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var questionInput: UILabel!
    @IBOutlet weak var correctAnswer: UILabel!
    @IBOutlet weak var rightOrWrong: UILabel!
    
    @IBAction func backToMenu(_ sender: Any) {
        let menu = storyboard?.instantiateViewController(withIdentifier: "menu") as! ViewController
        menu.modalPresentationStyle = .fullScreen
        self.present(menu, animated: true, completion: nil)
        score = 0
        numQuestion = 0
    }
    
    @IBAction func nextQuestion(_ sender: Any) {
        if numQuestion < questions.count {
            let tableControl = storyboard?.instantiateViewController(withIdentifier: "Question") as! QuestionViewController
            tableControl.questions = questions
            self.present(tableControl, animated: true, completion: nil)
        } else {
            let finishVC = storyboard?.instantiateViewController(withIdentifier: "finish") as! FinishViewController
            finishVC.questions = questions
            finishVC.modalPresentationStyle = .fullScreen
            self.present(finishVC, animated: true, completion: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
