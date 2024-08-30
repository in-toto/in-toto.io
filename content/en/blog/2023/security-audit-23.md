---
title: Security Audit '23
description: Explore our latest security audits and findings.
date: 2023-05-11
author:
  'Aditya Sirish, [NYU Secure Systems Lab](https://ssl.engineering.nyu.edu)'
---

We are excited to announce completion of a source code audit of the in-toto
Python and Go implementations along with an architectural review of the
specification. The audit was ordered by the Open Source Technology Improvement
Fund (OSTIF) and conducted by X41 D-Sec GmbH over the course of three weeks in
February 2023.

## Motivation

While in-toto has previously undergone a security review by the CNCF’s
TAG-Security, it had not been formally audited thus far. The in-toto
implementations are currently used in production and the Python reference
implementation reached v1.0 maturity in late 2020. The Go implementation has
been the experimental testbed for several new features including the in-toto
Attestation Framework. We decided in our roadmap that it is time to release v1.0
of the specification and to apply for graduation at the CNCF. To formally
underline our confidence in the specification we initiated the in-toto audit.

## Results and Resolutions

In their final report the auditors acknowledged that the quality of the analyzed
source code was very good, and presented eight issues they had identified both
in the code and also in the overall design and architecture of the in-toto
framework. Among these issues one was labeled as high-severity, four as
medium-severity, and three as low-severity issues.

In addition, several informational findings, not relevant to the security of the
in-toto framework, were listed in the report. We created GitHub advisories for
all security findings and GitHub issues for the informational findings
([implementation](https://github.com/in-toto/in-toto/issues?q=label%3AX41),
[specification](https://github.com/in-toto/docs/issues?q=label%3AX41)).

It shall be noted that all security-relevant issues can be mitigated by a
correct usage of in-toto, or by understanding its scope. In fact the issue
marked high-severity was well known to us as a possible use pattern and had an
issue open for several years. Thus, our fixes consist, above all, of
clarifications in the specification and usage documentation. Below we give an
overview of all security-relevant findings and our response to them. More
comprehensive details can be found in the linked advisories and the
[report](/2023-security-audit-report.pdf).

### File Metadata Ignored (medium severity)

Advisory:
[GHSA-wqrg-wjp9-wqfq](https://github.com/in-toto/docs/security/advisories/GHSA-wqrg-wjp9-wqfq)

in-toto does not verify the integrity of file metadata. This might allow
attackers to provoke privilege escalation or degradation of the final product.

in-toto is designed to protect the integrity of artifact contents and not their
metadata. That said and as recommended by the auditors, supply chain owners are
free to promote dedicated file container formats that include e.g. permissions
as part of the file contents.

### Configuration Read From Local Directory (medium severity)

Advisory:
[GHSA-wqrg-wjp9-wqfq](https://github.com/in-toto/in-toto/security/advisories/GHSA-wc64-c5rv-32pf)

CVE:
[CVE-2023-32076](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2023-32076)

The link generation tool of the reference implementation can be configured using
RC files stored in directories following the XDG base directory specification.
One of the options is via a hidden file in the directory in-toto is run. An
attacker that controls the inputs to a step may compromise the link metadata and
evade detection by including such a configuration with their materials in
transit, which, e.g. filter certain artifacts from being recorded.

This is a special case of “Functionaries Do Not Perform Verification”, which is
described below. Further, after conversations with in-toto adopters, we realized
that while RC files are widely used by other systems, in-toto users typically
set configurations using API parameters or CLI arguments. As such, we removed
support for RC files from the reference implementation.

### Layout Replay (low severity)

Advisory:
[GHSA-73jv-h86v-c2vh](https://github.com/in-toto/docs/security/advisories/GHSA-73jv-h86v-c2vh)

It is possible for an attacker to replay an older, since-replaced layout that
has not yet expired.

We consider this out-of-scope for in-toto and have updated the specification to
explicitly note this as a non-goal. That said,
[ITE-2](https://github.com/in-toto/ITE/blob/master/ITE/2/README.adoc) and
[ITE-3](https://github.com/in-toto/ITE/blob/master/ITE/3/README.adoc) are two
“accepted” in-toto Enhancements that detail how
[The Update Framework (TUF)](https://theupdateframework.io/) can be used in
conjunction with in-toto to defend against layout replay attacks.

### Link File Reuse (medium severity)

Advisory:
[GHSA-6q78-j78h-pqm2](https://github.com/in-toto/docs/security/advisories/GHSA-6q78-j78h-pqm2)

Link metadata files are not inherently tied to a layout, which might allow an
attacker to replay ​​steps by replacing link files with ones from an earlier
version.

This issue can be mitigated by using globally unique step names in a layout.
However, this is not mandated by the specification as link metadata reuse, e.g.
for different supply chains, or generating link metadata independently of any
supply chain, are valid use cases. In addition, as described above ITE-2 and
ITE-3 are designed to prevent unallowed metadata reuse.

### Functionaries Do Not Perform Verification (high severity)

Advisory:
[GHSA-p86f-xmg6-9q4x](https://github.com/in-toto/docs/security/advisories/GHSA-p86f-xmg6-9q4x)

An attacker, who controls the product in transit, may compromise the whole
supply chain and stay undetected, by modifying only the product in transit, and
in such a way that the product itself can compromise a subsequent functionary.

Among several possible mitigations, the preferred method is to encourage
functionaries to strictly separate link generation from operations on untrusted
materials. This recommendation aligns with the SLSA Level 3 requirement for
Provenance generation that
["Provenance is Non-forgeable"](https://slsa.dev/spec/v1.0/requirements#provenance-non-forgeable)
and can be applied without changes to the in-toto specification. Other
solutions, including [new tooling](https://github.com/in-toto/in-toto/pull/589)
we have added, can be found in the advisory.

### Several PGP Issues (varying severity)

Advisory:
[GHSA-jjgp-whrp-gq8m](https://github.com/in-toto/in-toto/security/advisories/GHSA-jjgp-whrp-gq8m)

PGP keys in the reference implementation are not validated when verifying
metadata signatures. More specifically, in-toto does not check if the validity
period is in the future (low severity), revocation signatures exist (medium
severity), or the key has correct usage flags (low severity).

The auditors recommend using GnuPG for signature verification. However, this is
not desirable as in-toto is designed to allow verification in isolation of
external resources. Instead, it is the responsibility of the supply chain owner
to vet keys before promoting them as verification keys, and to revoke them using
the mechanisms provided by in-toto if necessary.

## In Closing

The findings from this review strengthen the in-toto specification and
implementations. Several of these issues were difficult to find without the
perspective of an outside reviewer, and they serve as a catalyst for us to
deliver in-toto improvements and new features more quickly. We are also pleased
to note that none of the issues fundamentally weaken the in-toto framework.

We knew going in that in-toto would not be a typical subject of a security
audit, especially as it was also focused on the specification. We think X41 rose
to the task admirably and identified several points where the framework’s
behavior could detract from what’s expected. Their findings and the resulting
updates improve in-toto’s usability and make the framework more secure by
default.

Finally, we are extremely grateful to X41 for conducting, to Open Source
Technology Improvement Fund (OSTIF) for organizing, and to the Cloud Native
Computing Foundation (CNCF) for funding this audit – thank you all!
