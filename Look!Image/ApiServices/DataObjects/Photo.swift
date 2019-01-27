//
//  Photo.swift
//  Look!Image
//
//  Created by Catherine Korovkina on 23/1/2562 BE.
//  Copyright © 2562 snm. All rights reserved.
//

import Foundation


protocol ShortPhoto {
    var id: String { get }
    var title: String { get }
}

struct Photo: ShortPhoto {
    var id: String
    var secret: String = ""
    var format: String = ""
    var farm: String = ""
    var server: String = ""
    var title: String = ""
    var tags: [String] = []
    var description: String = ""
//    var date: Date
    var url: String = ""
    var flickrPageUrl: String = ""
    
    init(id: String, title: String) {
        self.id = id
        self.title = title
    }
    
    init(id: String,
         secret: String,
         format: String,
         farm: String,
         server: String,
         title: String,
         tags: [String],
         description: String,
         url: String,
         flickrPageUrl: String) {
        self.id = id
        self.server = server
        self.format = format
        self.secret = secret
        self.tags = tags
        self.description = description
        self.title = title
        self.farm = farm
        self.url = url
        self.flickrPageUrl = flickrPageUrl
    }
    
}
