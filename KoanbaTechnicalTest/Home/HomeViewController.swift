//
//  HomeViewController.swift
//  KoanbaTechnicalTest
//
//  Created by Iskandar Herputra Wahidiyat on 14/07/23.
//

import UIKit

class HomeViewController: BaseViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let refreshControl: UIRefreshControl = UIRefreshControl()
    let toolbar: UIToolbar = UIToolbar()
    
    var presenter: HomePresentation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.fetchMovieList(pageNumber: 1)
        setupView()
        setupTableView()
    }
    
    private func setupView() {
        searchBar.delegate = self
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.items = [flexibleSpace, doneButton]
        searchBar.searchTextField.inputAccessoryView = toolbar
        searchBar.searchTextField.placeholder = "Search"
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addSubview(refreshControl)
    }
    
    @objc func refreshData() {
        presenter?.fetchMovieList(pageNumber: 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.refreshControl.endRefreshing()
        }
    }
    
    @objc func doneButtonTapped() {
        searchBar.searchTextField.resignFirstResponder()
    }
}

extension HomeViewController: HomeView {
    func reloadTableView() {
        tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.navigateToDetail(indexPathRow: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.row == lastRowIndex {
            presenter?.pageNumber += 1
            presenter?.fetchMovieList(pageNumber: presenter?.pageNumber ?? 1)
            let topIndexPath = IndexPath(row: 0, section: 0)
            tableView.scrollToRow(at: topIndexPath, at: .top, animated: true)
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if presenter?.isSearchMode == true {
            return presenter?.tempSearchMovieData.count ?? 0
        } else {
            return presenter?.tempMovieData.count ?? 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        if presenter?.isSearchMode == true {
            let movieData = presenter?.tempSearchMovieData[indexPath.row]
            
            let movieImage = movieData?.posterPath ?? ""
            
            cell.movieImageView.image = nil
            
            DispatchQueue.global(qos: .background).async {
                if let url = URL(string: "https://image.tmdb.org/t/p/original\(movieImage)") {
                    let data = try? Data(contentsOf: url)
                    
                    if let imageData = data {
                        DispatchQueue.main.async {
                            cell.movieImageView.image = UIImage(data: imageData)
                        }
                    }
                }
            }
            
            cell.movieTitleLabel.text = movieData?.title ?? ""
            
            let dateString = movieData?.releaseDate ?? ""
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            if let date = dateFormatter.date(from: dateString) {
                let yearFormatter = DateFormatter()
                yearFormatter.dateFormat = "yyyy"
                let yearString = yearFormatter.string(from: date)
                cell.yearTitleLabel.text = yearString
            } else {
                cell.yearTitleLabel.text = ""
                print("Invalid date format")
            }
            
            var genreList: [String] = []
            
            if let genreIDS = movieData?.genreIDS {
                for genre in genreIDS {
                    if genre == 28 {
                        genreList.append("Action")
                    } else if genre == 12 {
                        genreList.append("Adventure")
                    } else if genre == 16 {
                        genreList.append("Animation")
                    } else if genre == 35 {
                        genreList.append("Comedy")
                    } else if genre == 80 {
                        genreList.append("Crime")
                    } else if genre == 99 {
                        genreList.append("Documentary")
                    } else if genre == 18 {
                        genreList.append("Drama")
                    } else if genre == 10751 {
                        genreList.append("Family")
                    } else if genre == 14 {
                        genreList.append("Fantasy")
                    } else if genre == 36 {
                        genreList.append("History")
                    } else if genre == 27 {
                        genreList.append("Horror")
                    } else if genre == 10402 {
                        genreList.append("Music")
                    } else if genre == 9648 {
                        genreList.append("Mystery")
                    } else if genre == 10749 {
                        genreList.append("Romance")
                    } else if genre == 878 {
                        genreList.append("Science Fiction")
                    } else if genre == 10770 {
                        genreList.append("TV Movie")
                    } else if genre == 53 {
                        genreList.append("Thriller")
                    } else if genre == 10752 {
                        genreList.append("War")
                    } else if genre == 37 {
                        genreList.append("Western")
                    }
                }
            }
            
            var genreDescription: String = ""
            for genre in genreList {
                genreDescription += " \(genre),"
            }
            if genreDescription != "" {
                genreDescription.removeLast()
            }
            
            cell.movieCategoryTitleLabel.text = genreDescription
            
            return cell
        } else {
            let movieData = presenter?.tempMovieData[indexPath.row]
            
            let movieImage = movieData?.posterPath ?? ""
            
            cell.movieImageView.image = nil
            
            DispatchQueue.global(qos: .background).async {
                if let url = URL(string: "https://image.tmdb.org/t/p/original\(movieImage)") {
                    let data = try? Data(contentsOf: url)
                    
                    if let imageData = data {
                        DispatchQueue.main.async {
                            cell.movieImageView.image = UIImage(data: imageData)
                        }
                    }
                }
            }
            
            cell.movieTitleLabel.text = movieData?.title ?? ""
            
            let dateString = movieData?.releaseDate ?? ""
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            if let date = dateFormatter.date(from: dateString) {
                let yearFormatter = DateFormatter()
                yearFormatter.dateFormat = "yyyy"
                let yearString = yearFormatter.string(from: date)
                cell.yearTitleLabel.text = yearString
            } else {
                cell.yearTitleLabel.text = ""
                print("Invalid date format")
            }
            
            var genreList: [String] = []
            
            if let genreIDS = movieData?.genreIDS {
                for genre in genreIDS {
                    if genre == 28 {
                        genreList.append("Action")
                    } else if genre == 12 {
                        genreList.append("Adventure")
                    } else if genre == 16 {
                        genreList.append("Animation")
                    } else if genre == 35 {
                        genreList.append("Comedy")
                    } else if genre == 80 {
                        genreList.append("Crime")
                    } else if genre == 99 {
                        genreList.append("Documentary")
                    } else if genre == 18 {
                        genreList.append("Drama")
                    } else if genre == 10751 {
                        genreList.append("Family")
                    } else if genre == 14 {
                        genreList.append("Fantasy")
                    } else if genre == 36 {
                        genreList.append("History")
                    } else if genre == 27 {
                        genreList.append("Horror")
                    } else if genre == 10402 {
                        genreList.append("Music")
                    } else if genre == 9648 {
                        genreList.append("Mystery")
                    } else if genre == 10749 {
                        genreList.append("Romance")
                    } else if genre == 878 {
                        genreList.append("Science Fiction")
                    } else if genre == 10770 {
                        genreList.append("TV Movie")
                    } else if genre == 53 {
                        genreList.append("Thriller")
                    } else if genre == 10752 {
                        genreList.append("War")
                    } else if genre == 37 {
                        genreList.append("Western")
                    }
                }
            }
            
            var genreDescription: String = ""
            for genre in genreList {
                genreDescription += " \(genre),"
            }
            if genreDescription != "" {
                genreDescription.removeLast()
            }
            
            cell.movieCategoryTitleLabel.text = genreDescription
            
            return cell
        }
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        presenter?.isSearchMode = true
        presenter?.searchMovie(query: searchText)
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            presenter?.isSearchMode = false
            reloadTableView()
        }
    }
}
