import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rm_characters_test_task/models/character.dart';
import 'package:rm_characters_test_task/providers.dart';


class CharacterCardItem extends ConsumerStatefulWidget {
  final Character character;

  const CharacterCardItem({super.key, required this.character});

  @override
  ConsumerState<CharacterCardItem> createState() => _CharacterCardItemState();
}

class _CharacterCardItemState extends ConsumerState<CharacterCardItem> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onFavoritePressed(bool currentState) async {
    await _animationController.forward();
    await _animationController.reverse();

    ref.read(favoritesProvider.notifier).toggleFavorite(
      widget.character.id,
      !currentState,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isFavoriteAsync = ref.watch(isCharacterFavoriteProvider(widget.character.id));

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            widget.character.image,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, size: 60),
          ),
        ),
        title: Text(
          widget.character.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${widget.character.status} - ${widget.character.species}'),
            Text(
              widget.character.location.name,
              style: const TextStyle(fontWeight: FontWeight.w500),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        trailing: isFavoriteAsync.when(
          data: (isFavorite) => ScaleTransition(
            scale: _scaleAnimation,
            child: IconButton(
              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: Icon(
                  isFavorite ? Icons.star_rounded : Icons.star_border_rounded,
                  key: ValueKey(isFavorite),
                  color: isFavorite ? Colors.amber : Colors.white,
                  size: 30,
                ),
              ),
              onPressed: () => _onFavoritePressed(isFavorite),
            ),
          ),
          loading: () => const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          error: (_, __) => const Icon(Icons.error),
        ),
      ),
    );
  }
}