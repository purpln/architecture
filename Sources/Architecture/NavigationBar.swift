#if APP_ARCHITECTURE

import UIKit

/**
 custom NavigationBar
 */
public class NavigationBar: UINavigationBar {
    var background: UIColor? = nil { didSet { configure() } }
    var color: UIColor? = nil { didSet { configure() } }
    var view = UIView()
    
    func configure() {
        for subview in subviews {
            let string = String(describing: type(of: subview))
            sendSubviewToBack(view)
            view.backgroundColor = background
            if string.contains("BarBackground") { view.frame = subview.frame }
            if string.contains("BarBackground") { subview.removeFromSuperview() }
            if string.contains("LargeTitle") && background != nil { subview.backgroundColor = background }
            if string.contains("LargeTitle") && color != nil {
                (subview.subviews.first as? UILabel)?.textColor = color }
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        configure()
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        addSubview(view)
    }
}

extension NavigationBar {
    @discardableResult public
    func color(_ color: UIColor?) -> Self {
        self.color = color
        guard let color = color else { return self }
        titleTextAttributes = [.foregroundColor: color]
        return self
    }
    @discardableResult public
    func back(_ color: UIColor?) -> Self {
        background = color
        return self
    }
    @discardableResult public
    func font(_ font: UIFont?) -> Self {
        guard let font = font else { return self }
        titleTextAttributes = [.font: font]
        return self
    }
    @discardableResult public
    func large(_ bool: Bool) -> Self {
        if #available(iOS 11.0, *) { prefersLargeTitles = bool }
        return self
    }
}

#endif
