# WhatsApp Web.js - Custom Guide
# Source: https://docs.wwebjs.dev
# Date: 2025-10-12
# Type: Custom guide (no official llms.txt available)

## About WhatsApp Web.js

WhatsApp Web.js (wwebjs) is a WhatsApp API client that connects through the WhatsApp Web browser. It allows you to send and receive messages, media, and interact with contacts and groups programmatically.

**⚠️ Important**: WhatsApp does not officially allow bots or unofficial clients on their platform. Using this library may result in your account being banned.

## Requirements

- Node.js v18+
- A WhatsApp account

## Installation

```bash
npm install whatsapp-web.js
```

### Additional Dependencies

For full functionality, install puppeteer:

```bash
npm install puppeteer
```

## Basic Setup

### Simple Client

```javascript
const { Client } = require('whatsapp-web.js');

const client = new Client();

// QR Code event
client.on('qr', (qr) => {
    console.log('QR RECEIVED', qr);
    // Generate QR code for scanning
});

// Client ready event
client.on('ready', () => {
    console.log('Client is ready!');
});

// Message received event
client.on('message', async (msg) => {
    console.log('MESSAGE RECEIVED', msg.body);

    if (msg.body === '!ping') {
        await msg.reply('pong');
    }
});

// Initialize client
client.initialize();
```

### With Local Authentication

```javascript
const { Client, LocalAuth } = require('whatsapp-web.js');

const client = new Client({
    authStrategy: new LocalAuth({
        clientId: 'client-one' // Unique identifier for this session
    })
});

client.on('ready', () => {
    console.log('Client is ready!');
});

client.initialize();
```

## Authentication Strategies

### LocalAuth (Recommended)

Stores session data locally in the file system:

```javascript
const { Client, LocalAuth } = require('whatsapp-web.js');

const client = new Client({
    authStrategy: new LocalAuth({
        clientId: 'my-app', // Optional, defaults to 'client'
        dataPath: './auth_data' // Optional, defaults to './.wwebjs_auth'
    })
});
```

### NoAuth (Development Only)

No session persistence - requires QR scan every time:

```javascript
const { Client, NoAuth } = require('whatsapp-web.js');

const client = new Client({
    authStrategy: new NoAuth()
});
```

## QR Code Generation

### Console Output

```javascript
client.on('qr', (qr) => {
    console.log('QR CODE:', qr);
});
```

### Generate QR Image with qrcode-terminal

```bash
npm install qrcode-terminal
```

```javascript
const qrcode = require('qrcode-terminal');

client.on('qr', (qr) => {
    qrcode.generate(qr, { small: true });
});
```

### Generate QR Image for Web

```bash
npm install qrcode
```

```javascript
const QRCode = require('qrcode');

client.on('qr', async (qr) => {
    const qrCodeDataUrl = await QRCode.toDataURL(qr);
    console.log('QR Code Data URL:', qrCodeDataUrl);
    // Send to frontend or save as image
});
```

## Sending Messages

### Text Messages

```javascript
const chatId = '5511999999999@c.us'; // Brazilian number format

await client.sendMessage(chatId, 'Hello from WhatsApp Web.js!');
```

### Mentions

```javascript
const chat = await client.getChatById('GROUP_CHAT_ID@g.us');
const contact = await client.getContactById('5511999999999@c.us');

await chat.sendMessage('Hello @5511999999999', {
    mentions: [contact]
});
```

### Replies

```javascript
client.on('message', async (msg) => {
    if (msg.body === '!help') {
        await msg.reply('Available commands: !ping, !info');
    }
});
```

## Sending Media

### Images

```javascript
const { MessageMedia } = require('whatsapp-web.js');

// From URL
const media = await MessageMedia.fromUrl('https://example.com/image.jpg');
await client.sendMessage(chatId, media, { caption: 'Image caption' });

// From local file
const media = MessageMedia.fromFilePath('./path/to/image.jpg');
await client.sendMessage(chatId, media);

// From base64
const media = new MessageMedia('image/jpeg', base64Data, 'image.jpg');
await client.sendMessage(chatId, media);
```

