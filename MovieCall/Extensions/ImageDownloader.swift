//
//  ImageDownloader.swift
//  MovieCall
//
//  Created by Juanito Martinon on 9/5/23.
//

import Foundation
import UIKit


var imageCache = NSCache<AnyObject, AnyObject>()
var secondimgcache = NSCache<AnyObject, AnyObject>()
// MARK: USE UICOLOR(PATTERN IMAGE) MAYBE

extension UIImageView {
    
  
  
    func load(urlString: String, contentview: MoviesCollectionViewCell) {

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
                        //contentview.getimageColor(someimg: someimg)
                        self.image = someimg
                        let avg = contentview.moivePosterImage.image?.averageColor
                        contentview.contentView.backgroundColor = avg
                       
                    }
                }
            }
        }
    }
    
    /*
    func loadAgain(urlString: String, contentview: UIView) {
        let dp = DetailPageViewController()
        // acts as a placeholder if image is not therespider
        self.image = UIImage(systemName: "photo.fill")
        
        if let imgz = secondimgcache.object(forKey: urlString as NSString)  {
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
                        secondimgcache.setObject(someimg, forKey: urlString as NSString)
                        //contentview.getimageColor(someimg: someimg)
                        self.image = someimg
                        let avg = dp.posterImage.image?.averageColor
                        contentview.backgroundColor = avg
                    }
                }
            }
        }
    }
    */
    
    
    func tvload(urlString: String, contentview: TVShowsCollectionViewCell) {

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
                        //contentview.getimageColor(someimg: someimg)
                        self.image = someimg
                        let avg = contentview.tvImage.image?.averageColor
                        contentview.contentView.backgroundColor = avg
                       
                    }
                }
            }
        }
    }
}






extension UIImage {
    
    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }

}


