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
        if UserDefaults.standard.string(forKey: "listQuestionURL") == nil {
            UserDefaults.standard.set("https://tednewardsandbox.site44.com/questions.json", forKey: "listQuestionURL")
        }
        setupQuestions()
        quizList.refreshControl = UIRefreshControl()
        self.quizList.addSubview(self.refreshControl)
    }
    
    var tedSubject: [tedSubject] = []
    var fetchedURL = ""
    
    func setupQuestions() {
        var newQuizList : [tedSubject] = []
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentDirectory.appendingPathComponent("questions.json")
        let jsonData = try? Data(contentsOf: archiveURL)
        if jsonData == nil {
            newQuizList = tedSubjects
        } else {
            let result = try? JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
            if let result = result {
                for i in 0..<result.count {
                    let subject = iQuiz.tedSubject(title: (result[i] as AnyObject)["title"] as! String, desc: (result[i] as AnyObject)["desc"] as! String, questions: [])
                    for j in 0..<((result[i] as AnyObject)["questions"] as! Array<Any>).count {
                      let question = Questions(question: (((result[i] as AnyObject)["questions"] as AnyObject)[j] as AnyObject)["question"] as! String, answer: (((result[i] as AnyObject)["questions"] as AnyObject)[j] as AnyObject)["answer"] as! String, multipleChoices: (((result[i] as AnyObject)["questions"] as AnyObject)[j] as AnyObject)["multipleChoices"] as! [String])
                        subject.questions.append(question)
                    }
                    newQuizList.append(subject)
                }
            }
        }
        tedSubject = newQuizList
        self.quizList.reloadData()
    }
    
//    func getURL(_ url: String){
//        fetchedURL = url
//    }
    
    func fetchData(_ url: String) {
        let url = URL(string: url)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if error != nil {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: "Sorry! There is an error!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(_) in
                        self.quizList.refreshControl?.endRefreshing()
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                let alert = UIAlertController(title: "Network Alert", message: "Please check your network", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(_) in
                    self.quizList.refreshControl?.endRefreshing()
                }))
                self.present(alert, animated: true, completion: nil)
                return
            }

            if response == nil {
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: "Sorry! No response!", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(_) in
                        self.quizList.refreshControl?.endRefreshing()
                    }))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
            }

//            if response != nil {
//
//            }
            guard data != nil else {
                return
            }
//            if let urlResponse = data as? HTTPURLResponse {
//                if urlResponse.statusCode != 200 {
//                    DispatchQueue.main.async {
//                        let alert = UIAlertController()
//                    }
//                }
//            }

        }
        task.resume()
    }
    
    @objc private func dataRefresh(_ refreshControl: UIRefreshControl) {
        fetchData((UserDefaults.standard.string(forKey: "listQuestionURL")!))
        refreshControl.endRefreshing()
    }
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ViewController.dataRefresh(_:)), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.tintColor
        return refreshControl
    }()

    @IBOutlet weak var quizList: UITableView!
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tedSubject.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //quizList.register(TableViewCell.self, forCellReuseIdentifier: "quiz")
        let cell = quizList.dequeueReusableCell(withIdentifier: "quiz") as! TableViewCell
        cell.titleLabel.text = tedSubject[indexPath.row].title
        cell.descripLabel.text = tedSubject[indexPath.row].desc
        cell.icon.image = UIImage(named: tedSubject[indexPath.row].title) ?? UIImage(named: "imagePlaceHolder") //有问题！！！
        //cell.configureCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tableControl = storyboard?.instantiateViewController(withIdentifier: "Question") as! QuestionViewController
        //let tableControl = segue.destinationViewController as! QuestionViewController
        tableControl.questions = tedSubject[indexPath.row].questions
        //print(questions[0].question)
        self.present(tableControl, animated: true, completion: nil)
    }
//
//    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//           return nil
//       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    
    @IBAction func settings(_ sender: Any) {
        let alert = UIAlertController(title: "Setting Alert", message: "Please enter URL", preferredStyle: .alert)
        alert.addTextField {
            (text) in text.placeholder = "URL"
            if let url = UserDefaults.standard.string(forKey: "listQuestionURL") {
                text.text = url
            }
        }
        alert.addAction(UIAlertAction(title: "check now", style: .default, handler: {
            [weak alert] (_) in
            let text = alert?.textFields![0]
            if text?.text == "" {
                return
            }
//            guard (URL(string: (text?.text)!) != nil) else {
//                let alert = UIAlertController(title: "Error", message: "Wrong URL", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//                return
//            }
            UserDefaults.standard.set(text?.text, forKey: "listQuestionURL")
            self.fetchData((text?.text)!)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