### Documents

```javascript
const media = MessageMedia.fromFilePath('./document.pdf');
await client.sendMessage(chatId, media, { caption: 'Important document' });
```

### Audio

```javascript
const media = MessageMedia.fromFilePath('./audio.mp3');
await client.sendMessage(chatId, media, { sendAudioAsVoice: true });
```

### Videos

```javascript
const media = MessageMedia.fromFilePath('./video.mp4');
await client.sendMessage(chatId, media, { caption: 'Check this video' });
```

## Receiving Messages

### Message Event

```javascript
client.on('message', async (msg) => {
    console.log('From:', msg.from);
    console.log('Body:', msg.body);
    console.log('Timestamp:', msg.timestamp);
    console.log('Is Group:', msg.from.endsWith('@g.us'));

    // Check if message has media
    if (msg.hasMedia) {
        const media = await msg.downloadMedia();
        console.log('Media type:', media.mimetype);
        // Save media: fs.writeFileSync('file.jpg', media.data, 'base64');
    }
});
```

### Message Types

```javascript
client.on('message', async (msg) => {
    if (msg.hasQuotedMsg) {
        const quotedMsg = await msg.getQuotedMessage();
        console.log('Quoted message:', quotedMsg.body);
    }

    if (msg.hasReaction) {
        console.log('Message has reaction');
    }

    if (msg.type === 'image') {
        const media = await msg.downloadMedia();
        // Process image
    }

    if (msg.type === 'audio' || msg.type === 'ptt') {
        // Process audio/voice note
    }
});
```

## Groups

### Get All Groups

```javascript
const chats = await client.getChats();
const groups = chats.filter(chat => chat.isGroup);

groups.forEach(group => {
    console.log(group.name, group.id._serialized);
});
```

### Get Group Info

```javascript
const group = await client.getChatById('GROUP_ID@g.us');
console.log('Name:', group.name);
console.log('Description:', group.description);
console.log('Participants:', group.participants.length);
```

### Get Group Participants

```javascript
const group = await client.getChatById('GROUP_ID@g.us');

group.participants.forEach(participant => {
    console.log('ID:', participant.id._serialized);
    console.log('Is Admin:', participant.isAdmin);
    console.log('Is Superadmin:', participant.isSuperAdmin);
});
```

### Send Message to Group

```javascript
await client.sendMessage('GROUP_ID@g.us', 'Hello everyone!');
```

### Create Group

```javascript
const participants = ['5511999999999@c.us', '5511888888888@c.us'];
const group = await client.createGroup('Group Name', participants);
console.log('Group created:', group.gid._serialized);
```

## Contacts

### Get All Contacts

```javascript
const contacts = await client.getContacts();

contacts.forEach(contact => {
    console.log('Name:', contact.name);
    console.log('Number:', contact.number);
    console.log('Is Business:', contact.isBusiness);
});
```

### Get Contact Info

```javascript
const contact = await client.getContactById('5511999999999@c.us');
console.log('Name:', contact.pushname);
console.log('Profile Picture:', await contact.getProfilePicUrl());
```

### Get Contact's About

```javascript
const contact = await client.getContactById('5511999999999@c.us');
const about = await contact.getAbout();
console.log('About:', about);
```

## Chat Management

### Mark as Read

```javascript
const chat = await msg.getChat();
await chat.sendSeen();
```

### Delete Messages

```javascript
await msg.delete(true); // true = delete for everyone
```

### Clear Chat

```javascript
const chat = await client.getChatById(chatId);
await chat.clearMessages();
```

### Archive/Unarchive Chat

```javascript
const chat = await client.getChatById(chatId);
await chat.archive();
await chat.unarchive();
```

## Reactions

```javascript
client.on('message', async (msg) => {
    if (msg.body === '!react') {
        await msg.react('👍');
    }
});
```

