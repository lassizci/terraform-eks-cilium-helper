################################################################################
# Create a job that cleans up aws-node and kube-proxy for installing cilium
################################################################################
resource "kubernetes_service_account" "this" {
  metadata {
    name      = "terraform-eks-cilium-helper"
    namespace = "kube-system"
  }
}

resource "kubernetes_role" "this" {
  metadata {
    name      = "terraform-eks-cilium-helper"
    namespace = "kube-system"
  }

  rule {
    api_groups     = ["apps"]
    resources      = ["daemonsets"]
    resource_names = ["aws-node", "kube-proxy"]
    verbs          = ["get", "list", "watch", "delete"]
  }
}

resource "kubernetes_role_binding" "this" {
  metadata {
    name      = "terraform-eks-cilium-helper"
    namespace = "kube-system"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.this.metadata[0].name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.this.metadata[0].name
    namespace = "kube-system"
  }
}

resource "kubernetes_job" "this" {
  metadata {
    name      = "terraform-eks-cilium-helper"
    namespace = "kube-system"
  }
  spec {
    template {
      metadata {
        name = "terraform-eks-cilium-helper"
      }
      spec {
        service_account_name = kubernetes_service_account.this.metadata[0].name
        toleration {
          key      = "node.cilium.io/agent-not-ready"
          operator = "Equal"
          value    = "true"
          effect   = "NoExecute"
        }
        container {
          name    = "kubectl"
          image   = "bitnami/kubectl:${var.cluster_version}"
          command = ["sh", "-c", "(kubectl -n kube-system delete daemonset/kube-proxy; kubectl -n kube-system delete daemonset aws-node) || true"]
        }
        restart_policy = "Never"
      }
    }
    backoff_limit = var.backoff_limit
  }

  wait_for_completion = true

  timeouts {
    create = "20m"
    update = "20m"
  }
}
