import Prelude
import UIKit

public protocol UIViewProtocol: KSObjectProtocol, UITraitEnvironmentProtocol, LensObject {
  func addConstraints(_ constraints: [NSLayoutConstraint])
  var alpha: CGFloat { get set }
  var backgroundColor: UIColor? { get set }
  var clipsToBounds: Bool { get set }
  var constraints: [NSLayoutConstraint] { get }
  func contentCompressionResistancePriority(for axis: NSLayoutConstraint.Axis) -> UILayoutPriority
  func contentHuggingPriority(for axis: NSLayoutConstraint.Axis) -> UILayoutPriority
  var contentMode: UIView.ContentMode { get set }
  var frame: CGRect { get set }
  var isHidden: Bool { get set }
  var layer: CALayer { get }
  var layoutMargins: UIEdgeInsets { get set }
  var preservesSuperviewLayoutMargins: Bool { get set }
  func removeConstraints(_ constraints: [NSLayoutConstraint])
  var semanticContentAttribute: UISemanticContentAttribute { get set }
  func setContentCompressionResistancePriority(_ priority: UILayoutPriority,
                                               for axis: NSLayoutConstraint.Axis)
  func setContentHuggingPriority(_ priority: UILayoutPriority,
                                 for axis: NSLayoutConstraint.Axis)
  var tag: Int { get set }
  var tintColor: UIColor! { get set }
  var translatesAutoresizingMaskIntoConstraints: Bool { get set }
  var isUserInteractionEnabled: Bool { get set }
}

extension UIView: UIViewProtocol {}

public extension LensHolder where Object: UIViewProtocol {
  var alpha: Lens<Object, CGFloat> {
    return Lens(
      view: { $0.alpha },
      set: { $1.alpha = $0; return $1 }
    )
  }

  var backgroundColor: Lens<Object, UIColor> {
    return Lens(
      view: { $0.backgroundColor ?? .clear },
      set: { $1.backgroundColor = $0; return $1 }
    )
  }

  var clipsToBounds: Lens<Object, Bool> {
    return Lens(
      view: { $0.clipsToBounds },
      set: { $1.clipsToBounds = $0; return $1 }
    )
  }

  var constraints: Lens<Object, [NSLayoutConstraint]> {
    return Lens(
      view: { $0.constraints },
      set: {
        $1.removeConstraints($1.constraints)
        $1.addConstraints($0)
        return $1
      }
    )
  }

  func contentCompressionResistancePriority(for axis: NSLayoutConstraint.Axis)
    -> Lens<Object, UILayoutPriority> {

    return Lens(
      view: { $0.contentCompressionResistancePriority(for: axis) },
      set: { $1.setContentCompressionResistancePriority($0, for: axis); return $1 }
    )
  }

  func contentHuggingPriority(for axis: NSLayoutConstraint.Axis)
    -> Lens<Object, UILayoutPriority> {

      return Lens(
        view: { $0.contentHuggingPriority(for: axis) },
        set: { $1.setContentHuggingPriority($0, for: axis); return $1 }
      )
  }

  var contentMode: Lens<Object, UIView.ContentMode> {
    return Lens(
      view: { $0.contentMode },
      set: { $1.contentMode = $0; return $1 }
    )
  }

  var frame: Lens<Object, CGRect> {
    return Lens(
      view: { $0.frame },
      set: { $1.frame = $0; return $1 }
    )
  }

  var isHidden: Lens<Object, Bool> {
    return Lens(
      view: { $0.isHidden },
      set: { $1.isHidden = $0; return $1 }
    )
  }

  var isUserInteractionEnabled: Lens<Object, Bool> {
    return Lens(
      view: { $0.isUserInteractionEnabled },
      set: { $1.isUserInteractionEnabled = $0; return $1 }
    )
  }

  var layer: Lens<Object, CALayer> {
    return Lens(
      view: { $0.layer },
      set: { $1 }
    )
  }

  var layoutMargins: Lens<Object, UIEdgeInsets> {
    return Lens(
      view: { $0.layoutMargins },
      set: { $1.layoutMargins = $0; return $1 }
    )
  }

  var preservesSuperviewLayoutMargins: Lens<Object, Bool> {
    return Lens(
      view: { $0.preservesSuperviewLayoutMargins },
      set: { $1.preservesSuperviewLayoutMargins = $0; return $1 }
    )
  }

  var semanticContentAttribute: Lens<Object, UISemanticContentAttribute> {
    return Lens(
      view: { $0.semanticContentAttribute },
      set: { $1.semanticContentAttribute = $0; return $1; }
    )
  }

  var tag: Lens<Object, Int> {
    return Lens(
      view: { $0.tag },
      set: { $1.tag = $0; return $1 }
    )
  }

  var tintColor: Lens<Object, UIColor> {
    return Lens(
      view: { $0.tintColor },
      set: { $1.tintColor = $0; return $1 }
    )
  }

  var translatesAutoresizingMaskIntoConstraints: Lens<Object, Bool> {
    return Lens(
      view: { $0.translatesAutoresizingMaskIntoConstraints },
      set: { $1.translatesAutoresizingMaskIntoConstraints = $0; return $1 }
    )
  }
}

public extension Lens where Whole: UIViewProtocol, Part == CGRect {
  var origin: Lens<Whole, CGPoint> {
    return Whole.lens.frame..CGRect.lens.origin
  }
  var size: Lens<Whole, CGSize> {
    return Whole.lens.frame..CGRect.lens.size
  }
}

public extension Lens where Whole: UIViewProtocol, Part == CGPoint {
  var x: Lens<Whole, CGFloat> {
    return Whole.lens.frame.origin..CGPoint.lens.x
  }
  var y: Lens<Whole, CGFloat> {
    return Whole.lens.frame.origin..CGPoint.lens.y
  }
}

public extension Lens where Whole: UIViewProtocol, Part == CGSize {
  var width: Lens<Whole, CGFloat> {
    return Whole.lens.frame.size..CGSize.lens.width
  }
  var height: Lens<Whole, CGFloat> {
    return Whole.lens.frame.size..CGSize.lens.height
  }
}

public extension Lens where Whole: UIViewProtocol, Part == CALayer {
  var borderColor: Lens<Whole, CGColor?> {
    return Whole.lens.layer..Part.lens.borderColor
  }

  var borderWidth: Lens<Whole, CGFloat> {
    return Whole.lens.layer..Part.lens.borderWidth
  }

  var cornerRadius: Lens<Whole, CGFloat> {
    return Whole.lens.layer..Part.lens.cornerRadius
  }

  var masksToBounds: Lens<Whole, Bool> {
    return Whole.lens.layer..Part.lens.masksToBounds
  }

  var shadowColor: Lens<Whole, CGColor?> {
    return Whole.lens.layer..CALayer.lens.shadowColor
  }

  var shadowOffset: Lens<Whole, CGSize> {
    return Whole.lens.layer..CALayer.lens.shadowOffset
  }

  var shadowOpacity: Lens<Whole, Float> {
    return Whole.lens.layer..CALayer.lens.shadowOpacity
  }

  var shadowRadius: Lens<Whole, CGFloat> {
    return Whole.lens.layer..CALayer.lens.shadowRadius
  }

  var shouldRasterize: Lens<Whole, Bool> {
    return Whole.lens.layer..CALayer.lens.shouldRasterize
  }
}
