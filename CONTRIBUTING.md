# Contributing to in-toto.io

Thank you for considering contributing to in-toto.io! Here are the steps to set up the project on your local machine.

## Quick Start Guide

To get started with contributing to in-toto.io, follow these steps:

### 1. Clone the Repository

Clone the in-toto.io git repository to your local machine:

```sh
git clone https://github.com/in-toto/in-toto.io.git
```

### 2. Install Development Dependencies

Navigate to the project root directory and install the necessary dependencies with Yarn. If you do not have Yarn installed, please install it by following the instructions on the [Yarn installation guide](https://classic.yarnpkg.com/en/docs/install):

```sh
cd in-toto.io
yarn install
```

### 3. Install Hugo

We use Hugo to build the site. Follow the [Hugo installation guide](https://gohugo.io/installation/) to install Hugo on your system. Below are simplified steps for different operating systems:

On macOS:

```sh
brew install hugo
```

On Windows:

Download the latest release from the [Hugo Releases](https://github.com/gohugoio/hugo/releases) page, then extract it and add the executable to your PATH.

On Linux:

```sh
sudo apt-get install hugo
```

For more detailed instructions, please refer to the [Hugo documentation](https://gohugo.io/installation/).

### 4. Serve the Project

Once Hugo is installed, you can serve the project locally to see your changes in real-time. Run the following command:

```sh
make serve
```

This will start a local server at http&#x3A; //localhost: XXXX/ where you can view the site.

### 5. Review Contribution Guidelines

Before contributing, please review our [contribution guidelines](https://github.com/in-toto/community/blob/main/CONTRIBUTING.md) to ensure that your code follows our style guidelines and is properly tested.

### 6. Sign the Developer Certificate of Origin (DCO)

All contributors must sign the Developer Certificate of Origin (DCO) by adding a "Signed-off-by" line to their commit messages. This indicates your acceptance of the DCO. You can do this by appending the following line to each commit message (see [git commit --signoff](https://git-scm.com/docs/git-commit#Documentation/git-commit.txt---signoff)):

```sh
git commit -s -m "Your descriptive commit message"
```

### Need Help?

If you encounter any issues or have any questions, feel free to open an issue on the repository or reach out to the maintainers.

#### Happy contributing!
