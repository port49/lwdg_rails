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

  postFile: function( form_id, input_id ) {
  },

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
  }

}

