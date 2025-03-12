//
//  CharTableViewCell.swift
//  MarvelList
//
//  Created by Süha Karakaya on 12.03.2025.
//

import UIKit
import RxSwift

class CharTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: CharTableViewCell.self)
    
    @IBOutlet weak var iv_character: UIImageView!
    @IBOutlet weak var lbl_title: UILabel!
    
    func configureView(data: ResultCharacter?, service: MarvelServiceProtocol, db: DisposeBag) {
        service.loadImage(from: data?.thumbnail?.url ?? "")
                    .observe(on: MainScheduler.instance)
                    .bind(to: iv_character.rx.image)
                    .disposed(by: db)
        lbl_title.text = data?.name
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
