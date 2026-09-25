import 'dart:io';

void main() async {
  var server = await HttpServer.bind(InternetAddress.anyIPv4, 8080);
  print('🌐 الخادم يعمل الآن على: http://localhost:8080');

  await for (HttpRequest request in server) {
    var path = request.uri.path == '/' ? '/index.html' : request.uri.path;
    var file = File('web$path');

    if (await file.exists()) {
      if (path.endsWith('.html')) request.response.headers.contentType = ContentType.html;
      if (path.endsWith('.js')) request.response.headers.contentType = ContentType.parse('application/javascript');
      await file.openRead().pipe(request.response);
    } else {
      request.response.statusCode = HttpStatus.notFound;
      request.response.write('404 Not Found');
      await request.response.close();
    }
  }
}
