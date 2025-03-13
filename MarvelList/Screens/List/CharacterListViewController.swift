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
        
        setupTableView()
        setupNavigationBar()
        fetchCharacters()
    }
    
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CharTableViewCell", bundle: nil), forCellReuseIdentifier: CharTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.tintColor = UIColor(named: "marvelRed")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    
    private func fetchCharacters() {
        marvelService.fetchCharacters(CharactersRequest(limit: 30, offset: currentOffset), overlayTarget: self.view)
            .subscribe(onNext: { [weak self] response in
                self?.handleCharacterResponse(response)
            }, onError: { error in
                print("Hata: \(error.localizedDescription)")
            })
            .disposed(by: disposeBag)
    }
    
    private func handleCharacterResponse(_ response: MarvelBaseResponse<ResultCharacter>) {
        tableViewList.append(contentsOf: response.data?.results ?? [])
        tableView.reloadData()
        currentOffset = tableViewList.count
    }
    
    
    private func navigateToDetail(with character: ResultCharacter) {
        let storyBoard = UIStoryboard(name: "DetailCharacter", bundle: nil)
        let detailVC = storyBoard.instantiateViewController(withIdentifier: "DetailCharacterViewController") as! DetailCharacterViewController
        detailVC.segueData = character
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}


extension CharacterListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharTableViewCell.identifier, for: indexPath) as! CharTableViewCell
        let characterItem = tableViewList[indexPath.row]
        cell.configureView(data: characterItem, service: marvelService, db: disposeBag)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = tableViewList.count - 1
        if indexPath.row == lastElement {
            fetchCharacters()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCharacter = tableViewList[indexPath.row]
        navigateToDetail(with: selectedCharacter)
    }
}
