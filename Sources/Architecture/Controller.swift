import UIKit

public typealias Controller = UIViewController & ControllerProtocol & ControllerViewing

public protocol ControllerProtocol: UIViewController {
    @discardableResult
    func initialize() -> Self
    func configure()
}

extension ControllerProtocol {
    @discardableResult
    public func initialize() -> Self { return self }
    public func configure() { }
    
    public var navigation: NavigationController? {
        guard let navigation = navigationController as? NavigationController else { return nil }
        return navigation
    }
    
    public init() {
        self.init(nibName: nil, bundle: nil)
    }
}

public protocol ControllerViewing {
    associatedtype Router: RouterProtocol
    var router: Router { get set }
    
    var iphoneView: AnyViewProtocol.Type? { get }
    var ipadView: AnyViewProtocol.Type? { get }
    var macView: AnyViewProtocol.Type? { get }
}

extension ControllerViewing where Self: ControllerProtocol {
    public var iphoneView: AnyViewProtocol.Type? { nil }
    public var ipadView: AnyViewProtocol.Type? { nil }
    public var macView: AnyViewProtocol.Type? { nil }
    
    public var router: SomeRouter {
        set { }
        get { SomeRouter() }
    }
    
    @discardableResult
    public func initialize() -> Self {
        if view is ViewProtocol { return self }
        var protocolView: UIView?
        #if targetEnvironment(macCatalyst)
            if let view = macView {
                protocolView = view.createView(router)
            }
        #else
            if UIDevice.current.userInterfaceIdiom == .pad, let view = ipadView {
                protocolView = view.createView(router)
            } else if UIDevice.current.userInterfaceIdiom == .phone, let view = iphoneView {
                protocolView = view.createView(router)
            }
        #endif
        
        view = protocolView ?? view
        configure()
        return self
    }
    
    public func load() {
        guard let view = view as? ViewProtocol else { return }
        view.load()
    }
}


