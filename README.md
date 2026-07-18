# User Context Provider

This Salesforce Apex package demonstrates how to run a callable Apex action under a specified user context. It combines an ActionWrapper payload, a UserContextProvider entry point, an ExampleService implementation, and Flow metadata to orchestrate execution in a controlled and reusable way.

## What It Does

The package allows you to wrap an Apex action with metadata such as the target class, method name, and serialized parameters, then execute that action as a chosen user. This is useful when business logic should run with the permissions and context of a specific user rather than the current transaction context.

## Key Components

- ActionWrapper: carries the target Apex class, method name, serialized parameters, and the username to execute under.
- UserContextProvider: invokes the action and coordinates the orchestration flow.
- ExampleService: a sample implementation of System.Callable for demonstration purposes.
- Flow metadata: UserContextOrchestrator and UserContextOrchestrator_CallAction provide the orchestration path for running the requested action under the target user context.

## Example Apex Usage

```apex
ActionWrapper action = new ActionWrapper(
    'ExampleService',
    'getContextUser',
    null
);

User targetUser = [
    SELECT Id, Username
    FROM User
    WHERE Username = :UserInfo.getUserName()
    LIMIT 1
];

String executedAs = UserContextProvider.runActionAs(action, targetUser);
System.debug(executedAs);
```

## Deployment and Usage Notes

1. Deploy the Apex classes and Flow metadata to a Salesforce org.
2. Ensure the target user exists and has access to the underlying Apex logic.
3. Use ActionWrapper to define the callable class and method to execute.
4. Review the Flow metadata if you want to adapt the orchestration behavior for your own implementation.

## Test Information

The package includes Apex tests for validation and execution paths in UserContextProviderTest and ActionWrapperTest. Run those test classes in a sandbox or scratch org to verify the core behavior.
