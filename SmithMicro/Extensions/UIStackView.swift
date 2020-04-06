import UIKit

extension UIStackView {
    static func configureStackView(spacing: CGFloat = 5, axis: NSLayoutConstraint.Axis = .vertical) -> UIStackView {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = axis
        stackView.distribution = .fill
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    func addArrangedSubViews(_ views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
