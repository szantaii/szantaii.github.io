# szantaii.github.io

## Contents

* [About](#about)
* [Technical notes](#technical-notes)
  * [Correct and clean-up HTML with Tidy](#correct-and-clean-up-html-with-tidy)
  * [Deploy site](#deploy-site)
* [Copyright](#copyright)

## About

This is the repository of the personal website of István Szántai, AKA szantaii.

## Technical notes

### Correct and clean-up HTML with Tidy

Correct and clean-up the [`src/html/index.html`](src/html/index.html) file by fixing markup errors and upgrading legacy code to modern standards.

```console
tidy -config ./tidy.config src/html/index.html
```

See [`tidy.man`](tidy.man) and [`tidy.config`](tidy.config) for the HTML Tidy configuration.

### Deploy site

Deploy the site into the `docs` directory.

```console
./deploy.sh
```

## Copyright

© 2022 István Szántai. All rights reserved.
