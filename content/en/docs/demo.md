---
title: in-toto demo
linkTitle: Demo
weight: 8
---

In this demo, we will use in-toto to secure a software supply chain with a very
simple workflow. Bob is a developer for a project, Carl packages the software,
and Alice oversees the project. Using in-toto's terminology:

- **Alice** is the project owner - she creates and signs the software supply
  chain layout with her private key.
- **Bob** and **Carl** are project functionaries - they carry out the steps of
  the software supply chain as defined in the layout.

For the sake of demonstrating in-toto, you will perform all parts of the
software supply chain. This means you will execute commands on behalf of Alice,
Bob, and Carl, as well as the client who verifies the final product.

For further steps, please refer to the
[demo](https://github.com/in-toto/demo/blob/main/README.md).
