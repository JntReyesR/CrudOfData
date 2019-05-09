//
//  MermaidModel.swift
//  AnimalDataBase
//
//  Created by Jeanette Reyes on 4/30/19.
//  Copyright © 2019 Jeanette. All rights reserved.
//

class MermaidModel{
    var id: String?
    var name: String?
    var typeWater: String?
    var characteristics: String?
    
    init(id: String?, name: String?, typeWater: String?, characteristics: String?) {
        self.id = id
        self.name = name
        self.typeWater = typeWater
        self.characteristics = characteristics
    }
}
