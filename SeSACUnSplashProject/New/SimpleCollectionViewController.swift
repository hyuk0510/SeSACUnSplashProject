//
//  SimpleCollectionViewController.swift
//  SeSACUnSplashProject
//
//  Created by 선상혁 on 2023/09/14.
//

import UIKit
import SnapKit

class NewSimpleViewModel {
    let list: Observable<[User]> = Observable([])
    
    let list2 = [User(name: "Sang", age: 27), User(name: "Sang", age: 17), User(name: "Hyuk", age: 7)]
    
    func append() {
        list.value = [User(name: "Sun", age: 27), User(name: "Sun", age: 27), User(name: "Hyuk", age: 7)]
    }
    
    func remove() {
        list.value = []
    }
    
    func removeUser(idx: Int) {
        list.value.remove(at: idx)
    }
    
    func inserUser(name: String) {
        let user = User(name: name, age: Int.random(in: 10...70))
        list.value.insert(user, at: Int.random(in: 0...2))
    }
}

class SimpleCollectionViewController: UIViewController {
    
    enum Section: Int, CaseIterable {
        case first = 0
        case second
    }
    
    var viewModel = NewSimpleViewModel()
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())

    var dataSource: UICollectionViewDiffableDataSource<String, User>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchBar = UISearchBar()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        configureDataSource()
       
        viewModel.list.bind { user in
            self.updateSnapshot()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.viewModel.append()
        }
        
    }
    
    func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<String, User>()
        snapshot.appendSections(["aa", "bb"])
        snapshot.appendItems(viewModel.list.value, toSection: "aa")
        snapshot.appendItems(viewModel.list2, toSection: "bb")
        
        dataSource.apply(snapshot)
    }
    
    static private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false
        configuration.backgroundColor = .systemGreen
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    
    private func configureDataSource() {
        
        //UICollectionView.CellRegistration : ios 14, 메서드 대신 제네릭을 사용, 셀이 생성될 때마다 클로저가 호출
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, User> (handler: { cell, indexPath, itemIdentifier in
            
            //셀 디자인 및 데이터 처리
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.name
            content.textProperties.color = .brown
            content.secondaryText = "\(itemIdentifier.age)"
            content.image = UIImage(systemName: "star.fill")
            content.imageProperties.tintColor = .red
            content.prefersSideBySideTextAndSecondaryText = false
            content.textToSecondaryTextVerticalPadding = 20
            cell.contentConfiguration = content
            
            var backgroundConfig = UIBackgroundConfiguration.listPlainCell()
            backgroundConfig.backgroundColor = .lightGray
            backgroundConfig.cornerRadius = 10
            backgroundConfig.strokeWidth = 2
            backgroundConfig.strokeColor = .systemPink
            cell.backgroundConfiguration = backgroundConfig
        })
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
           
            return cell
        })
    }
}

extension SimpleCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let user = viewModel.list.value[indexPath.item]
        
        guard let user = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        dump(user)
        //viewModel.removeUser(idx: indexPath.item)
    }
}

extension SimpleCollectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.inserUser(name: searchBar.text!)
    }
}

//extension SimpleCollectionViewController: UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return list.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: list[indexPath.row])
//
//        return cell
//    }
//
//
//}
