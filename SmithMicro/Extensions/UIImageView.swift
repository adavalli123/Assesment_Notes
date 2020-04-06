import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    func getImage(from urlString: String) {
        self.image = nil
        let activityIndicator = UIActivityIndicatorView()
        self.addSubview(activityIndicator)
        activityIndicator.addConstaintsToSuperview()
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
        
        guard let url = URL(string: urlString) else { return }
        
        if let image = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            activityIndicator.stopAnimating()
            self.image = image
        } else {
            let session = URLSession(configuration: .default)
            let dataTask = session.dataTask(with: url) { (data, response, error) in
                guard let data = data else { return }
                guard let image = UIImage(data: data) else { return }
                
                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                    self.image = image
                    self.contentMode = .scaleAspectFill
                }

                imageCache.setObject(image, forKey: url.absoluteString as NSString)
            }
            
            dataTask.resume()
        }
    }
    
    static func updateAlbumImage(url: String, height: CGFloat, width: CGFloat? = nil) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        if let width = width {
            imageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        imageView.clipsToBounds = true
        imageView.getImage(from: url)
        return imageView
    }
}
