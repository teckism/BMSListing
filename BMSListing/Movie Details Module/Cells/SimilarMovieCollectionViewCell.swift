//
//  SimilarMovieCollectionViewCell.swift
//  BMSListing
//
//  Created by Pankaj Teckchandani on 26/02/20.
//  Copyright © 2020 BMS. All rights reserved.
//

import UIKit

class SimilarMovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var labelForName: UILabel!
    
    @IBOutlet weak var labelForPopularity: UILabel!
    
    @IBOutlet weak var imageViewForMoviePoster: UIImageView!
    @IBOutlet weak var viewForDropShadow: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func loadMovie(movie : Movie){
        self.labelForName.text = movie.title ?? ""
        self.labelForPopularity.text = "\(movie.popularity ?? 0.0) Popularity"
        if let image = movie.posterPath{
                  imageViewForMoviePoster.sd_setImage(with: URL(string: Constants.BaseUrls.kProfilePathBaseUrl + image), placeholderImage: UIImage(named: "placeholder"));
              }
              else{
                  self.imageViewForMoviePoster.image = UIImage(named: "placeholder");
              }
        
        self.viewForDropShadow.dropShadow()
        
    }
}
