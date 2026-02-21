import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MessageBubbleDemo(),
    );
  }
}

class TelegramMessageBubble extends StatelessWidget {
  final String message;
  final String time;
  final bool isMe;

  const TelegramMessageBubble({
    super.key,
    required this.message,
    required this.time,
    this.isMe = true,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isMe ? const Color(0xFF2B5278) : const Color(0xFF182533),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMe ? 16 : 4),
            bottomRight: Radius.circular(isMe ? 4 : 16),
          ),
        ),
        child: _MessageContent(message: message, time: time),
      ),
    );
  }
}

class _MessageContent extends StatelessWidget {
  final String message;
  final String time;

  const _MessageContent({required this.message, required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: _MessageWithTime(message: message, time: time),
    );
  }
}

class _MessageWithTime extends StatelessWidget {
  final String message;
  final String time;

  const _MessageWithTime({required this.message, required this.time});

  @override
  Widget build(BuildContext context) {
    return _buildMessageWithInlineTime(context);
  }

  Widget _buildMessageWithInlineTime(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 15,
      height: 1.35,
    );

    const timeStyle = TextStyle(
      color: Colors.white54,
      fontSize: 12,
    );

    // Invisible placeholder qo'shib, text wrap qilganda joy olishini ta'minlaymiz
    // Bu Telegram'ning o'zi ishlatiydigan usul
    final spacer = '\u00A0' * 10; // time uchun joy

    return Stack(
      children: [
        // Asosiy text + oxirida bo'sh joy (time uchun)
        RichText(
          text: TextSpan(
            style: textStyle,
            children: [
              TextSpan(text: message),
              // Time o'rnini egallash uchun invisible spacer
              TextSpan(
                text: spacer,
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),

        // Time - har doim pastki o'ng burchakda
        Positioned(
          right: 0,
          bottom: -2,
          child: Text(time, style: timeStyle),
        ),
      ],
    );
  }
}

// Demo
class MessageBubbleDemo extends StatelessWidget {
  const MessageBubbleDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1621),
      appBar: AppBar(
        backgroundColor: const Color(0xFF17212B),
        title: const Text('Chat', style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: const [
          // Qisqa - bir qatorga sig'adi
          TelegramMessageBubble(
            message: 'Salom!',
            time: '14:25',
          ),

          SizedBox(height: 6,),

          // O'rta uzunlik
          TelegramMessageBubble(
            message: 'Bugun uchrashuvga kelasizmi?',
            time: '14:26',
            isMe: false,
          ),

          SizedBox(height: 6,),

          // URL bor
          TelegramMessageBubble(
            message: 'Ha, mana link: https://meet.google.com/abc-defg-hij',
            time: '14:27',
          ),

          SizedBox(height: 6,),

          // Ko'p qatorli, oxirida joy bor
          TelegramMessageBubble(
            message: 'Loyiha haqida gaplashdik.\nHamma narsa tayyor.',
            time: '14:28',
          ),

          SizedBox(height: 6,),

          // Ko'p qatorli, oxirida joy yo'q (time alohida qatorda)
          TelegramMessageBubble(
            message:
                'Bu juda uzun xabar bo\'lib, u bir necha qatorni egallaydi va oxirgi qatorda vaqt uchun joy qolmaydi demak vaqt alohida chiqadi.',
            time: '14:29',
          ),
        ],
      ),
    );
  }
}