/*
 * Copyright (c) 2026. All rights reserved.
 * Licensed under the MIT License. See LICENSE file in the project root for details.
 */

/**
 * Test class for ActionWrapper.
 */
@IsTest
private class ActionWrapperTest {

    @IsTest
    static void validate_noClassName() {
        ActionWrapper action = new ActionWrapper();
        action.methodName = 'someMethod';

        Test.startTest();
        try {
            action.validate();
            Assert.fail('Expected ActionWrapperException was not thrown');
        } catch (Exception e) {
            Assert.isInstanceOfType(e, ActionWrapper.ActionWrapperException.class, 'Expected ActionWrapperException to be thrown');
        }
        Test.stopTest();
    }

    @IsTest
    static void validate_noMethodName() {
        ActionWrapper action = new ActionWrapper();
        action.className = 'SomeClass';

        Test.startTest();
        try {
            action.validate();
            Assert.fail('Expected ActionWrapperException was not thrown');
        } catch (Exception e) {
            Assert.isInstanceOfType(e, ActionWrapper.ActionWrapperException.class, 'Expected ActionWrapperException to be thrown');
        }
        Test.stopTest();
    }

    @IsTest
    static void validate_validAction() {
        ActionWrapper action = new ActionWrapper(
            'SomeClass',
            'someMethod',
            null
        );

        Test.startTest();
        try {
            action.validate();
        } catch (Exception e) {
            Assert.fail('No exception should be thrown for a valid action');
        }
        Test.stopTest();
    }
}