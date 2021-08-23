/*
 * SPDX-License-Identifier: GPL-3.0-or-later
 * SPDX-FileCopyrightText: {COPYRIGHT.YEAR} {COPYRIGHT.NAME} <{COPYRIGHT.EMAIL}>
 */

public class App : Gtk.Application {
    public App () {
        Object(
            application_id: "org.small_tech.hello-world",
            flags: ApplicationFlags.FLAGS_NONE
        );
    }

    protected override void activate () {
        var main_window = new Gtk.ApplicationWindow (this) {
            default_height = 300,
            default_width = 300,
            title = _("{APP}")
        };

        main_window.show_all ();
    }

    public static int main (string[] args) {
        return new App ().run (args);
    }
}
