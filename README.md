# flutter_fitsize

Flutter APP 大小适配

## Getting Started

##### Import

```
import 'package:flutter_fitsize/flutter_fitsize.dart';
```



##### Configurate

```dart
fs.setup(referenceWidth: 414.0, padFitMultiple: 0.7);
fs.setup(referenceWidth: 414.0);
fs.setup(padFitMultiple: 0.7);
```



##### Fitsize

自动适配大小

```dart
fs>40.0;
fs(40.0);
fs.auto(40.0);
```

强行适配大小

```dart
// force
fs>>40.0;
fs(40.0, isForce: true);
fs.force(40.0);
```

