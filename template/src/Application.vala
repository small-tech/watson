/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: {COPYRIGHT.YEAR} {COPYRIGHT.NAME} <{COPYRIGHT.EMAIL}>
 */

namespace {APP.NAMESPACE} {
    public GLib.Settings saved_state;

    public class Application : Gtk.Application {

        // This is information about the app that can be useful for
        // introspection when the app is running as a Flatpak.
        public static string binary_path;
        public static string flatpak_id;
        public static bool is_running_as_flatpak;

        public Application () {
            Object(
                application_id: "com.github.{GITHUB.ORG}.{GITHUB.APP}",
                flags: ApplicationFlags.FLAGS_NONE
            );

            saved_state = new GLib.Settings ("com.github.{GITHUB.ORG}.{GITHUB.APP}.saved-state");

            // Command-line options.

            // If your app takes command-line arguments, you can specify it
            // using the set_option_context_parameter_string () method.
            // (The option context parameter string is displayed next to the
            // list of options on the first line of the --help screen.)

            // Display the app description as the option context summary.
            // The option context summary is displayed above the set of options
            // on the --help screen.
            set_option_context_summary (_("{APP.DESCRIPTION}"));

            // Display the copyright notice as the option context description.
            // The option context description is displayed below the set of options
            // on the --help screen.
            set_option_context_description (_("Copyright ⓒ {COPYRIGHT.YEAR}-present {COPYRIGHT.NAME}. Licensed under GNU GPL version 3.0."));

            // Add option: --version, -v
            add_main_option(
                "version", 'v',
                GLib.OptionFlags.NONE,
                GLib.OptionArg.NONE,
                _("Show version number and exit"),
                null
            );

            // Signal: Handle local options.
            handle_local_options.connect((application, options) => {
                // Handle option: --version, -v:
                //
                // Print a minimal version string based on the GNU coding standards.
                // https://www.gnu.org/prep/standards/standards.html#g_t_002d_002dversion
                if (options.contains("version")) {
                    print (@"{APP.NAME} $(Constants.Config.VERSION)\n");

                    // OK.
                    return 0;
                }

                // Let the system handle any other command-line options.
                return -1;
            });
        }

        construct {
            // Initialise localisation.
            GLib.Intl.setlocale (LocaleCategory.ALL, "");
            GLib.Intl.bindtextdomain (Constants.Config.GETTEXT_PACKAGE, Constants.Config.LOCALEDIR);
            GLib.Intl.bind_textdomain_codeset (Constants.Config.GETTEXT_PACKAGE, "UTF-8");
            GLib.Intl.textdomain (Constants.Config.GETTEXT_PACKAGE);
        }

        protected override void activate () {
            // Use person’s preferred color scheme.
            // See: https://docs.elementary.io/develop/apis/color-scheme
            use_preferred_color_scheme ();

            // Ensure there is only one window and show it.
            MainWindow window;
            unowned List<Gtk.Window> windows = get_windows ();
            if (windows.length () > 0) {
                window = windows.last ().data as MainWindow;
                window.present ();
            } else {
                window = new MainWindow (this);
                window.show ();
            };
        }

        private void use_preferred_color_scheme () {
            // Set color scheme of app based on person’s preference.
            var granite_settings = Granite.Settings.get_default ();
            var gtk_settings = Gtk.Settings.get_default ();
            gtk_settings.gtk_application_prefer_dark_theme
                = granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK;

            // Listen for changes in person’s color scheme settings
            // and update color scheme of app accordingly.
            granite_settings.notify["prefers-color-scheme"].connect (() => {
                gtk_settings.gtk_application_prefer_dark_theme
                    = granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK;
            });
        }

        public static int main (string[] commandline_arguments) {
            flatpak_id = Environment.get_variable ("FLATPAK_ID");
            is_running_as_flatpak = flatpak_id != null;

            // This removes the Gtk-Message: Failed to load module "canberra-gtk-module"
            // that plagues every elementary OS 6 (Odin) app at the moment when
            // running via Flatpak.
            if (is_running_as_flatpak) {
                Log.set_writer_func (logWriterFunc);
            }
            binary_path = File.new_for_path (commandline_arguments[0]).get_path();

            return new Application ().run (commandline_arguments);
        }

        // Used to remove the standard elementary OS 6 (Odin) warnings
        // when running as Flatpak. (See above.)
        private static LogWriterOutput logWriterFunc (LogLevelFlags log_level, [CCode (array_length_type = "gsize")] LogField[] fields) {
            return log_level == LogLevelFlags.LEVEL_MESSAGE ? LogWriterOutput.HANDLED : LogWriterOutput.UNHANDLED;
        }
    }
}
