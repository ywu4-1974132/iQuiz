//
//  tedSubject.swift
//  iQuiz
//
//  Created by Sky Wu on 5/18/22.
//

import Foundation

class tedSubject {
    var title: String
    var desc: String
    var questions: [Questions]
    init(title: String, desc: String, questions: [Questions]) {
        self.title = title
        self.desc = desc
        self.questions = questions
    }
}
    let tedSubjects: [tedSubject] = [
        tedSubject(title: "Science!", desc: "Because SCIENCE!", questions: [Questions(question: "What is fire?", answer: "1", multipleChoices: [
                "One of the four classical elements",
                "A magical reaction given to us by God",
                "A band that hasn't yet been discovered",
                "Fire! Fire! Fire! heh-heh"
        ])]),
        tedSubject(title: "Marvel Super Heroes", desc: "Avengers, Assemble!", questions: [Questions(question: "Who is Iron Man?", answer: "1", multipleChoices: [
                "Tony Stark",
                "Obadiah Stane",
                "A rock hit by Megadeth",
                "Nobody knows"
                ]),
            Questions(question: "Who founded the X-Men?", answer: "2", multipleChoices: [
                "Tony Stark",
                "Professor X",
                "The X-Institute",
                "Erik Lensherr"
                ]),
            Questions(question: "How did Spider-Man get his powers?", answer: "1", multipleChoices: [
                "He was bitten by a radioactive spider",
                "He ate a radioactive spider",
                "He is a radioactive spider",
                "He looked at a radioactive spider"
                ])
        ]),
        tedSubject(title: "Mathematics", desc: "Did you pass the third grade?", questions: [Questions(question: "What is 2+2?", answer: "1", multipleChoices: [
                "4",
                "22",
                "An irrational number",
                "Nobody knows"
          ])])
    ]

