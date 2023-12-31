//
//  NumberViewController.swift
//  SeSACUnSplashProject
//
//  Created by 선상혁 on 2023/09/18.
//

import UIKit

class NumberViewModel {
    
    var number: Observable<String?> = Observable("1000") // numberTextField
    var result = Observable("1,327,000") // resultLabel
    
    func convertNumber() {
        
        // 빈 값, 문자열, 백만원 내에서 가능
        guard let text = number.value else {
            result.value = "값을 입력해주세요"
            return
        }
        
        guard let textTonumber = Int(text) else {
            result.value = "100만원 이하의 숫자를 입력해주세요"
            return
        }
        
        guard textTonumber > 0, textTonumber <= 1000000 else {
            result.value = "환전 범주는 100만원 이하입니다"
            return
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        let decimalNumber = numberFormatter.string(for: textTonumber * 1327)!
        
        result.value = "환전 금액은 \(decimalNumber)입니다."
    }
}

class NumberViewController: UIViewController {
    
    @IBOutlet var numberTextField: UITextField!
    
    @IBOutlet var resultLabel: UILabel!
    
    let viewModel = NumberViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindData()
        numberTextField.addTarget(self, action: #selector(numberTextFieldChanged), for: .editingChanged)
    }
    
    func bindData() {
        viewModel.number.bind { number in
            self.numberTextField.text = number
        }
        
        viewModel.result.bind { value in
            self.resultLabel.text = value
        }
    }
    
    @objc func numberTextFieldChanged() {
        viewModel.number.value = numberTextField.text
        viewModel.convertNumber()
    }

   
}
