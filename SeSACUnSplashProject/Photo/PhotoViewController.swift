//
//  PhotoViewController.swift
//  SeSACUnSplashProject
//
//  Created by 선상혁 on 2023/09/12.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var viewModel = PhotoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "PhotoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PhotoTableViewCell")
        
        tableView.rowHeight = 200
        
        viewModel.fetchPhoto()
        
        viewModel.list.bind { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension PhotoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell") as? PhotoTableViewCell else { return UITableViewCell() }
        
        let data = viewModel.cellForRowAt(at: indexPath)
        let url = URL(string: viewModel.imageURL(at: indexPath))
        cell.cellImageView.kf.setImage(with: url)
        cell.backgroundColor = .lightGray
        return cell
    }
    
    
}
