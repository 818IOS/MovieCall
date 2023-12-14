//
//  MovieSearchVC&TransitionDelegate.swift
//  MovieCall
//
//  Created by Juanito Martinon on 10/11/23.
//

import Foundation
import UIKit


extension MovieSearchViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let firstViewController = presenting as? MovieSearchViewController,
                let secondViewController = presented as? DetailPageViewController,
                let selectedCellImageViewSnapshot = selectedImagebiewSnapshot
                else { return nil }
          
            animator = Animator(type: .present, firstViewController: firstViewController, secondViewController: secondViewController, selectedCellImageViewSnapshot: selectedCellImageViewSnapshot)
            return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let secondViewController = dismissed as? DetailPageViewController,
              let selectedCellImageViewSnapshot = selectedImagebiewSnapshot
              else { return nil }

          animator = Animator(type: .dismiss, firstViewController: self, secondViewController: secondViewController, selectedCellImageViewSnapshot: selectedCellImageViewSnapshot)
          return animator
    }
}
