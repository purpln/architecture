import UIKit

public typealias Navigation = NavigationController

public class NavigationController: UINavigationController {
    public var bar: NavigationBar? {
        guard let bar = navigationBar as? NavigationBar else { return nil }
        return bar
    }
    
    @discardableResult public
    func hidden(_ bool: Bool) -> Self {
        setNavigationBarHidden(bool, animated: true)
        return self
    }
    
    public override var prefersStatusBarHidden: Bool {
        visibleViewController?.prefersStatusBarHidden ?? false
    }
    public override var preferredStatusBarStyle : UIStatusBarStyle {
        if let vc = viewControllers.last {
            return vc.preferredStatusBarStyle
        }
        return .default
    }
    
    public init() {
        super.init(navigationBarClass: NavigationBar.self, toolbarClass: nil)
    }
    
    public init(_ rootViewController: UIViewController) {
        super.init(navigationBarClass: NavigationBar.self, toolbarClass: nil)
        (rootViewController as? ControllerProtocol)?.initialize()
        self.viewControllers = [rootViewController]
    }
    
    override public init(rootViewController: UIViewController) {
        super.init(navigationBarClass: NavigationBar.self, toolbarClass: nil)
        (rootViewController as? ControllerProtocol)?.initialize()
        self.viewControllers = [rootViewController]
    }
    
    required public init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}


