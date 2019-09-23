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

public class UndoNodesDelete : UndoItem {

  Array<Node>       _nodes;
  Array<Connection> _conns;

  /* Default constructor */
  public UndoNodesDelete( Array<Node> nodes, Array<Connection> conns ) {
    base( _( "delete node" ) );
    _nodes = new Array<Node>();
    _conns = conns;
  }

  /* Undoes a node deletion */
  public override void undo( DrawArea da ) {
    /*
    if( _parent == null ) {
      da.add_root( _node, _index );
    } else {
      _node.attached = true;
      _node.attach_init( _parent, _index );
    }
    da.set_current_node( _node );
    for( int i=0; i<_conns.length; i++ ) {
      da.get_connections().add_connection( _conns.index( i ) );
    }
    da.queue_draw();
    da.changed();
    */
  }

  /* Redoes a node deletion */
  public override void redo( DrawArea da ) {
    /*
    if( _parent == null ) {
      da.remove_root( _index );
    } else {
      _node.detach( _node.side );
    }
    da.set_current_node( null );
    for( int i=0; i<_conns.length; i++ ) {
      da.get_connections().remove_connection( _conns.index( i ), false );
    }
    da.queue_draw();
    da.changed();
    */
  }

}