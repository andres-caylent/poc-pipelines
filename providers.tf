# Codefresh provider requires to download the pluging from https://github.com/codefresh-io/terraform-provider-codefresh/releases
# Then copy the binary "terraform-provider-codefresh" to ~/.terraform.d/plugins/codefresh.io/app/codefresh/0.1.0/<OS_ARCH> . For mac OS_ARCH = darwin_amd64

terraform {

  required_providers {
    codefresh = {
      version = "0.1.0"
      source = "codefresh.io/app/codefresh"
    }
  }
}


provider "codefresh" {
  api_url = "https://g.codefresh.io/api"
  #token = "<MY API TOKEN>" # If token isn't set the provider expects the $CODEFRESH_API_KEY env variable
}
