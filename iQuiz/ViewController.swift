//
//  ViewController.swift
//  iQuiz
//
//  Created by Sky Wu on 5/10/22.
//

import UIKit
var numQuestion = 0
var score = 0



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        quizList.delegate = self
        quizList.dataSource = self
        
    }
    
    let quizs: [quiz] = [quiz("Mathematics",descriptions: "Abstract science of number, quantity, and space."), quiz("Marvel Super Heroes", descriptions: "Multiple choices realted to heros in Marvel."), quiz("Science", descriptions: "Study of physical and natural world.")]
    let images: [String] = ["math", "hero", "science"]

    let questionsAll = [
        "Mathematics": [
            Questions(question: "1 + 1 = ?", answer: 2, multipleChoices: ["0","1","2","3"]),
            Questions(question: "2 - 9 = ?", answer: 2, multipleChoices: ["11","0","-7","-11"])
        ],
        "Marvel Super Heroes": [
            Questions(question: "How many Infinity Stones are there?", answer: 0, multipleChoices: ["6","5","4","3"]),
            Questions(question: "Who rescued Tony Stark and Nebula From space?", answer: 3, multipleChoices: ["Dr. Strange","Spider-Man","Wonda","Captin Marvel"])
        ],
        "Science": [
            Questions(question: "How many bones are in the human body?", answer: 0, multipleChoices: ["206","205","204","203"]),
            Questions(question: "What is the hardest natural substance on Earth?", answer: 1, multipleChoices: ["Iron","Dimond","Silicon","Aluminum"])
        ]
    ]
    

    @IBOutlet weak var quizList: UITableView!
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //quizList.register(TableViewCell.self, forCellReuseIdentifier: "quiz")
        let cell = quizList.dequeueReusableCell(withIdentifier: "quiz") as! TableViewCell
        cell.titleLabel.text = quizs[indexPath.row].subject
        cell.descripLabel.text = quizs[indexPath.row].descrp
        cell.icon.image = UIImage(named: images[indexPath.row])
        //cell.configureCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tableControl = storyboard?.instantiateViewController(withIdentifier: "Question") as! QuestionViewController
        //let tableControl = segue.destinationViewController as! QuestionViewController
        let subject = quizs[indexPath.row].subject
        let questions = (questionsAll[subject]!)
        //print(questions[0].question)
        tableControl.questions = questions
        self.present(tableControl, animated: true, completion: nil)
    }
    
//    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//           return nil
//       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    
    @IBAction func settings(_ sender: Any) {
        let alert = UIAlertController(title: "Setting Alert", message: "Settings go here", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    
}

