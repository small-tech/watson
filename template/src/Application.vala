/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: {COPYRIGHT.YEAR} {COPYRIGHT.NAME} <{COPYRIGHT.EMAIL}>
 */

namespace {APP.NAMESPACE} {
    public GLib.Settings saved_state;

    public class Application : Gtk.Application {

        public Application () {
            Object(
                application_id: "com.github.{GITHUB.ORG}.{GITHUB.APP}",
                flags: ApplicationFlags.FLAGS_NONE
            );

            saved_state = new GLib.Settings ("com.github.{GITHUB.ORG}.{GITHUB.APP}.saved-state");
        }

        protected override void activate () {
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

        public static int main (string[] commandline_arguments) {
            return new Application ().run (commandline_arguments);
        }
    }
}
