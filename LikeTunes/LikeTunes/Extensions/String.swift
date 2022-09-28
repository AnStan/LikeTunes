
import Foundation

extension String {
    
    var asOptionalURL: URL? {
        return URL(string: self)
    }
    
    func changeSize() -> String? {
        return self.replacingOccurrences(of: "100x100bb", with: "500x500bb")
    }
}
