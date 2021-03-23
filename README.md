# eksworkshop

## notas

* There are two types of nodes:
  * A Control-plane-node type, which makes up the Control Plane, acts as the “brains” of the cluster.
  * A Worker-node type, which makes up the Data Plane, runs the actual container images (via pods).

* Create cluster with terraform in version kubernetes 1.18
  * 4 min duration
  * Upgrade to 1.19 active in console with 24 min.

### Architectural Overview

![Architectural Overview](img/Architectural-Overview.png)

### Control Plane

![Control Plane](img/Control-Plane.png)

### Data Plane

![Data Plane](img/Data-Plane.png)

### EKS Architecture for Control plane and Worker node communication

![EKS Architecture for Control plane and Worker node communication](img/eks-Architecture.png)

## References

* [eksworkshop](https://www.eksworkshop.com)