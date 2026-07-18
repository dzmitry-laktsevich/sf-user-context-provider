/*
 * Copyright (c) 2026. All rights reserved.
 * Licensed under the MIT License. See LICENSE file in the project root for details.
 */

/**
 * ExampleService is a sample implementation of the System.Callable interface.
 * It provides a method to retrieve the username of the current context user.
 * This class is designed to be invoked by the UserContextProvider to demonstrate executing actions under different user contexts.
 */
public inherited sharing class ExampleService implements System.Callable {
    public ExampleService() {}

    /**
     * Retrieves the username of the current context user.
     * This method is intended to be called via the UserContextProvider to demonstrate executing actions under different user contexts.
     * 
     * @return The username of the current context user
     */
    private String getContextUser() {
        String contextUser = UserInfo.getUserName();
        System.debug(contextUser);
        return contextUser;
    }

    // Callable interface implementation
    public Object call(String action, Map<String, Object> args) {
        switch on action {
            when 'getContextUser' {
                return this.getContextUser();
            }
            when else {
                throw new ExampleServiceMalformedCallException('Method not implemented');
            }
        }
    }

    /**
     * Custom exception class for handling malformed calls to the ExampleService.
     * This exception is thrown when an unrecognized method name is provided to the call method.
     */
    public class ExampleServiceMalformedCallException extends Exception {}
}