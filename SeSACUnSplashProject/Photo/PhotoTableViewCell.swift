//
//  PhotoTableViewCell.swift
//  SeSACUnSplashProject
//
//  Created by 선상혁 on 2023/09/12.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    
    @IBOutlet var cellImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellImageView.contentMode = .scaleToFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
