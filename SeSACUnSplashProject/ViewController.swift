//
//  ViewController.swift
//  SeSACUnSplashProject
//
//  Created by 선상혁 on 2023/09/11.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var nicknameTextField: UITextField!
    
    @IBOutlet var changeButton: UIButton!
    
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nicknameTextField.placeholder = "nickname_placeholder".localized
        
//        let value = NSLocalizedString("nickname_result", comment: "")
//        resultLabel.text = String(format: value, "졸리다")
        
        resultLabel.text = "age_result".localized(number: 27)
        
        //cmd ctrl e
        let searchBar = UISearchBar()
        searchBar.text = "ASdf"
        searchBar.placeholder = "zzzz"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function) //Ctrl + Shift + 클릭
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function) //Ctrl + Shift + 클릭
    }

}

