# Watson

> “It’s elementary, my dear…”

__A best-practices application template for elementary OS 6 (Odin).__

[![Looping GIF of a snippet of Aral Balkan’s video introducing Watson.](https://videoapi-muybridge.vimeocdn.com/animated-thumbnails/image/9710a275-8b39-40f9-b8c1-1c720883f364.gif?ClientID=vimeo-core-prod&Date=1633623413&Signature=b1d86a2778a3aa9e4ca472047355a6d4f43009be)](https://vimeo.com/625472483)

[Watch the introductory screencast](https://vimeo.com/625472483).

__Status: Beta.__

I’ve now backported everything I learned and created while making [Comet](https://github.com/small-tech/comet) into Watson.

Once Comet is on the AppCenter and I’m happy that Watson captures and supports the full elementary OS development cycle, I’ll remove the Beta status.

  - _For feedback, ideas, and suggestions, please see [Discussions](https://github.com/small-tech/watson/discussions)._
  - _For bug reports for Watson and generated projects, please [open an issue](https://github.com/small-tech/watson/issues)._
  - __Want to jump right in? See [Getting Started](#getting-started).__

[Want the wallpaper?](#get-the-wallpaper)

## What Watson is (and what Watson is not).

Watson gets you up and running quickly with a bare-bones single-window elementary OS 6 (Odin) app that is based on the [elementary OS Developer Documentation](https://docs.elementary.io/develop/) as well as a review of the conventions employed by the core apps that ship with elementary OS (like [Code](https://github.com/elementary/code/) and [Calculator](https://github.com/elementary/calculator)).

It also makes it equally easy for other developers to build and run your application on their own machines after they clone your project’s repository.

Watson includes a number of scripts – to create and run Flatpak packages, update translations, and even take screenshots of your app and preview your app in AppCenter – that make the everyday tasks of working with your application easier.

Finally, Watson includes a simple web site for your app that’s automatically generated from your app’s metadata and contains a basic, progressively-enhanced and accessible carousel of your screenshots as well as a Flatpak repository for your app where people can sideload your app from. To host the generated site, you simply have to turn on GitHub Pages for your app and use the provided publish task script to publish your app and push to your GitHub repository. (You can also host your site on any static host, e.g., using [Site.js](https://sitejs.org). If you decide to put your app on the elementary OS AppCenter you can also uncomment a “Get It On AppCenter” button that will open AppCenter at your app’s page. To see an example how you can build on and customise this base site, see the web site for [Comet](https://comet.small-web.org).

When deciding what to include and what to leave out of the generated app, the guiding principle is to include base functionality expected of any elementary OS 6 app. The goal is for you to only have to add to the generated template, not remove from it or change the generated code for common types of apps (with the understanding that multi-window applications and highly custom apps might require a bit of fiddling).

__Most importantly, the generated skeletal app complies with the [elementary OS Human Interface Guidelines](https://docs.elementary.io/hig/) and follows other recommended elementary OS 6 conventions like [coding style](https://docs.elementary.io/develop/writing-apps/code-style).__ _If you haven’t already done so, please read through both of those important resources before continuing. Also, to refer to language or library details during development, bookmark [Valadoc](https://valadoc.org/)._

Once you’ve made the generated app your own by customising it and adding to it, you can submit it for inclusion in the elementary OS [AppCenter](https://docs.elementary.io/develop/appcenter/publishing-requirements) as a curated app.

___Watson is not a substitute for knowing what you’re doing.__ Watson is meant to lower the barrier of entry to creating an elementary OS application by automating the start of a new project to ensure you do not misconfigure your project or leave out important aspects (like window state preservation or translations). So, again, please read the above documents before starting to develop apps for elementary OS._

## Goals

1. The time from when a developer decides to make an elementary OS app to when they have a working project using Watson should be < 60 seconds.

2. The time from when a developer clones a Watson-generated elementary OS application to when they have it up and running on their own machine should be < 60 seconds.

Furthermore, the generated project must:

  - Adhere to platform [human interface guidelines](https://docs.elementary.io/hig/), [conventions](https://docs.elementary.io/develop/writing-apps/code-style), and [other recommended practices](https://docs.elementary.io/develop/).

  - Be [maintainable](https://www.oreilly.com/content/what-is-maintainability/).

  - Adhere to [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself) (Don’t Repeat Yourself) principles.

## Getting started

### On GitHub:

1. __Press the green [“Use this template” button](https://github.com/small-tech/watson#repo-content-pjax-container)__ for this repository to create your new project’s repository using Watson as the template.

### On your development machine:

2. __Clone your project__ and switch to its directory in Terminal:

    ```shell
    git clone git@github.com:<my-org>/<my-app>.git
    cd <my-app>
    ```

3. __Initialise your project__:

    ```shell
    ./watson
    ```

> __Note on the GitHub-centric workflow:__ The elementary OS AppCenter currently ties application bundle IDs and the directory structure for assets, etc., to the GitHub project. So your project’s application bundle ID will be something like com.github.small_tech.comet (the init script will automatically convert dashes to underscores as per flatpak’s naming requirements). I have raised my concerns about this both from a legal perspective [as it is a trademark violation](https://github.com/elementary/appcenter/discussions/1622) and, more generally, [because it gives Microsoft a de-facto veto right on what apps are allowed on elementary OS](https://github.com/elementary/houston/issues/436#issuecomment-905554984). I do hope that this decision will be reviewed going forward. In the meanwhile, however, Watson is designed to make full use of the current system to make setting up a new elementary OS project as simple as possible while following all relevant platform guidelines and encouraging good practices. – [Aral](https://ar.al)

## What to expect

### Interactive app configuration screens

Watson will ask for your app details in a series of graphical dialogue windows and update the necessary bits of the template files (application bundle IDs, asset paths, etc.) to customise them for your project based on your answers.

It will also replace this README and the CHANGELOG with your application’s versions, recreate the git repository (so you start with a fresh history), make an initial commit, and set up your git remote so `origin` points to your repository.

Next, Watson will run the install task (`task/install`).

> The install task is also what developers who clone your project will run to ensure that they can build and run your project.

### The install task

The install task first checks whether you have the [elementary OS development libraries](https://docs.elementary.io/develop/writing-apps/the-basic-setup#development-libraries) installed and asks you to install them if it can’t find them.

> The elementary OS development libraries – also known as the elementary OS Software Development Kit (SDK) – are a [metapackage of elementary OS libraries](https://github.com/elementary/metapackages) required when creating apps for elementary OS. You can see which libraries are included in the SDK based on the architecture of your development machine by reviewing the following metapackage definitions: [AMD64](https://github.com/elementary/metapackages/blob/master/elementary-sdk-amd64), [ARM64](https://github.com/elementary/metapackages/blob/master/elementary-sdk-arm64), [ARMHF](https://github.com/elementary/metapackages/blob/master/elementary-sdk-armhf).

Next, Watson will check if you have [VSCodium](https://vscodium.com) installed. If you do, it will check whether or not you have useful set of VSCodium extensions for elementary OS development installed and ask you to install them if you don’t.

> You do _not_ need to use VSCodium to create elementary OS apps. You can, for instance, use elementary OS [Code](https://docs.elementary.io/develop/writing-apps/the-basic-setup#code), which comes preinstalled, or a different third-party editor like [Builder](https://apps.gnome.org/en/app/org.gnome.Builder/). However, if you do have VSCodium installed, there are a number of extensions that will make creating your elementary OS app easier ([Vala](https://github.com/Prince781/vala-vscode), [Meson](https://github.com/asabil/vscode-meson), [CodeLLDB](https://github.com/vadimcn/vscode-lldb), [XML](https://github.com/redhat-developer/vscode-xml), [YAML](https://github.com/redhat-developer/vscode-yaml)). If Watson cannot find these extensions installed, it will ask you if you’d like to install them now. With these extensions installed, once you’ve initialised your project, you can simple open it in VSCodium and hit <kbd>F5</kbd> to run/debug it and <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>B</kbd> → _Build all targets_ to rebuild it after making changes. You will also get code intelligence, etc., for all your source files. Finally, your project will also inform VSCodium of the set of recommended extensions for your project so even if you choose not to install them now, you can easily find and install them later yourself.

### Post install

Once the install task is done, Watson will delete itself, leaving only your project behind.

It will also commit and push the changes to your git repository.

___And that’s it!___

At this point, your project is ready and you can customise the template further to create your own unique and wonderful app, knowing you have a base that adheres to elementary OS guidelines.

You can also run your project using the run script:

```
task/run
```

Or, if you’re using VSCodium, just open your project and hit <kbd>F5</kbd> to run/debug it and <kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>B</kbd> → _Build all targets_ to rebuild it after making changes.

You can find more task scripts in the `task` folder of your project and the workflow is also documented in the README file that’s generated for your project.

Here’s hoping Watson will make it easier for you to start building and maintaining excellent apps for elementary OS.

## What’s included?

  - A prompt to install the [elementary OS development libraries](https://docs.elementary.io/develop/writing-apps/the-basic-setup#development-libraries) if they don’t already exist on your machine.

  - A prompt to install recommended [VSCodium](https://vscodium.com/) Vala development and debugging extensions ([Vala](https://github.com/Prince781/vala-vscode), [Meson](https://github.com/asabil/vscode-meson), [CodeLLDB](https://github.com/vadimcn/vscode-lldb), [EditorConfig for VS Code](https://github.com/editorconfig/editorconfig-vscode), [XML](https://github.com/redhat-developer/vscode-xml), [YAML](https://github.com/redhat-developer/vscode-yaml)) if you have VSCodium installed and are missing any of them.

  - VSCodium [launch.json](https://charlesagile.com/vscode-launch-json-and-the-debug-console) for [CodeLLDB](https://github.com/vadimcn/vscode-lldb) (press F5 to run/debug your project in VSCodium).

  - A basic `Application` class that instantiates a single window (`MainWindow`).

  - A basic [Handy application window](https://gnome.pages.gitlab.gnome.org/libhandy/) (`MainWindow`). (While this is not yet reflected in the [elementary OS Developer Documentation](https://docs.elementary.io/develop/), the core apps that ship with elementary OS – like Code and Calculator – all use the [Handy library](https://gnome.pages.gitlab.gnome.org/libhandy/) so I’ve based the template on them.)

  - A basic [Handy header bar](https://gnome.pages.gitlab.gnome.org/libhandy/doc/1-latest/HdyHeaderBar.html), as part of the basic window.

  - [Actions](https://docs.elementary.io/develop/apis/actions#glib-simpleaction) wired up for quit and fullscreen with keyboard shortcut accelerators (<kbd>Ctrl</kbd>+<kbd>Q</kbd>, and <kbd>F11</kbd>, respectively). The code is set up so you can easily expand the list of actions and accelerators with your own in a maintainable manner.

  - [Granite](https://valadoc.org/granite/Granite.html) library for application [launchers](https://docs.elementary.io/develop/apis/launchers), [badges](https://docs.elementary.io/develop/apis/launchers#badges), [progress bars](https://docs.elementary.io/develop/apis/launchers#progress-bars), etc.

  - [Window state preservation](https://docs.elementary.io/develop/apis/state-saving) using a [gschema.xml](https://docs.elementary.io/develop/apis/state-saving#define-settings-keys) file and [GSettings](https://valadoc.org/gio-2.0/GLib.Settings.html). Set up to automatically save and restore the last window state (dimensions, location, and whether it is maximised or fullscreen).

  - Set up for [custom resources](https://docs.elementary.io/develop/apis/gresource) ([custom icons](https://docs.elementary.io/develop/apis/gresource#icons), etc.). No custom resources are provided but you can easily add your own to the `data/` directory and declare them in the provided [gresource.xml](https://docs.elementary.io/develop/apis/gresource) file.

  - [Colour scheme](https://docs.elementary.io/develop/apis/color-scheme) support (automatically uses person’s dark/light mode preference and updates the app’s appearance should they change it while the app is running).

  - [elementary OS colours](https://elementary.io/brand#color) as constants. Refer to `Constants.Colors` (US spelling as used elsewhere in the libraries) in your app to access them.

  - [.desktop](https://docs.elementary.io/develop/writing-apps/our-first-app#the-desktop-file) file for information about your app that’s displayed in the Application Menu and Dock.

  - [AppData.xml](https://docs.elementary.io/develop/writing-apps/our-first-app#appdata-xml) file for information need to list your app in AppCenter.

  - [LICENSE](https://docs.elementary.io/develop/writing-apps/our-first-app#legal-stuff) file for the GNU GPL license.

  - [Meson configuration files](https://docs.elementary.io/develop/writing-apps/our-first-app/the-build-system) and a build script.

  - [Support for translations](https://docs.elementary.io/develop/writing-apps/our-first-app/translations) with [GNU gettext via Meson](https://mesonbuild.com/Localisation.html).

  - Placeholder [app icon](https://docs.elementary.io/develop/writing-apps/our-first-app/icons). Just replace the provided ones with your own custom icon.

  - [Flatpak manifest](https://docs.elementary.io/develop/writing-apps/our-first-app/packaging) for packaging your application.

  - [Continuous Integration](https://docs.elementary.io/develop/writing-apps/our-first-app/continuous-integration) GitHub workflow.

  - The recommended [EditorConfig](https://docs.elementary.io/develop/writing-apps/code-style#editorconfig) for elementary OS Code and other compatible editors for enforcing the suggested [code style](https://docs.elementary.io/develop/writing-apps/code-style).

  - Basic [.gitignore file](https://git-scm.com/docs/gitignore) that ensures build directories are not accidentally added to your project.

  - Task for building and running the app (with Meson/Ninja and with Flatpak), updating translations, taking localised screenshots, and previewing your app locally in the elementary OS AppCenter (with support for localisations).

  <!-- - A basic web site for your app that you can publish using [GitHub pages](). -->

## What’s _not_ included?

Watson creates a basic single-window elementary OS application using good practices.

Watson’s goal with the generated app is that you should only have to either customise existing functionality (e.g., replace the app logo SVGs with your own), use existing functionality (e.g., add your custom icons or your own translations), or add specialised logic to the generated app. So you shouldn’t have to _remove_ any of the generated functionality. This is why there are no sample widgets or even basic layout generated as that will differ from app to app.

The generated skeleton is just that, the structure you need to quickly get you started with building your own application.

In other words, Watson does _not_ generate a sample app. For widget demos of the underlying libraries, see the Granite demo (`sudo apt install granite-demo && granite-demo`) and Gtk+ 3 examples/demo (`sudo apt install gtk-3-examples && gtk3-demo`).

Watson is also not meant to teach you how to build an elementary OS app (see the [elementary OS Developer Documentation](https://docs.elementary.io/develop/)) and is not a substitute for knowing and applying the [elementary OS Human Interface Guidelines](https://docs.elementary.io/hig/) as you develop your app.

Finally, while Watson will install the elementary OS development tools and even the recommended VSCodium extensions for you if you ask it to, __you need to configure your GitHub account and set up git on your machine yourself.__ For instructions on how to do this, please see the [Basic Setup](https://docs.elementary.io/develop/writing-apps/the-basic-setup) section of the [elementary OS Developer Documentation](https://docs.elementary.io/develop/).

## Common functionality you might want to add to your app

Here are some quick links showing you how to add common functionality to your app after you’ve generated it:

  - [Notifications](https://docs.elementary.io/develop/apis/notifications)
  - [Launchers (dock integration; badges, progress bars, etc.)](https://docs.elementary.io/develop/apis/launchers)

## General resources

At the risk of sounding like a broken record, please work your way through the [elementary OS Developer Documentation](https://docs.elementary.io/develop/)) and [elementary OS Human Interface Guidelines](https://docs.elementary.io/hig/) before starting to create an app for elementary OS 6.

Also please review the AppCenter [publishing requirements](https://docs.elementary.io/develop/appcenter/publishing-requirements) before you [submit your app](https://developer.elementary.io/).


Other important references include:

  - [Vala documentation](https://valadoc.org/)
  - [Handy documentation](https://gnome.pages.gitlab.gnome.org/libhandy/)
  - [Gtk3 documentation](https://docs.gtk.org/gtk3/)
  - [Gtk4 documentation]() (elementary OS does not use Gtk4 yet but since elementary OS apps are Flatpaks, you can, if you like, use it in your own apps. Note that this will currently result in a large download if the person downloading your app doesn’t already have the Gtk4 platform image installed. Here’s [a good guide if you want to use Gtk4 in your apps today](https://mrmonkington.github.io/how-to-build-an-only-slightly-less-than-trivial-gtk4-app-using-flatpak.html). Bear in mind that elementary OS will move to Gtk4 eventually so it’s good to start learning about it today.)
  - The elementary OS core projects – [Code](https://github.com/elementary/code/), [Calculator](https://github.com/elementary/calculator), [Tasks](https://github.com/elementary/tasks), [Calendar](https://github.com/elementary/calendar), etc. – are a valuable learning resource. Read through the code to see how they do things. (See [elementary OS on GitHub](https://github.com/elementary) for more.)

## Similar projects

  - [Valdo](https://github.com/Prince781/valdo) by [Princeton Ferro](https://github.com/Prince781) (of Vala Language Server fame. Make sure you watch his excellent [elementary Developer Weekend](https://edw.elementary.io) talk on [Improving App Development in Vala](https://edw.elementary.io/#improving-app-development-in-vala-by-princeton-ferro)). Valdo is an app that helps you create a new Vala project from a repository of templates. Valdo is not designed specifically for elementary OS but it does feature an elementary OS app template.

  - [Develop](https://github.com/alcadica/develop) is an app for elementary OS 5 (Hera) that has starters for apps, [Switchboard](https://github.com/elementary/switchboard) [Plugs](https://github.com/elementary?q=switchboard-plug#org-repositories), and [Wingpanel](https://github.com/elementary/wingpanel) indicators.

## Get the wallpaper

![Illustration, Sherlock Holmes, Watson, Enola Holmes and the three cats from Catts are in a swamp full of alligators. Sherlock is standing on a makeshift wooden bridge examining a bird (one foot on an alligator’s nose). Watson is in the swamp gathering more wood for the bridge. Enola and the blue cat are in a row boat in the background. The purple and green cats are on branches.](https://small-tech.org/downloads/watson/wallpaper/watson-wallpaper-4k-by-margo-de-weerdt-small-technology-foundation.jpg)

The wallpaper you see in the screencast was commissioned for Watson from the singular [Margo de Weerdt](https://www.margodeweerdt.com/). And you’re welcome to download and use it in all its 4K glory on your own computer if you like.

_(Also available [with shallower depth of field](https://small-tech.org/downloads/watson/wallpaper/watson-wallpaper-4k-shallow-depth-of-field-by-margo-de-weerdt-small-technology-foundation.jpg) – and [even shallower depth of field](https://small-tech.org/downloads/watson/wallpaper/watson-wallpaper-4k-even-shallower-depth-of-field-by-margo-de-weerdt-and-aral-balkan-small-technology-foundation.jpg) – which you might prefer if you place icons on your desktop so they don’t get lost in the detail.)_

Released under [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-nc-sa/4.0/). Please credit [Margo de Weerdt](https://www.margodeweerdt.com/) and [Watson](https://github.com/small-tech/watson) by [Small Technology Foundation](https://small-tech.org).

## Like this? Fund us!

[Small Technology Foundation](https://small-tech.org) is a tiny, independent not-for-profit.

We exist in part thanks to patronage by people like you. If you share [our vision](https://small-tech.org/about/#small-technology) and want to support our work, please [become a patron or donate to us](https://small-tech.org/fund-us) today and help us continue to exist.

## Copyright

&copy; 2021-present [Aral Balkan](https://ar.al), [Small Technology Foundation](https://small-tech.org).

## License

[GPL version 3.0](./LICENSE)
