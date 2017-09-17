//
//  MainListViewController.swift
//  Flicks
//
//  Created by Xiang Yu on 9/14/17.
//  Copyright © 2017 Xiang Yu. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MainListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    var movies: [Movie] = []
    var moviesToDisplay: [Movie] = []
    var endpoint: String!

    @IBOutlet weak var movieListTableView: UITableView!
    @IBOutlet weak var errorMsgLabel: UILabel!
    @IBOutlet weak var movieSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieListTableView.delegate = self
        movieListTableView.dataSource = self
        
        movieSearchBar.delegate = self
        
        self.navigationItem.title = navigationController?.tabBarItem.title

        // Initialize a UIRefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        // add refresh control to table view
        movieListTableView.insertSubview(refreshControl, at: 0)
        
        refreshControlAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! MovieDetailsViewController
        let indexPath = movieListTableView.indexPath(for: sender as! UITableViewCell)!

        destinationViewController.movie = moviesToDisplay[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = movieListTableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        cell.titleLabel?.text = moviesToDisplay[indexPath.row].title
        cell.overviewLabel?.text = moviesToDisplay[indexPath.row].overview
        
        if let posterUrl = URL(string: moviesToDisplay[indexPath.row].lowResPosterUrl!) {
            //AFNetworking async download img
            cell.posterImgView.setImageWith(
                URLRequest(url: posterUrl),
                placeholderImage: nil,
                success: { (imageRequest, imageResponse, image) -> Void in
                    
                    // imageResponse will be nil if the image is cached
                    if imageResponse != nil {
                        print("Image was NOT cached, fade in image")
                        cell.posterImgView.alpha = 0.0
                        cell.posterImgView.image = image
                        UIView.animate(withDuration: 1, animations: { () -> Void in
                            cell.posterImgView.alpha = 1.0
                        })
                    } else {
                        print("Image was cached so just update the image")
                        cell.posterImgView.image = image
                    }
            },
                failure: { (imageRequest, imageResponse, error) -> Void in
                    // do something for the failure condition
            })
        }
        else {
            //put a default pic here
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        movieListTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl?=nil) {
        // Display HUD right before the request is made
        let initialLoad = (refreshControl == nil)
        if initialLoad {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        
        Movie.fetchMovies(
            endpoint: self.endpoint,
            successCallBack: { data in
                // Hide HUD once the network request comes back (must be done on main UI thread)
                MBProgressHUD.hide(for: self.view, animated: true)
                
                if let movies = data.value(forKeyPath: "results") as? [NSDictionary] {
                    self.movies.removeAll()
                    
                    for movie in movies {
                        self.movies.append(Movie(jsonResult: movie))
                        print(self.movies.last?.title ?? "can't find a title or no movie")
                    }
                    self.filterMoviesForSearchText(self.movieSearchBar.text ?? "")
                    self.movieListTableView.reloadData()
                    
                    refreshControl?.endRefreshing()
                }
        },
            errorCallBack: { error in
                // Hide HUD once the network request comes back (must be done on main UI thread)
                MBProgressHUD.hide(for: self.view, animated: true)

                //self.errorMsgLabel.text = "Network Error..."
                self.errorMsgLabel.isHidden = false
                print("error")
                
                refreshControl?.endRefreshing()
        })
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterMoviesForSearchText(searchText)
        
        movieListTableView.reloadData()
    }
    
    func filterMoviesForSearchText(_ searchText: String) {
        if(searchText.isEmpty) {
            self.moviesToDisplay = self.movies
            return
        }
        
        self.moviesToDisplay = self.movies.filter({( movie: Movie) -> Bool in
            // to start, let's just search by name
            return movie.title?.lowercased().range(of: searchText.lowercased()) != nil
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
