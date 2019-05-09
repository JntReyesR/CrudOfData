//
//  VCMermaids.swift
//  AnimalDataBase
//
//  Created by Jeanette Reyes on 4/30/19.
//  Copyright © 2019 Jeanette. All rights reserved.
//

import UIKit
import FirebaseDatabase

class VCMermaids: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
        var refMermaids: DatabaseReference!
    

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtTypeWater: UITextField!
    @IBOutlet weak var txtCharacteristics: UITextField!
    
    @IBOutlet weak var tblMermaids: UITableView!
    
    var mermaidsList = [MermaidModel]()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mermaid = mermaidsList[indexPath.row]
        let alertController = UIAlertController(title: mermaid.name, message: "Give new values to update mermaid", preferredStyle: .alert)
        
        let updateAction = UIAlertAction(title: "Update", style: .default){(_) in
            let id = mermaid.id
            let name = alertController.textFields?[0].text
            let typeWater = alertController.textFields?[1].text
            let characteristics = alertController.textFields?[2].text
            
            self.updateMermaid(id: id!,
                              name: name!,
                              typeWater: typeWater!,
                              characteristics: characteristics!)
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: .default){(_) in
            self.deleteMermaid(id: mermaid.id!)
        }
        
        alertController.addTextField{(textField) in
            textField.text = mermaid.name
        }
        alertController.addTextField{(textField) in
            textField.text = mermaid.typeWater
        }
        alertController.addTextField{(textField) in
            textField.text = mermaid.characteristics
        }
        alertController.addAction(updateAction)
        alertController.addAction(deleteAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func updateMermaid(id: String, name: String, typeWater: String, characteristics: String){
        let mermaid = [
            "id": id,
            "Name": name,
            "TypeWater": typeWater,
            "Characteristics": characteristics
        ]
        refMermaids.child(id).setValue(mermaid)
        
        clean()
    }
    
    func deleteMermaid(id: String){
        refMermaids.child(id).setValue(nil)
        tblMermaids.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mermaidsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMermaids", for: indexPath) as! TVCMermaids
        
        let mermaid: MermaidModel
        
        mermaid = mermaidsList[indexPath.row]
        
        cell.lblName.text = mermaid.name
        cell.lblTypeWater.text = mermaid.typeWater
        cell.lblCharacteristics.text = mermaid.characteristics
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refMermaids = Database.database().reference().child("mermaids")
        
        refMermaids.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                self.mermaidsList.removeAll()
                for mermaids in snapshot.children.allObjects as![DataSnapshot]{
                    let mermaidObject = mermaids.value as? [String: AnyObject]
                    let mermaidName = mermaidObject?["Name"]
                    let mermaidTypeWater = mermaidObject?["TypeWater"]
                    let mermaidCharacteristics = mermaidObject?["Characteristics"]
                    let mermaidId = mermaidObject?["id"]
                    
                    let mermaid = MermaidModel(id: mermaidId as! String?, name: mermaidName as! String?, typeWater: mermaidTypeWater as! String?, characteristics: mermaidCharacteristics as! String?)
                    
                    self.mermaidsList.append(mermaid)
                }
                self.tblMermaids.reloadData()
            }
        })
    }
    
    func addMermaid() {
        let key = refMermaids.childByAutoId().key
        let mermaid = ["id":key,
                      "Name":txtName.text! as String,
                      "TypeWater":txtTypeWater.text! as String,
                      "Characteristics":txtCharacteristics.text! as String]
        refMermaids.child(key!).setValue(mermaid)
        
        clean()
    }
    
    func clean(){
        txtName.text! = ""
        txtTypeWater.text! = ""
        txtCharacteristics.text! = ""
    }
    
    @IBAction func btnAddMermaid(_ sender: UIButton) {
        addMermaid()
    }
    
    
}


