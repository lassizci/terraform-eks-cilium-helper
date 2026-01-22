# terraform-eks-cilium-helper
Module to create a Kubernetes job, that removes aws-node and kube-proxy daemonsets. Helps
when provisioning EKS cluster with Cilium.

## Usage

```hcl
module "cilium_cleanup_helper" {
  source          = "github.com/lassizci/terraform-eks-cilium-helper?ref=v1.0"
}
```

<!-- BEGIN_TF_DOCS -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backoff_limit"></a> [backoff\_limit](#input\_backoff\_limit) | Backoff limit for the job | `number` | `10` | no |
| <a name="input_kubectl_version"></a> [kubectl\_version](#input\_kubectl\_version) | kubectl image version | `string` | `"1.33.4"` | no |

* * *
<details>
<summary>Detailed information</summary>
## Resources

| Name | Type |
|------|------|
| [kubernetes_job.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/job) | resource |
| [kubernetes_role.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role) | resource |
| [kubernetes_role_binding.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding) | resource |
| [kubernetes_service_account.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service_account) | resource |

</details>
<!-- END_TF_DOCS -->
