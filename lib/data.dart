class Product {
  String name;
  String img;
  List list;

  Product(this.name, this.img, this.list);
}

enum AnswerType { input, process, output }

enum AnswerStatus { pending, correct, wrong }

class Answer {
  String val;
  AnswerType type;
  AnswerStatus status;

  Answer(this.val, this.type, {this.status = AnswerStatus.pending});
}

List all = [
  Product('Kereta Kawalan Jauh', 'kereta-kawal', keretakawal),
  Product('Pintu Gelangsar Automatik', 'pintu-gelangsar', pintugelangsar),
  Product('Mesin Basuh Automatik', 'mesin-basuh', mesinbasuh),
  Product('Kipas Siling Automatik', 'kipas', kipassiilingautomatik),
  Product('Drone', 'dron', drone),
  Product('Printer', 'printer', printer),
  Product('Lampu meja', 'lampu', lampumeja),
];

List keretakawal = [
  Answer('Panel kawalan tanpa wayar', AnswerType.input),
  Answer('Mikropengawal', AnswerType.process),
  Answer('Pemacu motor', AnswerType.output),
  Answer('Motor AT', AnswerType.output)
];
List pintugelangsar = [
  Answer('Penderia gerakan', AnswerType.input),
  Answer('Mikropengawal', AnswerType.process),
  Answer('Motor AT', AnswerType.output),
  Answer('Takal dan tali sawat', AnswerType.output),
  Answer('Pemacu motor', AnswerType.output)
];
List mesinbasuh = [
  Answer('Mod pilihan', AnswerType.input),
  Answer('Penderia', AnswerType.input),
  Answer('Mikropengawal', AnswerType.process),
  Answer('Motor AU', AnswerType.output),
  Answer('Takal dan tali sawat', AnswerType.output),
  Answer('Pemacu motor', AnswerType.output)
];
List kipassiilingautomatik = [
  Answer('Mod pilihan', AnswerType.input),
  Answer('Penderia', AnswerType.input),
  Answer('Mikropengawal', AnswerType.process),
  Answer('Pemacu motor', AnswerType.output),
  Answer('Motor AT', AnswerType.output),
];
List drone = [
  Answer('Panel kawalan tanpa wayar', AnswerType.input),
  Answer('Mikropengawal', AnswerType.process),
  Answer('Pemacu motor', AnswerType.output),
  Answer('Motor AT', AnswerType.output),
];
List printer = [
  Answer('Mod pilihan', AnswerType.input),
  Answer('Penderia', AnswerType.input),
  Answer('Mikropengawal', AnswerType.process),
  Answer('Motor AU', AnswerType.output),
  Answer('Takal dan tali sawat', AnswerType.output),
  Answer('Pemacu motor', AnswerType.output),
];
List lampumeja = [
  Answer('Panel kawalan tanpa wayar', AnswerType.input),
  Answer('Penderia', AnswerType.input),
  Answer('Penderia infra merah', AnswerType.input),
  Answer('Perintang peka cahaya LDR', AnswerType.input),
  Answer('Mikropengawal', AnswerType.process),
  Answer('Motor AT', AnswerType.output),
  Answer('Lampu LED', AnswerType.output),
];
