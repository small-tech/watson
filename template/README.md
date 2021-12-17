# {APP.NAME}

![{APP.NAME} icon](./data/128.svg)

{APP.DESCRIPTION}

[![Get it on AppCenter](https://appcenter.elementary.io/badge.svg)](https://appcenter.elementary.io/com.github.{GITHUB.ORG}.{GITHUB.APP}])

## System requirements

  - [elementary OS](https://elementary.io) 6 (Odin)

## Developer notes

### Getting started

Clone this repository and run the install task:

```shell
task/install
```

You can now run the app from either the _Applications Menu_ or using the run task:

```shell
task/run
```

### About

This project is written in [Vala](https://valadoc.org/) and follows the following elementary OS guidelines:

  - [Human Interface Guidelines](https://docs.elementary.io/hig/)
  - [Developer Guidelines](https://docs.elementary.io/develop/)
  - [Coding style](https://docs.elementary.io/develop/writing-apps/code-style)

Please take some time to familiarise yourself with those documents before continuing.

To get your system ready to develop for elementary OS, please see the [Basic Setup](https://docs.elementary.io/develop/writing-apps/the-basic-setup) section of the [elementary OS Developer Documentation](https://docs.elementary.io/develop/).

### Tasks

#### Install

Configures and runs the build, installs settings-related features and translations and refreshes the icon cache.

Run this after you clone this repository to get a working build.

```shell
task/install
```

#### Build

Builds the project.

```shell
task/build
```

#### Run

Builds and runs the executable.

```shell
task/run
```

#### Package

Creates a Flatpak package.

```shell
task/package
```

#### Run Package

Creates and runs a Flatpak package.

```shell
task/run-package
```

#### Take screenshots

Takes screenshots of your app in both the light and dark colour schemes and also creates a montage of the two for use in the AppCenter.

For ideas on how to customise this script for more complicated screenshots, see [the take-screenshots script for Comet](https://github.com/small-tech/comet/blob/main/task/take-screenshots).

```shell
task/take-screenshots
```

> You must push the generated screenshots folder to your GitHub repository before the screenshot will appear when you preview your app in AppCenter.

#### Publish

There is a simple web site for {APP.NAME} in the _docs/_ folder.

If GitHub pages is enabled for the app, you can view the site at https://{GITHUB.ORG.ORIGINAL}.github.io/{GITHUB.APP.ORIGINAL}

The site has an Install button that links to the Flatpak repository. People can use this button to sideload the app directly from its website.

To publish this Flatpak repository, use this task:

```shell
task/publish
```

> You must push the generated Flatpak repository to your GitHub repository and enable GitHub pages (or host it elsewhere – e.g., using [Site.js](https://sitejs.org)) before people will be able install your app.

#### Preview in AppCenter

Launches app locally in AppCenter so you can preview how it will look when published.

Optionally, you can specify a language code (e.g., `tr_TR`) to preview a specific localisation.

```shell
task/preview-in-appcenter <language-code>
```

### App web site

There is a simple web site for {APP.NAME} in the _docs/_ folder.

If GitHub pages is enabled for the app, you can view the site at https://{GITHUB.ORG.ORIGINAL}.github.io/{GITHUB.APP.ORIGINAL}

You do not have to use GitHub pages to host your app’s website. You can use any web server that’s capable of serving static files. You can also use a tool like [Site.js](https://sitejs.org) as a development server to preview your site locally during development.

The site has an Install button that links to the Flatpak repository. People can use this button to sideload the app directly from its website. (For more information, see the [Publish task](#publish)).

If you decide to put your app on the elementary OS AppCenter you can also uncomment a “Get It On AppCenter” button that will open AppCenter at your app’s page.

To see an example how you can build on and customise this base site, see the web site for [Comet](https://comet.small-web.org), which is hosted with [Site.js](https://sitejs.org).

### VSCodium

You do _not_ need to use [VSCodium](https://vscodium.com) to create elementary OS apps.

You can, for instance, use elementary OS [Code](https://docs.elementary.io/develop/writing-apps/the-basic-setup#code), which comes preinstalled, or a different third-party editor like [Builder](https://apps.gnome.org/en/app/org.gnome.Builder/).

However, if you do have VSCodium installed, there are a number of extensions that will make creating your elementary OS app easier:

  - [Vala](https://github.com/Prince781/vala-vscode) (`codium --install-extension prince781.vala`)
  - [Meson](https://github.com/asabil/vscode-meson) (`codium --install-extension asabil.meson`)
  - [CodeLLDB](https://github.com/vadimcn/vscode-lldb) (`codium --install-extension vadimcn.vscode-lldb`)
  - [EditorConfig](https://github.com/editorconfig/editorconfig-vscode) (`codium --install-extension editorconfig.editorconfig`)
  - [XML](https://github.com/redhat-developer/vscode-xml) (`codium --install-extension redhat.vscode-xml`)
  - [YAML](https://github.com/redhat-developer/vscode-yaml) (`codium --install-extension redhat.vscode-yaml`)

With the Meson and CodeLLDB extensions installed, press <kbd>Control</kbd> + <kbd>Shift</kbd> + B → _Build all targets_ to build and <kbd>F5</kbd> to run and debug.

If you need to pass command-line arguments to your app while testing, you can do so by specifying them in the `"args": []` array of [your app’s VSCodium launch configuration](.vscode/launch.json).

## Continuous integration

[Continuous Integration](https://docs.elementary.io/develop/writing-apps/our-first-app/continuous-integration) is set up for this repository.

## Submitting the app

__Note:__ App submissions in elementary OS are currently in Beta.

Please make sure you [review the AppCenter publishing requirements](https://docs.elementary.io/develop/appcenter/publishing-requirements) before [submitting the app](https://beta.developer.elementary.io/) to the [elementary OS AppCenter](https://appcenter.elementary.io/).

If anything fails during the Beta process, you can submit your app for review manually by opening a pull request on the [AppCenter Reviews repository](https://github.com/elementary/appcenter-reviews).

_\* If you know [Elixir](https://elixir-lang.org/), you might want to [contribute to improving the new AppCenter dashboard for elementary OS 6](https://github.com/elementary/appcenter-reviews). They’re looking for help._

### Notes on Stripe API keys for monetised apps

  - Stripe only allows one Stripe Connect connection to each Stripe account. While following the Stripe Connect flow during the app submission process, make sure you create a separate Stripe account under your organisation specifically for elementary OS.

  - Do __not__ add the key that’s displayed in your Stripe account to your _appdata.xml_ file.

  - __DO__ add the key you get from https://beta.developer.elementary.io/submissions/add to your _appdata.xml_ file.

  - Regarding the last two points: just to make things more confusing, the first however many letters of the keys might be the same, leading you to think that the key displayed on the Stripe account _is_ the same key. Don’t fall into that trap. (If you enter the wrong key, it’s not the end of the world. Payments for your app will fail on AppCenter until you issue an update with the correct key listed in your _appdata.xml_ file.)

## It’s elementary, my dear…

This project was initially generated by [Watson](https://github.com/small-tech/watson), a tool for quickly setting up a new elementary OS 6 app that follows platform [human interface](https://docs.elementary.io/hig/) and [development](https://docs.elementary.io/develop/) guidelines.

## Copyright and license

Copyright &copy; {COPYRIGHT.YEAR}-present {COPYRIGHT.NAME}

Licensed under [GNU GPL version 3.0](./LICENSE).
