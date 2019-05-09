//
//  TVSeriesModel.swift
//  AnimalDataBase
//
//  Created by Jeanette Reyes on 4/30/19.
//  Copyright © 2019 Jeanette. All rights reserved.
//

class TVSeriesModel{
    var id: String?
    var title: String?
    var gender: String?
    var creator: String?
    var protagonists: String?
    
    init(id: String?, title: String?, gender: String?, creator: String?, protagonists: String?) {
        self.id = id
        self.title = title
        self.gender = gender
        self.creator = creator
        self.protagonists = protagonists
    }
}
