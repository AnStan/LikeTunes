
import UIKit
import AlamofireImage

class SongItemCell: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var coverImage: UIImageView!
    @IBOutlet private weak var artistLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var likeButton: UIButton!
    
    // MARK: - State
    
    private var isLiked = false
    
    // MARK: - Callback
    
    var action: (() -> Void)?
    
    // MARK: - Display
    
    func display(with model: SongItemCellDataModel) {
        
        artistLabel.text = model.artistName
        titleLabel.text = model.trackName
        isLiked = model.isLiked
        setButtonImage(for: isLiked)
        
        let defaultImg = UIImage(systemName: "music.note.list")
        
        if let artworkUrl = model.artworkUrl {
            coverImage.af.setImage(withURL: artworkUrl,
                                   placeholderImage: defaultImg)
        } else {
            coverImage.image = defaultImg
        }
    }
    
    // MARK: - Action
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        self.isLiked = !isLiked
        setButtonImage(for: isLiked)
        action?()
    }
    
    // MARK: - Private
    
    private func setButtonImage(for isLiked: Bool) {
        let buttonImage = isLiked ? UIImage.init(systemName: "star.fill") : UIImage.init(systemName: "star")
        likeButton.setImage(buttonImage, for: .normal)
    }
}
