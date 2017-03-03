//
//  tableCell.swift
//  GithubDemo
//
//  Created by Jose Guerrero on 2/15/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class tableCell: UITableViewCell {

    
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var forkCountLabel: UILabel!
    @IBOutlet private weak var starCountLabel: UILabel!
    @IBOutlet private weak var ownerLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var repoImage: UIImageView!
    
    var repo: GithubRepo! { // upon update, also update the cell's labels with new info.
        didSet{
            descriptionLabel.text = repo.repoDescription
            forkCountLabel.text = "\(repo.forks!)"
            starCountLabel.text = "\(repo.stars!)"
            ownerLabel.text = repo.ownerHandle
            titleLabel.text = repo.name
            repoImage.setImageWith(URL(string: repo.ownerAvatarURL!)!)
        }
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
