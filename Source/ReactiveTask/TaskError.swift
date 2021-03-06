import Foundation

/// An error originating from ReactiveTask.
public enum TaskError: Error, Equatable {
    
    /// A shell task failed to launch
    case launchFailed(Task, reason: String?)
    
    /// A shell task exited unsuccessfully.
    case shellTaskFailed(Task, exitCode: Int32, standardError: String?)
    
    /// An error was returned from a POSIX API.
    case posixError(Int32)
}

extension TaskError: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .launchFailed(task, reason: reason):
            var description = "A shell task (\(task)) failed to launch"
            if let reason = reason {
                description += ":\n\(reason)"
            }
            return description
            
        case let .shellTaskFailed(task, exitCode, standardError):
            var description = "A shell task (\(task)) failed with exit code \(exitCode)"
            if let standardError = standardError {
                description += ":\n\(standardError)"
            }
            return description
            
        case let .posixError(code):
            return NSError(domain: NSPOSIXErrorDomain, code: Int(code), userInfo: nil).description
        }
    }
}
