//
//  AnimalModel.swift
//  AnimalDataBase
//
//  Created by Jeanette Reyes on 4/29/19.
//  Copyright © 2019 Jeanette. All rights reserved.
//

class AnimalModel{
    var id: String?
    var name: String?
    var kind: String?
    var classification: String?
    var lessons: String?
    var characteristics: String?
    
    init(id: String?, name: String?, kind: String?, classification: String?, lessons: String?, characteristics: String?) {
        self.id = id
        self.name = name
        self.kind = kind
        self.classification = classification
        self.lessons = lessons
        self.characteristics = characteristics
    }
}
