//
//  FinishViewController.swift
//  iQuiz
//
//  Created by Sky Wu on 5/17/22.
//

import UIKit

class FinishViewController: UIViewController {
    var questions: [Questions] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        finishText.text = "Congradulation! You have completed the quiz!"
        correctScore.text = "You Got \(score)/\(questions.count) Right!"

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var finishText: UILabel!
    
    @IBOutlet weak var correctScore: UILabel!
    
    @IBAction func nextToMenu(_ sender: Any) {
        let menu = storyboard?.instantiateViewController(withIdentifier: "menu") as! ViewController
        menu.modalPresentationStyle = .fullScreen
        self.present(menu, animated: true, completion: nil)
        score = 0
        numQuestion = 0
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
