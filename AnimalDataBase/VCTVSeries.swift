//
//  VCTVSeries.swift
//  AnimalDataBase
//
//  Created by Jeanette Reyes on 4/30/19.
//  Copyright © 2019 Jeanette. All rights reserved.
//

import UIKit
import FirebaseDatabase

class VCTVSeries: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var refTVSeries: DatabaseReference!
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtCreator: UITextField!
    @IBOutlet weak var txtProtagonists: UITextField!
    
    
    @IBOutlet weak var tblTVSeries: UITableView!
    
    var tVSeriesList = [TVSeriesModel]()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tVSeries = tVSeriesList[indexPath.row]
        let alertController = UIAlertController(title: tVSeries.title, message: "Give new values to update TVSeries", preferredStyle: .alert)
        
        let updateAction = UIAlertAction(title: "Update", style: .default){(_) in
            let id = tVSeries.id
            let title = alertController.textFields?[0].text
            let gender = alertController.textFields?[1].text
            let creator = alertController.textFields?[2].text
            let protagonists = alertController.textFields?[3].text
            
            self.updateTVSeries(id: id!,
                              title: title!,
                              gender: gender!,
                              creator: creator!,
                              protagonists: protagonists!)
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: .default){(_) in
            self.deleteTVSeries(id: tVSeries.id!)
        }
        
        alertController.addTextField{(textField) in
            textField.text = tVSeries.title
        }
        alertController.addTextField{(textField) in
            textField.text = tVSeries.gender
        }
        alertController.addTextField{(textField) in
            textField.text = tVSeries.creator
        }
        alertController.addTextField{(textField) in
            textField.text = tVSeries.protagonists
        }
        alertController.addAction(updateAction)
        alertController.addAction(deleteAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func updateTVSeries(id: String, title: String, gender: String, creator: String, protagonists: String){
        let tVSeries = [
            "id": id,
            "Title": title,
            "Gender": gender,
            "Creator": creator,
            "Protagonists": protagonists
        ]
        refTVSeries.child(id).setValue(tVSeries)
        
        clean()
    }
    
    func deleteTVSeries(id: String){
        refTVSeries.child(id).setValue(nil)
        self.tblTVSeries.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tVSeriesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellTvSeries", for: indexPath) as! TVCTVSeries
        
        let tVSeries: TVSeriesModel
        
        tVSeries = tVSeriesList[indexPath.row]
        
        cell.lblTitle.text = tVSeries.title
        cell.lblGender.text = tVSeries.gender
        cell.lblCreator.text = tVSeries.creator
        cell.lblProtagonists.text = tVSeries.protagonists
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refTVSeries = Database.database().reference().child("tVSeries")
        
        refTVSeries.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                self.tVSeriesList.removeAll()
                for tVSeries in snapshot.children.allObjects as![DataSnapshot]{
                    let tVSeriesObject = tVSeries.value as? [String: AnyObject]
                    let tVSeriesTitle = tVSeriesObject?["Title"]
                    let tVSeriesGender = tVSeriesObject?["Gender"]
                    let tVSeriesCreator = tVSeriesObject?["Creator"]
                    let tVSeriesProtagonists = tVSeriesObject?["Protagonists"]
                    let tVSeriesId = tVSeriesObject?["id"]
                    
                    let tVSeries = TVSeriesModel(id: tVSeriesId as! String?, title: tVSeriesTitle as! String?, gender: tVSeriesGender as! String?,creator: tVSeriesCreator as! String?, protagonists: tVSeriesProtagonists as! String?)
                    
                    self.tVSeriesList.append(tVSeries)
                }
                self.tblTVSeries.reloadData()
            }
        })
    }
    
    func addTVSeries() {
        let key = refTVSeries.childByAutoId().key
        let tVSeries = ["id":key,
                      "Title":txtTitle.text! as String,
                      "Gender":txtGender.text! as String,
                      "Creator":txtCreator.text! as String,
                      "Protagonists":txtProtagonists.text! as String]
        refTVSeries.child(key!).setValue(tVSeries)
        
        clean()
    }
    
    func clean(){
        txtTitle.text! = ""
        txtGender.text! = ""
        txtCreator.text! = ""
        txtProtagonists.text! = ""
    }
    
    @IBAction func btnAddTVSeries(_ sender: UIButton) {
        addTVSeries()
    }
    
    
}

