//
//  PreferenceSwitchCell.swift
//  Github Browser
//
//  Created by Jose Guerrero on 3/1/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class PreferenceSwitchCell: UITableViewCell {

    weak var delegate: PreferenceSwitchCellDelegate?
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var starSlider: UISlider!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var prefRowIdentifier: PrefRowIdentifier! {
        didSet {
            descriptionLabel?.text = prefRowIdentifier?.rawValue
        }
    }
    
    
    @IBAction func onSliderValueChanged(_ sender: Any) {
        let value = starSlider.value
        delegate?.preferenceSliderCellDidChange(cell: self, newValue: value)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

protocol PreferenceSwitchCellDelegate: class {
    func preferenceSliderCellDidChange(cell: PreferenceSwitchCell, newValue:Float)
}
