Secrets
Kubernetes Secrets let you store and manage sensitive information,
such as passwords, OAuth tokens, and ssh keys.
Storing confidential information in a Secret is safer and more flexible than putting it verbatim in a Pod definition or in a container image.

To use a secret, a Pod needs to reference the secret. A secret can be used with a Pod in three ways:

As files in a volume mounted on one or more of its containers.
As container environment variable.
By the kubelet when pulling images for the Pod.

Creating a Secret
There are several options to create a Secret:

create Secret using kubectl command
create Secret from config file
create Secret using kustomize


Using Secrets
Secrets can be mounted as data volumes or exposed as environment variables to be used by a container in a Pod. Secrets can also be used by other parts of the system, without being directly exposed to the Pod. For example, Secrets can hold credentials that other parts of the system should use to interact with external systems on your behalf.
