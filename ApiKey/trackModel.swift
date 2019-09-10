
//
//  trackModel.swift
//  ApiKey
//
//  Created by albert coelho oliveira on 9/9/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import Foundation

struct Music: Codable{
    let message: Message
    static func getMusic(userInput: String?,completionHandler: @escaping (Result<[TrackList],AppError>) -> () ) {
        var url = "http://api.musixmatch.com/ws/1.1/track.search?q_artist=kanye&page_size=100&page=1&s_track_rating=desc&apikey=3445509192b50cd7ccfe4df777f38cb2"
        if let word = userInput{
            let newString = word.replacingOccurrences(of: " ", with: "-")
            url = "http://api.musixmatch.com/ws/1.1/track.search?q_artist=\(newString)&page_size=100&page=1&s_track_rating=desc&apikey=3445509192b50cd7ccfe4df777f38cb2"
            
        }
        NetWorkManager.shared.fetchData(urlString: url) { (result) in
            print(url)
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let decodedShow = try JSONDecoder().decode(Music.self, from: data)
                    completionHandler(.success(decodedShow.message.body.track_list))
                } catch {
                    completionHandler(.failure(.badJSONError))
                    print(error)
                }
            }
        }
    }
}
struct Message: Codable{
    let body: Body
}
struct Body: Codable{
    let track_list: [TrackList]
}
struct TrackList: Codable{
    let track: Track
}
struct Track: Codable{
    let track_id: Int
    let track_name: String
    let artist_name: String
}




