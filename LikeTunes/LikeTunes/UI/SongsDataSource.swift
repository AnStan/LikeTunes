
import Foundation

class SongsDataSource {
    
    // MARK: - Dependencies

    private var defaults = DefaultsService.shared
    private var api = APIService.shared
    
    var items: [Song] = []
    
    func isListEmpty() -> Bool {
        return items.isEmpty
    }

    func fetchSongs(with text: String, completion: @escaping () -> Void) {
        
        api.fetchSongs(with: text) { [weak self] songs in
            self?.items = songs
            completion()
        }
    }
    
    func fetchLikedSongs(completion: @escaping () -> Void) {
        
        api.fetchSongs(with: defaults.likedSongsIds) { [weak self] songs in
            self?.items = songs
            completion()
        }
    }
    
    func updateLikedSong(id: Int) {
        defaults.likedSongsIds = [id]
    }
    
    func isSongLiked(with songID: Int) -> Bool {
        let savedSongs = getLikedIDs()
        let result = savedSongs.contains { id in
            return id == songID
        }
        return result
    }
    
    private func getLikedIDs() -> [Int] {
        return defaults.likedSongsIds
    }
}
