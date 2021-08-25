# Watson

> “It’s elementary…”

Watson is an application template for elementary OS 6 (Odin).

Watson will get you up and running with scaffolding that compiles on elementary OS 6 (Odin) and follows elementary OS 6 best practices (e.g., [code style](https://docs.elementary.io/develop/writing-apps/code-style)). Once you’ve made it your own, you can submit your app for inclusion in the [AppCenter](https://docs.elementary.io/develop/appcenter/publishing-requirements) as a curated app.

_(As part of that process, you should replace the contents of this README with your own. After you’ve read it and followed the instructions in it, that is.)_

## What Watson is (and what Watson is not).

The scaffolding that’s included is based on the [elementary OS Developer Documentation](https://docs.elementary.io/develop/) and [elementary OS Human Interface Guidelines](https://docs.elementary.io/hig/).

If you haven’t already done so, we highly recommended you read through both of these important resources before continuing.

Also, to refer to language or library details during development, bookmark [Valadoc](https://valadoc.org/).

_Watson is not a substitute for knowing what you’re doing. It is meant to lower the barrier of entry to creating an elementary OS application by automating the start of a new project and ensure you do not misconfigure your project or leave out important aspects (like translations). So, again, please read the above documents before starting to develop apps for elementary OS._

## Getting started

Open up Terminal and:

1. Clone this template and switch your current working directory to your local working copy:

    ```shell
    git clone https://github.com/small-tech/watson my-project-name
    cd my-project-name
    ```

1. Initialise your project:

    ```shell
    ./watson
    ```

    Watson will ask for your app details in a series of graphical dialogue windows and update the necessary bits of the template files (application bundle IDs, asset paths, etc.) to customise them for your project based on your answers. It will delete itself once it’s done.

    > The elementary OS AppCenter currently ties application bundle IDs and the directory structure for assets, etc., to the GitHub project. So your project’s application bundle ID will be something like com.github.small_tech.comet (the init script will automatically convert dashes to underscores as per flatpak’s naming requirements). [I have raised my concerns about this](https://github.com/elementary/appcenter/discussions/1622) and hope that this decision will be reviewed going forward. – [Aral](https://ar.al)

    It will also commit recreate the git repository (so you start with a fresh history), make an initial commit, and set up your git remote so `origin` points to your repository.

2. Create your repository on GitHub (if you haven’t already) and push your changes:

    ```shell
    git push origin main
    ```

That’s it!

Now you can customise the template further to create your app, knowing you have scaffolding that adheres to elementary OS guidelines.

Before moving on, make sure you learn how to set up [continuous integration](https://docs.elementary.io/develop/writing-apps/our-first-app/continuous-integration) and review the AppCenter [publishing requirements](https://docs.elementary.io/develop/appcenter/publishing-requirements) before you [submit your app](https://developer.elementary.io/).

Enjoy and here’s hoping Watson will make it easier for you to start building excellent apps for elementary OS.

## Get it on AppCenter

Once you run Watson, the following badge will lead to your app on the AppCenter (for when you’ve published it):

[![Get it on AppCenter](https://appcenter.elementary.io/badge.svg)](https://appcenter.elementary.io/com.github.USER.REPO)

## What is included?

  - A basic window with [header bar](https://docs.elementary.io/develop/apis/actions#gtk-headerbar).

  - [Action wired up for quit](https://docs.elementary.io/develop/apis/actions#glib-simpleaction) (<kbd>Ctrl</kdb>+<kbd>Q</kbd>).

  - Simple [notifications](https://docs.elementary.io/develop/apis/notifications) example.

  - [Granite](https://valadoc.org/granite/Granite.html) library for application [launchers](https://docs.elementary.io/develop/apis/launchers), [badges](https://docs.elementary.io/develop/apis/launchers#badges), [progress bars](https://docs.elementary.io/develop/apis/launchers#progress-bars), etc.

  - [State saving](https://docs.elementary.io/develop/apis/state-saving) using a [gschema.xml](https://docs.elementary.io/develop/apis/state-saving#define-settings-keys) file and [GSettings](https://valadoc.org/gio-2.0/GLib.Settings.html).

  - [Custom resources](https://docs.elementary.io/develop/apis/gresource) ([custom icons](https://docs.elementary.io/develop/apis/gresource#icons), etc.) using a [gresource.xml](https://docs.elementary.io/develop/apis/gresource) file.

  - [Colour scheme](https://docs.elementary.io/develop/apis/color-scheme) support.

  - [.desktop](https://docs.elementary.io/develop/writing-apps/our-first-app#the-desktop-file) file for information about your app that’s displayed in the Application Menu and Dock.

  - [AppData.xml](https://docs.elementary.io/develop/writing-apps/our-first-app#appdata-xml) file for information need to list your app in AppCenter.

  - [LICENSE](https://docs.elementary.io/develop/writing-apps/our-first-app#legal-stuff) file for the GNU GPL license.

  - [Meson configuration files](https://docs.elementary.io/develop/writing-apps/our-first-app/the-build-system) and a build script.

  - [Support for translations](https://docs.elementary.io/develop/writing-apps/our-first-app/translations) with [GNU gettext via Meson](https://mesonbuild.com/Localisation.html).

  - [App icon](https://docs.elementary.io/develop/writing-apps/our-first-app/icons)

  - [Flatpak manifest](https://docs.elementary.io/develop/writing-apps/our-first-app/packaging)

  - The recommended [EditorConfig](https://docs.elementary.io/develop/writing-apps/code-style#editorconfig) for elementary OS Code and other compatible editors for enforcing the suggested [code style](https://docs.elementary.io/develop/writing-apps/code-style).

  - _.gitignore_ file that ignores the _build_ and _.flatpak-builder_ directories.

## What’s _not_ included?

This template does not configure your system for elementary OS app development.

For example, it doesn’t install git, or the elementary SDK. To get your system ready to develop for elementary OS, please see the [Basic Setup](https://docs.elementary.io/develop/writing-apps/the-basic-setup) section of the [elementary OS Developer Documentation](https://docs.elementary.io/develop/).
