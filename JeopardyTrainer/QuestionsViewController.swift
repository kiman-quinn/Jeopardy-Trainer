//
//  QuestionsViewController.swift
//  JeopardyTrainer
//
//  Created by Kim-An Quinn on 12/13/19.
//  Copyright © 2019 Kim-An Quinn. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var showAnswerButton: UIButton!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var getItRightLabel: UILabel!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    
    var clue: Clue!
    var categoryTitle: String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if clue == nil{
            questionLabel.text = "Error: clue was nil"
        }
        if categoryTitle == nil{
            questionLabel.text = "Error: categoryTitle was nil"
        }
        
        categoryLabel.text = "Category: \(categoryTitle!)"
        questionLabel.text = clue.question
        answerLabel.text = clue.answer

    }
    
    
    @IBAction func showAnswerButtonPressed(_ sender: UIButton) {
        showAnswerButton.isHidden = true
        answerLabel.isHidden = false
        getItRightLabel.isHidden = false
        yesButton.isHidden = false
        noButton.isHidden = false
        
    }
    
    @IBAction func noButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func yesButtonPressed(_ sender: UIButton) {
    }
    
}
