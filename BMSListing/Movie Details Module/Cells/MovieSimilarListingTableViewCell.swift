//
//  MovieSimilarListingTableViewCell.swift
//  BMSListing
//
//  Created by Pankaj Teckchandani on 26/02/20.
//  Copyright © 2020 BMS. All rights reserved.
//

import UIKit

class MovieSimilarListingTableViewCell: UITableViewCell {
    
    private var similarMovies : SimilarMovies?
    
    @IBOutlet weak var collectionViewForSimilarMovies: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let nibForSimlarMovie = UINib.init(nibName: Constants.Cells.kSimilarMovieCell, bundle: Bundle.main)
        
        self.collectionViewForSimilarMovies.register(nibForSimlarMovie, forCellWithReuseIdentifier: Constants.CellIdentifiers.kSimilarMovieCellIdentifier)
        self.collectionViewForSimilarMovies.delegate = self;
        self.collectionViewForSimilarMovies.dataSource = self;
    
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadSimilarMovies(similarMovies : SimilarMovies){
        
        self.similarMovies = similarMovies
        
        DispatchQueue.main.async {
            self.collectionViewForSimilarMovies.reloadData()
        }
        
    }
    
}


extension MovieSimilarListingTableViewCell : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.similarMovies?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifiers.kSimilarMovieCellIdentifier, for: indexPath) as! SimilarMovieCollectionViewCell
        
        cell.loadMovie(movie: (self.similarMovies?.results![indexPath.row])!)
        
        return cell;
        
    }
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 3.0 , height: collectionView.frame.size.height)

    }
    
    
 
}
