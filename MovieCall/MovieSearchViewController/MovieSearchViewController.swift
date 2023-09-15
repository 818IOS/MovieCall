//
//  MovieSearchViewController.swift
//  MovieCall
//
//  Created by Juanito Martinon on 10/5/23.
//

import UIKit

class MovieSearchViewController: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var searchituptextfield: UITextField!
    
    @IBOutlet weak var buttontap: UIButton!
    @IBOutlet weak var movieHeaderLabel: UILabel!
    
    @IBOutlet weak var movieResultsCollection: UICollectionView!
    @IBOutlet weak var tvshowresultsCollection: UICollectionView!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButtn: UIBarButtonItem!
    
    // MARK: - MOVIE DATA ARRAYS
    var movieTitle = [String]()
    var imgArray = [String]()
    var overviewArray = [String]()
    var imgBackgroundArray = [String]()
    var titleid = [Int]()
    
   // MARK: - TV DATA ARRAYS
    var tvtitle = [String]()
    var tvimgArray = [String]()
    
    
    // movie call and tv call
    var movieCall = MovieCall()
    var tvCall = TvCall()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.navigationController?.navigationBar.setNeedsLayout()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchituptextfield.delegate = self
        
        movieResultsCollection.delegate = self
        movieResultsCollection.dataSource = self
            
        tvshowresultsCollection.delegate = self
        tvshowresultsCollection.dataSource = self
        
        
       if searchituptextfield.state.isEmpty == true {
            self.buttontap.isEnabled = false
        }
    }
    
 // MARK: - DATA CALL ⚠️
    
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
                        self.movieResultsCollection.reloadData()
                    }
                }
            } catch {
                print(error)
            }
        }
    }
    
    func callTv(sometitle: String) {
        Task {
            do {
                let tvcall = try await tvCall.tvcallApiUsingAsync(sometitle: sometitle)
                for title in tvcall {
                    self.tvtitle.append(title.name)
                    self.tvimgArray.append(title.posterPath ?? "photo.fill")
                    print(title)
                    print(tvimgArray.count)
                    DispatchQueue.main.async {
                        self.tvshowresultsCollection.reloadData()
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
            callTv(sometitle: textField.text ?? "empty")
            textField.text = ""
            return true
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let text = (searchituptextfield.text! as NSString).replacingCharacters(in: range, with: string)
            if text.isEmpty {
                buttontap.isEnabled = false
            } else {
                
                buttontap.isEnabled = true
            }
            
            return true
        }
    
    
    @IBAction func searchbuttontapped(_ sender: Any) {
        callMe(someTitle: searchituptextfield.text ?? "nada")
        callTv(sometitle: searchituptextfield.text ?? "nada")
        movieTitle.removeAll()
        tvtitle.removeAll()
        //movieCall.callApi(sometitle: searchTextField.text ?? "nada")
        //movieCall.titleArray.removeAll()
        searchituptextfield.text = ""
        if searchituptextfield.state.isEmpty == true {
            buttontap.isEnabled = false
        }
        DispatchQueue.main.async {
            self.movieResultsCollection.reloadData()
            self.tvshowresultsCollection.reloadData()
            self.tvimgArray.removeAll()
            self.imgArray.removeAll()
            self.imgBackgroundArray.removeAll()
        }
    }
    
    
    
    /*
    @IBAction func searchTap(_ sender: UIBarButtonItem) {
        callMe(someTitle: searchituptextfield.text ?? "nada")
        movieTitle.removeAll()
        //movieCall.callApi(sometitle: searchTextField.text ?? "nada")
        //movieCall.titleArray.removeAll()
        searchTextField.text = ""
        if searchTextField.state.isEmpty == true {
            searchButtn.isEnabled = false
        }
        DispatchQueue.main.async {
          self.movieResultsCollection.reloadData()
            self.imgArray.removeAll()
            self.imgBackgroundArray.removeAll()
        }
    }
     */
  
    // MARK: - COLLECTION VIEW SEARCH RESULTS ⚠️
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == movieResultsCollection {
            return movieTitle.count
        } else {
            return tvtitle.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // AMARK: - MOVIE CELLS
        if collectionView == movieResultsCollection {
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "movie", for: indexPath) as! MoviesCollectionViewCell
            let movieimgs = imgArray[indexPath.row]
            let movietitle = movieTitle[indexPath.row]
            
            DispatchQueue.main.async {
                cell.moivePosterImage.load(urlString: movieimgs, contentview: cell)
                cell.moivePosterImage.layer.shadowRadius = 5
                cell.moivePosterImage.layer.shadowOffset = CGSize(width: 0, height: 10)
                cell.moivePosterImage.layer.shadowOpacity = 1
                
                cell.movieTitle.text = movietitle
                let avg = cell.moivePosterImage.image?.averageColor
                cell.contentView.backgroundColor = avg
            }
        
            cell.layer.cornerRadius = 15
            return cell
            // MARK: - TV CELLS
        } else {
            let tvcell = collectionView.dequeueReusableCell(withReuseIdentifier: "tv", for: indexPath) as! TVShowsCollectionViewCell
            let tvtitles = tvtitle[indexPath.row]
            let tvimgs = tvimgArray[indexPath.row]
            
            DispatchQueue.main.async {
                tvcell.tvImage.tvload(urlString: tvimgs, contentview: tvcell)
                tvcell.tvImage.layer.shadowRadius = 5
                tvcell.tvImage.layer.shadowOffset = CGSize(width: 0, height: 10)
                tvcell.tvImage.layer.shadowOpacity = 1
                
                tvcell.tvTitle.text = tvtitles
                let avg = tvcell.tvImage.image?.averageColor
                tvcell.contentView.backgroundColor = avg
            }
            tvcell.layer.cornerRadius = 15
          
            return tvcell
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == movieResultsCollection {
            return 30
        } else {
            return 30
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == movieResultsCollection {
            return 30
        } else {
            return 30
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? MoviesCollectionViewCell
        let sometghinh = cell?.moivePosterImage.snapshotView(afterScreenUpdates: false)
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
        present(vc, animated: true)
       // self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
/*
extension MovieSearchViewController: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        <#code#>
    }
    
    
}
*/
