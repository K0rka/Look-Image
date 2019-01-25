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
    var title: String
    var tags: [String] = []
    var description: String = ""
//    var date: Date
    var url: String = ""
}
