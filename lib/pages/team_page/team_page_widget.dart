import 'package:flutter/foundation.dart';
import 'package:flutterflow_ui_pro/flutterflow_ui_pro.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'team_page_model.dart';
export 'team_page_model.dart';

class TeamPageWidget extends StatefulWidget {
  const TeamPageWidget({super.key, required this.name, required this.rank, required this.total_points, required this.image, required this.nzam_points, required this.ro7y_points, required this.ka4fy_points, required this.skafy_points, required this.games_points, required this.missions_points});

  final String name;
  final int rank;
  final int total_points;
  final String image;
  final int nzam_points;
  final int ro7y_points;
  final int ka4fy_points;
  final int skafy_points;
  final int games_points;
  final int missions_points;

  static String routeName = 'TeamPage';
  static String routePath = '/teamPage';

  @override
  State<TeamPageWidget> createState() => _TeamPageWidgetState();
}

class _TeamPageWidgetState extends State<TeamPageWidget>
    with TickerProviderStateMixin {
  late TeamPageModel _model;

  final supabase = Supabase.instance.client;

  bool loading = false;

  List<dynamic> matches = [];

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  Future<void> getMatches() async {
    try {
      // Query the BusinessPrice table to get the last price
      setState(() {
        loading = true;
      });
      final MatchesResponse = await supabase
          .from('Matches')
          .select('*')
          .or('player_one.eq.${widget.name},player_two.eq.${widget.name}')
          .order('created_at', ascending: false);

      matches = MatchesResponse;

      setState(() {
        loading = false;
      });
    } catch (e) {
      // Handle any exceptions
      if (kDebugMode) {
        print('Exception occurred: $e');
      }

      matches = [];

      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TeamPageModel());

    getMatches();

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: Offset(0.0, 100.0),
            end: Offset(0.0, 0.0),
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
        backgroundColor: Color(0xFF101213),
        appBar: AppBar(
          backgroundColor: Color(0xFF101213),
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: Align(
          alignment: AlignmentDirectional(0, 0),
          child: Skeletonizer(
            enabled: loading,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                            child: Text(
                              widget.rank.toString(),
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Colors.white,
                                fontSize: 22,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            'مركز',
                            textAlign: TextAlign.center,
                            style:
                            FlutterFlowTheme.of(context).labelMedium.override(
                              fontFamily: 'Plus Jakarta Sans',
                              color: Color(0xCCFFFFFF),
                              fontSize: 14,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF4B39EF), Color(0xFFEE8B60)],
                            stops: [0, 1],
                            begin: AlignmentDirectional(1, -1),
                            end: AlignmentDirectional(-1, 1),
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: EdgeInsets.all(4),
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Color(0xFF101213),
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(4),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    widget.image,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                            child: Text(
                              widget.total_points.toString(),
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Colors.white,
                                fontSize: 22,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            'الاجمالي',
                            textAlign: TextAlign.center,
                            style:
                            FlutterFlowTheme.of(context).labelMedium.override(
                              fontFamily: 'Plus Jakarta Sans',
                              color: Color(0xCCFFFFFF),
                              fontSize: 14,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                              child: Text(
                                widget.nzam_points.toString(),
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Colors.white,
                                  fontSize: 22,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              'نظام',
                              textAlign: TextAlign.center,
                              style:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color(0xCCFFFFFF),
                                fontSize: 14,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                              child: Text(
                                widget.ka4fy_points.toString(),
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Colors.white,
                                  fontSize: 22,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              'كشفي',
                              textAlign: TextAlign.center,
                              style:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color(0xCCFFFFFF),
                                fontSize: 14,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                              child: Text(
                                widget.ro7y_points.toString(),
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Colors.white,
                                  fontSize: 22,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              'روحي',
                              textAlign: TextAlign.center,
                              style:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color(0xCCFFFFFF),
                                fontSize: 14,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                              child: Text(
                                widget.skafy_points.toString(),
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Colors.white,
                                  fontSize: 22,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              'ثقافي',
                              textAlign: TextAlign.center,
                              style:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color(0xCCFFFFFF),
                                fontSize: 14,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                              child: Text(
                                widget.missions_points.toString(),
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Colors.white,
                                  fontSize: 22,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              'مهام',
                              textAlign: TextAlign.center,
                              style:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color(0xCCFFFFFF),
                                fontSize: 14,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                              child: Text(
                                widget.games_points.toString(),
                                textAlign: TextAlign.center,
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Colors.white,
                                  fontSize: 22,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              'العاب',
                              textAlign: TextAlign.center,
                              style:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Color(0xCCFFFFFF),
                                fontSize: 14,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                  child: Text(
                    widget.name,
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Colors.white,
                      fontSize: 22,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsetsDirectional.fromSTEB(0, 44, 0, 0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3,
                          color: Color(0x33000000),
                          offset: Offset(
                            0,
                            -1,
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'مباريات',
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                              fontFamily: 'Plus Jakarta Sans',
                              color: Color(0xFF101213),
                              fontSize: 24,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: ListView(
                                children: [
                                  if (matches.isNotEmpty) SizedBox(
                                    height: 62.0 * matches.length,
                                    child: FlutterFlowDataTable<dynamic>(
                                      controller:
                                      _model.paginatedDataTableController,
                                      data: matches,numRows: matches.length,
                                      columnsBuilder: (onSortChanged) => [
                                        DataColumn2(
                                          label: DefaultTextStyle.merge(
                                            softWrap: true,
                                            child: Container(),
                                          ),
                                        ),
                                      ],
                                      dataRowBuilder: (Item,
                                          paginatedDataTableIndex,
                                          selected,
                                          onSelectChanged) =>
                                          DataRow(
                                            color: MaterialStateProperty.all(
                                              paginatedDataTableIndex % 2 == 0
                                                  ? FlutterFlowTheme.of(context)
                                                  .primaryBackground
                                                  : FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                            ),
                                            cells: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      '${Item['player_one']}\n (${Item['sub_team']})',
                                                      textAlign: TextAlign.center,
                                                      style: FlutterFlowTheme.of(
                                                          context)
                                                          .bodyMedium
                                                          .override(
                                                        fontFamily: 'Inter',
                                                        fontSize: 12,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                        FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Padding(
                                                      padding: EdgeInsetsDirectional
                                                          .fromSTEB(0, 6, 0, 6),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .secondaryBackground,
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize:
                                                          MainAxisSize.max,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            Expanded(
                                                              child: Column(
                                                                mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
                                                                children: [
                                                                  Text(
                                                                    Item['game_name'],
                                                                    style: FlutterFlowTheme.of(
                                                                        context)
                                                                        .bodyMedium
                                                                        .override(
                                                                      fontFamily:
                                                                      'Inter',
                                                                      fontSize:
                                                                      10,
                                                                      letterSpacing:
                                                                      0.0,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                          context)
                                                                          .secondaryBackground,
                                                                    ),
                                                                    child: Text(
                                                                      '${Item['player_one_score']} - ${Item['player_two_score']}',
                                                                      style: FlutterFlowTheme.of(
                                                                          context)
                                                                          .bodyMedium
                                                                          .override(
                                                                        fontFamily:
                                                                        'Inter',
                                                                        fontSize:
                                                                        12,
                                                                        letterSpacing:
                                                                        0.0,
                                                                        fontWeight:
                                                                        FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 18,
                                                              decoration:
                                                              BoxDecoration(
                                                                color: Item['player_one_score'] == Item['player_two_score'] ? FlutterFlowTheme
                                                                    .of(context)
                                                                    .warning : (
                                                                    (Item['player_one_score'] > Item['player_two_score'] && Item['player_one'] == widget.name) ||
                                                                        (Item['player_one_score'] < Item['player_two_score'] && Item['player_two'] == widget.name) ? FlutterFlowTheme
                                                                        .of(context)
                                                                        .success : FlutterFlowTheme
                                                                        .of(context)
                                                                        .error
                                                                ),
                                                                borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                                  bottomLeft: Radius
                                                                      .circular(0),
                                                                  bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                      6),
                                                                  topLeft: Radius
                                                                      .circular(0),
                                                                  topRight: Radius
                                                                      .circular(6),
                                                                ),
                                                              ),
                                                              child: Column(
                                                                mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                                children: [
                                                                  Text(
                                                                    Item['player_one_score'] == Item['player_two_score'] ? '+' : (
                                                                        (Item['player_one_score'] > Item['player_two_score'] && Item['player_one'] == widget.name) ||
                                                                            (Item['player_one_score'] < Item['player_two_score'] && Item['player_two'] == widget.name) ? '+' : ''
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                        context)
                                                                        .bodyMedium
                                                                        .override(
                                                                      fontFamily:
                                                                      'Inter',
                                                                      color: Colors
                                                                          .white,
                                                                      letterSpacing:
                                                                      0.0,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    Item['player_one_score'] == Item['player_two_score'] ? Item['points'].toString() : (
                                                                        (Item['player_one_score'] > Item['player_two_score'] && Item['player_one'] == widget.name) ||
                                                                            (Item['player_one_score'] < Item['player_two_score'] && Item['player_two'] == widget.name) ? Item['points'].toString() : '0'
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                        context)
                                                                        .bodyMedium
                                                                        .override(
                                                                      fontFamily:
                                                                      'Inter',
                                                                      color: Colors
                                                                          .white,
                                                                      letterSpacing:
                                                                      0.0,
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Text(
                                                      '${Item['player_two']}\n (${Item['sub_team']})',
                                                      textAlign: TextAlign.center,
                                                      style: FlutterFlowTheme.of(
                                                          context)
                                                          .bodyMedium
                                                          .override(
                                                        fontFamily: 'Inter',
                                                        fontSize: 12,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                        FontWeight.w500,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ].map((c) => DataCell(c)).toList(),
                                          ),
                                      paginated: false,
                                      selectable: false,
                                      headingRowHeight: 0,
                                      dataRowHeight: 62,
                                      columnSpacing: 8,
                                      borderRadius: BorderRadius.circular(8),
                                      addHorizontalDivider: true,
                                      addTopAndBottomDivider: false,
                                      hideDefaultHorizontalDivider: true,
                                      horizontalDividerColor:
                                      FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      horizontalDividerThickness: 1,
                                      addVerticalDivider: false,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animateOnPageLoad(
                      animationsMap['containerOnPageLoadAnimation']!),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
