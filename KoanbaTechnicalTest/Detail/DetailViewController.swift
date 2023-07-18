//
//  DetailViewController.swift
//  KoanbaTechnicalTest
//
//  Created by Iskandar Herputra Wahidiyat on 14/07/23.
//

import UIKit

class DetailViewController: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: DetailPresentation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "MovieDetailHeaderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieDetailHeaderCollectionViewCell")
        collectionView.register(UINib(nibName: "MovieDescriptionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieDescriptionCollectionViewCell")
        collectionView.register(UINib(nibName: "MovieCastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCastCollectionViewCell")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderViewIdentifier")
    }
}

extension DetailViewController: DetailView {
    func reloadCollectionView() {
        collectionView.reloadData()
    }
}

extension DetailViewController: UICollectionViewDelegate {

}

extension DetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieDetailHeaderCollectionViewCell", for: indexPath) as? MovieDetailHeaderCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.backButton.addAction { [weak self] in
                self?.presenter?.popViewController()
            }
            
            let movieImage = presenter?.movieDetailData?.posterPath
            DispatchQueue.global(qos: .background).async {
                if let url = URL(string: "https://image.tmdb.org/t/p/original\(movieImage ?? "")") {
                    let data = try? Data(contentsOf: url)
                    
                    if let imageData = data {
                        DispatchQueue.main.async {
                            cell.movieDetailImageView.image = UIImage(data: imageData)
                            cell.movieDetailImageView.alpha = 0.2
                        }
                    }
                }
            }
            
            cell.movieTitleLabel.text = presenter?.movieDetailData?.title
            let minutesString = "\(presenter?.movieDetailData?.runtime ?? 0)"
            if let formattedTime = StringHelper().convertMinutesToHoursMinutes(minutesString: minutesString) {
                cell.movieDurationLabel.text = formattedTime
            }
            
            var genreDescription: String = ""
            if let genreData = presenter?.movieDetailData?.genres {
                for item in genreData {
                    genreDescription += " \(item.name ?? ""),"
                }
                genreDescription.removeLast()
            }
            cell.movieCategoryLabel.text = genreDescription
            return cell
        } else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieDescriptionCollectionViewCell", for: indexPath) as? MovieDescriptionCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.movieDescriptionLabel.text = presenter?.movieDetailData?.overview ?? ""
            return cell
        } else if indexPath.section == 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCastCollectionViewCell", for: indexPath) as? MovieCastCollectionViewCell else {
                return UICollectionViewCell()
            }
            if let movieCreditsData = presenter?.movieCreditsData {
                cell.setupMovieCreditsData(data: movieCreditsData)
            }
            return cell
        }
        return UICollectionViewCell()
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderViewIdentifier", for: indexPath)
            let titleLabel = UILabel()
            titleLabel.text = "Cast"
            titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
            titleLabel.textColor = UIColor.black
            titleLabel.frame = CGRect(x: 16, y: 0, width: collectionView.bounds.width - 32, height: 50)
            headerView.addSubview(titleLabel)
            
            return headerView
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 2 {
            return CGSize(width: collectionView.bounds.width, height: 50)
        } else {
            return CGSize.zero
        }
    }
}
