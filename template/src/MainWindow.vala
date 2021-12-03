namespace {APP.NAMESPACE} {
    public class MainWindow : Hdy.ApplicationWindow {
        public weak {APP.NAMESPACE}.Application app { get; construct; }

        // Widgets
        public {APP.NAMESPACE}.Widgets.HeaderBar toolbar;

        public const string ACTION_PREFIX = "win.";
        public const string ACTION_FULLSCREEN = "action_fullscreen";
        public const string ACTION_QUIT = "action_quit";

        public SimpleActionGroup actions { get; set; }
        public static Gee.MultiMap<string, string> action_accelerators = new Gee.HashMultiMap<string, string> ();

        public enum WindowState {
            NORMAL = 0,
            MAXIMIZED = 1,
            FULLSCREEN = 2
        }

        private const ActionEntry[] ACTION_ENTRIES = {
            { ACTION_FULLSCREEN, action_fullscreen },
            { ACTION_QUIT, action_quit },
        };

        private static void define_action_accelerators () {
            // Define action accelerators (keyboard shortcuts).
            action_accelerators.set (ACTION_FULLSCREEN, "F11");
            action_accelerators.set (ACTION_QUIT, "<Control>q");
        }

        public MainWindow ({APP.NAMESPACE}.Application application) {
            Object (
                // We must set the inherited application property for Hdy.ApplicationWindow
                // to initialise properly. However, this is not a set-type property (get; set;)
                // so the assignment is made after construction, which means that we cannot
                // reference the application during the construct method. This is why we also
                // declare a property called app that is construct-type (get; construct;) which
                // is assigned before the constructors are run.
                //
                // So use the app property when referencing the application instance from
                // the constructors. Anywhere else, they can be used interchangably.
                app: application,
                application: application,                    // DON’T use in constructors; won’t have been assigned yet.
                height_request: 420,
                width_request: 420,
                hide_titlebar_when_maximized: true,          // FIXME: This does not seem to have an effect. Why not?
                icon_name: "com.github.{GITHUB.ORG}.{GITHUB.APP}"
            );
        }

        // This constructor is guaranteed to be run only once during the lifetime of the application.
        static construct {
            // Initialise the Handy library.
            // https://gnome.pages.gitlab.gnome.org/libhandy/
            // (Apps in elementary OS 6 use the Handy library extensions
            // instead of GTKApplicationWindow, etc., directly.)
            Hdy.init();

            // Define acclerators (keyboard shortcuts) for actions.
            MainWindow.define_action_accelerators ();
        }

        // This constructor will be called every time an instance of this class is created.
        construct {
            // State preservation: save window dimensions and location on window close.
            // See: https://docs.elementary.io/hig/user-workflow/closing
            set_up_state_preservation ();

            // State preservation: restore window dimensions and location from last run.
            // See https://docs.elementary.io/hig/user-workflow/normal-launch#state
            restore_window_state ();

            // Create window layout.
            create_layout ();

            // Set up actions (with accelerators) for full screen, quit, etc.
            set_up_actions ();

            // Make all widgets (the interface) visible.
            show_all ();
        }

        // Layout.

        private void create_layout () {
            // Unlike GTK, in Handy, the header bar is added to the window’s content area.
            // See https://gnome.pages.gitlab.gnome.org/libhandy/doc/1-latest/HdyHeaderBar.html
            toolbar = new {APP.NAMESPACE}.Widgets.HeaderBar ();
            var grid = new Gtk.Grid ();
            grid.attach (toolbar, 0, 0);

            // Add other components to go under the toolbar here.

            add (grid);
        }

        // State preservation.

        private void set_up_state_preservation () {
            // Before the window is deleted, preserve its state.
            delete_event.connect (() => {
                preserve_window_state ();
                return false;
            });

            // Quit gracefully (ensuring state is preserved) when SIGINT or SIGTERM is received
            // (e.g., when run from terminal and terminated using Ctrl+C).
            Unix.signal_add (Posix.Signal.INT, quit_gracefully, Priority.HIGH);
            Unix.signal_add (Posix.Signal.TERM, quit_gracefully, Priority.HIGH);
        }

        private void restore_window_state () {
            var rect = Gdk.Rectangle ();
            {APP.NAMESPACE}.saved_state.get ("window-size", "(ii)", out rect.width, out rect.height);

            default_width = rect.width;
            default_height = rect.height;

            var window_state = {APP.NAMESPACE}.saved_state.get_enum ("window-state");
            switch (window_state) {
                case WindowState.MAXIMIZED:
                    maximize ();
                    break;
                case WindowState.FULLSCREEN:
                    fullscreen ();
                    break;
                default:
                    {APP.NAMESPACE}.saved_state.get ("window-position", "(ii)", out rect.x, out rect.y);
                    if (rect.x != -1 && rect.y != -1) {
                        move (rect.x, rect.y);
                    }
                    break;
            }
        }

        private void preserve_window_state () {
            // Persist window dimensions and location.
            var state = get_window ().get_state ();
            if (Gdk.WindowState.MAXIMIZED in state) {
                {APP.NAMESPACE}.saved_state.set_enum ("window-state", WindowState.MAXIMIZED);
            } else if (Gdk.WindowState.FULLSCREEN in state) {
                {APP.NAMESPACE}.saved_state.set_enum ("window-state", WindowState.FULLSCREEN);
            } else {
                {APP.NAMESPACE}.saved_state.set_enum ("window-state", WindowState.NORMAL);
                // Save window size
                int width, height;
                get_size (out width, out height);
                {APP.NAMESPACE}.saved_state.set ("window-size", "(ii)", width, height);
            }

            int x, y;
            get_position (out x, out y);
            {APP.NAMESPACE}.saved_state.set ("window-position", "(ii)", x, y);
        }

        // Actions.

        private void set_up_actions () {
            // Setup actions and their accelerators.
            actions = new SimpleActionGroup ();
            actions.add_action_entries (ACTION_ENTRIES, this);
            insert_action_group ("win", actions);

            foreach (var action in action_accelerators.get_keys ()) {
                var accels_array = action_accelerators[action].to_array ();
                accels_array += null;

                app.set_accels_for_action (ACTION_PREFIX + action, accels_array);
            }
        }

        // Action handlers.

        private void action_fullscreen () {
            if (Gdk.WindowState.FULLSCREEN in get_window ().get_state ()) {
                unfullscreen ();
            } else {
                fullscreen ();
            }
        }

        private void action_quit () {
            preserve_window_state ();
            destroy ();
        }

        // Graceful shutdown.

        public bool quit_gracefully () {
            action_quit ();
            return false;
        }
    }
}
