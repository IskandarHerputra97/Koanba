//
//  MovieDetailHeaderCollectionViewCell.swift
//  KoanbaTechnicalTest
//
//  Created by Iskandar Herputra Wahidiyat on 14/07/23.
//

import UIKit

class MovieDetailHeaderCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var movieDetailImageView: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDurationLabel: UILabel!
    @IBOutlet weak var movieCategoryLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
