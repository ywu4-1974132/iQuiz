//
//  Questions.swift
//  iQuiz
//
//  Created by Sky Wu on 5/17/22.
//

import Foundation

class Questions{
    var question: String
    var answer: Int
    var multipleChoices: Array<String>
    
    init(question: String, answer: Int, multipleChoices: Array<String>){
        self.question = question
        self.answer = answer
        self.multipleChoices = multipleChoices
    }
    
}
