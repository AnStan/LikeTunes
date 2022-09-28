
import Foundation
import Alamofire

class APIService {
    
    static let shared = APIService()
    
    func fetchSongs(with keyword: String,
                    completion: @escaping ([Song]) -> Void) {
        
        let escapedString = keyword.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        guard let request = makeRequest(with: "https://itunes.apple.com/search",
                                        queryItems: [URLQueryItem(name: "term", value: escapedString)]) else {
            completion([])
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in

            do {
                
                let songsResult = try JSONDecoder().decode(SongsResult.self, from: data!)
                let fileterd = self.filterOutWithoutIDs(songs: songsResult.results)
                completion(fileterd)
                
            } catch {
                completion([])
            }
        })
        task.resume()
    }
    
    func fetchSongs(with ids: [Int],
                    completion: @escaping ([Song]) -> Void)  {
        
        let stringArray = ids.map(String.init)
        let combinedString = stringArray.joined(separator: ",")
        
        guard let request = makeRequest(with: "https://itunes.apple.com/lookup",
                                        queryItems: [URLQueryItem(name: "id", value: combinedString)]) else {
            completion([])
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in

            do {
                
                let songsResult = try JSONDecoder().decode(SongsResult.self, from: data!)
                let fileterd = self.filterOutWithoutIDs(songs: songsResult.results)
                completion(fileterd)
                
            } catch {
                completion([])
            }
        })
        task.resume()
    }
    
    private func makeRequest(with url: String, queryItems: [URLQueryItem]) -> URLRequest? {
        
        guard var url = URLComponents(string: url) else {
            return nil
        }
        
        url.queryItems = queryItems
        
        guard let url = url.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    private func filterOutWithoutIDs(songs: [Song]?) -> [Song] {
        let filteredSongs = songs?.filter({ song in
            return song.trackId != nil
        })
        return filteredSongs ?? []
    }
}
