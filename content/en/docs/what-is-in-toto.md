---
title: What is in-toto?
description: A short explanation of what in-toto is.
weight: 1
---

A software supply chain is the series of steps performed when writing, testing,
packaging, and distributing software. A typical software supply chain is
composed of multiple steps "chained" together that transform (e.g., compilation)
or verify the state (e.g., linting) of the project in order to drive it to a
final product.

Supply chain security is crucial to the overall security of a software product.
An attacker who is able to control a step in the supply chain can alter the
product for malicious intents that range from introducing backdoors in the
source code to including vulnerable libraries in the final product. As a result,
supply chain breaches are an impactful means for an attacker to affect multiple
users at once.

Although many frameworks exist to ensure security in the "last mile" (e.g.,
software updaters), they may be providing integrity and authentication to a
product that is already vulnerable; it is possible that, by the time the package
makes it to a software update repository, it has already been compromised.

in-toto is designed to ensure the integrity of a software product from
initiation to end-user installation. It does so by making it transparent to the
user what steps were performed, by whom and in what order. As a result, with
some guidance from the group creating the software, in-toto allows the user to
verify if a step in the supply chain was intended to be performed, and if the
step was performed by the right actor.

You can read more about in-toto's internals in our
[latest](https://github.com/in-toto/docs/blob/master/in-toto-spec.md) or
[stable](https://github.com/in-toto/docs/blob/v1.0/in-toto-spec.md)
specification.
