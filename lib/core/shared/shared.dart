library shared;

//! ----------------- Native -----------------
export 'enums.dart';
export 'text_styles.dart';
export 'theme/scheme.dart';
export 'theme/theme_bloc.dart';
export 'error/failure/failure.dart';
export 'extension/authentication.dart';
export 'extension/token.dart';
export 'extension/name.dart';
export 'extension/context.dart';
export 'extension/date_time.dart';
export 'extension/int.dart';
export 'extension/string.dart';
export 'extension/theme.dart';
export 'remote/network_info.dart';
export 'remote/endpoints.dart';
export 'remote/response.dart';
export 'resources/address.dart';
export 'resources/links.dart';
export 'resources/name.dart';
export 'resources/activity.dart';
export 'resources/contact.dart';
export 'resources/identity.dart';
export 'resources/kemon_identity.dart';
export 'resources/lat_lng.dart';
export 'router.dart';
export 'shimmer/icon.dart';
export 'shimmer/label.dart';
export 'loading_indicator.dart';
export 'task_notifier.dart';

//! ----------------- Core -----------------
export 'dart:async';
export 'dart:convert';
export 'dart:io';
export 'dart:math' hide log;
export 'dart:developer' hide Flow;

//! ----------------- 3rd party -----------------
export 'package:cached_network_image/cached_network_image.dart';
export 'package:collection/collection.dart';
export 'package:either_dart/either.dart';
export 'package:equatable/equatable.dart';
export 'package:flutter/cupertino.dart' hide RefreshCallback;
export 'package:flutter/foundation.dart' hide binarySearch, mergeSort;
export 'package:flutter/material.dart' hide ThemeExtension;
export 'package:flutter/services.dart';
export 'package:flutter_animate/flutter_animate.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
export 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
export 'package:flutter_native_splash/flutter_native_splash.dart';
export 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
export 'package:get_it/get_it.dart';
export 'package:go_router/go_router.dart';
export 'package:google_fonts/google_fonts.dart';
export 'package:html/parser.dart';
export 'package:http/http.dart';
export 'package:hydrated_bloc/hydrated_bloc.dart';
export 'package:in_app_update/in_app_update.dart';
export 'package:internet_connection_checker/internet_connection_checker.dart';
export 'package:intl/intl.dart' hide TextDirection;
export 'package:path_provider/path_provider.dart';
export 'package:url_launcher/url_launcher_string.dart';
export 'package:package_info_plus/package_info_plus.dart';
export 'package:image_picker/image_picker.dart';
export 'package:url_launcher/url_launcher.dart';
export 'package:maps_launcher/maps_launcher.dart';
