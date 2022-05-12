//
//  ViewController.swift
//  iQuiz
//
//  Created by Sky Wu on 5/10/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        quizList.delegate = self
        quizList.dataSource = self
        
    }

    @IBOutlet weak var quizList: UITableView!
    
    
    let quizs: [quiz] = [quiz("Mathematics",descriptions: "Abstract science of number, quantity, and space."), quiz("Marvel Super Heroes", descriptions: "Multiple choices realted to heros in Marvel."), quiz("Science", descriptions: "Study of physical and natural world.")]
    let images: [String] = ["math", "hero", "science"]
    
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

