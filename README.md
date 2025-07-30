# JMeter EKS Helm Chart

A Helm chart to run scalable, distributed [Apache JMeter](https://jmeter.apache.org/) load tests on [Amazon EKS](https://aws.amazon.com/eks/), with slave workers, results output to a Persistent Volume, and automated upload of `.jtl` result files to S3 via IRSA (IAM Roles for Service Accounts).

---

## 🚀 Features

- **Distributed JMeter:** Scalable master/slave pattern
- **Persistent Results:** Test results stored in a PVC
- **S3 Integration:** Results automatically uploaded to your S3 bucket after test
- **AWS Best Practices:** Uses IRSA (no long-lived AWS keys in k8s!)
- **Easy Scaling:** Change slaves in `values.yaml`
- **Configurable Test Plan:** Supply your own JMeter `.jmx` via ConfigMap

---

## 📋 Prerequisites

- An **EKS cluster** (v1.21+ recommended)
- `kubectl` and `helm` installed & configured for your cluster
- **Your custom JMeter Docker image** (with plugins and `awscli` installed)
- A JMeter test plan (`testplan.jmx`)
- An **S3 bucket** for results
- An **IAM Role** for IRSA with S3 write access (see below)
- OIDC provider enabled on your EKS cluster (for IRSA)

---

## 1. Clone the Chart Repo
```sh
git clone <your-repo-url>
cd jmeter-eks-chart
```

## 2. Customize Your values.yaml
- Set your JMeter image repo and tag.

- Set replicaCount (number of slaves).

- Set your S3 bucket and AWS region.

- Add your IRSA role ARN in serviceAccount.annotations.

    Example snippet:

    ```yaml
    image:
    repository: miranlfk/jmeter
    tag: 5.6.3

    slave:
    replicaCount: 5

    aws:
    bucket: s3://your-bucket/path
    region: us-east-1

    serviceAccount:
    create: true
    name: jmeter-aws
    annotations:
        eks.amazonaws.com/role-arn: arn:aws:iam::<account-id>:role/jmeter-irsa-role
    ```

## 3. Prepare Your JMeter Test Plan and Entrypoint

- Create a ConfigMap for your test plan:

    ```sh
    kubectl create configmap jmeter-testplan --from-file=path/to/testplan.jmx
    ```
- Create a ConfigMap for the entrypoint script (from scripts/entrypoint.sh):

    ```sh
    kubectl create configmap jmeter-entrypoint --from-file=scripts/entrypoint.sh
    ```

## 4. Deploy the Helm Chart

```sh
helm install jmeter ./jmeter-eks-chart
```

Or, to upgrade:

```sh
helm upgrade --install jmeter ./jmeter-eks-chart
```

## 5. Monitor the Test

Check pods and jobs:

```sh
kubectl get pods
kubectl logs job/jmeter-master
```

## 6. Download Results
Once the master job completes, your .jtl results will be in your specified S3 bucket:

- Path: s3://your-bucket/path/results-<timestamp>.jtl

Download using the AWS CLI or the AWS Console:

```sh
aws s3 cp s3://your-bucket/path/results-YYYYMMDDHHMMSS.jtl .
```

## ⚠️ Troubleshooting
- S3 upload fails?

    - Ensure your IRSA role has s3:PutObject permission.

    - Check the annotation on the ServiceAccount.

- Pods can’t start?

    - Make sure the image is correct and public (or ECR auth is set).

- JMeter master can't see slaves?

    - Check headless service and network policies.

## 🏁 Summary Flow
1. Push your JMeter image with plugins & awscli.

2. Update values.yaml for your image, S3, IRSA, and test config.

3. Create ConfigMaps for test plan and entrypoint.

4. Deploy Helm chart.

5. Wait for master to finish, then fetch results from S3.



um_id |              um_user_id              | um_user_name |               um_user_password               |      um_salt_value       | um_require_change |     um_changed_time     | um_tenant_id
-------+--------------------------------------+--------------+----------------------------------------------+--------------------------+-------------------+-------------------------+--------------
        1 | 05ede236-af54-4b5e-9f09-918f199c637c | safelabrador | 7AH1JoSOWi2gjLL//vBjQBWjKWX6uerYgsJzdyHowVk= | 5S6m+i++XNTja9vZQx/w5A== | f                 | 2025-06-24 19:00:39.499 |        -1234
(1 row)