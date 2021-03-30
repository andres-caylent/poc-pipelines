
resource "codefresh_pipeline" "pipe-build" {
    is_public            = false
    name                 = "poc/pipe-build"
    tags                 = [] 

    spec {
        branch_concurrency  = 0 
        concurrency         = 0 
        contexts            = [] 
        priority            = 0 
        trigger_concurrency = 0 
        variables           = {
           "SLACK_WEBHOOK_URL" = var.slack_webhook
        }

        trigger {
        context       = "andres-caylent"
        description   = "Trigger the pipeline on every commit"
        disabled      = false
        events        = [
        "push.heads", "push.tags"
        ]
        modified_files_glob = ""
        commit_status_title = "commit-trigger"
        name                = "trigger_on_any_commit"
        provider            = "github"
        repo                = "andres-caylent/poc-monorepo"
        type                = "git"
        }        
    }
    original_yaml_string = file("./build.yml")

    # original_yaml_string = <<-EOT
    #     version: "1.0"
    #     stages:
    #     - "clone"
    #     - "build"

    #     steps:
    #     clone:
    #         title: "Cloning repository"
    #         type: "git-clone"
    #         repo: "andres-caylent/poc-monorepo"
    #         revision: "${{CF_BRANCH}}"
    #         git: "andres-caylent"
    #         stage: "clone"

    #     build:
    #         title: "Building container image"
    #         type: "build"
    #         arguments:
    #         working_directory: "${{clone}}"
    #         image_name: "lucerozuazquita/monorepo"
    #         tags:
    #         - ${{CF_REVISION}}
    #         - ${{CF_BRANCH_TAG_NORMALIZED}}
    #         registry: docker-hub
    #         dockerfile: "Dockerfile"
    #         stage: build    
    # EOT
}

resource "codefresh_pipeline" "pipe-umbrella" {
    is_public            = false
    name                 = "poc/pipe-umbrella"
    tags                 = [] 

    spec {
        branch_concurrency  = 0 
        concurrency         = 0 
        contexts            = [] 
        priority            = 0 
        trigger_concurrency = 0 
        variables           = {
           "SLACK_WEBHOOK_URL" = var.slack_webhook
        }

        spec_template {
            context  = "andres-caylent" 
            location = "git" 
            path     = "./pipe-umbrella.yml" 
            repo     = "andres-caylent/poc-pipelines"
            revision = "master" 
        }
        trigger {
        context       = "andres-caylent"
        description   = "Trigger the pipeline on every release"
        disabled      = false
        events        = [
        "release"
        ]
        modified_files_glob = ""
        commit_status_title = "commit-trigger"
        name                = "trigger_from_commit"
        provider            = "github"
        repo                = "andres-caylent/poc-live"
        type                = "git"
        }        
    }
}

resource "codefresh_pipeline" "pipe-to-int" {
    is_public            = false
    name                 = "poc/pipe-to-int" 
    tags                 = [] 

    spec {
        branch_concurrency  = 0 
        concurrency         = 0 
        contexts            = [] 
        priority            = 0 
        trigger_concurrency = 0 
        variables           = {
           "SLACK_WEBHOOK_URL" = var.slack_webhook
        }

        spec_template {
            context  = "andres-caylent" 
            location = "git" 
            path     = "./pipe-to-int.yml" 
            repo     = "andres-caylent/poc-pipelines" 
            revision = "master" 
        }
        trigger {
        branch_regex   = "/INT$/gi"
        context       = "andres-caylent"
        description   = "Trigger the pipeline when a PR comming from a branch named int is merged"
        disabled      = false
        events        = [
        #"pullrequest.merged"
         "push.tags"
        # "release"
        ]
        modified_files_glob = ""
        commit_status_title = "tags-trigger"
        name                = "trigger_when_merging_from_feature"
        provider            = "github"
        repo                = "andres-caylent/poc-live"
        type                = "git"
        }       
    }
}

resource "codefresh_pipeline" "pipe-to-preprod" {
    is_public            = false
    name                 = "poc/pipe-to-preprod" 
    tags                 = [] 

    spec {
        branch_concurrency  = 0 
        concurrency         = 0 
        contexts            = [] 
        priority            = 0 
        trigger_concurrency = 0 
        variables           = {
           "SLACK_WEBHOOK_URL" = var.slack_webhook
        }

        spec_template {
            context  = "andres-caylent" 
            location = "git" 
            path     = "./pipe-to-preprod.yml" 
            repo     = "andres-caylent/poc-pipelines" 
            revision = "master" 
        }
        trigger {
        branch_regex  = "/preprod/g"
        context       = "andres-caylent"
        description   = "Trigger the pipeline when a PR comming from branch named preprod is merged"
        disabled      = false
        events        = [
        "pullrequest.merged"
        ]
        modified_files_glob = ""
        commit_status_title = "tags-trigger"
        name                = "trigger_when_merging_from_feature"
        provider            = "github"
        repo                = "andres-caylent/poc-live"
        type                = "git"
        }        

    }
}

resource "codefresh_pipeline" "pipe-to-prod" {
    is_public            = false
    name                 = "poc/pipe-to-prod" 
    tags                 = []        

    spec {
        branch_concurrency  = 0 
        concurrency         = 0 
        contexts            = [] 
        priority            = 0 
        trigger_concurrency = 0 
        variables           = {
           "SLACK_WEBHOOK_URL" = var.slack_webhook
        }

        spec_template {
            context  = "andres-caylent" 
            location = "git" 
            path     = "./pipe-to-prod.yml" 
            repo     = "andres-caylent/poc-pipelines" 
            revision = "master" 
        }
        # trigger {
        # branch_regex  = "/prod/g"
        # branch_regex_input = regex
        # context       = "andres-caylent"
        # description   = "Trigger the pipeline when a PR comming from a branch named int is merged"
        # disabled      = false
        # events        = [
        # "pullrequest.merged"
        # ]
        # modified_files_glob = ""
        # commit_status_title = "tags-trigger"
        # name                = "trigger_when_merging_from_feature"
        # provider            = "github"
        # repo                = "andres-caylent/poc-live"
        # type                = "git"
        # }       
    }
}

