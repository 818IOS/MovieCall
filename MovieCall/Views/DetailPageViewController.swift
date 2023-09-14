//
//  DetailPageViewController.swift
//  MovieCall
//
//  Created by Juanito Martinon on 9/8/23.
//

import UIKit

class DetailPageViewController: UIViewController {

    var movieTitle = String()
    var imagePath = String()
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.posterImage.layer.cornerRadius = 10
        self.posterImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.posterImage.clipsToBounds = true
        changeText(atitle: movieTitle, imgpath: imagePath)
        print(movieTitle, "inside detail view controller")
        print(imagePath, "image path dc")
        print("detail page")
    }
    
    func changeText(atitle: String, imgpath: String) {
        DispatchQueue.main.async {
          
            self.movieTitleLabel.text = atitle
            self.posterImage.load(urlString: imgpath)
        }
    }
  

}
