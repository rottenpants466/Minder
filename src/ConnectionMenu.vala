/*
* Copyright (c) 2018 (https://github.com/phase1geo/Minder)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Trevor Williams <phase1geo@gmail.com>
*/

using Gtk;

public class ConnectionMenu : Gtk.Menu {

  DrawArea     _da;
  Gtk.MenuItem _delete;
  Gtk.MenuItem _edit;
  Gtk.MenuItem _note;
  Gtk.MenuItem _sticker;
  Gtk.MenuItem _selstart;
  Gtk.MenuItem _selend;
  Gtk.MenuItem _selnext;
  Gtk.MenuItem _selprev;

  /* Default constructor */
  public ConnectionMenu( DrawArea da, AccelGroup accel_group ) {

    _da = da;

    _delete = new Gtk.MenuItem.with_label( _( "Delete" ) );
    _delete.activate.connect( delete_connection );
    Utils.add_accel_label( _delete, 65535, 0 );

    _edit = new Gtk.MenuItem.with_label( _( "Edit…" ) );
    _edit.activate.connect( edit_title );
    Utils.add_accel_label( _edit, 'e', 0 );

    _note = new Gtk.MenuItem.with_label( _( "Add Note" ) );
    _note.activate.connect( change_note );

    _sticker = new Gtk.MenuItem.with_label( _( "Remove Sticker" ) );
    _sticker.activate.connect( remove_sticker );

    var selnode = new Gtk.MenuItem.with_label( _( "Select" ) );
    var selmenu = new Gtk.Menu();
    selnode.set_submenu( selmenu );

    _selstart = new Gtk.MenuItem.with_label( _( "Start Node" ) );
    _selstart.activate.connect( select_start_node );
    Utils.add_accel_label( _selstart, 'f', 0 );

    _selend = new Gtk.MenuItem.with_label( _( "End Node" ) );
    _selend.activate.connect( select_end_node );
    Utils.add_accel_label( _selend, 't', 0 );

    _selnext = new Gtk.MenuItem.with_label( _( "Next Connection" ) );
    _selnext.activate.connect( select_next_connection );
    Utils.add_accel_label( _selnext, 65363, 0 );

    _selprev = new Gtk.MenuItem.with_label( _( "Previous Connection" ) );
    _selprev.activate.connect( select_prev_connection );
    Utils.add_accel_label( _selprev, 65361, 0 );

    /* Add the menu items to the menu */
    add( _delete );
    add( new SeparatorMenuItem() );
    add( _edit );
    add( _note );
    add( _sticker );
    add( new SeparatorMenuItem() );
    add( selnode );

    /* Add the items to the selection menu */
    selmenu.add( _selstart );
    selmenu.add( _selend );
    selmenu.add( new SeparatorMenuItem() );
    selmenu.add( _selnext );
    selmenu.add( _selprev );

    /* Make the menu visible */
    show_all();

    /* Make sure that we handle menu state when we are popped up */
    show.connect( on_popup );

  }

  /* Returns true if a note is associated with the currently selected node */
  private bool connection_has_note() {
    Connection? current = _da.get_current_connection();
    return( (current != null) && (current.note != "") );
  }

  /* Called when the menu is popped up */
  private void on_popup() {

    _sticker.set_sensitive( _da.get_current_connection().sticker != null );

    /* Set the menu item labels */
    _note.label = connection_has_note() ? _( "Remove Note" ) : _( "Add Note" );

  }

  /* Deletes the current node */
  private void delete_connection() {
    _da.delete_connection();
  }

  /* Displays the sidebar to edit the node properties */
  private void edit_title() {
    Connection conn = _da.get_current_connection();
    if( conn.title == null ) {
      conn.change_title( _da, "", true );
    }
    _da.set_connection_mode( conn, ConnMode.EDITABLE );
  }

  /* Changes the note status of the currently selected node */
  private void change_note() {
    if( connection_has_note() ) {
      _da.change_current_connection_note( "" );
    } else {
      _da.show_properties( "current", true );
    }
    _da.current_changed( _da );
  }

  /* Removes the sticker attached to the connection */
  private void remove_sticker() {
    var current = _da.get_current_connection();
    _da.undo_buffer.add_item( new UndoConnectionStickerRemove( current ) );
    current.sticker = null;
    _da.queue_draw();
    _da.changed();
  }

  /* Selects the next sibling node of the current node */
  private void select_start_node() {
    _da.select_connection_node( true );
  }

  /* Selects the previous sibling node of the current node */
  private void select_end_node() {
    _da.select_connection_node( false );
  }

  /* Selects the next connection in the mind map */
  private void select_next_connection() {
    _da.select_connection( 1 );
  }

  /* Selects the previous connection in the mind map */
  private void select_prev_connection() {
    _da.select_connection( -1 );
  }

}
