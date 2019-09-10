//
//  lyricModel.swift
//  ApiKey
//
//  Created by albert coelho oliveira on 9/10/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import Foundation

struct Lyric: Codable{
    let message: messaWrapper
    static func getLyric(userInput: Int,completionHandler: @escaping (Result<lyricsWrapper,AppError>) -> () ) {
        let url = "http://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=\(userInput)&apikey=3445509192b50cd7ccfe4df777f38cb2"
     print(url)
        NetWorkManager.shared.fetchData(urlString: url) { (result) in
            print(url)
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let decodedShow = try JSONDecoder().decode(Lyric.self, from: data)
        completionHandler(.success(decodedShow.message.body.lyrics))
                } catch {
                    completionHandler(.failure(.badJSONError))
                    print(error)
                }
            }
        }
    }
}
struct messaWrapper: Codable{
   let body: bodyWrapper
}
struct bodyWrapper: Codable{
    let lyrics: lyricsWrapper
}
struct lyricsWrapper: Codable {
    let lyrics_body: String
}
