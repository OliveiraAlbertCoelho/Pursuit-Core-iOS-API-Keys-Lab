//
//  lyricsViewController.swift
//  ApiKey
//
//  Created by albert coelho oliveira on 9/10/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import UIKit

class lyricsViewController: UIViewController {
    var track: TrackList?
    var lyric: lyricsWrapper?{
        didSet{
            setLabels()
        }
    }
    
    @IBOutlet weak var musicName: UILabel!
    @IBOutlet weak var musicArtist: UILabel!
    @IBOutlet weak var lyrics: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData(word: track?.track.track_id)
    }
    
    func loadData(word: Int?){
        if let word = word{
        Lyric.getLyric(userInput: word){ (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let music):
                DispatchQueue.main.async{
                return self.lyric = music.self
                }
            }
        }
        }}
    func setLabels(){
        musicName.text = track?.track.track_name
        musicArtist.text = track?.track.artist_name
        lyrics.text = lyric?.lyrics_body
    }
}
