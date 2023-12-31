//
//  Animator.swift
//  MovieCall
//
//  Created by Juanito Martinon on 10/11/23.
//

import Foundation
import UIKit


final class Animator: NSObject, UIViewControllerAnimatedTransitioning {


    // CHANGES THE SPEED OF THE ANIMATION
    static let duration: TimeInterval = 0.45

    private let type: PresentationType
    private let firstViewController: MovieSearchViewController
    private let secondViewController: DetailPageViewController
    // MARK: SELECTED CELL
    private var selectedCellImageViewSnapshot: UIView
    // MARK: CELL IMAGE VIEW
    private let cellImageViewRect: CGRect
    // MARK: CELL LABEL
    private let celllabelRect: CGRect

    // B2 - 10
    init?(type: PresentationType, firstViewController: MovieSearchViewController, secondViewController: DetailPageViewController, selectedCellImageViewSnapshot: UIView) {
        self.type = type
        self.firstViewController = firstViewController
        self.secondViewController = secondViewController
        self.selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
   
        guard let window = firstViewController.view.window ?? secondViewController.view.window,
              let selectedCell = firstViewController.selectedCell
            else { return nil }

        // B2 - 11
        firstViewController.hidesBottomBarWhenPushed = true
        self.cellImageViewRect = selectedCell.moivePosterImage.convert(selectedCell.moivePosterImage.bounds, to: window)
        self.celllabelRect = selectedCell.movieTitle.convert(selectedCell.movieTitle.bounds, to: window)
    }

    
    
    
    // B2 - 12
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Self.duration
    }

    
    
    
    
    
    // B2 - 13
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 18
        let containerView = transitionContext.containerView

        // 19
        guard let toView = secondViewController.view
            else {
                transitionContext.completeTransition(false)
                return
        }

        containerView.addSubview(toView)

        // 21
        guard
            let selectedCell = firstViewController.selectedCell,
            let window = firstViewController.view.window ?? secondViewController.view.window,
            let cellImageSnapshot = selectedCell.moivePosterImage.snapshotView(afterScreenUpdates: true),
            let controllerImageSnapshot = secondViewController.posterImage.snapshotView(afterScreenUpdates: true),
            let cellLabelSnapshot = selectedCell.movieTitle.snapshotView(afterScreenUpdates: true), // 47
            let closeButtonSnapshot = secondViewController.closingButton.snapshotView(afterScreenUpdates: true) // 53
                
            else {
                transitionContext.completeTransition(true)
                return
        }
    
        
        let isPresenting = type.isPresenting

        // 40
        let backgroundView: UIView
        let fadeView = UIView(frame: containerView.bounds)
        fadeView.backgroundColor = secondViewController.view.backgroundColor

        // 33
        if isPresenting {
            selectedCellImageViewSnapshot = cellImageSnapshot

            // 41
            backgroundView = UIView(frame: containerView.bounds)
            backgroundView.addSubview(fadeView)
            fadeView.alpha = 0
        } else {
            backgroundView = firstViewController.view.snapshotView(afterScreenUpdates: true) ?? fadeView
            backgroundView.addSubview(fadeView)
        }

        // 23
        toView.alpha = 0

        // 34
        // 42
        // 48
        // 54
        [backgroundView, selectedCellImageViewSnapshot, controllerImageSnapshot, cellLabelSnapshot, closeButtonSnapshot].forEach { containerView.addSubview($0) }

        // 25
        let controllerImageViewRect = secondViewController.posterImage.convert(secondViewController.posterImage.bounds, to: window)
        // 49
        let controllerLabelRect = secondViewController.movieTitleLabel.convert(secondViewController.movieTitleLabel.bounds, to: window)
        // 55
        let closeButtonRect = secondViewController.closingButton.convert(secondViewController.closingButton.bounds, to: window)

        // 35
        [selectedCellImageViewSnapshot, controllerImageSnapshot].forEach {
            $0.frame = isPresenting ? cellImageViewRect : controllerImageViewRect

            // 59
            $0.layer.cornerRadius = isPresenting ? 12 : 0
            $0.layer.masksToBounds = true
        }

        // 36
        controllerImageSnapshot.alpha = isPresenting ? 0 : 1

        // 37
        selectedCellImageViewSnapshot.alpha = isPresenting ? 1 : 0

        // 50
        cellLabelSnapshot.frame = isPresenting ? celllabelRect : controllerLabelRect

        // 56
        closeButtonSnapshot.frame = closeButtonRect
        closeButtonSnapshot.alpha = isPresenting ? 0 : 1

        // 27
        UIView.animateKeyframes(withDuration: Self.duration, delay: 0, options: .calculationModeCubic, animations: {

            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                // 38
                self.selectedCellImageViewSnapshot.frame = isPresenting ? controllerImageViewRect : self.cellImageViewRect
                controllerImageSnapshot.frame = isPresenting ? controllerImageViewRect : self.cellImageViewRect

                // 43
                fadeView.alpha = isPresenting ? 1 : 0

                // 51
                cellLabelSnapshot.frame = isPresenting ? controllerLabelRect : self.celllabelRect

                // MARK: TF DIES THIS DO
                [controllerImageSnapshot, self.selectedCellImageViewSnapshot].forEach {
                    $0.layer.cornerRadius = isPresenting ? 0 : 1
                }
            }

            // MARK: IMAGE ANIMATION TRANSITION
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3) {
                self.selectedCellImageViewSnapshot.alpha = isPresenting ? 0 : 1
                controllerImageSnapshot.alpha = isPresenting ? 1 : 0
            }

            // 57
            UIView.addKeyframe(withRelativeStartTime: isPresenting ? 0.7 : 0, relativeDuration: 0.3) {
                closeButtonSnapshot.alpha = isPresenting ? 1 : 0
            }
            
        }, completion: { _ in
            // 29
            self.selectedCellImageViewSnapshot.removeFromSuperview()
            controllerImageSnapshot.removeFromSuperview()

            // 44
            backgroundView.removeFromSuperview()
            // 52
            cellLabelSnapshot.removeFromSuperview()
            // 58
            closeButtonSnapshot.removeFromSuperview()

            // 30
            toView.alpha = 1

            // 31
            transitionContext.completeTransition(true)
        })
    }
}

// B2 - 14
enum PresentationType {

    case present
    case dismiss

    var isPresenting: Bool {
        return self == .present
    }
}
