resource "codefresh_pipeline" "pipe-build" {
    # id                   = "6052148ad64f7c6287d66f30"
    is_public            = false
    name                 = "poc/pipe-build"
    
    # project_id           = "60514174f8c2af37c0cf9f1d"  this is project poc
    # project_id           = "6058b68ebfffd036cae23f6e"
    # revision             = 3 
    tags                 = [] 

    spec {
        branch_concurrency  = 0 
        concurrency         = 0 
        contexts            = [] 
        priority            = 0 
        trigger_concurrency = 0 
        variables           = {
            "SLACK_WEBHOOK_URL" = "https://hooks.slack.com/services/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"
        }

        spec_template {
            context  = "andres-caylent" 
            location = "git" 
            path     = "./build.yml" 
            repo     = "andres-caylent/poc-pipelines"
            revision = "master" 
        }
        trigger {
        # branch_regex  = "/preprod/g"
        # branch_regex_input = regex
        context       = "andres-caylent"
        description   = "Trigger the pipeline on every commit"
        disabled      = false
        events        = [
        "push"
        ]
        modified_files_glob = ""
        commit_status_title = "commit-trigger"
        name                = "trigger_from_commit"
        provider            = "github"
        repo                = "andres-caylent/poc-monorepo"
        type                = "git"
        }        
    }
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
            # "SLACK_WEBHOOK_URL" = "https://hooks.slack.com/services/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"
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
            # "SLACK_WEBHOOK_URL" = "https://hooks.slack.com/services/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"
        }

        spec_template {
            context  = "andres-caylent" 
            location = "git" 
            path     = "./pipe-to-int.yml" 
            repo     = "andres-caylent/poc-pipelines" 
            revision = "master" 
        }
        trigger {
        # branch_regex  = "/.INT/g" 
        branch_regex   = "/INT$/gi"
        # branch_regex  = "/v([0-9]+)\.([0-9]+)\.([0-9]+)-INT/gi"
        # branch_regex_input = regex
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
            # "SLACK_WEBHOOK_URL" = "https://hooks.slack.com/services/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"
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
        # branch_regex_input = regex
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
            # "SLACK_WEBHOOK_URL" = "https://hooks.slack.com/services/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"
        }

        spec_template {
            context  = "andres-caylent" 
            location = "git" 
            path     = "./pipe-to-prod.yml" 
            repo     = "andres-caylent/poc-pipelines" 
            revision = "master" 
        }
        # trigger {
        # branch_regex  = "/int/g"
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



