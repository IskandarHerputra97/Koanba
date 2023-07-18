//
//  MovieCastCollectionViewCell.swift
//  KoanbaTechnicalTest
//
//  Created by Iskandar Herputra Wahidiyat on 14/07/23.
//

import UIKit

class MovieCastCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movieCreditsData: MovieCredit?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCollectionView()
    }
    
    func setupMovieCreditsData(data: MovieCredit) {
        movieCreditsData = data
        collectionView.reloadData()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "MovieCastDetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCastDetailCollectionViewCell")
    }
}

extension MovieCastCollectionViewCell: UICollectionViewDelegate {
    
}

extension MovieCastCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieCreditsData?.cast?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCastDetailCollectionViewCell", for: indexPath) as? MovieCastDetailCollectionViewCell else {
            return UICollectionViewCell()
        }
        let movieImage = movieCreditsData?.cast?[indexPath.row].profilePath
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: "https://image.tmdb.org/t/p/original\(movieImage ?? "")") {
                let data = try? Data(contentsOf: url)

                if let imageData = data {
                    DispatchQueue.main.async {
                        cell.movieCastImageView.image = UIImage(data: imageData)
                    }
                }
            }
        }
        cell.movieCastNameLabel.text = movieCreditsData?.cast?[indexPath.row].name
        return cell
    }
}

extension MovieCastCollectionViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.height)
    }
}
