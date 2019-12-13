//
//  ViewController.swift
//  JeopardyTrainer
//
//  Created by Kim-An Quinn on 12/13/19.
//  Copyright © 2019 Kim-An Quinn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var category0Label: UILabel!
    @IBOutlet var category0Buttons: [UIButton]!
    @IBOutlet weak var totalQuestionsLabel: UILabel!
    @IBOutlet weak var answeredCorrectlyLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var categories: Categories!
    var currentCategories = Categories()
    var clues = Clues()
    var clueNumberToShow = 0
    var selectedCategoryNumber = 0
    var totalQuestionsSeen = 0
    var answersCorrect = 0 {
        didSet{
            answeredCorrectlyLabel.text = "\(answersCorrect)"
        }
    }
    var score = 0{
        didSet{
            if score < 0 {
                scoreLabel.textColor = .red
            }else{
                scoreLabel.textColor = .systemBlue
            }
            scoreLabel.text = "$\(score)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categories = Categories()
        
        loadCategories()
    }
    
    func loadCategories(){
        categories.categoryArray = []
        currentCategories.categoryArray.removeAll()
        categories.getData {
            self.currentCategories.categoryArray.append(self.categories.categoryArray.randomElement()!)
            self.category0Label.text = self.currentCategories.categoryArray[0].title
            
            self.loadClues()
        }
    }
    
    func loadClues(){
        
        for button in category0Buttons{
            button.isEnabled = true
            button.backgroundColor = .systemBlue
        }
        
        self.clues.clueArray = []
        self.clues.id = self.currentCategories.categoryArray[0].id
        self.clues.getData {
            for i in 0..<self.category0Buttons.count{
                self.category0Buttons[i].setTitle("$\(self.clues.clueArray[i].value)", for: .normal)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PresentQuestion"{
            let destination = segue.destination as! QuestionsViewController
            destination.clue = clues.clueArray[clueNumberToShow]
            destination.categoryTitle = self.currentCategories.categoryArray[selectedCategoryNumber].title
        }
    }
    

    @IBAction func segueAfterYesPressed(segue: UIStoryboardSegue){
        answersCorrect += 1
        score = score + clues.clueArray[clueNumberToShow].value
        
    }
    
    @IBAction func segueAfterNoPressed(segue: UIStoryboardSegue){
        score = score - clues.clueArray[clueNumberToShow].value
    }
    

    @IBAction func loadButtonPressed(_ sender: UIBarButtonItem) {
        loadCategories()
    }
    
    @IBAction func category0ButtonPressed(_ sender: UIButton) {
        // if you have multiple rows of buttons for different categories
        // you can create a category1buttonpressed, category2buttonpressed... and
        // set selectedcategorynumber to 1,2, etc.
        selectedCategoryNumber = 0
        clueNumberToShow = sender.tag
        totalQuestionsSeen += 1
        totalQuestionsLabel.text = "\(totalQuestionsSeen)"
        sender.isEnabled = false
        sender.backgroundColor = .lightGray
        sender.setTitle("", for: .normal)
        performSegue(withIdentifier: "PresentQuestion", sender: sender)
    }
    
}

