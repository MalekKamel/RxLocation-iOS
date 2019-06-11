//
// Created by mac on 2019-05-31.
// Copyright (c) 2019 A. All rights reserved.
//

import Foundation

extension NSObjectProtocol {
    /// Same as retain(), which the compiler no longer lets us call:
    @discardableResult
    func retainMe() -> Self {
        _ = Unmanaged.passRetained(self)
        return self
    }
    
    /// Same as autorelease(), which the compiler no longer lets us call.
    ///
    /// This function does an autorelease() rather than release() to give you more flexibility.
    @discardableResult
    func releaseMe() -> Self {
        _ = Unmanaged.passUnretained(self).autorelease()
        return self
    }
}
