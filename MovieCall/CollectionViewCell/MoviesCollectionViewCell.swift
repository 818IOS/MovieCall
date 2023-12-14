//
//  MoviesCollectionViewCell.swift
//  MovieCall
//
//  Created by Juanito Martinon on 9/27/23.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var moivePosterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    var colorArray = [UIColor]()

    override init(frame: CGRect) {
         super.init(frame: frame)
         // Set the background color of the cell's contentView (only in the initialization)
         //self.contentView.backgroundColor = nil// Change this to your desired color
     }
     
     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         
         // Set the background color of the cell's contentView (only in the initialization)
        // self.contentView.backgroundColor = nil// Change this to your desired color
     }
   
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        
        //moivePosterImage.layer.cornerRadius = 100
        //moivePosterImage.layer.borderWidth = 1
        //moivePosterImage.layer.masksToBounds = true
        //moivePosterImage.clipsToBounds = true
    }
 
    
    override func prepareForReuse() {
      
        self.contentView.backgroundColor = nil
        //moivePosterImage.image = nil
        super.prepareForReuse()
    }
    
}
