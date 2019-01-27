//
//  PhotosMapper.swift
//  Look!Image
//
//  Created by Catherine Korovkina on 23/1/2562 BE.
//  Copyright © 2562 snm. All rights reserved.
//

import Foundation
import SwiftyXMLParser

protocol PhotosMapper {
    func map(photosData: Data) -> [ShortPhoto]
    func map(photoData: Data) -> Photo

}

class PhotosMapperImplementation: PhotosMapper {
    
    func map(photosData: Data) -> [ShortPhoto] {
        let xml = XML.parse(photosData)
        let photosIterator = xml["rsp", "photos", "photo"].makeIterator()
        var photos = [ShortPhoto]()
        
        for next in photosIterator {
            let photo = Photo(id: next.attributes["id"] ?? "",
                              title: next.attributes["title"] ?? "")
            photos.append(photo)
        }
        
        return photos
    }
    
    func map(photoData: Data) -> Photo {
        let xml = XML.parse(photoData)
        let id = xml["rsp", "photo"].attributes["id"] ?? ""
        let farm = xml["rsp", "photo"].attributes["farm"] ?? ""
        let server = xml["rsp", "photo"].attributes["server"] ?? ""
        let secret = xml["rsp", "photo"].attributes["secret"] ?? ""
        let format = xml["rsp", "photo"].attributes["format"] ?? "jpg"

        let name = xml["rsp", "photo", "title"].text ?? ""
        let description = xml["rsp", "photo", "description"].text ?? ""
        let url = xml["rsp", "photo", "urls", "url"].text ?? ""
        let tagsIterator = xml["rsp", "photo", "tags", "tag"].makeIterator()
        var tags = [String]()
        for nextTag in tagsIterator {
            tags.append(nextTag.text ?? "")
        }
        let photo = Photo(id: id,
                          secret: secret,
                          format: format,
                          farm: farm,
                          server: server,
                          title: name,
                          tags: tags,
                          description: description,
                          url: "https://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg"

                          )
        
        return photo
    }
}
