//
//  PhotoCell.swift
//  Look!Image
//
//  Created by Catherine Korovkina on 25/1/2562 BE.
//  Copyright © 2562 snm. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
        titleLabel.text = nil
    }
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    func configure(with photo: Photo) {
        if let url = URL(string: photo.url) {
        photoImageView.sd_setImage(with: url, completed: nil)
        }
        titleLabel.text = photo.title
    }

}
