
import Foundation

class DefaultsService {
    
    static let shared = DefaultsService()
    
    private let defaults = UserDefaults.standard
    private let songsIDsStorageKey = "SavedSongsIds"
    
    var likedSongsIds: [Int] {
        get {
            return UserDefaults.standard.array(forKey: songsIDsStorageKey) as? [Int] ?? []
        }
        set {
            var arr = likedSongsIds
            if !arr.contains(newValue) {
                arr.append(contentsOf: newValue)
                UserDefaults.standard.set(arr, forKey: songsIDsStorageKey)
            } else {
                arr = arr.filter({ value in value != newValue.first })
                UserDefaults.standard.set(arr, forKey: songsIDsStorageKey)
            }
        }
    }
}
