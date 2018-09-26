/*! Contains the connection and screen information
*/
typedef struct _screen_class {
	/*! connection to server */
	xcb_connection_t *c;
	/*! xcb generic error structure */
	xcb_generic_error_t *e;
	/*! default screen number of the connection */
	xcb_screen_t *screen;
	/*! edid atom fetched from the server */
	xcb_intern_atom_reply_t *edid_atom;
	/*! screen resources information */
	xcb_randr_get_screen_resources_reply_t *screen_resources_reply;

	/*! Update screen resources after the screen configuration has changed */
	void (*update_screen) (struct _screen_class *);

} screen_class;

void open_connection()
{
	/* Open the connection to the X server. Use the DISPLAY environment variable */
	xcb_connection_t *c;
	xcb_generic_error_t *e;

	c = xcb_connect(NULL, &screenNum);
	conn_error = xcb_connection_has_error(self->c);
	if (conn_error) {
		// TODO conn_error might overlap with my predefined errors
		fprintf(stderr, "Connection error!\n");
		exit(conn_error);
	}
}



// void screen_change_listener()
//
// int i, screenNum, conn_error;
// static const xcb_setup_t *setup;	//Must not be freed
// static xcb_screen_iterator_t iter;
// xcb_intern_atom_cookie_t atom_cookie;
//
// uint8_t only_if_exists = 1;
// const char *edid_name = "EDID";
// uint16_t name_len = strlen(edid_name);
//
// /* Get the screen whose number is screenNum */
//
// setup = xcb_get_setup(self->c);
// iter = xcb_setup_roots_iterator(setup);
//
// // we want the screen at index screenNum of the iterator
// for (i = 0; i < screenNum; ++i) {
// 	xcb_screen_next(&iter);
// }
//
// self->screen = iter.data;
// umon_print("Connected to server\n");
// atom_cookie =
//     xcb_intern_atom(self->c, only_if_exists, name_len, edid_name);
//
// self->edid_atom =
//     xcb_intern_atom_reply(self->c, atom_cookie, &self->e);
//
// while (self->edid_atom->atom == XCB_ATOM_NONE) {
// 	atom_cookie =
// 	    xcb_intern_atom(self->c, only_if_exists, name_len,
// 			    edid_name);
//
// 	self->edid_atom =
// 	    xcb_intern_atom_reply(self->c, atom_cookie, &self->e);
// }
//
//
// self->update_screen = update_screen;
// self->screen_resources_reply = NULL;
// self->update_screen(self);
