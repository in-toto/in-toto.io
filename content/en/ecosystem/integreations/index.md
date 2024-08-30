---
title: Integrations
description: Projects and products with in-toto integrations.
---

This section lists software systems, services, or platforms that integrate with
the project to provide additional functionality, interoperability, or
compatibility. These integrations enhance the project's capabilities and extend
its usefulness across various ecosystems.

| Organization  |                                                            | Description                                                                                                                                                                                                                            |
| ------------- | ---------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| GitLab        | <img src="img/Gitlab_logo.png" width="50" height="50">     | GitLab is a popular Git server that also provides CI/CD integrations.                                                                                                                                                                  |
| Grafeas       | <img src="img/Grafeas_logo.png" width="50" height="50">    | Grafeas is an open source metadata API that is used to store metadata relevant to software supply chains. Grafeas includes support for in-toto link metadata.                                                                          |
| GUAC          | <img src="img/Guac_logo.png" width="50" height="50">       | GUAC has the ability to ingest and parse SLSA and other in-toto ITE6 attestations (either wrapped in DSSE or standalone).                                                                                                              |
| Hoppr         |                                                            | Hoppr leverages the in-toto python package to generate in-toto layout files based on a hoppr transfer configuration.                                                                                                                   |
| Jenkins       | <img src="img/Jenkins_logo.png" width="50" height="50">    | The in-toto team maintains a plugin for Jenkins that can be used to generate in-toto metadata pertaining to a particular build or "job".                                                                                               |
| rebuilderd    |                                                            | Rebuilderd is a build system project part of Reproducible Builds. When the result of a rebuild is positive, i.e., the build process is found to be reproducible, rebuilderd generates an in-toto link recording this result.           |
| Sigstore      | <img src="img/Sistore_logo.png" width="50" height="50">    | In-toto and Sigstore are complementary in their efforts, and Sigstore integrates in-toto in a number of ways. Sigstore's keyless signing can be used to sign in-toto metadata, as demonstrated by Cosign's SLSA Provenance generation. |
| Tekton Chains | <img src="img/Tekton_logo.png" width="50" height="50">     | Tekton Chains is a component for Tekton that adds software supply chain security. Chains observes all "TaskRuns" or jobs that are executed, and generates an in-toto attestation.                                                      |
| TestifySec    | <img src="img/Testifysec_logo.svg" width="50" height="50"> | TestifySec is a software supply chain security company that has created two open source projects that leverage in-toto. Witness and Archivista.                                                                                        |
