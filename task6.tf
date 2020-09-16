provider "kubernetes" {
  config_context_cluster = "minikube"
}
resource "kubernetes_service" "webservice" {
  metadata {
    name = "wordpress"
  }
  spec {
    selector = {
      app = "wordpress"
    }
    session_affinity = "ClientIP"
    port {
      port        =    80
      target_port = 80
      node_port = 30000
    }
type = "NodePort"
  }
}
resource "kubernetes_deployment" "deployment" {
  metadata {
    name = "wordpress"
    labels = {
       app = "wordpress"
    }
  }
spec {
    replicas = 3
selector {
      match_labels = {
         app = "wordpress"
      }
    }
template {
      metadata {
        labels = {
          app = "wordpress"
        }
      }
spec {
        container {
          image = "wordpress"
          name  = "wordpress"
        }
      }
    }
  }
}


provider "aws" {
    region = "ap-south-1"
    profile = "default"
}


resource "aws_db_instance" "mysql" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7.30"
  instance_class       = "db.t2.micro"
  name                 = "arun_sql"
  username             = "Arun"
  password             = "#ArunKumar"
  parameter_group_name = "default.mysql5.7"
  publicly_accessible  = true
  iam_database_authentication_enabled = true
  skip_final_snapshot  = true
}