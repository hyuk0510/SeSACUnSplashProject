//
//  CalculateViewController.swift
//  SeSACUnSplashProject
//
//  Created by 선상혁 on 2023/09/13.
//

import UIKit

class CalculateViewController: UIViewController {

    @IBOutlet var firstTextField: UITextField!
    @IBOutlet var secondTextField: UITextField!
    
    @IBOutlet var resultLabel: UILabel!

    @IBOutlet var tempLabel: UILabel!
    
    let viewModel = CalculateViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstTextField.addTarget(self, action: #selector(firstTextFieldChanged), for: .editingChanged)
        secondTextField.addTarget(self, action: #selector(secondTextFieldChanged), for: .editingChanged)
        
        viewModel.firstNumber.bind { number in
            self.firstTextField.text = number
            print("firstNumber changed \(number)")
        }
        
        viewModel.secondNumber.bind { number in
            self.secondTextField.text = number
            print("secondNumber changed \(number)")
        }
        
        viewModel.resultText.bind { text in
            self.resultLabel.text = text
        }
        
        viewModel.tempText.bind { text in
            self.tempLabel.text = text
        }
        
    }
    
    @objc func firstTextFieldChanged() {
        viewModel.firstNumber.value = firstTextField.text
        viewModel.calculate()
        viewModel.presentNumberFormat()
    }
    
    @objc func secondTextFieldChanged() {
        viewModel.secondNumber.value = secondTextField.text
        viewModel.calculate()
    }

}

/*
 let person = CustomObservable("선상혁")
 
 person.value = "가나다라"
 
 person.value = "abcd"
 
 person.introduce { value in
     self.view.backgroundColor = [UIColor.orange, UIColor.lightGray, UIColor.magenta].randomElement()!
     self.resultLabel.text = value
 }
             
 DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
     person.value = "바나나"
     print("========1초뒤==========")
 }
 
 DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
     person.value = "키위"
     print("=========3초뒤=========")
 }
 
 firstTextField.text = viewModel.firstNumber.value
 secondTextField.text = viewModel.secondNumber.value
 */
