import 
  asynchttpserver, 
  asyncdispatch, 
  json

proc error_handle(req: Request): Future[JsonNode] {.async.} =
  return %* {"message": "404 not found"} 

proc hello_handle(req: Request): Future[JsonNode] {.async.} =
  return %* {"message": "Hello World!"}

export 
  error_handle, 
  hello_handle
  