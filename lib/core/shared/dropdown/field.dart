import '../shared.dart';

class DropdownWidget<T> extends StatelessWidget {
  final Widget? popup;
  final Function(T)? onSelect;
  final String label;
  final String text;
  final bool showIcon;
  final TextStyle? labelStyle;
  final TextStyle? textStyle;
  final EdgeInsets? padding;

  const DropdownWidget({
    super.key,
    this.popup,
    this.onSelect,
    this.showIcon = true,
    required this.label,
    required this.text,
    this.labelStyle,
    this.textStyle,
    this.padding,
  }) : assert(onSelect != null ? popup != null : popup == null);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        final labelWidget = Text(
          label,
          style: labelStyle ??
              TextStyles.subTitle(context: context, color: theme.textSecondary),
        );
        final textWidget = Text(
          text,
          style: textStyle ??
              TextStyles.title(
                context: context,
                color:
                    onSelect != null ? theme.textPrimary : theme.textSecondary,
              ),
          maxLines: 2,
          textAlign: TextAlign.end,
        );
        return InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onSelect != null && popup != null
              ? () async {
                  final selection = await showModalBottomSheet<T?>(
                    context: context,
                    isScrollControlled: true,
                    barrierColor: context.barrierColor,
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * .85,
                    ),
                    builder: (_) => popup!,
                  );

                  if (selection != null) {
                    onSelect!(selection);
                  }
                }
              : null,
          child: Padding(
            padding: padding ?? const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                labelWidget,
                const SizedBox(width: 12),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: textWidget,
                      ),
                      if (showIcon)
                        Icon(Icons.arrow_drop_down_rounded,
                            size: 20, color: theme.textPrimary),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
