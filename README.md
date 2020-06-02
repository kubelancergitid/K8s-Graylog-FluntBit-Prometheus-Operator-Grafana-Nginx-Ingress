# Install GrayLog, Fluentbit and Prometheus Operator

## Infrastructure
Cloud: Google Cloud GKE Kubernetes
Ingress: Nginx Ingress

## Prerequisite
1. GKE Cluster up and running
2. DNS controller to add A records for DomainName Add
3. Clone this Git Repo on local


## Steps we going to perform:

#### 1. Install GrayLog and Fluentbit
#### 2. Install prometheus-operator
#### 3. Install Nginx Ingress and Cert Manager
#### 4. Create Issuer
#### 5. Create A records on DNS controller
#### 6. Create Ingress
#### 7. Access URLS (Graylog, Prometheus and Grafana)
#### 8. Configure GrayLog INPUT
#### 9. Configure Grafana Data Source as Prometheus
#### 10. Configure NGINX Ingress controller metrics on Grafana dashboard


## Let's get start step by step

#### 1. Install GrayLog and Fluentbit

Before run below script, do below changes as per your DomainName for graylog External URI, I have used kunelancer.net

```yaml

        - name: GRAYLOG_HTTP_EXTERNAL_URI
          value: https://graylog.kubelancer.net/

```

```bash

cd 1-graylog
sh deploy.sh

```

#### 2. Install prometheus-operator

```bash

cd 2-prometheus-operator/
sh install-prometheus-operator.sh

```

#### 3. Install Nginx Ingress and Cert Manager

```bash

cd 3-ingress/

sh 1-install-nginx-ingress.sh
sh 2-install-cert-manager.sh

```
#### 4. Create Issuer on namespace logging and ingress-nginx

``bash

sh 3-install-issuer.sh

```

#### 5. Create A records on DNS controller

To get Ingress External IP address

```bash

kubectl get svc -n ingress-nginx

```
Create A records on DNS controller, (change DomainName as per your own DomainName)

```
graylog.kubelancer.net
prometheus-operator.kubelancer.net
prometheus-operator-grafana.kubelancer.net

```

#### 6. Create Ingress

Before create ingress, please do (change DomainName as per your own DomainName) on all listed ingress files

```
graylog-ingress.yaml
prometheus-operator-ingress.yaml
prometheus-operator-grafana-ingress.yaml
web1-ingress.yaml

```

Once changed DNS Names, execute

```bash

sh 4-create-ingress.sh

```

#### 7. Access URLS (Graylog, Prometheus and Grafana)

Credentials

Graylog: admin/admin
Prometheus:
Grafana: admin/GRAYLOG_PASSWORD_SECRET

```html

https://graylog.kubelancer.net
https://prometheus-operator.kubelancer.net
https://prometheus-operator-grafana.kubelancer.net

```

#### 8. Configure GrayLog INPUT

Demo: 1

1. Launch the Graylog home page by using URLs.
2. Enter the valid Username and Password
3. To configure the input in Graylog, click System->Inputs
4. Then Select the Gelf HTTP  and click on  Launch New Input button.
5. From the box Select Node and Click Ok.

6. Create sample cronJob to forward message

```bash
cd 1-graylog
kubectl apply -f cronJob.yaml
```
7. On Graylog dashboard, Click Search and Check the received Logs from CronJob on GrayLog


8. That’s it for this demo:1  on Configuring Graylog input and get messages.

Demo: 2

1. Launch the Graylog home page by using URLs.
2. Enter the valid Username and Password
3. To configure the input in Graylog, click System->Inputs
4. Then Select the Gelf TCP  and click on  Launch New Input button.
5. From the box Select Global and Click Ok.
6. Start the INPUT
7. We have deployed sample Nginx Web server already, access it bu curl/Via Browser to forward message

```bash

watch curl https://web1.kubelancer.net

```
8. On Graylog dashboard, Click Search and Check the received Logs from web1 on GrayLog (use filter 'curl' if needed)

9. That’s it for this demo:2  on Configuring Graylog input and get messages.


#### 9. Configure Grafana Data Source as Prometheus

1. Click on the Grafana logo to open the sidebar.
2. Click on “Data Sources” in the sidebar.
3. Choose “Add New”.
4. Select “Prometheus” as the data source.
5. Set the Prometheus server URL (in our case: https://prometheus-operator.kubelancer.net )
6. Click “Add” to test the connection and to save the new data source.


#### 10. Configure NGINX Ingress controller metrics on Grafana dashboard

The import view can be found at the Dashboard Picker dropdown, next to the New Dashboard and Playlist buttons.

To import a NGINX Ingress controller metrics from a local JSON file,

1. Download Json file from https://grafana.com/grafana/dashboards/9614

click the Choose file button in the Import File section. Find the downloaded nginx-ingress-controller_rev1.json  on your local file system, and import it.

#### 11. Prometheus Stats Dashboard on Grafana

1. Download Json file from https://grafana.com/grafana/dashboards/2

& Import it.

                 #Thank You
