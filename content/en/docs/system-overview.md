---
title: 'System Overview'
description:
  'An overview of the in-toto framework, detailing its components and workflow
  for software supply chain security.'
weight: 3
---

## System Overview

The main goal of in-toto is to provide authentication, integrity and
auditability guarantees for the supply chain that created a final product that a
client will install.

To avoid ambiguity, we will refer to any files in the final product that in-toto
does not use to verify supply chain integrity as "target files". Target files
are opaque to the framework. Whether target files are packages containing
multiple files, single text files, or executable binaries is irrelevant to
in-toto.

The portion of the in-toto layout describing target files is the information
necessary to indicate which functionaries are trusted to modify or create such a
file. Additional metadata, besides layout and link metadata, can be provided
along with target files to verify other properties of the supply chain (e.g.,
was a code review policy applied?) when inspecting the final product.

The following are the high-level steps for using the framework, as seen from the
viewpoint of an operating system’s package manager. This is an error-free case:

1. The project owner creates a layout. This describes the steps that every
   functionary must perform, as well as the specific inspection steps that must
   be performed on the client's machine.
2. Each functionary performs their usual tasks within the supply chain (e.g.,
   the functionary in charge of compilation compiles the binary), and records
   link metadata about that action. After all steps are performed by
   functionaries, the metadata and target files are aggregated into a final
   product.
3. The client obtains the final product, and verifies that all steps were
   performed correctly. This is done by checking that all materials used were
   products of the intended steps, that each step was performed by the
   authorized functionary, and that the layout was created by the right project
   owner. If additional verification is required on the accompanying metadata
   (e.g., to verify VCS-specific metadata), the client will then perform
   additional inspection steps. If verification is successful, installation is
   carried out as usual.

### 2.1 Involved parties and their roles

In the context of in-toto, a role is a set of duties and actions that an actor
must perform.

In the description of the roles that follows, it is important to remember that
the framework has been designed to allow a large amount of flexibility for many
different use cases. Given that every project uses a very specific set of tools
and practices, this is a necessary requirement for in-toto.

There are three roles in the framework:

1. Project owner: defines the layout of a software supply chain.
2. Functionary: performs a step in the supply chain and provides a piece of link
   metadata as a record that such a step was carried out.
3. Client: Performs verification on the final product by checking the provided
   layout and link metadata.

In addition, there are third-party equivalents of the above roles, which are
managed by the sublayout mechanism, described in section 2.1.3. We will
elaborate on these roles in depth now.

#### 2.1.1 Project owner

As previously stated, the project owner sets the required steps to be performed
in the supply chain. For each step, its requirements, and the specific public
keys that can sign for evidence of the step are included to ensure compliance
and accountability. In addition, the layout file will contain the definition of
inspection steps to be carried out when verifying the final product.

#### 2.1.2 Functionaries

Functionaries are intended to carry out steps within the supply chain, and to
provide evidence of this by means of link metadata.

A functionary is uniquely identified by the public key that they will use to
sign a piece of link metadata as evidence that a step within the supply chain
was performed.

A functionary can allow a third-party define a step or series of steps of the
supply chain a sublayout. In this case, a subset of the steps to be performed
are defined by such a functionary, who adopts the role of a project owner for
this sublayout.

#### 2.1.3 Clients

Clients are users or automated tools who want to use the product.

The client will perform verification on the final product. This includes
verifying the layout metadata, and that the link metadata provided matches the
specified layout described in the metadata, and performing inspection steps to
ensure that any additional metadata and target files meet the criteria specified
by the layout for this inspection step.

A client will likely not interact with the in-toto framework directly, as it
should be integrated into system installation tools, or package managers.

#### 2.1.4 Third-party sublayouts

Sublayouts allow a functionary to further define steps within the supply chain.
When a functionary defines a sublayout, instead of carrying out the next step,
they will define the series of steps required as if they were a project owner
for the steps in this sublayout. This is helpful if the project owner does not
know the specifics of a step, but trusts a functionary to specify them later.

Sublayouts can also be used for third-party sections of the supply chain. For
example, a package maintainer for a Linux distribution will likely trust all the
steps in the version control system as a sublayout defined by upstream
developers of each package.

### 2.2 in-toto components

A in-toto implementation contains three main components:

1. A tool to generate and design supply chain layouts. This tool will be used by
   the project owner to generate a desired supply chain layout file. There are
   many tools in the reference implementation to aid project owners in creating
   and signing layouts.
