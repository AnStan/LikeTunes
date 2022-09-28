
import Foundation

struct SongItemCellDataModel {
    
    let artistName: String?
    let trackName : String?
    let artworkUrl: URL?
    let isLiked: Bool
    
    init(song: Song, isLiked: Bool) {
        
        self.artistName = song.artistName
        self.trackName = song.trackName
        self.artworkUrl = song.artworkUrl100?.changeSize()?.asOptionalURL
        self.isLiked = isLiked
    }
}
