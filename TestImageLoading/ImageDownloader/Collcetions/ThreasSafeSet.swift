import Foundation

// A class that provides thread safety for Set
class ThreadSafeSet<T: Hashable> {
    private var setValue: Set<T> = []
    private let queue = DispatchQueue(label: "Thread Safe Set", qos: .utility, attributes: .concurrent)
    
    
    func insert(_ new: T) {
        queue.async(flags: .barrier) {
            self.setValue.insert(new)
        }
    }
    
    func contains(_ value: T) -> Bool {
        return queue.sync {
            setValue.contains(value)
        }
    }
    
    func remove(_ value: T) {
        queue.async(flags: .barrier) {
            self.setValue.remove(value)
        }
    }
}
