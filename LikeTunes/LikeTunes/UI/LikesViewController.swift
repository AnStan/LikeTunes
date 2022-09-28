
import UIKit

class LikesViewController: BaseSongsCollectionViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        needsToRefreshAfterUpdate = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setup()
    }
    
    // MARK: - Private
    
    private func setup() {
        fetchLikedSongs()
    }
}
