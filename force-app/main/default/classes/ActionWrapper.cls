/*
 * Copyright (c) 2026. All rights reserved.
 * Licensed under the MIT License. See LICENSE file in the project root for details.
 */

/**
 * ActionWrapper is a utility class that encapsulates the details of an action to be executed, including the class name, method name, serialized parameters, and the username of the user under which the action should be executed.
 * This class is designed to be used in conjunction with the UserContextProvider to facilitate executing actions under different user contexts.
 */
public inherited sharing class ActionWrapper {
    @AuraEnabled
    @InvocableVariable(Label='Class Name' Description='The name of the class to invoke' Required=true)
    public String className;

    @AuraEnabled
    @InvocableVariable(Label='Method Name' Description='The name of the method to invoke' Required=true)
    public String methodName;

    @AuraEnabled
    @InvocableVariable(Label='Serialized Method Parameters' Description='The serialized parameters for the method to invoke')
    public String serializedMethodParams;

    @AuraEnabled
    @InvocableVariable(Label='Username' Description='The username of the user to run the action as')
    public String username;

    public ActionWrapper() {}

    public ActionWrapper(String className, String methodName, Map<String, Object> methodParams) {
        this();
        this.className = className;
        this.methodName = methodName;
        this.serializedMethodParams = methodParams != null ? JSON.serialize(methodParams) : '{}';
    }

    /**
     * Validates the ActionWrapper instance to ensure that the className and methodName are not blank.
     * Throws an ActionWrapperException if validation fails.
     */
    public void validate() {
        if (String.isBlank(this.className)) {
            throw new ActionWrapperException('Class name is required');
        }
        if (String.isBlank(this.methodName)) {
            throw new ActionWrapperException('Method name is required');
        }
    }

    /**
     * Custom exception class for handling validation errors in the ActionWrapper.
     * This exception is thrown when the className or methodName is not provided.
     */
    public class ActionWrapperException extends Exception {}
}