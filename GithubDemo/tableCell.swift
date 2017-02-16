//
//  tableCell.swift
//  GithubDemo
//
//  Created by Jose Guerrero on 2/15/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class tableCell: UITableViewCell {

    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var forkCountLabel: UILabel!
    @IBOutlet weak var starCountLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var repoImage: UIImageView!
    
    var repo: GithubRepo! {
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
