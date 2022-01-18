import UIKit

/**
 custom NavigationBar
 */
public class NavigationBar: UINavigationBar {
    var background: UIColor? = nil { didSet { configure() } }
    var color: UIColor? = nil { didSet { configure() } }
    var view = UIView()
    var atributes: [NSAttributedString.Key: Any] = [:]
    
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
        atributes[.foregroundColor] = color
        titleTextAttributes = atributes
        return self
    }
    @discardableResult public
    func back(_ color: UIColor?) -> Self {
        background = color
        return self
    }
    @discardableResult public
    func font(_ font: UIFont?) -> Self {
        atributes[.font] = font
        titleTextAttributes = atributes
        return self
    }
}


