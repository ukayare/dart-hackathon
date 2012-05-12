

class oauth {
  final String consumer_key = "";
  final String consumer_secret = "";
  String token = "";
  String token_secret = "";
  
  String GenerateSignature(String url){
    String ret=url;
    ret+="consumer_key="+consumer_key;
    ret+="oauth_token="+token;
    ret+="oauth_version=1.0";
    ret+="oauth_timestamp="+TimeStamp();
    ret+="oauth_nonce="+GenerateNonce();
    ret+="oauth_signature_method=HMAC-SHA1";
    
    return ret;
  }
  
  String GenerateNonce()
  {
      String letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
      String result = "";
      for (int i = 0; i < 8; ++i)
      {
          double x = Math.random()*10000000;
          int y=x.toInt()%letters.length;
          result+=letters.substring(y,y+1);
          
      }
      return result;
  }
  
  String TimeStamp(){
    Date now = new Date.now();
    Date d = new Date(1970, 1, 1, 0, 0, 0, 0);
    return now.difference(d).toString();
  }

}

main(){
  oauth o =new oauth();
  
}