import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../services/todo_service.dart';
import '../l10n/app_localizations.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _showAddTodoDialog() {
    _titleController.clear();
    _descriptionController.clear();
    _showTodoDialog();
  }

  void _showEditTodoDialog(TodoItem todo) {
    _titleController.text = todo.title;
    _descriptionController.text = todo.description;
    _showTodoDialog(todo: todo);
  }

  void _showTodoDialog({TodoItem? todo}) {
    final isEditing = todo != null;
    final loc = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          isEditing ? loc.todoEdit : loc.todoAdd,
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: loc.todoTitleLabel,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return loc.todoTitleRequired;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: loc.todoDescriptionLabel,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(loc.todoCancel),
          ),
          ElevatedButton(
            onPressed: () {
              final form = _formKey.currentState;
              if (form != null && form.validate()) {
                final todoService = context.read<TodoService>();
                if (isEditing) {
                  final currentTodo = todo!;
                  todoService.updateTodo(
                    currentTodo.id,
                    _titleController.text,
                    _descriptionController.text,
                  );
                } else {
                  todoService.addTodo(
                    _titleController.text,
                    _descriptionController.text,
                  );
                }
                Navigator.pop(context);
              }
            },
            child: Text(isEditing ? loc.todoSave : loc.todoAdd),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(TodoItem todo) {
    final loc = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(loc.todoDeleteTitle),
        content: Text(loc.todoDeleteMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(loc.todoCancel),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<TodoService>().deleteTodo(todo.id);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: Text(loc.delete),
          ),
        ],
      ),
    );
  }

  void _showClearCompletedDialog() {
    final loc = AppLocalizations.of(context)!;
    final todoService = context.read<TodoService>();

    if (todoService.completedCount == 0) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(loc.todoClearCompletedTitle),
        content: Text(
          loc.todoClearCompletedMessage(todoService.completedCount),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(loc.todoCancel),
          ),
          ElevatedButton(
            onPressed: () {
              todoService.clearCompletedTodos();
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: Text(loc.clear),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Заголовок
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFF8E53), Color(0xFFFF6B6B)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.checklist,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc.todoTitle,
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color:
                                theme.textTheme.bodyLarge?.color ??
                                Colors.black87,
                          ),
                        ),
                        Consumer<TodoService>(
                          builder: (context, todoService, child) {
                            return Text(
                              loc.todoCompleted(
                                todoService.completedCount,
                                todoService.totalCount,
                              ),
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color:
                                    theme.textTheme.bodyMedium?.color ??
                                    Colors.grey[600],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Consumer<TodoService>(
                    builder: (context, todoService, child) {
                      if (todoService.completedCount > 0) {
                        return IconButton(
                          onPressed: _showClearCompletedDialog,
                          icon: Icon(
                            Icons.clear_all,
                            color: theme.colorScheme.primary,
                          ),
                          tooltip: loc.todoClearCompleted,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),

            // Список задач
            Expanded(
              child: Consumer<TodoService>(
                builder: (context, todoService, child) {
                  if (todoService.todos.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.task_alt,
                            size: 80,
                            color: theme.textTheme.bodyMedium?.color
                                ?.withOpacity(0.5),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            loc.todoEmpty,
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: theme.textTheme.bodyLarge?.color,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            loc.todoEmptyAdd,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: theme.textTheme.bodyMedium?.color,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: todoService.todos.length,
                    itemBuilder: (context, index) {
                      final todo = todoService.todos[index];
                      return _buildTodoItem(todo);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTodoDialog,
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTodoItem(TodoItem todo) {
    final theme = Theme.of(context);

    return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: GestureDetector(
              onTap: () => context.read<TodoService>().toggleTodo(todo.id),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: todo.isCompleted
                      ? theme.colorScheme.primary
                      : Colors.transparent,
                  border: Border.all(
                    color: todo.isCompleted
                        ? theme.colorScheme.primary
                        : theme.dividerColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: todo.isCompleted
                    ? Icon(
                        Icons.check,
                        size: 16,
                        color: theme.colorScheme.onPrimary,
                      )
                    : null,
              ),
            ),
            title: Text(
              todo.title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: todo.isCompleted
                    ? theme.textTheme.bodyLarge?.color?.withOpacity(0.6)
                    : theme.textTheme.bodyLarge?.color,
                decoration: todo.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (todo.description.isNotEmpty)
                  Text(
                    todo.description,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: theme.textTheme.bodyMedium?.color,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                const SizedBox(height: 4),
                Text(
                  _formatDate(todo.createdAt),
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                  ),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () => _showEditTodoDialog(todo),
                  icon: Icon(
                    Icons.edit_outlined,
                    color: theme.colorScheme.primary,
                  ),
                  tooltip: 'Редактировать',
                ),
                IconButton(
                  onPressed: () => _showDeleteConfirmation(todo),
                  icon: Icon(
                    Icons.delete_outline,
                    color: theme.colorScheme.error,
                  ),
                  tooltip: 'Удалить',
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideX(begin: 0.3, duration: 400.ms, curve: Curves.easeOutCubic);
  }

  String _formatDate(DateTime date) {
    final loc = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return loc.todoTimeMinutesAgo(difference.inMinutes);
      }
      return loc.todoTimeHoursAgo(difference.inHours);
    } else if (difference.inDays == 1) {
      return loc.todoTimeYesterday;
    } else if (difference.inDays < 7) {
      return loc.todoTimeDaysAgo(difference.inDays);
    } else {
      return '${date.day}.${date.month}.${date.year}';
    }
  }
}
