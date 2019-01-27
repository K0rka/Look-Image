//
//  PhotoDetailController.swift
//  Look!Image
//
//  Created by Catherine Korovkina on 25/1/2562 BE.
//  Copyright © 2562 snm. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoDetailController: UIViewController, UIScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let photoToShow = photoToShow {
            display(photo: photoToShow)
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textsContainer: UIView!

    var photoToShow: Photo?
    
    
    
    func display(photo: Photo) {
        photoImageView.sd_setImage(with: URL(string: photo.url), completed: nil)
        titleLabel.text = photo.title
        descriptionLabel.text = photo.description
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.scrollIndicatorInsets = view.safeAreaInsets
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: view.safeAreaInsets.bottom, right: 0)
    }
    
    //MARK: - Scroll View Delegate
    
    private var previousStatusBarHidden = false
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if previousStatusBarHidden != shouldHideStatusBar {
            
            UIView.animate(withDuration: 0.2, animations: {
                self.setNeedsStatusBarAppearanceUpdate()
            })
            
            previousStatusBarHidden = shouldHideStatusBar
        }
    }
    
    //MARK: - Status Bar Appearance
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return shouldHideStatusBar
    }
    
    private var shouldHideStatusBar: Bool {
        let frame = textsContainer.convert(textsContainer.bounds, to: nil)
        return frame.minY < view.safeAreaInsets.top
    }
}
