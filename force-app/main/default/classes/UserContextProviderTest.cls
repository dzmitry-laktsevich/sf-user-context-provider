/*
 * Copyright (c) 2026. All rights reserved.
 * Licensed under the MIT License. See LICENSE file in the project root for details.
 */

/**
 * Test class for UserContextProvider.
 */
@IsTest
private class UserContextProviderTest {

    @IsTest
    static void runActionAs_nullAction() {
        ActionWrapper action = null;
        Test.startTest();
        try {
            UserContextProvider.runActionAs(action, null);
            Assert.fail('Expected UserContextProviderException was not thrown');
        } catch (Exception e) {
            Assert.isInstanceOfType(e, UserContextProvider.UserContextProviderException.class, 'Expected UserContextProviderException to be thrown');
        }
        Test.stopTest();
    }

    @IsTest
    static void runActionAs_invalidAction() {
        ActionWrapper action = new ActionWrapper(
            'ExampleService',
            null,
            null
        );

        Test.startTest();
        try {
            UserContextProvider.runActionAs(action, null);
            Assert.fail('Expected ActionWrapperException was not thrown');
        } catch (Exception e) {
            Assert.isInstanceOfType(e, ActionWrapper.ActionWrapperException.class, 'Expected ActionWrapperException to be thrown');
        }
        Test.stopTest();
    }

    @IsTest
    static void runActionAs_validAction() {
        User testUser = new User();
        testUser.Username = UserInfo.getUserName();

        ActionWrapper action = new ActionWrapper(
            'ExampleService',
            'getContextUser',
            null
        );

        Test.startTest();
        String resultUsername = UserContextProvider.runActionAs(action, testUser);
        Test.stopTest();

        Assert.areEqual(resultUsername, testUser.Username, 'The returned username should match the context user\'s username');
    }

    @IsTest
    static void callActionAsUser_nullAction() {
        List<ActionWrapper> actions = null;

        Test.startTest();
        try {
            UserContextProvider.callActionAsUser(actions);
            Assert.fail('Expected UserContextProviderException was not thrown');
        } catch (Exception e) {
            Assert.isInstanceOfType(e, UserContextProvider.UserContextProviderException.class, 'Expected UserContextProviderException to be thrown');
        }
        Test.stopTest();
    }

    @IsTest
    static void callActionAsUser_emptyAction() {
        List<ActionWrapper> actions = new List<ActionWrapper>();

        Test.startTest();
        try {
            UserContextProvider.callActionAsUser(actions);
            Assert.fail('Expected UserContextProviderException was not thrown');
        } catch (Exception e) {
            Assert.isInstanceOfType(e, UserContextProvider.UserContextProviderException.class, 'Expected UserContextProviderException to be thrown');
        }
        Test.stopTest();
    }

    @IsTest
    static void callActionAsUser_invalidAction() {
        List<ActionWrapper> actions = new List<ActionWrapper>{
            new ActionWrapper(
                'ExampleService',
                null,
                null
            )
        };

        Test.startTest();
        try {
            UserContextProvider.callActionAsUser(actions);
            Assert.fail('Expected ActionWrapperException was not thrown');
        } catch (Exception e) {
            Assert.isInstanceOfType(e, ActionWrapper.ActionWrapperException.class, 'Expected ActionWrapperException to be thrown');
        }
        Test.stopTest();
    }

    @IsTest
    static void callActionAsUser_validAction() {
        List<ActionWrapper> actions = new List<ActionWrapper>{
            new ActionWrapper(
                'ExampleService',
                'getContextUser',
                null
            )
        };

        Test.startTest();
        try {
            UserContextProvider.callActionAsUser(actions);
        } catch (Exception e) {
            Assert.fail('Expected no exception to be thrown for a valid action: ' + e.getMessage());
        }
        Test.stopTest();
    }
}