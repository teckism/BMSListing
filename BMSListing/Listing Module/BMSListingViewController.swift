//
//  ViewController.swift
//  BMSListing
//
//  Created by Pankaj Teckchandani on 25/02/20.
//  Copyright © 2020 BMS. All rights reserved.
//

import UIKit

class BMSListingViewController: BMSBaseViewController {
    
    
    private var dataCtlr : BMSListingDataController?
    @IBOutlet weak var tableViewForListing: UITableView!
    @IBOutlet weak var textFieldForSearch: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addMenuButton()
        
        self.hideKeyboardWhenTappedAround()
        
        if dataCtlr == nil {
            self.dataCtlr = BMSListingDataController()
        }
        
        
        
        self.dataCtlr?.getAllGenres(onSuccess: {
            self.dataCtlr?.getNowPlayingMovies(onSuccess: {
                DispatchQueue.main.async {
                    self.tableViewForListing.reloadData()
                }
            }, onFailure: { (message) in
                
            })
            
        }, onFailure: { (message) in
            
        })
        
        self.tableViewForListing.tableFooterView = UIView();
        
        registerNibs();
        
        
        //To change scolling content size when keyboard is shown and hidden
        NotificationCenter.default.addObserver(self, selector: #selector(BMSListingViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(BMSListingViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Movies List"
    }
    func registerNibs(){
        let nib = UINib.init(nibName: Constants.Cells.kMovieListingCell, bundle: Bundle.main)
        
        self.tableViewForListing.register(nib, forCellReuseIdentifier: Constants.CellIdentifiers.kMovieListingCellIdentifier)
        
    }
    @IBAction func textChanged(_ sender: Any) {
        var text = (sender as! UITextField).text!.trim();
        
        while text.contains("  ") {
            text = text.replacingOccurrences(of: "  ", with: " ")
        }
        self.dataCtlr?.performSearch(searchText: text)
        
        DispatchQueue.main.async {
            self.tableViewForListing.reloadData()
        }
    }
    
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableViewForListing.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    @objc func keyboardWillHide(_ notification:Notification) {
        
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            tableViewForListing.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    
    func addMenuButton(){
           let menuButton = UIButton(type: .custom)
           menuButton.setImage(UIImage(named: "icon_menu"), for: .normal)
           menuButton.setTitleColor(menuButton.tintColor, for: .normal)
        
           menuButton.addTarget(self, action: Selector(("menuAction")), for: .touchUpInside)
           
           self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
       }
       @objc func menuAction(){
           
            //Open Navigation Drawer
       }
    
}


extension BMSListingViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataCtlr?.arrayOfMovies?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.kMovieListingCellIdentifier) as! MovieListingItemTableViewCell
        cell.selectionStyle = .none
        
        let movie = self.dataCtlr?.arrayOfMovies![indexPath.row]
        cell.delegate = self;
        cell.loadMovie(movie : movie!, genres: self.dataCtlr?.arrayOfAllGenres ?? [], indexPath: indexPath)
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let movie = self.dataCtlr?.arrayOfMovies![indexPath.row]
        
        let movieDetailsVC = Constants.mainStoryboard.instantiateViewController(withIdentifier: Constants.StoryBoardIdentifiers.kMovieDetailsViewControllerIdenfier) as! MovieDetailsViewController
       
        movieDetailsVC.setMovie(movie: movie!)
        movieDetailsVC.setGenres(genres: (self.dataCtlr?.arrayOfAllGenres!)!)
        
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(movieDetailsVC, animated: true)
        }
    }
}



extension BMSListingViewController : MovieListingItemTableViewCellDelegate {
    func didTapBookShow(indexPath: IndexPath) {
        //Handle Booking Screen Navigation
    }
}
