//
//  HeroTableViewCell.swift
//  HeroisMarvel
//
//  Created by Lucas Santana Brito on 11/01/20.
//  Copyright © 2020 lsb.br. All rights reserved.
//

import UIKit
import Kingfisher

class HeroTableViewCell: UITableViewCell {

    @IBOutlet weak var thubImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func prepareCell(with hero: MarvelHero) {
        nameLabel.text = hero.name
        descriptionLabel.text = hero.description
        if let url = URL(string: hero.thumbnail.url) {
            thubImageView.kf.indicatorType = .activity
            thubImageView.kf.setImage(with: url)
        } else {
            thubImageView.image = nil
        }
        
        thubImageView.layer.cornerRadius = thubImageView.frame.height/2
        thubImageView.layer.borderColor = UIColor.red.cgColor
        thubImageView.layer.borderWidth = 2
        
    }

}
