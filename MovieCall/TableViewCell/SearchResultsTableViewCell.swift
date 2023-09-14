//
//  SearchResultsTableViewCell.swift
//  MovieCall
//
//  Created by Juanito Martinon on 8/24/23.
//

import UIKit

class SearchResultsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var posterImages: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
