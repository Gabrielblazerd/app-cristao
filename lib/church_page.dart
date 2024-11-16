import 'package:flutter/material.dart';

class ChurchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Por que ir pra igreja?'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Escolher uma igreja para frequentar é uma decisão muito pessoal, mas há alguns aspectos e razões comuns que levam as pessoas a buscar uma igreja. Aqui estão alguns pontos gerais sobre o tema e os benefícios de frequentar uma igreja:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            _buildChurchBenefitsText(),
          ],
        ),
      ),
    );
  }

  Widget _buildChurchBenefitsText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildBenefitTitle('1. Comunidade e Apoio Social'),
        _buildBenefitDescription(
            'Ir à igreja proporciona uma sensação de pertencimento. Muitas igrejas têm uma forte comunidade onde é possível encontrar apoio e amizade. Frequentar regularmente cria laços com pessoas que compartilham valores e crenças, o que pode ser muito enriquecedor, especialmente em momentos difíceis ou de celebração.'),
        _buildBenefitTitle(
            '2. Desenvolvimento Espiritual e Crescimento Pessoal'),
        _buildBenefitDescription(
            'A igreja oferece um espaço para reflexão e crescimento espiritual. Para muitos, é um lugar de conexão com o divino, onde podem desenvolver sua fé, receber orientações morais e refletir sobre temas importantes da vida.'),
        _buildBenefitTitle('3. Participação em Atividades e Projetos Sociais'),
        _buildBenefitDescription(
            'A maioria das igrejas envolve-se em projetos sociais, como ajudar os mais necessitados, realizar campanhas de doação ou programas de voluntariado.'),
        _buildBenefitTitle('4. Espaço para a Família'),
        _buildBenefitDescription(
            'Muitas igrejas oferecem programas e atividades para pessoas de todas as idades, incluindo crianças, adolescentes e adultos.'),
        _buildBenefitTitle('5. Encontro com a Tradição e Ritual'),
        _buildBenefitDescription(
            'Frequentar uma igreja é, para muitas pessoas, uma forma de se conectar com tradições e práticas religiosas de longa data.'),
        _buildBenefitTitle('6. Explorar a Fé e Buscar Respostas'),
        _buildBenefitDescription(
            'Para aqueles que têm dúvidas ou buscam sentido na vida, a igreja pode ser um local de aprendizado e descoberta.'),
        const SizedBox(height: 20),
        const Text(
          'Como Escolher uma Igreja?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        const Text(
          'Para escolher uma igreja, pode ser útil considerar alguns fatores, como o estilo do culto, a doutrina ou teologia que a igreja segue, a localização, e a comunidade que frequenta a igreja.',
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildBenefitTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildBenefitDescription(String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(
        description,
        style: const TextStyle(fontSize: 14),
        textAlign: TextAlign.center,
      ),
    );
  }
}
