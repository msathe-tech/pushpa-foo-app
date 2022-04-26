# K8s Config Directory
This directory is where application K8s config YAML need to be stored for each application

For each application:
   1. Create a directory using the application name
   2. Place the base Kustomize a directory called `base`
   3. Place environment specific overlays in the `overlays` directory.

As an example application `foo` is shown.

