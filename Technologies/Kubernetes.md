# Kubernetes

Kubernetes is an orchestration platform that manages containers.

## Nodes

The nod serves as a worker machine in a K8s cluster. A node can be a physical computer or a virtual machine.

Each node must have:
1. A kubelet running
2. Container tooling like Docker
3. A kube-proxy process running
4. Supervisord

Supervisord is a service which lets you restart components.

## Pods

The simplest unit you can interact with.

You can create, deploy and delete pods. It represents one running process on your cluster.

A pod contains:
1. Your Docker application container
2. Storage resources
3. Unique network IP
4. Options that govern how the container(s) should run.

Pods are designed to be ephemeral and disposable. They never self-heal, and are not restarted by the scheduler by itself. Don't create a pod by itself!

### Pod Lifecycle

1. Pending
   1. Has been accepted by the orchestration system but has not been deployed yet.
2. Running
   1. At least one container is in the running state.
3. Succeeded
   1. Where all the containers have exited with an exit code of 0 and do not need to be restarted.
4. Failed
   1. Where at least one container has exited with an exit code of 1.
5. CrashLoopBackOff
   1. This is where a container fails to start and the K8s engine will continue to try restarting it.

## Controller

The benefits of using a controller is:

1. Application reliability
2. Scaling
3. Load balancing

### ReplicaSets

Ensures that a specified number of replicas for a pod are running at all times. When a pod has crashed, it would try to create a new pod of that container. You need to use these within a deployment.

### Deployments

A deployment controller provides dclarative updates for pods and ReplicaSets. You can describe the desired state for a deployment in a yaml file and the deployment controller will align the actual state to match. You  would need this to define what state you wish your application to take so that ReplicaSets can match against this.

### DaemonSets

### Jobs

### Services


## Commands

|Command | Use |
--|--
`kubectl get pods` | returns all the active pods|
`kubectl get services` | returns all the active services|
