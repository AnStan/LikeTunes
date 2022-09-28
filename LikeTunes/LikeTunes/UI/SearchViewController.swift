
import UIKit

class SearchViewController: BaseSongsCollectionViewController, UISearchBarDelegate {
    
    // MARK: - Outlets

    @IBOutlet private weak var searchBar: UISearchBar!

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let text = searchBar.text, !text.isEmpty else { return }
        fetchSongs(with: text)
    }
    
    // MARK: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else { return }
        fetchSongs(with: text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    // MARK: - Private
    
    private func setup() {
        navigationItem.titleView = searchBar
        searchBar.delegate = self
    }
}
