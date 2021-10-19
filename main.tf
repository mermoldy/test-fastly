terraform {
  required_providers {
    fastly = {
      source  = "fastly/fastly"
      version = "~> 0.30"
    }
  }
}

resource "fastly_service_v1" "test_service" { 
 name = "An Example Service"

  domain {
    name = "jopapopa.global.ssl.fastly.net"
  }

  backend {
    address = "httpbin.org"
    name     = "My Test Backend"
  }

  force_destroy = true
  
  vcl {
    name    = "my_custom_main_vcl"
    content = "${file("${path.module}/test.vcl")}"
    main    = true
  }
}

output "active" {
  value = fastly_service_v1.test_service.active_version
}
