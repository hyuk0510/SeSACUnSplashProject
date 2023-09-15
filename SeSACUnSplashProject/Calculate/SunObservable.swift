//
//  SunObservable.swift
//  SeSACUnSplashProject
//
//  Created by 선상혁 on 2023/09/13.
//

import Foundation

class CustomObservable<T> {
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value)
            print("사용자의 이름이 \(value)로 변경되었습니다.")
            
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ sample: @escaping (T) -> Void) {
        print("저는 \(value)입니다.")
        sample(value)
        listener = sample
    }
    
}

