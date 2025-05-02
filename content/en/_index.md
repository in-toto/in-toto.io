---
title: in-toto
outputs:
  - HTML
  - REDIRECTS # Include this `content/en` ONLY
description: A framework to secure the integrity of software supply chains
---

{{% blocks/cover image_anchor="top" height="max" %}}

<img src="/img/in-toto-horizontal-white.svg" alt="in-toto" class="in-toto-logo">

<!-- prettier-ignore-start -->
{{% param description %}}
{.display-6 .mb-5}

<a class="btn btn-primary" href="docs/what-is-in-toto/">Learn More</a>
<a class="btn btn-secondary" href="docs/getting-started/">Get started</a>
<a class="btn btn-primary" href="https://github.com/in-toto/demo">Try the demo</a>
{.p-initial .cta}

<!-- prettier-ignore-end -->

{{% /blocks/cover %}}

{{% blocks/lead color="primary" %}}

{{% param whatIsInToto %}}

{{% /blocks/lead %}}

{{% blocks/section color="dark" type="row" %}}

{{% blocks/feature
  title="Open, extensible standard"
  url="/docs/specs/"
  icon="fa-solid fa-book"
%}}

An open metadata standard that you can implement in your software's supply
chain.

{{% /blocks/feature %}} {{% blocks/feature
  title="Adoptions and Integrations"
  url="https://github.com/in-toto/friends"
  icon="fa-solid fa-handshake-simple"
%}}

Explore integrations and adopters of in-toto.

{{% /blocks/feature %}} {{% blocks/feature
  title="Extensive tooling"
  url="https://github.com/in-toto"
  icon="fa-solid fa-gear"
%}}

Use in-toto today by through Apache-licensed libraries and tools.

{{% /blocks/feature %}}

{{% /blocks/section %}}

{{% blocks/section color="secondary" type="cncf" %}}

**in-toto is a [CNCF][] [graduated][] project**.<br>

[![CNCF logo][]][cncf]

[cncf]: https://cncf.io
[cncf logo]: /img/cncf-white.svg
[graduated]: https://www.cncf.io/projects/

{{% /blocks/section %}}
