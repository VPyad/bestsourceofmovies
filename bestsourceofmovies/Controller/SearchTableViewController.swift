//
//  SearchTableViewController.swift
//  bestsourceofmovies
//
//  Created by Vadim on 06/05/2018.
//  Copyright © 2018 Vadim. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {
    let searchBar = UISearchBar()
    
    var movieSource = [MoviePreviewStruct]()
    var movieProvider = MovieProvider()
    
    // used for paggination
    var page = 1
    var q = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        createSearchBar()
        
        let nibName = UINib(nibName: "MainMovieTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "mainMovieTableViewCell")
    }
    
    func createSearchBar() {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = false
        searchBar.placeholder = "search best movies ever"
        searchBar.delegate = self
        
        self.navigationItem.titleView = searchBar
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        self.navigationItem.setHidesBackButton(false, animated: true)
        searchBar.endEditing(true)
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if (searchBar.text != nil && searchBar.text != "") {
            requestMovies(q: searchBar.text!)
            q = searchBar.text!
            searchBar.endEditing(true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieSource.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 197
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainMovieTableViewCell", for: indexPath) as! MainMovieTableViewCell
        
        cell.titleLabel.text = movieSource[indexPath.row].title!
        cell.overviewLabel.text = movieSource[indexPath.row].overview!
        
        let url = URL(string: movieSource[indexPath.row].posterPath!)
        cell.posterUIImageView.sd_setImage(with: url, completed: nil)
        
        cell.votesLabel.text = MoviePreviewUtil.formatVoteNumber(votes: movieSource[indexPath.row].voteCount)
        cell.releaseDateLabel.text = MoviePreviewUtil.formatReleaseDate(date: movieSource[indexPath.row].releaseDate!)
        
        return cell
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height) {
            if (q != "") {
                requestMovies(q: q)
            }
        }
    }
    
    func populateMovies(movies: [MoviePreviewStruct]){
        movies.forEach {
            movie in
            movieSource.append(movie)
        }
    }
    
    func clearMovieSource() {
        movieSource.removeAll()
    }
    
    func requestMovies(q: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        movieProvider.searchMovies(page: self.page, q: q, completion: {
            result in
            switch result {
            case .success(let movies):
                self.populateMovies(movies: movies)
                self.page = self.page + 1
                self.tableView.reloadData()
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            case .failure(let error):
                print("error during loading data")
                self.showError(text: "An error ocuried during loading best movies for you")
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        })
    }
    
    func showError(text: String) {
        let alert = UIAlertController(title: "We are so sorry", message: text, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Forgive me", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
