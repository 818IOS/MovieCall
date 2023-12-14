//
//  InTheatersViewController.swift
//  MovieCall
//
//  Created by Juanito Martinon on 11/9/23.
//

import UIKit

class InTheatersViewController: UIViewController {
    
    var callingTheater = TheaterCall()

    override func viewDidLoad() {
        super.viewDidLoad()
        callTheaters()
        //callUpcoming()
        //callPopular()
    }
 
    func callTheaters() {
        Task {
            do {
                let calling = try await callingTheater.theaterCallUsingAsync()
                for whatever in calling {
                    print(whatever.originalTitle)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func callUpcoming() {
        Task {
            do {
                let upcoming = try await callingTheater.upcomingCallAsync()
                for inside in upcoming {
                    print(inside.originalTitle, "upcoming")
                }
            } catch {
                print(error)
            }
        }
    }
    
    func callPopular() {
        Task {
            do {
                let popular = try await callingTheater.popularCallAsync()
                for inside in popular {
                    print(inside.originalTitle, "popular")
                }
            } catch {
                print(error)
            }
        }
    }

}
