//
//  MovieDetailsViewController.swift
//  BMSListing
//
//  Created by Pankaj Teckchandani on 26/02/20.
//  Copyright © 2020 BMS. All rights reserved.
//

import UIKit

class MovieDetailsViewController: BMSBaseViewController {
    
    @IBOutlet weak var labelForHeaderTextTop: NSLayoutConstraint!
    @IBOutlet weak var tableViewForMovieDetails: UITableView!
    
    
    @IBOutlet weak var viewForHeaderReference: UIView!
    @IBOutlet weak var labelForHandleHeaderText: UILabel!
    
    var buttonForBack: UIButton!
    private var callingAPI  = true
    
    var headerImageView:UIImageView!
    var headerImageViewGradient:UIImageView!
    @IBOutlet weak var labelForHeaderText: UILabel!
    
    private var vendor : Movie?
    private var topHedaerHeight = 200
    
    var headerWhiteView:UIView!
    private var dataCtlr = MovieDetailsDataController()
    @IBOutlet weak var viewForHeader: UIView!
    //For Animation
    var offsetHeaderStop:CGFloat = 0  // At this offset the Header stops its transformations
    let distanceWLabelHeader:CGFloat = 30 // The distance between the top of the screen and the top
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()

        setupHeaderView()
        self.tableViewForMovieDetails.estimatedRowHeight = 210;
        self.tableViewForMovieDetails.tableHeaderView = UIView();
        
        if self.detectIsPhoneXOrAbove() == true {
            offsetHeaderStop = self.viewForHeader.frame.size.height - 80
            
        } else {
            
            offsetHeaderStop = self.viewForHeader.frame.size.height - 64
        }
        
        
        self.loadMovieDetails()
        self.loadMovieCredits()
        self.loadSimilarMovies()
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationItem.hidesBackButton = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        showHideTopBarButtons(bFlag: false)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setMovie(movie : Movie){
        self.dataCtlr.movie = movie
    }
    
    func setGenres(genres : [Genre]){
        self.dataCtlr.arrayOfAllGenres = genres
    }
    
    //Show Top Bar Buttons
    func showHideTopBarButtons(bFlag: Bool) {
        if bFlag == true {
            self.buttonForBack.isHidden = true
            
        } else {
            self.buttonForBack.isHidden = false
        }
    }
    
    
    
