/*

## ¿Qué es main.dart y cómo lanza la aplicación?

El archivo **main.dart** es el punto de entrada de toda aplicación Flutter.
Contiene la función principal `void main()`, que es la primera pieza de código 
que se ejecuta cuando se inicia la app. Dentro de esta función, se llama a 
`runApp()`, pasándole el widget raíz de tu aplicación (comúnmente llamado `MyApp`), 
lo que efectivamente "infla" ese widget y lo muestra en la pantalla.

---

## ¿Qué rol juega pubspec.yaml?

El archivo **pubspec.yaml** es el archivo de configuración y manifiesto del proyecto.
Su función principal es gestionar las **dependencias** del proyecto, como 
paquetes y plugins de terceros que añaden funcionalidades a la app. También se 
utiliza para declarar los **assets** que la aplicación utilizará, como imágenes, 
videos y fuentes personalizadas.

---

## ¿Cuál es la diferencia entre lib/ y android/?

La carpeta **lib/ ** es donde vive todo el código **Dart** de tu aplicación
Flutter; aquí es donde los desarrolladores pasan la mayor parte del tiempo
escribiendo la lógica y la interfaz de usuario que será compartida entre todas 
las plataformas. Por otro lado, la carpeta **android/ ** contiene el proyecto 
anfitrión de **Android nativo**, que se encarga de compilar y ejecutar el código
de Flutter en un dispositivo Android; se modifica principalmente para 
configuraciones específicas de la plataforma.
*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'You have pressed the button this many times:',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: ProfileCard(
        name: 'John Doe',
        description: 'Flutter Developer | Tech Enthusiast',
        imageUrl: 'https://picsum.photos/id/237/200/300',
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String name;
  final String description;
  final String imageUrl;

  ProfileCard({
    super.key,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Card'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card wrap its content
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(imageUrl),
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: 16),
              Text(
                name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int counter = 0;

  void _incrementCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '$counter',
          key: Key('counterText'),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        ElevatedButton(
          key: Key('incrementButton'),
          onPressed: _incrementCounter,
          child: const Text('Increment'),
        ),
      ],
    );
  }
}

class TextInputWidget extends StatefulWidget {
  const TextInputWidget({super.key});

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  final TextEditingController _controller = TextEditingController();
  String _currentText = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateText);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateText() {
    setState(() {
      _currentText = _controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextField(
          key: Key('inputField'),
          controller: _controller,
          decoration: InputDecoration(hintText: 'Enter text here'),
        ),
        SizedBox(height: 16),
        Text(
          _currentText,
          key: Key('liveText'),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }
}

class ToggleControlsWidget extends StatefulWidget {
  const ToggleControlsWidget({super.key});

  @override
  _ToggleControlsWidgetState createState() => _ToggleControlsWidgetState();
}

class _ToggleControlsWidgetState extends State<ToggleControlsWidget> {
  bool isDarkMode = false;
  bool agreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Dark Mode'),
            Switch(
              key: Key('darkModeSwitch'),
              value: isDarkMode,
              onChanged: (bool value) {
                setState(() {
                  isDarkMode = value;
                });
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              key: Key('termsCheckbox'),
              value: agreedToTerms,
              onChanged: (bool? value) {
                setState(() {
                  agreedToTerms = value ?? false;
                });
              },
            ),
            const Text('Agree to Terms'),
          ],
        ),
        SizedBox(height: 16),
        Text(
          key: Key('statusText'),
          isDarkMode && agreedToTerms ? 'Ready' : 'Incomplete',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }
}

class MiniFormWidget extends StatefulWidget {
  const MiniFormWidget({super.key});

  @override
  _MiniFormWidgetState createState() => _MiniFormWidgetState();
}

class _MiniFormWidgetState extends State<MiniFormWidget> {
  final TextEditingController _nameController = TextEditingController();
  bool _agreedToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_nameController.text.isNotEmpty && _agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form submitted successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all fields.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            key: Key('nameField'),
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Checkbox(
                key: Key('formCheckbox'),
                value: _agreedToTerms,
                onChanged: (bool? value) {
                  setState(() {
                    _agreedToTerms = value ?? false;
                  });
                },
              ),
              const Text('I agree to the terms'),
            ],
          ),
          SizedBox(height: 24),
          ElevatedButton(
            key: Key('submitButton'),
            onPressed: _submitForm,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: <Widget>[
          ProfileCard(
            name: 'Jane Doe',
            description: 'Mobile App Designer | UX Specialist',
            imageUrl: 'https://picsum.photos/id/1/200/200',
          ),
          ProfileCard(
            name: 'Peter Jones',
            description: 'Backend Engineer | Cloud Expert',
            imageUrl: 'https://picsum.photos/id/10/200/200',
          ),
          ProfileCard(
            name: 'Alice Williams',
            description: 'Project Manager | Agile Coach',
            imageUrl: 'https://picsum.photos/id/20/200/200',
          ),
          ProfileCard(
            name: 'Tom Brown',
            description: 'QA Tester | Automation Fanatic',
            imageUrl: 'https://picsum.photos/id/30/200/200',
          ),
        ],
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.*/
    );
  }
}