## Polls

### Create Poll

```javascript
const poll = {
    question: 'What's your favorite color?',
    options: ['Red', 'Blue', 'Green', 'Yellow'],
    allowMultipleAnswers: false
};

await client.sendMessage(chatId, '', { poll });
```

## Events

### Available Events

```javascript
// Authentication
client.on('authenticated', () => console.log('Authenticated'));
client.on('auth_failure', (msg) => console.error('Auth failure', msg));
client.on('logout', () => console.log('Logged out'));

// Connection
client.on('ready', () => console.log('Ready'));
client.on('disconnected', (reason) => console.log('Disconnected', reason));

// Messages
client.on('message', (msg) => console.log('New message'));
client.on('message_create', (msg) => console.log('Message created'));
client.on('message_revoke_everyone', async (after, before) => {
    console.log('Message deleted for everyone');
});
client.on('message_revoke_me', async (msg) => {
    console.log('Message deleted for me');
});

// Group
client.on('group_join', (notification) => {
    console.log('User joined group');
});
client.on('group_leave', (notification) => {
    console.log('User left group');
});

// State
client.on('change_state', (state) => {
    console.log('State changed:', state);
});
```

## Client Configuration

### Advanced Options

```javascript
const client = new Client({
    authStrategy: new LocalAuth(),
    puppeteer: {
        headless: true,
        args: ['--no-sandbox', '--disable-setuid-sandbox']
    },
    qrMaxRetries: 5,
    restartOnAuthFail: true,
    takeoverOnConflict: false, // Don't take over if already logged in
    takeoverTimeoutMs: 0
});
```

## Common Use Cases

### Auto-Reply Bot

```javascript
client.on('message', async (msg) => {
    const chat = await msg.getChat();

    // Don't reply to groups
    if (chat.isGroup) return;

    const responses = {
        'oi': 'Olá! Como posso ajudar?',
        'ajuda': 'Digite seu nome para começar.',
        'info': 'Este é um bot automático.'
    };

    const response = responses[msg.body.toLowerCase()];
    if (response) {
        await chat.sendStateTyping();
        await new Promise(resolve => setTimeout(resolve, 1000));
        await msg.reply(response);
    }
});
```

### Download Media from Messages

```javascript
client.on('message', async (msg) => {
    if (msg.hasMedia) {
        const media = await msg.downloadMedia();

        const fs = require('fs');
        const filename = `media_${Date.now()}.${media.mimetype.split('/')[1]}`;

        fs.writeFileSync(filename, media.data, 'base64');
        console.log('Media saved:', filename);
    }
});
```

### Send Scheduled Messages

```javascript
const cron = require('node-cron');

// Send message every day at 9 AM
cron.schedule('0 9 * * *', async () => {
    await client.sendMessage(chatId, 'Good morning! Daily reminder.');
});
```

## Error Handling

```javascript
client.on('auth_failure', (msg) => {
    console.error('Authentication failed:', msg);
    // Handle re-authentication
});

client.on('disconnected', (reason) => {
    console.log('Client was disconnected:', reason);
    // Attempt to reconnect
    client.initialize();
});

// Try-catch for async operations
try {
    await client.sendMessage(chatId, 'Hello');
} catch (error) {
    console.error('Failed to send message:', error);
}
```

## Best Practices

1. **Rate Limiting** - Don't send too many messages too quickly
2. **Error Handling** - Always wrap API calls in try-catch
3. **Session Management** - Use LocalAuth for production
4. **Graceful Shutdown** - Properly close client on exit
5. **Message Validation** - Check if chat/contact exists before sending
6. **Media Handling** - Limit file sizes and validate formats
7. **Privacy** - Never log sensitive user data

## Resources

- [Official Website](https://wwebjs.dev)
- [Documentation](https://docs.wwebjs.dev/)
- [GitHub Repository](https://github.com/pedroslopez/whatsapp-web.js)
- [Guide](https://wwebjs.dev/guide/)
