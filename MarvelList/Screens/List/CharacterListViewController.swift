//
//  ViewController.swift
//  MarvelList
//
//  Created by Süha Karakaya on 11.03.2025.
//

import UIKit
import RxSwift



class CharacterListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var marvelService: MarvelServiceProtocol! = MarvelService()
    let disposeBag = DisposeBag()
    var currentOffset = 0
    
    var tableViewList: [ResultCharacter] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CharTableViewCell", bundle: nil), forCellReuseIdentifier: CharTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        
        getList()
        
        self.navigationController?.navigationBar.isHidden = true
        
        self.navigationController?.navigationBar.tintColor = .red
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButtonItem
        
    }
    
    
    
    func getList() {
        marvelService.fetchCharacters(CharactersRequest(limit: 30, offset: currentOffset), overlayTarget: self.view)
            .subscribe(onNext: { [weak self] response in // burayı sorar mısın doğru bir kullanım var mı?
                self?.tableViewList.append(contentsOf: response.data?.results ?? [])
                self?.tableView.reloadData()
                self?.currentOffset = self?.tableViewList.count ?? 0
            }, onError: { error in
                print("Hata: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }

}

extension CharacterListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CharTableViewCell = tableView.dequeueReusableCell(withIdentifier: CharTableViewCell.identifier) as! CharTableViewCell
        let characterItem = tableViewList[indexPath.row]
        cell.configureView(data: characterItem, service: marvelService, db: disposeBag)

        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = tableViewList.count - 1
        if indexPath.row == lastElement {
            getList()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "DetailCharacter", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "DetailCharacterViewController") as! DetailCharacterViewController
        nextViewController.segueData = tableViewList[indexPath.row]
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}


