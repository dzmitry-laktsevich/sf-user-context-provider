/*
 * Copyright (c) 2026. All rights reserved.
 * Licensed under the MIT License. See LICENSE file in the project root for details.
 */

/**
 * UserContextProvider is a utility class that provides methods to execute Callable actions under a specific user context.
 */
public with sharing class UserContextProvider {

    /**
     * Runs an action as a specific user by invoking the UserContextOrchestrator flow that runs a background step under specified user.
     * 
     * @param actionToCall The action to be executed, wrapped in an ActionWrapper
     * @param contextUser The user context under which the action should be executed. If null, the action will be executed under the current user's context.
     * 
     * @return The username of the user under which the action was executed
     */
    public static String runActionAs(ActionWrapper actionToCall, User contextUser) {
        if (actionToCall == null) {
            throw new UserContextProviderException('No action provided');
        }
        actionToCall.validate();

        actionToCall.username = contextUser?.Username ?? UserInfo.getUserName();
        Map<String, Object> inputs = new Map<String, Object>{
            'actionToCall' => actionToCall
        };

        Flow.Interview.UserContextOrchestrator interview = new Flow.Interview.UserContextOrchestrator(inputs);
        interview.start();
        return actionToCall.username;
    }

    /**
     * Invocable method to call a Callable action wrapped in an ActionWrapper.
     * This method is designed to be called from a Flow.
     * 
     * @param actionToCall A list of ActionWrapper instances representing the actions to be executed
     */
    @InvocableMethod(Label='Call Action As User' Description='Call an action as a specific user')
    public static void callActionAsUser(List<ActionWrapper> actionToCall) {
        if (actionToCall == null || actionToCall.isEmpty()) {
            throw new UserContextProviderException('No action provided');
        }

        for (ActionWrapper action : actionToCall) {
            action.validate();
            Callable callableAction = (Callable) Type.forName(action.className).newInstance();
            callableAction.call(action.methodName, (Map<String, Object>) JSON.deserializeUntyped(action.serializedMethodParams));
        }
    }

    /**
     * Custom exception class for handling errors in the UserContextProvider.
     * This exception is thrown when an action is not provided.
     */
    public class UserContextProviderException extends Exception {}
}