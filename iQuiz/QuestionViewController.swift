//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Sky Wu on 5/17/22.
//

import UIKit

class QuestionViewController: UIViewController {

    var questions: [Questions] = []
    var selections: [UIButton] = [UIButton]()
    var userChoice: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //print(questions[numQuestion].question)
        submit.isEnabled = false
        questionL.text = questions[numQuestion].question
        selections = [answer1, answer2, answer3, answer4]
        for i in 0...3 {
            selections[i].setTitle(questions[numQuestion].multipleChoices[i], for: .normal)
        }
    }
    
    @IBOutlet weak var questionL: UILabel!
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    @IBOutlet weak var submit: UIButton!
    
    
    @IBAction func back(_ sender: Any) {
        let menu = storyboard?.instantiateViewController(withIdentifier: "menu") as! ViewController
        menu.modalPresentationStyle = .fullScreen
        self.present(menu, animated: true, completion: nil)
        score = 0
        numQuestion = 0
    }
    
    @IBAction func answerChoose(_ sender: Any) {
        userChoice = selections.firstIndex(of: sender as! UIButton)!
        //print(userChoice)
        submit.isEnabled = true
    }
    
    @IBAction func submitted(_ sender: Any) {
        //print("hello")
        let answer = storyboard?.instantiateViewController(withIdentifier: "Answer") as! AnswerViewController
        //print("12345")
        answer.questions = questions
        answer.userChoice = userChoice
        //print(answer)
        answer.modalPresentationStyle = .fullScreen
        self.present(answer, animated: true, completion: nil)
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
