//
//  ViewController.swift
//  MovieCall
//
//  Created by Juanito Martinon on 8/22/23.
//

import UIKit

// MARK: WE MADE A CHANGE GITHUB    

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
// MARK: - THIS IS FROM MY IMAC
    
    @IBOutlet weak var searchResults: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    var movieTitle = [String]()
    var imgArray = [String]()
    var overviewArray = [String]()
    
    var movieCall = MovieCall()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchResults.delegate = self
        searchResults.dataSource = self
        searchTextField.delegate = self
       if searchTextField.state.isEmpty == true {
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
                }
                
                DispatchQueue.main.async {
                    self.searchResults.reloadData()
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
        let text = (searchTextField.text! as NSString).replacingCharacters(in: range, with: string)
        if text.isEmpty {
            searchButton.isEnabled = false
        } else {
            
            searchButton.isEnabled = true
        }
        
        return true
    }
    
    // makes the api call
    @IBAction func searchTapped(_ sender: UIButton) {
      
        callMe(someTitle: searchTextField.text ?? "nada")
        movieTitle.removeAll()
        //movieCall.callApi(sometitle: searchTextField.text ?? "nada")
        //movieCall.titleArray.removeAll()
        searchTextField.text = ""
        if searchTextField.state.isEmpty == true {
            searchButton.isEnabled = false
        }
        self.searchResults.reloadData()
        self.imgArray.removeAll()
      
    }
    
    
// MARK: TABLE VIEW FOR SEARCH RESULTS
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberTwo = movieTitle.count
        
        return numberTwo
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movietitle = movieTitle[indexPath.row]
        let imagePath = imgArray[indexPath.row]
        // add a description to the other view!
        let overview = overviewArray[indexPath.row]
        presentDetail(sendTitle: movietitle, sendimg: imagePath)
        
        print(overview)
    }
    
    
    
    // sending data and seguing ⚠️
    func presentDetail(sendTitle: String, sendimg: String) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "detail") as! DetailPageViewController
        vc.movieTitle = sendTitle
        vc.imagePath = sendimg
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
    

}