    //Setup Header View
    func setupHeaderView() {
        let iButtonHeightWidth: CGFloat = 44
        var iYAxis: CGFloat = 0
        if self.detectIsPhoneXOrAbove() == true {
            iYAxis = 40
            self.labelForHeaderTextTop.constant = 254
        } else {
            iYAxis = 20
            self.labelForHeaderTextTop.constant = 244
        }
        self.view.layoutIfNeeded()
        
        
        //buttonForBack
        buttonForBack = UIButton(frame: CGRect(x: 4, y: iYAxis, width: iButtonHeightWidth, height: iButtonHeightWidth))
        
        //headerImageViewGradient
        headerImageViewGradient = UIImageView(frame: CGRect(x: 0, y: 0, width: viewForHeader.frame.width, height: viewForHeader.frame.height))
        headerImageViewGradient?.image = UIImage();
        headerImageViewGradient?.contentMode = UIView.ContentMode.scaleAspectFill
        viewForHeader.insertSubview(headerImageViewGradient, belowSubview: labelForHeaderText)
        
        //headerImageView
        headerImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: viewForHeader.frame.width, height: viewForHeader.frame.height))
        headerImageView?.image = UIImage();
        headerImageView.backgroundColor = UIColor.lightGray;
        headerImageView?.contentMode = UIView.ContentMode.scaleAspectFill
        headerImageView?.alpha = 0.9
        viewForHeader.insertSubview(headerImageView, belowSubview: headerImageViewGradient)
        
        //headerWhiteView
        headerWhiteView = UIView(frame: CGRect(x: 0, y: 0, width: viewForHeader.frame.width, height: viewForHeader.frame.height+20))
        headerWhiteView?.backgroundColor = UIColor(hex: "#130C60ff");
        headerWhiteView.alpha = 0
        viewForHeader.insertSubview(headerWhiteView, belowSubview: labelForHeaderText)
        
        
        
        //buttonForBack
        
        let image  = Constants.Images.kImageForBackNavigation.withRenderingMode(.alwaysTemplate)
        
        
        buttonForBack.setImage(image, for: .normal)
        buttonForBack.imageView?.tintColor = UIColor.white
        
        buttonForBack.addTarget(self, action: #selector(MovieDetailsViewController.backToHome(_:)), for: .touchUpInside)
      
        
        UIApplication.shared.keyWindow?.addSubview(buttonForBack)
        self.tableViewForMovieDetails.contentInset = UIEdgeInsets(top: viewForHeader.frame.height, left: 0, bottom: 0, right: 0)
        
        viewForHeader.clipsToBounds = true
    }
    
    @IBAction func backToHome(_ sender: Any) {
        
        DispatchQueue.main.async{
             self.buttonForBack.removeFromSuperview()
            self.navigationController?.popViewController(animated: true)
           
            
        }
    }
    
    
    //Set up TableViewCell Nibs
    func registerNibs() {
        
        
        let nibForDetails = UINib.init(nibName: "MovieDetailsTableViewCell", bundle: Bundle.main)
        self.tableViewForMovieDetails.register(nibForDetails, forCellReuseIdentifier: Constants.CellIdentifiers.kMovieDetailsCellIdentifier)
        
        
        
        let nibForCredits = UINib.init(nibName: Constants.Cells.kMovieCreditsCell, bundle: Bundle.main)
              self.tableViewForMovieDetails.register(nibForCredits, forCellReuseIdentifier: Constants.CellIdentifiers.kMovieCreditsCellIdentifier)
              
        
        let nibForSimilarMovies = UINib.init(nibName: Constants.Cells.kSimilarMoviesListingCell, bundle: Bundle.main)
              self.tableViewForMovieDetails.register(nibForSimilarMovies, forCellReuseIdentifier: Constants.CellIdentifiers.kSimilarMoviesListingCellIdentifier)
              
        
        self.tableViewForMovieDetails.tableFooterView = UIView();
    }
    
    
    
    // MARK: Scroll view delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        DispatchQueue.main.async {
            let offset = scrollView.contentOffset.y + self.viewForHeader.bounds.height
            var headerTransform = CATransform3DIdentity
            
            // PULL DOWN -----------------
            if offset < 0 {
                let headerScaleFactor:CGFloat = -(offset) / self.viewForHeader.bounds.height
                let headerSizevariation = ((self.viewForHeader.bounds.height * (1.0 + headerScaleFactor)) - self.viewForHeader.bounds.height)/2
                headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
                headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
                
                // Hide views if scrolled super fast
                self.viewForHeader.layer.zPosition = 0
                self.labelForHeaderText.isHidden = true
                
            }
                // SCROLL UP/DOWN ------------
            else {
                // Header -----------
                headerTransform = CATransform3DTranslate(headerTransform, 0, max(-self.offsetHeaderStop, -offset), 0)
                //print("headerTransform: \(headerTransform)")
                
                //  ------------ Label
                var alignToNameLabel: CGFloat = 0
                self.labelForHeaderText.isHidden = false
                alignToNameLabel = -offset + (self.labelForHandleHeaderText?.frame.origin.y ?? 0) + self.viewForHeader.frame.height + self.offsetHeaderStop
                //print("alignToNameLabel: \(alignToNameLabel)")
                
                if self.detectIsPhoneXOrAbove() == true {
                    self.labelForHeaderText.frame.origin = CGPoint(x: self.labelForHeaderText.frame.origin.x, y: 248)
                } else {
                    self.labelForHeaderText.frame.origin = CGPoint(x: self.labelForHeaderText.frame.origin.x, y: max(alignToNameLabel - 5, (self.distanceWLabelHeader + self.offsetHeaderStop)))
                }
                //print("max(alignToNameLabel, distanceWLabelHeader + offset_HeaderStop) : \(max(alignToNameLabel, distanceWLabelHeader + offset_HeaderStop))")
                
                //print("headerLabel.frame.origin: \(labelForHeaderText.frame.origin)")
                
                //  ------------ Blur
                self.headerWhiteView?.alpha = min (1.0, (offset - alignToNameLabel + 40)/self.distanceWLabelHeader)
                //print("(offset - alignToNameLabel)/distanceWLabelHeader: \((offset - alignToNameLabel + 40)/distanceWLabelHeader)")
                
                if self.headerWhiteView?.alpha == 1 {
                    
                    self.labelForHeaderText.textColor = UIColor.white
                    
                } else {
                    
                    self.labelForHeaderText.textColor = .clear
                    
                }
                
                if offset <= self.offsetHeaderStop {
                    self.viewForHeader.layer.zPosition = 0
                }else {
                    self.viewForHeader.layer.zPosition = 2
                }
            }
            
            // Apply Transformations
            self.viewForHeader.layer.transform = headerTransform
            
            
            // Set scroll view insets just underneath the segment control
            self.tableViewForMovieDetails.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
        }
    }
    
    
    func loadMovieDetails(){
        
        self.headerImageView.sd_setImage(with: URL(string: (Constants.BaseUrls.kPosterBaseUrl + self.dataCtlr.movie!.backdropPath! ) ), placeholderImage: nil)
        
        self.labelForHeaderText.text = self.dataCtlr.movie?.title ?? ""
        self.labelForHandleHeaderText.text = self.dataCtlr.movie?.title ?? ""
        self.dataCtlr.getMovieDetails(onSuccess: {
            DispatchQueue.main.async {
                if(self.dataCtlr.movieDetails != nil)
                {
                    
                    self.tableViewForMovieDetails.reloadData()
                    self.tableViewForMovieDetails.layoutIfNeeded()
                    self.tableViewForMovieDetails.layoutSubviews()
                    
                }
                else
                {
                    //Error Message
                }
            }
        }) { (message) in
            //Error Message UI
        }
    }
    
    func loadMovieCredits(){
        
        self.dataCtlr.getMovieCredits(onSuccess: {
            
            DispatchQueue.main.async{
                self.tableViewForMovieDetails.reloadData()
            }
            
        }) { (message) in
            
            //Error Handling
        }
    }
    func loadSimilarMovies() {
        self.dataCtlr.getSimilarMovies(onSuccess: {
            
            DispatchQueue.main.async{
                self.tableViewForMovieDetails.reloadData()
            }
            
        }) { (message) in
            
            //Error Handling
        }
    }
    
}


extension MovieDetailsViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        
        self.dataCtlr.getTypesOfCells().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(self.dataCtlr.getTypesOfCells()[indexPath.row] == .details){
            let cell = self.tableViewForMovieDetails.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.kMovieDetailsCellIdentifier)
                as! MovieDetailsTableViewCell
            cell.selectionStyle = .none
            
            cell.loadMovie(movie: self.dataCtlr.movie!, genres: self.dataCtlr.arrayOfAllGenres!, indexPath: indexPath);
            
            
            return cell
            
        }
        else if(self.dataCtlr.getTypesOfCells()[indexPath.row] == .similarMovies){
            
            let cell = self.tableViewForMovieDetails.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.kSimilarMoviesListingCellIdentifier)
                as! MovieSimilarListingTableViewCell
            cell.selectionStyle = .none
            
            cell.loadSimilarMovies(similarMovies: self.dataCtlr.similarMovies!)
            
            return cell
            
        }
        else{
            let cell = self.tableViewForMovieDetails.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.kMovieCreditsCellIdentifier)
                as! MovieCreditsUITableViewCell
            cell.selectionStyle = .none
            
            cell.loadCredits(credits: self.dataCtlr.credits!)
            
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
}
