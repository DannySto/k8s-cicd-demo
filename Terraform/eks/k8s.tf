# create the namespace for the demo
resource "kubernetes_namespace" "demo-ns" {
  metadata {
    name = var.demo-namespace
    labels = {
    env = "demo"
    }
  }

    
    depends_on = [
  module.eks,
  ]
}

# create the namespace for the demo
resource "kubernetes_namespace" "stage-ns" {
  metadata {
    name = var.stage-namespace
    labels = {
     env = "stage"
    }
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


# Enable istio by default for the demo namespace
resource "null_resource" "stage-ns-enable-istio" {
  provisioner "local-exec" {
    command = "kubectl label ns ${var.stage-namespace} istio-injection=enabled"
  }
    depends_on = [
   module.eks,
   kubernetes_namespace.stage-ns,
  ]
}


# create a role with limited access to the demo namespace
resource "kubernetes_role" "demo-role" {
  metadata {
    name = "eks-demo-group"
    namespace = var.demo-namespace
    labels = {
    env = "demo"
    }
    
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
    name      = "eks-demo-group-bind"
    namespace =  var.demo-namespace
    labels = {
    env = "demo"
    }
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "eks-demo-group"
  }
  subject {
    kind      = "User"
    name      = "demo_user"
    api_group = "rbac.authorization.k8s.io"
    namespace = var.demo-namespace
  }
  
  depends_on = [
  module.eks,
  kubernetes_namespace.demo-ns,
  ]
}


# create a role with limited access to the stage namespace
resource "kubernetes_role" "stage-role" {
  metadata {
    name = "eks-stage-group"
    namespace = var.stage-namespace
    labels = {
    env = "stage"
    }
  }

  rule {
    api_groups     = ["*"]
    resources      = ["*"]
    verbs          = ["*"]
  }
  
  depends_on = [
  module.eks,
  kubernetes_namespace.stage-ns,
  ]
}


resource "kubernetes_role_binding" "stage-role-binding" {
  metadata {
    name      = "eks-stage-group-bind"
    namespace =  var.stage-namespace
    labels = {
    env = "stage"
    }
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "eks-stage-group"
  }
  subject {
    kind      = "User"
    name      = "dev_user"
    api_group = "rbac.authorization.k8s.io"
    namespace = var.stage-namespace
  }
  
  depends_on = [
  module.eks,
  kubernetes_namespace.stage-ns,
  ]
}