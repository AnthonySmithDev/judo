
def context [] {
  mods 'tu eres un excelente alumno de judo y me vas a ayudar a responder las siguentes preguntas que te voy a dar:'
}

def chunk [lista: list] {
  mut idx = 0
  mut chunks = []
  const chunk_size = 10
  while ($idx < ($lista | length)) {
    $chunks = ($chunks | append [($lista | skip $idx | first $chunk_size)])
    $idx = $idx + $chunk_size
  }
  return $chunks
}

def guardar [pregunta: string, respuesta: string] {
  let text = ([$pregunta, "\n\n", $respuesta, "\n\n\n"] | str join)
  $text | save --append --progress respuestas.txt
}

let preguntas = (open preguntas.txt | lines)
let chunks = chunk $preguntas
for chunk in $chunks {
  context
  for pregunta in $chunk {
    let respuesta = (mods -C $pregunta)
    guardar $pregunta $respuesta
    sleep 30sec
  }
}
