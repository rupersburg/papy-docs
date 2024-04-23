workspace {

    model {
        papyrus = softwareSystem "Papyrus" {
            description "The main area of the system including components and integrations"


            unifiedData = container "Unified Data" {
                unifiedDataNormalizer = component  "Unified Data Access"
                deviceControllerProxy = component  "Unified Controller/Device Proxy"
                otherDataProxy = component "Non-Controller Data Sources" {
                    description "Other data sources such as TAC cases, PSIRT etc"
                }
                unifiedDataNormalizer -> deviceControllerProxy
                unifiedDataNormalizer -> otherDataProxy
            }

            notebooks = container "Notebooks" {
                description "Handles various notebook-related functionalities"

                frontend = component "Notebook FrontEnd" {
                    description "The front-end interface for notebooks"
                }
                papyrusPlugin = component "Notebook Papyrus FrontEnd Plugin" {
                    description "Front-end plugin for the Papyrus system"
                }
                storageBackend = component "Notebook Storage Backend" {
                    description "Backend storage for notebooks"
                }
                executionEngine = component "Notebook Execution Engine (sandboxed)" {
                    description "The execution engine for running notebooks in a sandboxed environment"
                }
                # papyrusEnginePlugin = component "Notebook Papyrus Engine Plugin" {
                #   description "Engine plugin for integrating with the Papyrus system"
                # }

                storageAndExecutionProxy = component "Notebook Excution & Storage Proxy" {
                    -> storageBackend
                    -> executionEngine
                }
                frontend -> storageAndExecutionProxy

            }
            apilayer {
                authn = component "Authentication"
            }

        }
        aiModels = container "AI Model(s) Inference" {

        }

        ai = container "AI Model Orchestration" {
            context = component "AI Session/Context"
            -> aiModels
            -> unifiedDataNormalizer

        }

        integrations = container "Product Integrations" {
            description "Integrations with external products"

            intersightWidget = component "Intersight/DNAC/Meraki FE widget/chrome plugin etc" {
                description "Front-end widget and plugins for integration with Intersight, DNAC, Meraki, etc."
            }
            chatbotInterface = component "Webex Chatbot interface" {
                description "Interface for the Webex chatbot"
            }
            data = component "Paypyrus Own Data" {
                description "Data owned by Paypyrus"
            }
            usageTracking = component "Usage Tracking" {
                description "Tracks the usage of the system"
            }
            feedbackLoop = component "Feedback Loop for Models" {
                description "Collects feedback for the AI models"
            }
            vault = component "Vault for API Key Storage etc" {
                description "Stores API keys and sensitive information securely"
            }
            dashboarding = component "Dashboarding" {
                description "Provides dashboard functionalities"
            }
        }

        // Other containers and components would be added here in a similar fashion

        servicesPlatform = container "Services Platform" {
            description "Platform providing various services and APIs"

            apiProxy = component "API Proxy/FrontDoor" {
                description "The entry point for API calls, acting as a proxy"
            }
            // Additional components like JVM Runtime, Authn/Authz, etc., would be added here
        }

        // The rest of the components and containers would be defined here as well

        // Define relationships between components if necessary
        // Example:
        // frontend -> storageBackend "reads/writes to"
        // executionEngine -> papyrusEnginePlugin "uses"
    }

    // Define external software systems that interact with the system
    // Example:
    // intersight = softwareSystem "Intersight" {
    //   description "An external system for Intersight integration"
    // }
}

views {
    systemLandscape {
        include *
        autoLayout
    }
    // Define views for the system
    systemContext papyrus {
        include *
        autoLayout
    }

    container papyrus {
        include *
        autoLayout
    }
    dynamic * {

    }
    // Component views for each container would be defined here
    // Example:
    component notebooks {
        include *
        autoLayout
    }
    component aiService {
        include *
        autoLayout
    }

    component unifiedData {
        include *
        autoLayout
    }
}

// Add styling and other configurations if necessary
}