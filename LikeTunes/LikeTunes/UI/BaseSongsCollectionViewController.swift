
import UIKit

class BaseSongsCollectionViewController: UIViewController, ActivityIndicatorPresenter {
    
    internal var activityIndicator = UIActivityIndicatorView()
    
    // MARK: - UI Components
    
    @IBOutlet private(set) var collectionView: UICollectionView!
    
    // MARK: - Data Source
    
    private(set) lazy var dataSource: SongsDataSource = SongsDataSource()
    
    // MARK: - State
    
    var needsToRefreshAfterUpdate: Bool = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "SongItemCell",
                                      bundle: Bundle.main),
                                forCellWithReuseIdentifier: "SongItemCell")
        
        let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        
        collectionViewLayout?.sectionInset = UIEdgeInsets(top: 10,
                                                          left: 10,
                                                          bottom: 10,
                                                          right: 10)
        collectionViewLayout?.invalidateLayout()
    }
    
    // MARK: - Display
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func fetchLikedSongs() {
        showActivityIndicator()
        dataSource.fetchLikedSongs { [weak self] in
            self?.hideActivityIndicator()
            self?.reloadData()
        }
    }
    
    func fetchSongs(with text: String) {
        showActivityIndicator()
        dataSource.fetchSongs(with: text) { [weak self] in
            self?.hideActivityIndicator()
            self?.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension BaseSongsCollectionViewController: UICollectionViewDelegate,
                                             UICollectionViewDataSource,
                                             UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        dataSource.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SongItemCell",
                                                            for: indexPath as IndexPath) as? SongItemCell,
              let id = dataSource.items[indexPath.row].trackId else {
            return UICollectionViewCell()
        }
        
        let model = SongItemCellDataModel(song: dataSource.items[indexPath.row],
                                          isLiked: dataSource.isSongLiked(with: id))
        cell.display(with: model)
        
        cell.action = { [weak self] in
            self?.handleAction(for: id)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.width - 40)/2
        return CGSize(width: width, height: 230)
    }
    
    private func handleAction(for id: Int) {
        
        dataSource.updateLikedSong(id: id)
        
        if needsToRefreshAfterUpdate {
            fetchLikedSongs()
        }
    }
}
