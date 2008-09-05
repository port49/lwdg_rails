var Directory = {

  postDirectory: function( form_id, input_id ) {
    var p = prompt( "New folder", "new folder" );
    if( p ) {
      $( 'input#' + input_id )[0].value = p;
      $( 'form#' + form_id ).submit();
    }
  },

  putDirectory: function( form_id, input_id ) {
    var p = prompt( "Rename folder", $( 'input#' + input_id )[0].value );
    if( p ) {
      $( 'input#' + input_id )[0].value = p;
      $( 'form#' + form_id ).submit();
    }
  },

  deleteDirectory: function( form_id ) {
    var c = confirm( "Really delete this folder and all files in it?  This cannot be undone!" );
    if( c ) {
      $( 'form#' + form_id ).submit();
    }
  }

}

var Rickets = {

  redirect: function( url ) {
    if( url ) {
      document.location = url;
    }
  },

  showRow: function( row ) {
    tr = $( row );
    if( tr.length == 1 ) {
      Rickets.redirect( tr.attr( 'id' ) );
    }
  },

  selectRow: function( tr ) {
    row = $( tr );
    if( row.hasClass( 'selected' ) ) {
      row.removeClass( 'selected' );
    } else {
      // Only one selected row at a time.
      Rickets.unSelectRows( row.parent() );
      row.addClass( 'selected' );
    }
  },

  unSelectRows: function( row_set ) {
    var rows = row_set.children();
    rows.removeClass( 'selected' );
  },

  findSelectedRow: function( table ) {
    var tr = table.find( "tr.selected:first" );
    if( tr.length < 1 ) {
      alert( "Please select a row first." );
      return false;
    } else {
      return tr;
    }
  },

  extractId: function( url ) {
    parts = url.split( "/" );
    return parts.pop();
  },
  
  newChildForSelectedRow: function( table, url ) {
    var match = Rickets.findSelectedRow( table );
    if( match ) {
      document.location = url + '?parent_id=' + Rickets.extractId( match.id );
    }
  },

  redirectToSelectedRow: function( table ) {
    var tr = Rickets.findSelectedRow( table );
    if( tr ) {
      Rickets.showRow( tr );
    }
  },

  destroySelectedRow: function( table ) {
    var tr = Rickets.findSelectedRow( table );
    if( tr ) {
      var c = confirm( "Really delete this?" );
      if( c ) {
        $.post( tr.attr('id'), { _method:'delete' }, null, 'script' );
      }
    }
  },

  toggleCheckboxToPanel: function( checkbox, panel ) {
    if( $F(checkbox) ) {
      $( panel ).show();
    } else {
      $( panel ).hide();
    }
  },

  toggleSelectOptionToPanel: function( select, option_value, panel ) {
    if( $F(select) == option_value ) {
      $( panel ).show();
    } else {
      $( panel ).hide();
    }
  },

  destroySelectedListItem: function( li ) {
    var match = $( li );
    if( match ) {
      var c = confirm( "Really delete this forever?" );
      if( c ) {
        match.remove();
      }
    }
  },

  publishForm: function( button ) {
    var c = confirm( "Accept all pending changes and publish this to the live site?" );
    if( c ) {
      $('workflow').value='publish';
      button.form.submit();
    }
  },
  
  revertForm: function( button ) {
    var c = confirm( "Revert to last published version and destroy all pending changes?" );
    if( c ) {
      $('workflow').value='revert';
      button.form.submit();
    }
  }
  
}
