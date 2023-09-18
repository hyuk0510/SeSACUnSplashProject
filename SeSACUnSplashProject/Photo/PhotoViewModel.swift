//
//  PhotoViewModel.swift
//  SeSACUnSplashProject
//
//  Created by 선상혁 on 2023/09/12.
//

import Foundation
import Kingfisher

class PhotoViewModel {
    
    var list = Observable(Photo(total: 0, total_pages: 0, results: []))
    
    func fetchPhoto(text: String) {
        APIService.shared.searchPhoto(query: text) { photo in
            
            DispatchQueue.main.async {
                guard let photo = photo else { return }
                self.list.value = photo
            }
           
        }
    }
    
    var rowCount: Int {
        return list.value.results.count
    }
    
    func cellForRowAt(at indexPath: IndexPath) -> PhotoResult {
        return list.value.results[indexPath.row]
    }
    
    func imageURL(at indexPath: IndexPath) -> String {
        return cellForRowAt(at: indexPath).urls.full
    }
}
