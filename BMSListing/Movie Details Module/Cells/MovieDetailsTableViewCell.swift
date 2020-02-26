//
//  MovieDetailsTableViewCell.swift
//  BMSListing
//
//  Created by Pankaj Teckchandani on 26/02/20.
//  Copyright © 2020 BMS. All rights reserved.
//

import UIKit
import Cosmos

class MovieDetailsTableViewCell: UITableViewCell {
    
    var indexPath : IndexPath?
    
    @IBOutlet weak var labelForMovieTitle: UILabel!
    @IBOutlet weak var labelForGenres: UILabel!
    @IBOutlet weak var labelForReleaseDate: UILabel!
    
    @IBOutlet weak var labelForVotes: UILabel!
    @IBOutlet weak var imageViewForPoster: UIImageView!
    
    
    @IBOutlet weak var labelForOverview: UILabel!
    @IBOutlet weak var viewForRating: CosmosView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func loadMovie(movie : Movie, genres : [Genre], indexPath : IndexPath) {
        
        
        self.labelForMovieTitle.text = movie.title ?? ""
        
        self.indexPath = indexPath
        if let releaseDate = movie.releaseDate {
            let dateObj = Date(fromString: releaseDate, format: .isoDate)
            self.labelForReleaseDate.text = dateObj?.toString(format: .custom("MMMM dd, yyyy")) ?? ""
        }
        
        
        
        if let image = movie.posterPath{
            imageViewForPoster.sd_setImage(with: URL(string: Constants.BaseUrls.kPosterBaseUrl + image), placeholderImage: UIImage(named: "placeholder"));
        }
        else{
            self.imageViewForPoster.image = UIImage(named: "placeholder");
        }
        
        
        self.viewForRating.rating = (movie.voteAverage ?? 0.0) / 2.0;
        
        self.labelForOverview.text = movie.overview ?? ""
        self.labelForVotes.text = "\(movie.voteCount ?? 0) votes"
      
        
        
        let currentGenres = genres.filter{(movie.genreIDS?.contains($0.id!))!};
        
        var genresString = "";
        
        for current in currentGenres {
            
            if genresString == "" {
                genresString = current.name ?? ""
                continue
            }
            
            genresString = genresString + " | " + (current.name ?? "")
            
        }
        
        self.labelForGenres.text = genresString
    }
}
