resource "kubernetes_namespace" "demo-ns" {
  metadata {
    name = var.demo-namespace
  }
    
    depends_on = [
   module.eks,
  ]
}

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