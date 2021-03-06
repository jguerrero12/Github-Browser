//
//  SearchSettingsViewController.swift
//  Github Browser
//
//  Created by Jose Guerrero on 3/1/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

enum PrefRowIdentifier : String { // will be used to identify a cell row, and initialize it's title to the string.
    case MinStars = "Minimum Stars"
    //case sort..
}

class SearchSettingsViewController: UIViewController,UITableViewDataSource, PreferenceSwitchCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: RepoResultsViewController? // parent, used to pass up settings values.
    
    let tableStructure: [[PrefRowIdentifier]] = [[.MinStars]]// ,[sort]], this will hold the structure of the tableview (groups and rows) and identify the corresponding cells.
    
    var prefValues: [PrefRowIdentifier: Int] = [:] // this will hold the cell's values
    
    // should be set by the class that instantiates this view controller
    var settings: GithubRepoSearchSettings!{
        didSet {
            prefValues[.MinStars] = settings.minStars
            //prefValues[.Languages] = settings.languages
            tableView?.reloadData()
        }
    }
    
    private func settingsFromTableData() -> GithubRepoSearchSettings {
        var set = GithubRepoSearchSettings()
        set.minStars = prefValues[.MinStars] ?? set.minStars
        return set
    }
    
    override func viewDidLoad() {
        // when view appears, do this:
        super.viewDidLoad()
        settings = settings ?? GithubRepoSearchSettings()
        tableView.dataSource = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return tableStructure.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return " "
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableStructure[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "minStarCell") as! PreferenceSwitchCell
        let prefIdentifier = tableStructure[indexPath.section][indexPath.row]
        cell.prefRowIdentifier = prefIdentifier
        cell.starSlider.setValue(Float(prefValues[prefIdentifier]!), animated: true)
        let value = prefValues[prefIdentifier]!
        cell.countLabel.text = "\(value)"
        cell.delegate = self
        return cell
    }
    
    func preferenceSliderCellDidChange(cell: PreferenceSwitchCell, newValue: Float) {
        prefValues[cell.prefRowIdentifier] = Int.init(newValue)
        settings = settingsFromTableData()
        tableView.reloadData()
    }
    
    /*func preferenceSwitchCellDidToggle(cell: PreferenceSwitchCell, newValue: Bool) {
        prefValues[cell.prefRowIdentifier] = newValue
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction private func onSave(_ sender: Any) {
        delegate?.didSaveSettings(settings: settings)
        self.dismiss(animated: true) {
        }
    }
    
    @IBAction private func onCancel(_ sender: Any) {
        delegate?.didCancelSettings()
        self.dismiss(animated: true) {
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

protocol SettingsPresentingViewControllerDelegate: class {
    func didSaveSettings(settings: GithubRepoSearchSettings)
    func didCancelSettings()
}