2. A tool that functionaries can use to create link metadata about a step. For
   example, in the reference implementation, this feature is provided by the
   "in-toto-run" and "in-toto-record" tools.
3. A tool to be used by the client to perform verification on the final product.
   This tool uses all of the link and layout metadata generated by the previous
   tools. It also performs the inspection steps, as directed by the layout. This
   tool is often included in a package manager or system installer. In the case
   of the reference implementation, the tool performing this operation is
   "in-toto-verify".

### 2.3 System workflow example

To exemplify how these roles interact, we will describe a simple scenario. We
provide more specific scenarios in section 5.3, after we have presented a more
thorough description of the framework.

Consider a project owner, Alice, and her two functionaries, Diana and Bob. Alice
wants Diana to write a Python script (foo.py). Then, Alice wants Bob to package
the script into a tarball (foo.tar.gz). This tarball will be sent to the client,
Carl, as part of the final product. Carl’s target file is foo.tar.gz.

When providing the tarball to Carl, Alice will create a layout file that Carl
will use to make sure of the following:

- That the script was written by Diana
- That the packaging was done by Bob
- That the script contained in the tarball matches the one that Diana wrote, so
  if Bob is malicious or if the packaging program has an error, Carl will detect
  it.

In order to do this, Carl will require four files in the final product: first,
Alice’s layout, describing the requirements listed above. Then, a piece of link
metadata that corresponds to Diana’s action of writing a script, and a piece of
link metadata for Bob’s step of packaging the script. Finally, the target file
(foo.tar.gz) must also be contained in the final product.

When Carl verifies the final product, his installer will perform the following
checks:

- The layout file exists and is signed with a trusted key (in this case,
  Alice's).
- Every step in the layout has one or more corresponding link metadata files
  signed by the intended functionaries, as described in the layout (in this
  case, the link metadata provided by Bob and Diana).
- All the materials and products listed in the link metadata match, as specified
  by the layout. This will be used to prevent packages from being altered
  without a record (missing link metadata), or tampered with while in transit.
  In this case, the products reported by Diana should match the materials
  reported by Bob and so on.
- Finally, as is specified in the layout metadata, inspection steps are run on
  the client side. In this case, the tarball will be inspected to verify that
  the extracted foo.py matches the one that was written by Diana.

If all of these verifications pass, then installation continues as usual.

![Supply Chain Example](/images/in-toto-metadata.png) Figure 1: The supply chain
pieces for this example

## Final Product

The final product is the bundle of link metadata, layout metadata and target
files that will be used by the client's system. Additional, project-specific
metadata can be also bundled in the final product for verification during
inspection steps.

An installer or package manager uses the framework to inspect the final product
and verify its contents. Each project will have specific requirements to verify.
For example, a project may want to impose a review policy on the VCS. Thus, it
requires in-toto to validate additional accompanying link and layout metadata to
verify the review policy was followed.

### 3.1 Contents

The final product must contain at least these three files:

1. The supply chain layout
2. A link metadata file
3. A target file

More complex and robust supply chain layouts will contain more pieces of link
metadata, as well as additional sublayout files. Additional metadata (e.g., a
signed git commit log) can also be provided to be used during inspection phases.

#### 3.1.1 Supply chain Layout

The supply chain layout specifies each of the different steps and its
requirements, as well as the public keys used by functionaries to sign the link
metadata for steps within the chain.

The layout will also specify how each piece of link metadata will be verified,
and how the chain steps are interconnected via their materials and products.

#### 3.1.2 Link metadata

Link metadata is a statement that a step was carried out. Each piece of link
metadata will be used by the framework to ensure that the contents of materials
and products have not been altered in an unauthorized manner (e.g., while in
transit), and, that any alterations have been done only by an intended
functionary.

A step may be performed a single time but it may be a part of multiple supply
chains. in-toto supports such scenarios by not directly associating link
metadata with a specific layout. Multiple layouts, therefore, can use the same
link metadata during their respective verifications.

#### 3.1.3 Target files

Target files are the files clients will install and use in their systems. For
example, a target file could be an installation disk image, which will be
bundled with link metadata for each step performed to create the target file.

#### 3.1.4 Additional metadata files

Additional metadata files can be shipped within the final product for
verification. In this case, inspection steps that utilize this metadata can be
declared to determine if this metadata is correct. These metadata files will be
treated as regular target files by the framework.

## Further Information

For more detailed information, refer to the
[Document Formats](https://github.com/in-toto/docs/blob/v1.0/in-toto-spec.md#4-document-formats).
