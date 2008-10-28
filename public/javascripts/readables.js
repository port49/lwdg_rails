function readableTime( seconds ) {
  var parts = [ 
    ( 60 * 60 * 24 * 7 * 52 ),
    ( 60 * 60 * 24 * 7 ),
    ( 60 * 60 * 24 ),
    ( 60 * 60 ),
    60,
    1
  ];
  var time = "";
  if( seconds >= parts[0] ) {
    time = time + parseInt( seconds / parts[0] ) + ' years and ';
    seconds = ( seconds % parts[0] );
  }
  if( seconds >= parts[1] || time.length > 0 ) {
    time = time + parseInt( seconds / parts[1] ) + ' weeks and ';
    seconds = ( seconds % parts[1] );
  }
  if( seconds >= parts[2] || time.length > 0 ) {
    time = time + parseInt( seconds / parts[2] ) + ' days and ';
    seconds = ( seconds % parts[2] );
  }
  if( seconds >= parts[3] ) {
    unit = parseInt( seconds / parts[3] );
    time = time + ( unit > 10 ? unit : '0' + unit ) + ':';
    seconds = ( seconds % parts[3] );
  } else {
    time = time + '00:';
  }
  if( seconds >= parts[4] ) {
    unit = parseInt( seconds / parts[4] );
    time = time + ( unit > 10 ? unit : '0' + unit ) + ':';
    seconds = ( seconds % parts[4] );
  } else {
    time = time + '00:';
  }
  if( seconds >= parts[5] ) {
    unit = parseInt( seconds / parts[5] );
    time = time + ( unit > 10 ? unit : '0' + unit );
  } else {
    time = time + '00';
  }
  return time;
}

function readableBytes( size, precision, longName, realSize ) {
   if (typeof precision=="undefined") {
      precision=2;
   }
   if (typeof longName=="undefined") {
      longName=true;
   }
   if (typeof realSize=="undefined") {
      realSize=true;
   }
   var base=realSize?1024:1000;
   var pos=0;
   while (size>base) {
      size/=base;
      pos++;
   }
   var prefix=readableBytesPrefix(pos);
   var sizeName=longName?prefix+"bytes":prefix.charAt(0)+'B';
   sizeName=sizeName.charAt(0).toUpperCase()+sizeName.substring(1);
   var num=Math.pow(10,precision);
   return (Math.round(size*num)/num)+sizeName;
}
function readableBytesPrefix(pos) {
   switch (pos) {
      case  0: return "";
      case  1: return "kilo";
      case  2: return "mega";
      case  3: return "giga";
      case  4: return "tera";
      case  5: return "peta";
      case  6: return "exa";
      case  7: return "zetta";
      case  8: return "yotta";
      case  9: return "xenna";
      case 10: return "w-";
      case 11: return "vendeka";
      case 12: return "u-";
      default: return "?-";
   }
}


