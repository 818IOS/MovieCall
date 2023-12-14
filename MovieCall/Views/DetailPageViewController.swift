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
    var backdropimg = String()
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var discriptLabel: UILabel!
    @IBOutlet weak var closingButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // this was to change the look of the image
        self.posterImage.layer.cornerRadius = 10
        self.posterImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.posterImage.clipsToBounds = true
        
        changeText(atitle: movieTitle, imgpath: imagePath, discript: discript, backdrop: backdropimg)
        print(movieTitle, "inside detail view controller")
        print(imagePath, "image path dc")
        print("detail page")
    }
    
    func changeText(atitle: String, imgpath: String, discript: String, backdrop: String) {
        DispatchQueue.main.async {
            
            self.movieTitleLabel.text = atitle
            self.posterImage.loadz(urlString: imgpath)
            let avg = self.posterImage.image?.averageColor
            self.discriptLabel.text = discript
            self.backgroundView.backgroundColor = avg
        }
    }
    
    @IBAction func dismissButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    
}
