
import UIKit

class ViewController: UIViewController {

    var userIsInTheMiddleOfTyping: Bool = false
    var dotEntered: Bool = false
    var operandArray = Array<Double>()

    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var displayLabel: UILabel!

    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            displayLabel.text = displayLabel.text! + digit
        } else {
            userIsInTheMiddleOfTyping = true
            displayLabel.text = digit
        }
    }

    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        
        if userIsInTheMiddleOfTyping {
            enter();
        }
        switch operation {
            case "x":
                performOperation {$0 * $1}
            case "÷":
                performOperation {$1 / $0}
            case "+":
                performOperation {$0 + $1}
            case "-":
                performOperation {$1 - $0}
            case "√":
                performOperation {sqrt($0)}
            case "sin":
                performOperation {sin($0)}
            case "cos":
                performOperation {cos($0)}
            case "π":
                performOperation {$0 * M_PI}
            default:
                break;
        }
    }
    

    @IBAction func dotEnter() {
        if dotEntered {
            return
        }
        
        dotEntered = true
        
        if userIsInTheMiddleOfTyping {
            displayLabel.text = displayLabel.text! + "."
        } else {
            userIsInTheMiddleOfTyping = true
            displayLabel.text = "0."
        }
    }
    
    @IBAction func onClear() {
        userIsInTheMiddleOfTyping = false
        dotEntered = false
        operandArray = Array<Double>()
        historyLabel.text = nil
        displayLabel.text = "0"
        
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if operandArray.count > 1 {
        displayValue = operation(operandArray.removeLast(), operandArray.removeLast())
        enter()
        }
    }
    
    func performOperation(operation: (Double) -> Double) {
        if operandArray.count > 0 {
            displayValue = operation(operandArray.removeLast())
            enter()
        }
    }
    
    @IBAction func enter() {
        userIsInTheMiddleOfTyping = false
        dotEntered = false
        operandArray.append(displayValue)
        historyLabel.text = "\(operandArray)"
    }
    
    var displayValue: Double {
        get {
            return NSNumberFormatter().numberFromString(displayLabel.text!)!.doubleValue
        }
        set {
            displayLabel.text = "\(newValue)"
            userIsInTheMiddleOfTyping = false;
        }
    }
}

