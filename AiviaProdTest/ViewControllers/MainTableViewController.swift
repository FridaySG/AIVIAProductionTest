//
//  MainTableViewController.swift
//  AiviaProdTest
//
//  Created by Adam on 2020-01-19.
//  Copyright © 2020 Adam. All rights reserved.
//

import UIKit

class MainTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var retrievedData: HeroObject?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortSegment: UISegmentedControl!
    @IBOutlet weak var rainbowSwitch: UISwitch!
    @IBOutlet weak var valentinesSwitch: UISwitch!
    
    var rainbowMode = false //Rainbow mode and valentine mode, set to false for application start
    var valentinesMode = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self //Assign tableview delegate and datasource to this class
        
        retrieveData() //Call the retrieveData() function and started building the table
        
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    @IBAction func didToggleSegment(_ sender: AnyObject?){
        //This function resorts the data based on user preference and calls tableView.reloadData() to rebuild the table
        if sortSegment.selectedSegmentIndex == 0 {
            self.retrievedData!.data.sort { $0.name!.lowercased() < $1.name!.lowercased() }
        }
        else{
            self.retrievedData!.data.sort { $0.name!.lowercased() > $1.name!.lowercased() }
        }
        
        self.tableView.reloadData()
    }
    
    @IBAction func rainbowSwitch(_ sender: AnyObject){
        //This particluar function activate/deactivate the rainbow colour mode on the table
        if rainbowMode{
            rainbowMode = false
            for index in 0...retrievedData!.data.count{
                let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
                cell?.backgroundColor = UIColor.white
            }
        }
        else{
            rainbowMode = true
            let colors = [UIColor.green, UIColor.red, UIColor.blue, UIColor.yellow, UIColor.orange, UIColor.purple, UIColor.magenta, UIColor.systemTeal]
            
            for index in 0...retrievedData!.data.count{
                let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
                let randomNumber = Int.random(in: 0...7)
                cell?.backgroundColor = colors[randomNumber] //Select a random color from the array of colors of above
            }
        }
        
    }
    
    @IBAction func valentinesSwitch(_ sender: AnyObject){
                
        //This function activates/deactivates the valentine colour mode
        if valentinesMode{
            valentinesMode = false
            for index in 0...retrievedData!.data.count{
                let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
                cell?.backgroundColor = UIColor.white
            }
        }
        else{
            valentinesMode = true
            for index in 0...retrievedData!.data.count{
                let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
                if index % 2 == 0 { //Check if number is even or odd, used for alternating pink/red pattern
                    cell?.backgroundColor = UIColor.red
                }
                else{
                    cell?.backgroundColor = UIColor.systemPink
                }
            }
        }
        

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if retrievedData?.data.count == 0{
            return 0
        }
        
        
        return retrievedData?.data.count ?? 0
    }
    
    func errorAlert(){
        let alertController = UIAlertController(title: "Network Error", message:
            "Sorry, it looks like something went wrong. Please check your network and try again.!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

        self.present(alertController, animated: true, completion: nil)
    }
    
    func retrieveData(){
        //This function retrieves data from the API and stores it in an object named "HeroObject"
        //The data is directly parsed from the JSON response
        
        let session = URLSession.shared
        let url = URL(string: "https://ios-prod.aivia.dev/api/production/heros")!
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            if data != nil{
                                
                do {
                    self.retrievedData = try JSONDecoder().decode(HeroObject.self, from: (data!)) //Decode into HeroObject
                    self.retrievedData!.data.sort { $0.name!.lowercased() < $1.name!.lowercased() } //Sort by ascending
                } catch {
                    self.errorAlert() //Show alert if there is an error
                }

                DispatchQueue.main.async { //Reload data. This must be done on the main thread.
                    self.tableView.reloadData()
                }
            }
            else if error != nil{
                self.errorAlert()
            }
            
        })
        
        task.resume()
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath)
        cell.textLabel?.text = retrievedData?.data[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailTableView = storyboard?.instantiateViewController(withIdentifier: "DetailTableViewController") as! DetailTableViewController
        detailTableView.heroData = retrievedData?.data[indexPath.row] //Store data in the DetailTableViewController's retrievedData property
        self.show(detailTableView, sender: self)
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
