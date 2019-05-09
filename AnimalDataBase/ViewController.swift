//
//  ViewController.swift
//  AnimalDataBase
//
//  Created by LABMAC06 on 05/04/19.
//  Copyright © 2019 Jeanette. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var refAnimals: DatabaseReference!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtKind: UITextField!
    @IBOutlet weak var txtClassification: UITextField!
    @IBOutlet weak var txtLessons: UITextField!
    @IBOutlet weak var txtCharacteristics: UITextField!
    
    @IBOutlet weak var tblAnimals: UITableView!
    
    var animalsList = [AnimalModel]()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let animal = animalsList[indexPath.row]
        let alertController = UIAlertController(title: animal.name, message: "Give new values to update animal", preferredStyle: .alert)
        
        let updateAction = UIAlertAction(title: "Update", style: .default){(_) in
            let id = animal.id
            let name = alertController.textFields?[0].text
            let kind = alertController.textFields?[1].text
            let classification = alertController.textFields?[2].text
            let lessons = alertController.textFields?[3].text
            let characteristics = alertController.textFields?[4].text
            
            self.updateAnimal(id: id!,
                              name: name!,
                              kind: kind!,
                              classification: classification!,
                              lessons: lessons!,
                              characteristics: characteristics!)
        }
        
        let deleteAction = UIAlertAction(title: "Delete", style: .default){(_) in
            self.deleteAnimal(id: animal.id!)
        }
        
        alertController.addTextField{(textField) in
            textField.text = animal.name
        }
        alertController.addTextField{(textField) in
            textField.text = animal.kind
        }
        alertController.addTextField{(textField) in
            textField.text = animal.classification
        }
        alertController.addTextField{(textField) in
            textField.text = animal.lessons
        }
        alertController.addTextField{(textField) in
            textField.text = animal.characteristics
        }
        alertController.addAction(updateAction)
        alertController.addAction(deleteAction)
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func updateAnimal(id: String, name: String, kind: String, classification: String, lessons: String, characteristics: String){
        let animal = [
            "id": id,
            "Name": name,
            "Kind": kind,
            "Classification": classification,
            "Lessons": lessons,
            "Characteristics": characteristics
        ]
        refAnimals.child(id).setValue(animal)
        
        clean()
    }
    
    func deleteAnimal(id: String){
        refAnimals.child(id).setValue(nil)
        tblAnimals.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animalsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellAnimals", for: indexPath) as! TVCAnimals
        
        let animal: AnimalModel
        
        animal = animalsList[indexPath.row]
        
        cell.lblName.text = animal.name
        cell.lblKind.text = animal.kind
        cell.lblClassification.text = animal.classification
        cell.lblLessons.text = animal.lessons
        cell.lblCharacteristics.text = animal.characteristics
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        refAnimals = Database.database().reference().child("animals")
        
        refAnimals.observe(DataEventType.value, with: {(snapshot) in
            if snapshot.childrenCount>0{
                self.animalsList.removeAll()
                for animals in snapshot.children.allObjects as![DataSnapshot]{
                    let animalObject = animals.value as? [String: AnyObject]
                    let animalName = animalObject?["Name"]
                    let animalKind = animalObject?["Kind"]
                    let animalClassification = animalObject?["Classification"]
                    let animalLessons = animalObject?["Lessons"]
                    let animalCharacteristics = animalObject?["Characteristics"]
                    let animalId = animalObject?["id"]
                    
                    let animal = AnimalModel(id: animalId as! String?, name: animalName as! String?, kind: animalKind as! String?,classification: animalClassification as! String?, lessons: animalLessons as! String?, characteristics: animalCharacteristics as! String?)
                    
                    self.animalsList.append(animal)
                }
                self.tblAnimals.reloadData()
            }
        })
    }
    
    func addAnimal() {
        let key = refAnimals.childByAutoId().key
        let animal = ["id":key,
                      "Name":txtName.text! as String,
                      "Kind":txtKind.text! as String,
                      "Classification":txtClassification.text! as String,
                      "Lessons":txtLessons.text! as String,
                      "Characteristics":txtCharacteristics.text! as String]
        refAnimals.child(key!).setValue(animal)
        
        clean()
    }

    func clean(){
        txtName.text! = ""
        txtKind.text! = ""
        txtClassification.text! = ""
        txtLessons.text! = ""
        txtCharacteristics.text! = ""
    }
    
    @IBAction func btnAddAnimal(_ sender: UIButton) {
        addAnimal()
    }
    

}

