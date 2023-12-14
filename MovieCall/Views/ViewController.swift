//
//  ViewController.swift
//  MovieCall
//
//  Created by Juanito Martinon on 8/22/23.
//

import UIKit

// MARK: WE MADE A CHANGE GITHUB
// MARK: WE ADDIN THIS FROM THE IMAC

class ViewController: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
    
    // MARK: FROM MY MACBOOK AIR BUT NOT REALLY
    // MARK: OK NO FR THIS ONE IS FROM MY MACBOOK AIR FR FR
    
    @IBOutlet weak var moviesLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var collectionViewMovies: UICollectionView!
    @IBOutlet weak var searchText: UITextField!
    
    
    var movieTitle = [String]()
    var imgArray = [String]()
    var overviewArray = [String]()
    var imgBackgroundArray = [String]()
    var titleid = [Int]()
    
    
    var movieCall = MovieCall()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        searchText.delegate = self
        collectionViewMovies.delegate = self
        collectionViewMovies.dataSource = self
        
       if searchText.state.isEmpty == true {
            self.searchButton.isEnabled = false
        }
    }
    

    
// MARK: - DATA CALLS ⚠️
    func callMe(someTitle: String) {
        Task {
            do {
                let call = try await movieCall.callApiUsingAsync(sometitle: someTitle)
                for title in call {
                    self.movieTitle.append(title.originalTitle)
                    self.imgArray.append(title.posterPath ?? "photo.fill")
                    self.overviewArray.append(title.overview)
                    self.imgBackgroundArray.append(title.backdropPath ?? "photo.fill")
                    self.titleid.append(title.id)
                    DispatchQueue.main.async {
                        self.collectionViewMovies.reloadData()
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
// MARK: - TEXTFIELD  ⚠️
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text ?? "emptiness")
       
        //movieCall.callApi(sometitle: textField.text ?? "empty")
        callMe(someTitle: textField.text ?? "empty")
      
        textField.text = ""
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (searchText.text! as NSString).replacingCharacters(in: range, with: string)
        if text.isEmpty {
            searchButton.isEnabled = false
        } else {
            
            searchButton.isEnabled = true
        }
        
        return true
    }
    
    // makes the api call
    @IBAction func searchTapped(_ sender: UIButton) {
      
        callMe(someTitle: searchText.text ?? "nada")
        movieTitle.removeAll()
        //movieCall.callApi(sometitle: searchTextField.text ?? "nada")
        //movieCall.titleArray.removeAll()
        searchText.text = ""
        if searchText.state.isEmpty == true {
            searchButton.isEnabled = false
        }
        DispatchQueue.main.async {
          self.collectionViewMovies.reloadData()
            self.imgArray.removeAll()
            self.imgBackgroundArray.removeAll()
        }
   
    }
    
    
    
    
    
// MARK: - COLLECTION VIEW SEARCH RESULTS ⚠️
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieTitle.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movie", for: indexPath) as! MoviesCollectionViewCell
        
        let movieimgs = imgArray[indexPath.row]
        let movietitle = movieTitle[indexPath.row]
        
        DispatchQueue.main.async {
            cell.moivePosterImage.load(urlString: movieimgs, contentview: cell)
            cell.movieTitle.text = movietitle
            let avg = cell.moivePosterImage.image?.averageColor
            cell.contentView.backgroundColor = avg
        }
    
        cell.layer.cornerRadius = 15
        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let titleid = titleid[indexPath.row]
        let movietitle = movieTitle[indexPath.row]
        let imagePath = imgArray[indexPath.row]
        // add a description to the other view!
        let overview = overviewArray[indexPath.row]
        let backdrop = imgBackgroundArray[indexPath.row]
        print(titleid)
        presentDetail(sendTitle: movietitle, sendimg: imagePath, discript: overview, backDrop: backdrop)
    }
    
    
    
    // presents other view
    func presentDetail(sendTitle: String, sendimg: String, discript: String, backDrop: String) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "detail") as! DetailPageViewController
        vc.movieTitle = sendTitle
        vc.imagePath = sendimg
        vc.discript = discript
        vc.backdropimg = backDrop
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    /*
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.height / 2)
    }
    */
    
// MARK: - TABLE VIEW FOR SEARCH RESULTS
    /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberTwo = movieTitle.count
        
        return numberTwo
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movietitle = movieTitle[indexPath.row]
        let imagePath = imgArray[indexPath.row]
        // add a description to the other view!
        let overview = overviewArray[indexPath.row]
        let backdrop = imgBackgroundArray[indexPath.row]
        
        presentDetail(sendTitle: movietitle, sendimg: imagePath, discript: overview, backDrop: backdrop)
        
        print(overview)
    }
    
    
    
    // sending data and seguing ⚠️
    func presentDetail(sendTitle: String, sendimg: String, discript: String, backDrop: String) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "detail") as! DetailPageViewController
        vc.movieTitle = sendTitle
        vc.imagePath = sendimg
        vc.discript = discript
        vc.backdropimg = backDrop
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchResultsTableViewCell
        let movieTitle = movieTitle[indexPath.row]
        let stringimg = imgArray[indexPath.row]
   
        DispatchQueue.main.async {
            cell.posterImages.load(urlString: stringimg)
        }
        
        cell.title.text = movieTitle
        return cell
    }
    
    
    
    */

}

