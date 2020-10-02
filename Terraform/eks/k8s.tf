# create the namespace for the demo
resource "kubernetes_namespace" "demo-ns" {
  metadata {
    name = var.demo-namespace
  }
    
    depends_on = [
  module.eks,
  ]
}

# Enable istio by default for the demo namespace
resource "null_resource" "demo-ns-enable-istio" {
  provisioner "local-exec" {
    command = "kubectl label ns ${var.demo-namespace} istio-injection=enabled"
  }
    depends_on = [
   module.eks,
   kubernetes_namespace.demo-ns,
  ]
}

# create a role with limited access to the demo namespace
resource "kubernetes_role" "demo-role" {
  metadata {
    name = "eks-user-group"
    namespace = var.demo-namespace
  }

  rule {
    api_groups     = ["*"]
    resources      = ["*"]
    verbs          = ["*"]
  }
  
  depends_on = [
  module.eks,
  kubernetes_namespace.demo-ns,
  ]
}


resource "kubernetes_role_binding" "demo-role-binding" {
  metadata {
    name      = "eks-user-group-bind"
    namespace =  var.demo-namespace
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "eks-user-group"
  }
  subject {
    kind      = "User"
    name      = "eks_user"
    api_group = "rbac.authorization.k8s.io"
    namespace = var.demo-namespace
  }
  
  depends_on = [
  module.eks,
  kubernetes_namespace.demo-ns,
  ]
}