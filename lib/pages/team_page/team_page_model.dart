import 'package:flutterflow_ui_pro/flutterflow_ui_pro.dart';
import 'team_page_widget.dart' show TeamPageWidget;
import 'package:flutter/material.dart';

class TeamPageModel extends FlutterFlowModel<TeamPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for PaginatedDataTable widget.
  final paginatedDataTableController =
  FlutterFlowDataTableController<dynamic>();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    paginatedDataTableController.dispose();
  }
}
