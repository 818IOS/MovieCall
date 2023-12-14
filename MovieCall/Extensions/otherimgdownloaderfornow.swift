//
//  otherimgdownloaderfornow.swift
//  MovieCall
//
//  Created by Juanito Martinon on 9/28/23.
//

import Foundation
import UIKit



var imageCachez = NSCache<AnyObject, AnyObject>()
// MARK: USE UICOLOR(PATTERN IMAGE) MAYBE

extension UIImageView {
  
    func loadz(urlString: String) {

        // acts as a placeholder if image is not therespider
        self.image = UIImage(systemName: "photo.fill")
        
        if let imgz = imageCache.object(forKey: urlString as NSString)  {
            self.image = imgz as? UIImage
            return
        }
        
        guard let baseUrl = URL(string: "https://image.tmdb.org/t/p/w500/\(urlString)") else {
            return
        }
        
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: baseUrl) {
                if let someimg = UIImage(data: data) {
                    DispatchQueue.main.async {
                        imageCache.setObject(someimg, forKey: urlString as NSString)
                        self.image = someimg
                        someimg.getColors { colors in
                            
                        }
                    }
                }
            }
        }
    }
}
