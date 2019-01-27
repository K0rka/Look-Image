//
//  PhotoDetailController.swift
//  Look!Image
//
//  Created by Catherine Korovkina on 25/1/2562 BE.
//  Copyright © 2562 snm. All rights reserved.
//

import UIKit
import SDWebImage
import GSImageViewerController

class PhotoDetailController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textsContainer: UIView!
    
    var photoToShow: Photo?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let photoToShow = photoToShow {
            display(photo: photoToShow)
        }
    }
    
    func display(photo: Photo) {
        photoImageView.sd_setImage(with: URL(string: photo.url), completed: nil)
        titleLabel.text = photo.title
        descriptionLabel.text = photo.description
        scrollView.contentSize = CGSize(width: view.frame.width, height: max(view.frame.height, scrollView.contentSize.height))
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.scrollIndicatorInsets = view.safeAreaInsets
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: view.safeAreaInsets.bottom, right: 0)
    }
    
    @IBAction func didTapImage() {
        if let photo = photoToShow, let image = photoImageView.image {
            let imageInfo      = GSImageInfo(image: image, imageMode: .aspectFit, imageHD: URL(string: photo.url))
            let transitionInfo = GSTransitionInfo(fromView: photoImageView)
            let imageViewer    = GSImageViewerController(imageInfo: imageInfo, transitionInfo: transitionInfo)
            present(imageViewer, animated: true, completion: nil)
        }
    }
    
    @IBAction func openOnFlickr(_ sender: Any) {
        if let url = URL(string: photoToShow?.flickrPageUrl ?? "") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
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
        if let textsContainer = textsContainer {
            let frame = textsContainer.convert(textsContainer.bounds, to: nil)
            return frame.minY < view.safeAreaInsets.top
        }
        return false
    }
}
