import 
  asynchttpserver, 
  asyncdispatch, 
  json, 
  strutils, 
  handles

var 
  port: int = 8080
  server = newAsyncHttpServer()

proc wrap_route(req: Request, aHandler: proc) {.async.} =
  var data = await aHandler(req)
  var headers = newHttpHeaders([("Content-Type","application/json")])
  await req.respond(Http200, $data, headers)

proc handler(req: Request) {.async.} =
  case req.url.path
  of "/hello":
    discard req.wrap_route(hello_handle)
  else:
    discard req.wrap_route(error_handle)

proc start_application(): Future[system.void] = 
  echo "\nStarting application..."
  echo "Application has been started at `http://localhost:" & intToStr(port) & "/`\n"
  return server.serve(Port(port), handler)

export 
  start_application