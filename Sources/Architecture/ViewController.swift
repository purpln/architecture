import UIKit

public class ViewController: UIViewController {
    //var StatusBarStyle: StatusBarStyle { .default }
    var StatusBarHidden: Bool { false }
    var NavigationBarHidden: Bool { false }
    var NavigationBarClear: Bool { false }
    var NavigationBarColor: UIColor? { nil }
    var NavigationBarTitle: String { "" }
    var HomeIndicatorAutoHidden: Bool { false }
    var content: UIView? { nil }
    
    public override var prefersStatusBarHidden: Bool { StatusBarHidden }
    public override var preferredStatusBarStyle: UIStatusBarStyle { .light }
    public override var prefersHomeIndicatorAutoHidden: Bool { HomeIndicatorAutoHidden }
    
    var navigation: NavigationController? {
        guard let navigation = navigationController as? NavigationController else { return nil }
        return navigation
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = NavigationBarTitle
        if NavigationBarColor != nil {
            navigation?.bar?.color = NavigationBarColor
        }
        if let view = content {
            self.view = view
        }
        configure()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        if NavigationBarHidden {
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
        super.viewWillAppear(animated)
        willAppear()
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        if NavigationBarHidden {
            navigationController?.setNavigationBarHidden(false, animated: true)
        }
        super.viewWillDisappear(animated)
        willDisappear()
    }
    
    func configure() { }
    func willAppear() { }
    func willDisappear() { }
    
    public init() { super.init(nibName: nil, bundle: nil) }
    
    required public init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension UIStatusBarStyle {
    static var dark: UIStatusBarStyle { .lightContent }
    static var light: UIStatusBarStyle { if #available(iOS 13.0, *) { return .darkContent } else { return .lightContent } }
}


