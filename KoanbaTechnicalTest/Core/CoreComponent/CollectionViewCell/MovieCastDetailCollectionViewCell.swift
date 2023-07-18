//
//  MovieCastDetailCollectionViewCell.swift
//  KoanbaTechnicalTest
//
//  Created by Iskandar Herputra Wahidiyat on 14/07/23.
//

import UIKit

class MovieCastDetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var movieCastImageView: UIImageView!
    @IBOutlet weak var movieCastNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        movieCastImageView.layer.cornerRadius = movieCastImageView.bounds.width / 2
        movieCastImageView.layer.masksToBounds = true
    }
}
