//
//  DetailTableView.swift
//  AiviaProdTest
//
//  Created by Adam on 2020-01-19.
//  Copyright © 2020 Adam. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {

    var heroData: HeroData! //This property is given it's value from the previous view controller

    override func viewDidLoad() {
        super.viewDidLoad()
        
                
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows

        return 5
    }



    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "heroDescriptionCell", for: indexPath) as! HeroDescriptionCell
        
        cell.valueLabel.adjustsFontSizeToFitWidth = true
        //Simple switch that determines what information to put in the cell based on index position
        switch indexPath.row {
        case 0:
            cell.categoryLabel!.text = "Name"
            cell.valueLabel!.text = heroData.name
        case 1:
            cell.categoryLabel?.text = "Secret Identity"
            cell.valueLabel?.text = heroData.identity
        case 2:
            cell.categoryLabel?.text = "Group Alliance"
            cell.valueLabel?.text = heroData.group
        case 3:
            cell.categoryLabel?.text = "Place of Origin"
            cell.valueLabel?.text = heroData.place_of_origin
        case 4:
            cell.categoryLabel?.text = "Company"
            cell.valueLabel?.text = heroData.publisher?.capitalized
        default: break
        }
        
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
