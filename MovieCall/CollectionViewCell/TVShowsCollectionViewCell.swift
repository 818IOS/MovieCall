//
//  TVShowsCollectionViewCell.swift
//  MovieCall
//
//  Created by Juanito Martinon on 10/5/23.
//

import UIKit

class TVShowsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var tvImage: UIImageView!
    @IBOutlet weak var tvTitle: UILabel!
    
    
    override init(frame: CGRect) {
         super.init(frame: frame)
     }
     
     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
   
     }
   
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()

    }
 
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
