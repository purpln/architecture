import UIKit

public typealias View = UIView & ViewProtocol & ViewRouter

public protocol ViewRouter {
    associatedtype Router: RouterProtocol
    var router: Router! { get set }
}

public protocol ViewProtocol: UIView, AnyViewProtocol {
    func configure()
    func load()
}

extension ViewProtocol {
    public func configure() { }
    public func load() { }
    
    public static func createView(_ router: RouterProtocol) -> UIView? { nil }
}

public protocol AnyViewProtocol {
    static func createView(_ router: RouterProtocol) -> UIView?
}

extension ViewProtocol where Self: ViewRouter {
    public static func createView(_ router: RouterProtocol) -> UIView? {
        guard let router = router as? Router else { return nil }
        var view = Self(frame: .zero)
        view.router = router
        view.configure()
        return view
    }
}


