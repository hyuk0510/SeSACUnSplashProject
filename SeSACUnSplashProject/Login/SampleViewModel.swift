//
//  SampleViewModel.swift
//  SeSACUnSplashProject
//
//  Created by 선상혁 on 2023/09/12.
//

import Foundation

class SampleViewModel {
    
    var list = [User(name: "Sun", age: 27), User(name: "Sang", age: 17), User(name: "Hyuk", age: 7)]

    var numberOfRowsInSection: Int {
        return list.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> User {
        return list[indexPath.row]
    }
}
