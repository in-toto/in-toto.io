---
title: Getting started
weight: 20
# EDITORIAL NOTE: the content below was copied from the main in-toto repository
# For details, see:
# https://github.com/in-toto/in-toto.io/issues/75
---

in-toto provides a framework to protect the integrity of the software supply
chain. It does so by verifying that each task in the chain is carried out as
planned, by authorized personnel only, and that the product is not tampered with
in transit.

in-toto requires a **project owner** to create a **layout**. A layout lists the
sequence of **steps** of the software supply chain, and the **functionaries**
authorized to perform these steps. When a functionary performs a step in-toto
gathers information about the used command and the related files and stores it
in a **link** metadata file. As a consequence link files provide the required
evidence to establish a continuous chain that can be validated against the steps
defined in the layout.

The layout, signed by the project owners, together with the links, signed by the
designated functionaries, are released as part of the final product, and can be
validated manually or via automated tooling in, e.g. a package manager.

### Installation

in-toto is available on [PyPI](https://pypi.org/project/in-toto/) and can be
installed via [`pip`](https://pypi.org/project/pip/). See
[in-toto.readthedocs.io](https://in-toto.readthedocs.io/en/latest/installing.html)
to learn about system dependencies and installation alternatives and
recommendations.

```shell
pip install in-toto
```

### Create layout, run supply chain steps and verify final product

#### Layout

The in-toto software supply chain layout consists of the following parts:

- **expiration date**
- **readme** (an optional description of the supply chain)
- **functionary keys** (public keys, used to verify link metadata signatures)
- **signatures** (one or more layout signatures created with the project owner
  key(s))
- **software supply chain steps** correspond to steps carried out by a
  functionary as part of the software supply chain. The steps defined in the
  layout list the functionaries who are authorized to carry out the step (by key
  id). Steps require a unique name to associate them (upon verification) with
  link metadata that is created when a functionary carries out the step using
  the `in-toto` tools. Additionally, steps must have material and product rules
  which define the files a step is supposed to operate on. Material and product
  rules are described in the section below.
- **inspections** define commands to be run during the verification process and
  can also list material and product rules.

Take a look at the
[demo layout creation example](https://in-toto.readthedocs.io/en/latest/layout-creation-example.html)
for further information on how to create an in-toto layout.

#### Artifact Rules

A software supply chain usually operates on a set of files, such as source code,
executables, packages, or the like. in-toto calls these files artifacts. A
material is an artifact that will be used when a step or inspection is carried
out. Likewise, a product is an artifact that results from carrying out a step.

The in-toto layout provides a simple rule language to authorize or enforce the
artifacts of a step and to chain them together. This adds the following
guarantees for any given step or inspection:

- Only artifacts **authorized** by the project owner are created, modified or
  deleted,
- each defined creation, modification or deletion is **enforced**, and also
- restricted to the scope of its definition, which **chains** subsequent steps
  and inspections together.

Note that it is up to you to properly secure your supply chain, by authorizing,
enforcing and chaining materials and products using any and usually multiple of
the following rules:

- `CREATE <pattern>`
- `DELETE <pattern>`
- `MODIFY <pattern>`
- `ALLOW <pattern>`
- `DISALLOW <pattern>`
- `REQUIRE <file>`
- `MATCH <pattern> [IN <source-path-prefix>] WITH (MATERIALS|PRODUCTS) [IN <destination-path-prefix>] FROM <step>`

_Rule arguments specified as `<pattern>` allow for Unix shell-style wildcards as
implemented by Python's
[`fnmatch`](https://docs.python.org/3/library/fnmatch.html)._

in-toto's Artifact Rules, by default, allow artifacts to exist if they are not
explicitly disallowed. As such, a `DISALLOW *` invocation is recommended as the
final rule for most step definitions. To learn more about the different rule
types, their guarantees and how they are applied, take a look at the
[Artifact Rules](https://github.com/in-toto/docs/blob/master/in-toto-spec.md#433-artifact-rules)
section of the in-toto specification.

#### Carrying out software supply chain steps

##### in-toto-run

`in-toto-run` is used to execute a step in the software supply chain. This can
be anything relevant to the project such as tagging a release with `git`,
running a test, or building a binary. The relevant step name and command are
passed as arguments, along with materials, which are files required for that
step's command to execute, and products which are files expected as a result of
the execution of that command. These, and other relevant details pertaining to
the step are stored in a link file, which is signed using the functionary's key.

If materials are not passed to the command, the link file generated just doesn't
record them. Similarly, if the execution of a command via `in-toto-run` doesn't
result in any products, they're not recorded in the link file. Any files that
are modified or used in any way during the execution of the command are not
recorded in the link file unless explicitly passed as artifacts. Conversely, any
materials or products passed to the command are recorded in the link file even
if they're not part of the execution of the command.

See
[this simple usage example from the demo application for more details](https://github.com/in-toto/demo).
For a detailed list of all the command line arguments, run `in-toto-run --help`
or look at the
[online documentation](https://in-toto.readthedocs.io/en/latest/command-line-tools/in-toto-run.html).

##### in-toto-record

`in-toto-record` works similar to `in-toto-run` but can be used for multi-part
software supply chain steps, i.e. steps that are not carried out by a single
command. Use `in-toto-record start ...` to create a preliminary link file that
only records the _materials_, then run the commands of that step or edit files
manually and finally use `in-toto-record stop ...` to record the _products_ and
generate the actual link metadata file. For a detailed list of all command line
arguments and their usage, run `in-toto-record start --help` or
`in-toto-record stop --help`, or look at the
[online documentation](https://in-toto.readthedocs.io/en/latest/command-line-tools/in-toto-record.html).

#### Release final product

In order to verify the final product with in-toto, the verifier must have access
to the layout, the `*.link` files, and the project owner's public key(s).

#### Verification

Use `in-toto-verify` on the final product to verify that

- the layout was signed with the project owner's private key(s),
- has not expired,
- each step was performed and signed by the authorized functionary,
- the functionaries used the commands, they were supposed to use,
- materials and products of each step were in place as defined by the rules, and
- run the defined inspections

For a detailed list of all command line arguments and their usage, run
`in-toto-verify --help` or look at the
[online documentation](https://in-toto.readthedocs.io/en/latest/command-line-tools/in-toto-verify.html).

#### Signatures

`in-toto-sign` is a metadata signature helper tool to add, replace, and verify
signatures within in-toto Link or Layout metadata, with options to:

- replace (default) or add signature(s), with layout metadata able to be signed
  by multiple keys at once while link metadata can only be signed by one key at
  a time
- write signed metadata to a specified path (if no output path is specified,
  layout metadata is written to the path of the input file while link metadata
  is written to `<name>.<keyid prefix>.link`)
- verify signatures

This tool serves well to re-sign test and demo data. For example, it can be used
if metadata formats or signing routines change.

For a detailed list of all command line arguments and their usage, run
`in-toto-sign --help` or look at the
[online documentation](https://in-toto.readthedocs.io/en/latest/command-line-tools/in-toto-sign.html).

## What next?

- Try the [demo](../demo).
- Consult the [specifications](../specs).
