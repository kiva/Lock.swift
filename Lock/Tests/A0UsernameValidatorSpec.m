// A0UsernameValidatorSpec.m
//
// Copyright (c) 2014 Auth0 (http://auth0.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "A0LockTest.h"

#import "A0UsernameValidator.h"
#import "A0Errors.h"

SpecBegin(A0UsernameValidator)

describe(@"A0UsernameValidator", ^{

    __block A0UsernameValidator *validator;
    __block UITextField *field;

    beforeEach(^{
        field = mock(UITextField.class);
        validator = [[A0UsernameValidator alloc] initWithField:field];
    });

    it(@"should fail init with nil field", ^{
        expect(^{
            validator = [[A0UsernameValidator alloc] initWithField:nil];
        }).to.raise(NSInternalInconsistencyException);
    });

    context(@"valid username", ^{

        beforeEach(^{
            [given(field.text) willReturn:@"jdoe"];
        });

        specify(@"should obtain value from field", ^{
            [validator validate];
            [MKTVerify(field) text];
        });

        specify(@"no error", ^{
            expect([validator validate]).to.beNil();
        });

    });

    sharedExamplesFor(@"invalid username", ^(NSDictionary *data) {
        beforeEach(^{
            [given(field.text) willReturn:data[@"username"]];
        });

        specify(@"should obtain value from field", ^{
            [validator validate];
            [MKTVerify(field) text];
        });

        specify(@"an error", ^{
            expect([validator validate]).notTo.beNil();
        });

        specify(@"invalid username error code", ^{
            expect([[validator validate] code]).to.equal(@(A0ErrorCodeInvalidUsername));
        });

    });

    itShouldBehaveLike(@"invalid username", @{});
    itShouldBehaveLike(@"invalid username", @{@"username": @""});
    itShouldBehaveLike(@"invalid username", @{@"username": @"  "});

});

SpecEnd
