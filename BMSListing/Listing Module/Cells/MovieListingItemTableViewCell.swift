//
//  MovieListingItemTableViewCell.swift
//  BMSListing
//
//  Created by Pankaj Teckchandani on 25/02/20.
//  Copyright © 2020 BMS. All rights reserved.
//

import UIKit
import SDWebImage
import Cosmos

protocol MovieListingItemTableViewCellDelegate : class {
    func didTapBookShow(indexPath  : IndexPath);
}

class MovieListingItemTableViewCell: UITableViewCell {
    
    
    weak var delegate : MovieListingItemTableViewCellDelegate?
    
    var indexPath : IndexPath?
    
    @IBOutlet weak var labelForMovieTitle: UILabel!
    @IBOutlet weak var labelForDate: UILabel!
    @IBOutlet weak var imageViewForPoster: UIImageView!
    @IBOutlet weak var buttonForBook: UIButton!
    
    
    @IBOutlet weak var labelForDescription: UILabel!
    @IBOutlet weak var viewForRating: CosmosView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func loadMovie(movie : Movie, genres : [Genre], indexPath : IndexPath){
        
        self.labelForMovieTitle.text = movie.title ?? ""
        
        self.indexPath = indexPath
        if let releaseDate = movie.releaseDate {
            let dateObj = Date(fromString: releaseDate, format: .isoDate)
            self.labelForDate.text = dateObj?.toString(format: .custom("MMMM dd, yyyy")) ?? ""
        }
        
        
        
        if let image = movie.posterPath{
            imageViewForPoster.sd_setImage(with: URL(string: Constants.BaseUrls.kPosterBaseUrl + image), placeholderImage: UIImage(named: "placeholder"));
        }
        else{
            self.imageViewForPoster.image = UIImage(named: "placeholder");
        }
        
        
        self.viewForRating.rating = (movie.voteAverage ?? 0.0) / 2.0;
        
        self.labelForDescription.text = movie.overview ?? ""
        
        self.buttonForBook.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
        
        
        let currentGenres = genres.filter{(movie.genreIDS?.contains($0.id!))!};
        
        var genresString = "";
        
        for current in currentGenres {
            
            if genresString == "" {
                genresString = current.name ?? ""
                continue
            }
            
            genresString = genresString + " | " + (current.name ?? "")
            
        }
     
        
        self.labelForDescription.text = genresString

    }
    @IBAction func clickedBook(_ sender: Any) {
        
        
        self.delegate?.didTapBookShow(indexPath: self.indexPath!)
    }
}

