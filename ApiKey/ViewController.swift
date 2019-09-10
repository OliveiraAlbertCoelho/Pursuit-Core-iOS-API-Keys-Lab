//
//  ViewController.swift
//  ApiKey
//
//  Created by albert coelho oliveira on 9/9/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var musics = [TrackList](){
        didSet{
            artistTable.reloadData()
        }}
    @IBOutlet weak var artistSearch: UISearchBar!
    @IBOutlet weak var artistTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        artistTable.delegate = self
        artistTable.dataSource = self
        artistSearch.delegate = self
    }
    var userSearchTerm: String? {
        didSet {
            self.artistTable.reloadData()
        }
    }
    var filteredTrack: [TrackList]  {
        guard let userSearchTerm = userSearchTerm else {
            return musics
        }
        guard userSearchTerm != "" else {
            return musics
        }
        return musics
    }
    func loadData(word: String?){
        Music.getMusic(userInput: word){ (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let music):
                DispatchQueue.main.async{
                    return self.musics = music
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let musicVc = segue.destination as? lyricsViewController else {
            fatalError("Unexpected segue")
        }
        guard let selectedIndexPath = artistTable.indexPathForSelectedRow
            else { fatalError("No row selected") }
        musicVc.track = filteredTrack[selectedIndexPath.row]
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTrack.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = artistTable.dequeueReusableCell(withIdentifier: "musicCell", for: indexPath)
        let pick = musics[indexPath.row]
        cell.textLabel?.text = pick.track.track_name
        cell.detailTextLabel?.text = pick.track.artist_name
        return cell
    }
}
extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.userSearchTerm = searchText
        loadData(word: searchText)
    }
}
