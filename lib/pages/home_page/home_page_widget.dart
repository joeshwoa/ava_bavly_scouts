import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:ava_bavly_scouts/generated/assets.dart';
import 'package:ava_bavly_scouts/pages/team_page/team_page_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterflow_ui_pro/flutterflow_ui_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart' as animate;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:data_table_2/data_table_2.dart';

import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  static String routeName = 'HomePage';
  static String routePath = '/homePage';

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
    with TickerProviderStateMixin {
  late HomePageModel _model;

  final supabase = Supabase.instance.client;

  bool loading = false;

  String title = '';

  String pointsImageURL = '';

  List<dynamic> teams = [];

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  Future<void> getTeams() async {
    try {
      // Query the BusinessPrice table to get the last price
      setState(() {
        loading = true;
      });
      final titleResponse = await supabase
          .from('Title')
          .select('title');

      title = titleResponse[0]['title'];

      final pUnitResponse = await supabase
          .from('PUnit')
          .select('points_image_url');

      pointsImageURL = pUnitResponse[0]['points_image_url'];

      final teamsResponse = await supabase
          .from('Teams')
          .select('*')
          .order('total_points', ascending: false);

      teams = teamsResponse;

      await getVersion();

      setState(() {
        loading = false;
      });
    } catch (e) {
      // Handle any exceptions
      if (kDebugMode) {
        print('Exception occurred: $e');
      }

      teams = [];

      setState(() {
        loading = false;
      });
    }
  }

  Future<void> getVersion() async {
    try {
      final versionResponse = await supabase
          .from('Version')
          .select('version');

      if(versionResponse[0]['version'] != '1.0.0') {
        if(mounted) {
          showOkAlertDialog(context: context,
              message: 'New Version Available Please Update The App'
          );
        }
      }
    } catch (e) {
      // Handle any exceptions
      if (kDebugMode) {
        print('Exception occurred: $e');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    getTeams();

    animationsMap.addAll({
      'paginatedDataTableOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          animate.ShimmerEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 800.0.ms,
            color: const Color(0x80FFFFFF),
            angle: 0.524,
          ),
        ],
      ),
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: const Color(0xFF101213),
          automaticallyImplyLeading: false,
          title: Text(
            title,
            maxLines: 3,
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              fontFamily: 'Inter Tight',
              color: Colors.white,
              fontSize: 22,
              letterSpacing: 0.0,
            ),
          ),
          actions: const [],
          centerTitle: true,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Skeletonizer(
            enabled: loading,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (teams.isNotEmpty) Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 12, 8, 12),
                    child: FlutterFlowDataTable<dynamic>(
                      controller: _model.paginatedDataTableController,
                      data: teams,
                      columnsBuilder: (onSortChanged) => [
                        DataColumn2(
                          size: ColumnSize.S,
                          label: DefaultTextStyle.merge(
                            softWrap: true,
                            child: Text(
                              'Rank',
                              style: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .override(
                                fontFamily: 'Inter',
                                color: Colors.white,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        DataColumn2(
                          size: ColumnSize.L,
                          label: DefaultTextStyle.merge(
                            softWrap: true,
                            child: Text(
                              'Teams',
                              style: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .override(
                                fontFamily: 'Inter',
                                color: Colors.white,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        DataColumn2(
                          size: ColumnSize.M,
                          label: DefaultTextStyle.merge(
                            softWrap: true,
                            child: Text(
                              'Points',
                              style: FlutterFlowTheme.of(context)
                                  .labelLarge
                                  .override(
                                fontFamily: 'Inter',
                                color: Colors.white,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                      dataRowBuilder: (Item, paginatedDataTableIndex, selected,
                          onSelectChanged) {
                        return DataRow(
                            color: MaterialStateProperty.all(
                              paginatedDataTableIndex % 2 == 0
                                  ? FlutterFlowTheme.of(context).secondaryBackground
                                  : FlutterFlowTheme.of(context).primaryBackground,
                            ),
                            cells: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if(paginatedDataTableIndex == 0 && Item['total_points'] != 0)Padding(
                                    padding:
                                    const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                                    child: FaIcon(
                                      FontAwesomeIcons.trophy,
                                      color: FlutterFlowTheme.of(context).warning,
                                      size: 24,
                                    ),
                                  ),
                                  Text(
                                    (paginatedDataTableIndex+1).toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, TeamPageWidget.routePath, arguments: {
                                    'name': Item['name'],
                                    'total_points': Item['total_points'],
                                    'rank': paginatedDataTableIndex+1,
                                    'image': Item['image'],
                                    'nzam_points': Item['nzam_points'],
                                    'ro7y_points': Item['ro7y_points'],
                                    'ka4fy_points': Item['ka4fy_points'],
                                    'skafy_points': Item['skafy_points'],
                                    'games_points': Item['games_points'],
                                    'missions_points': Item['missions_points'],
                                  });
                                },
                                child: AutoSizeText(
                                  Item['name'],
                                  style:
                                  FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    Item['total_points'].toString(),
                                    style:
                                    FlutterFlowTheme.of(context).bodyMedium.override(
                                      fontFamily: 'Inter',
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                                    child: Image.network(
                                      pointsImageURL,
                                      width: 24,
                                      height: 24,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ].map((c) => DataCell(c)).toList(),
                          );
                      },
                      paginated: false,
                      selectable: false,
                      headingRowHeight: 56,
                      dataRowHeight: 48,
                      columnSpacing: 20,
                      headingRowColor: const Color(0xFF0A0035),
                      borderRadius: BorderRadius.circular(8),
                      addHorizontalDivider: true,
                      addTopAndBottomDivider: false,
                      hideDefaultHorizontalDivider: false,
                      horizontalDividerColor:
                      FlutterFlowTheme.of(context).secondaryBackground,
                      horizontalDividerThickness: 1,
                      addVerticalDivider: false,
                    ).animateOnPageLoad(
                        animationsMap['paginatedDataTableOnPageLoadAnimation']!),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: const Color(0xFF101213),
          padding: const EdgeInsets.all(6),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                child: Text(
                  'Powered by',
                  maxLines: 1,
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Inter Tight',
                    color: Colors.white,
                    fontSize: 22,
                    letterSpacing: 0.0,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  launchUrl(Uri.parse('https://cominde.onrender.com'));
                },
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    Assets.assetsComindeLogo,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
