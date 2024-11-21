---
title: Contributing
weight: 700
---

Thank you for considering contributing to in-toto.io! Here are the steps to set
up the project on your local machine.

## Review Community Contribution Guidelines

Start by reviewing our
[community contribution guidelines](https://github.com/in-toto/community/blob/main/CONTRIBUTING.md)
to ensure that your code follows our style guidelines and is properly tested.

## Sign the Developer Certificate of Origin (DCO)

All contributors must sign the Developer Certificate of Origin (DCO) by adding a
"Signed-off-by" line to their commit messages. This indicates your acceptance of
the DCO. For details, see [git commit --signoff].

[git commit --signoff]:
  https://git-scm.com/docs/git-commit#Documentation/git-commit.txt---signoff

## Setting up for local development

To get started with contributing to in-toto.io, follow these steps:

### 1. Clone the Repository

Clone the in-toto.io git repository to your local machine:

```sh
git clone https://github.com/in-toto/in-toto.io.git
```

### 2. Install Development Dependencies

Change to the project root directory and install project dependencies, including
[Hugo]:

```sh
cd in-toto.io
npm install
```

### 3. Serve the website

Locally serve the website to see your changes in real-time:

```sh
npm run serve
```

This starts a local server. View the site at the URL displayed in your terminal,
usually <http://localhost:1313>.

To only build the site, run:

```sh
npm run build
```

## Need Help?

If you encounter any issues or have any questions, feel free to open an issue on
the repository or reach out to the maintainers.

**Happy contributing!**

[Hugo]: https://gohugo.io
