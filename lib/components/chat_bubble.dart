import "package:chat_app/services/chat/chart_service.dart";
import "package:chat_app/themes/theme_provider.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final String messageId;
  final String userId;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser,
    required this.messageId,
    required this.userId,
  });

  // Show options
  void _showOptions(BuildContext context, String messageId, String userId) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
              child: Wrap(
            children: [
              // Report message
              ListTile(
                leading: const Icon(Icons.report),
                title: const Text("Report"),
                onTap: () {
                  Navigator.pop(context);
                  _reportMessage(context, messageId, userId);
                },
              ),

              // Block user
              ListTile(
                leading: const Icon(Icons.block),
                title: const Text("Block user"),
                onTap: () {
                  Navigator.pop(context);
                  _blockUser(context, userId);
                },
              ),

              // Cancel
              ListTile(
                leading: const Icon(Icons.cancel),
                title: const Text("Cancel"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ));
        });
  }

  // Report message
  void _reportMessage(BuildContext context, String messageId, String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Report message"),
        content: const Text("Are you sure you want to report this message?"),
        actions: [
          // Cancel button
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),

          // Report button
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ChatService().reportUser(messageId, userId);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Message reported")));
            },
            child: const Text("Report"),
          ),
        ],
      ),
    );
  }

  // Block user
  void _blockUser(BuildContext context, String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Block user"),
        content: const Text("Are you sure you want to block this user?"),
        actions: [
          // Cancel button
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),

          // Report button
          TextButton(
            onPressed: () {
              ChatService().blockUser(userId);

              // Close the dialog
              Navigator.pop(context);

              // Close the chat
              Navigator.pop(context);

              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("User blocked")));
            },
            child: const Text("Block"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    return GestureDetector(
      onLongPress: () {
        if (!isCurrentUser) {
          _showOptions(context, messageId, userId);
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: isCurrentUser
                ? (isDarkMode ? Colors.green.shade600 : Colors.green.shade500)
                : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
            borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        child: Text(
          message,
          style: TextStyle(
            color: isCurrentUser
                ? Colors.white
                : (isDarkMode ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}
