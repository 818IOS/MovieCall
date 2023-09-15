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
    var discript = String()
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var discriptLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.posterImage.layer.cornerRadius = 10
        self.posterImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.posterImage.clipsToBounds = true
        changeText(atitle: movieTitle, imgpath: imagePath, discript: discript)
        print(movieTitle, "inside detail view controller")
        print(imagePath, "image path dc")
        print("detail page")
    }
    
    func changeText(atitle: String, imgpath: String, discript: String) {
        DispatchQueue.main.async {
          
            self.movieTitleLabel.text = atitle
            self.posterImage.load(urlString: imgpath)
            self.discriptLabel.text = discript
        }
    }
  

}
