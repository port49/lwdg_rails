var Directory = {

  postDirectory: function( anchor ) {
    var i = $( anchor ).prev()[0];
    var p = prompt( "New folder", "new folder" );
    if( p ) {
      i.value = p;
      i.form.submit();
    }
  },

  putDirectory: function( anchor ) {
    var i = $( anchor ).prev()[0];
    var p = prompt( "Rename folder", i.value );
    if( p ) {
      i.value = p;
      i.form.submit();
    }
  },

  deleteDirectory: function( anchor ) {
    var i = $( anchor ).prev()[0];
    var c = confirm( "Really delete this folder and all files in it?  This cannot be undone!" );
    if( c ) {
      i.form.submit();
    }
  }

}

var File = {

  putFile: function( anchor ) {
    var i = $( anchor ).prev()[0];
    var p = prompt( "Rename file", i.value );
    if( p ) {
      i.value = p;
      i.form.submit();
    }
  },

  deleteFile: function( anchor ) {
    var i = $( anchor ).prev()[0];
    var c = confirm( "Really delete this file?  This cannot be undone!" );
    if( c ) {
      i.form.submit();
    }
  },
  
  addInput: function( button ) {
    var button = $( button );
    var count = button.data( 'count' );
    if( !count ) {
      count = 1;
    }
    button.data( 'count', ( count + 1 ) );
    button.after( "<br /><input name='file[" + count + "]' type='file' /><button onclick='File.removeInput( this );return false;'>-</button>" );
    return false;
  },
  
  removeInput: function( button ) {
    var button = $( button );
    var input = button.prev();
    var br = input.prev();
    br.remove();
    input.remove();
    button.remove();
    return false;
  }

}

var User = {

  postUser: function( form_id, input_id ) {
  },

  putUser: function( anchor ) {
    var i = $( anchor ).prev()[0];
    var p = prompt( "New password", i.value );
    if( p ) {
      i.value = p;
      i.form.submit();
    }
  },

  deleteUser: function( anchor ) {
    var i = $( anchor ).prev()[0];
    var c = confirm( "Really delete this user?  This cannot be undone!" );
    if( c ) {
      i.form.submit();
    }
  }

}

