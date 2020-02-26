//
//  MovieCreditsUITableViewCell.swift
//  BMSListing
//
//  Created by Pankaj Teckchandani on 26/02/20.
//  Copyright © 2020 BMS. All rights reserved.
//

import UIKit

class MovieCreditsUITableViewCell: UITableViewCell {
    
    private var credits : MovieCredits?
    
    @IBOutlet weak var collectionViewForCredits: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let nibForCast = UINib.init(nibName: Constants.Cells.kMovieCastCell, bundle: Bundle.main)
        
        self.collectionViewForCredits.register(nibForCast, forCellWithReuseIdentifier: Constants.CellIdentifiers.kMovieCastCellIdentifier)
        self.collectionViewForCredits.delegate = self;
        self.collectionViewForCredits.dataSource = self;
    
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCredits(credits : MovieCredits){
        
        self.credits = credits
        
        DispatchQueue.main.async {
            self.collectionViewForCredits.reloadData()
        }
        
    }
    
}


extension MovieCreditsUITableViewCell : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.credits?.cast?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifiers.kMovieCastCellIdentifier, for: indexPath) as! MovieCastCollectionViewCell
        
        cell.loadCast(cast: (self.credits?.cast?.sorted {$0.order! < $1.order!}[indexPath.row])!)
        
        return cell;
        
    }
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 4.0 , height: collectionView.frame.size.height)

    }
    
    
 
}
