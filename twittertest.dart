#import('dart:io');
#import('dart:uri');
#import('dart:json');
#import("dart:utf");

class TwitterTest {
  String URL;
 
  StringBuffer responseStringBuff;
  InputStream inputStream;
 
  TwitterTest(String searchWord) {
    URL = "http://search.twitter.com/search.json?q=+"+searchWord+"&lang=ja";
    responseStringBuff = new StringBuffer();
  }
 
  void onResponse(HttpClientResponse res) {
    if(res.statusCode==200)
      print("ok write test.txt");
 
    inputStream = res.inputStream;
    inputStream.onData = onResponseData;
    inputStream.onClosed = onResponseClosed;
  }
 
  void onResponseData() {
    StringBuffer bf=new StringBuffer();
    bf.add(new String.fromCharCodes(inputStream.read()));
    String responseData = bf.toString();
    responseStringBuff.add(responseData);
    File out =new File("test2.txt");
    OutputStream ostream =out.openOutputStream();
    ostream.writeString(responseData);
  }
 
  void onResponseClosed() {
    var resJSON = JSON.parse(responseStringBuff.toString());
    var entries = resJSON["results"];
    File out =new File("test.txt");
    OutputStream ostream =out.openOutputStream();
    entries.forEach((value){
      ostream.writeString(value["text"]+"\r\n");
    });
    ostream.close();
  }
 
  void run() {
    print("get_serchdata");
    HttpClient client = new HttpClient();
    HttpClientConnection connection = client.getUrl(new Uri.fromString(URL));
    connection.onResponse = onResponse;
    onResponseClosed;
  }
}
 
void main() {
  new TwitterTest("toeic").run();
}
