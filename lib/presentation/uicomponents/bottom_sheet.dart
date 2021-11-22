import 'dart:async';

import 'package:container_locations/core/values/colors.dart' as colors;
import 'package:container_locations/presentation/uicomponents/button.dart';
import 'package:flutter/material.dart';

Future<void> showCustomBottomSheet({
  required BuildContext context,
  required GlobalKey<ScaffoldState> scaffoldKey,
  required Widget content,
  bool? isError = false,
  bool? closeOnDrag = true,
  bool? autoDismiss = false,
  CustomButton? primaryButton,
  CustomButton? secondaryButton,
}) async {
  late PersistentBottomSheetController _controller;
  dismiss() {
    _controller.close();
  }

  _controller = scaffoldKey.currentState!.showBottomSheet(
      (context) => WillPopScope(
            onWillPop: () async => false,
            child: GestureDetector(
              onVerticalDragStart: (_) {
                if (closeOnDrag ?? true) {
                  dismiss();
                }
              },
              child: BottomSheetWidget(
                content: content,
                isError: isError,
                primaryButton: primaryButton,
                secondaryButton: secondaryButton,
              ),
            ),
          ),
      backgroundColor: Colors.transparent) /*.closed.then((value) => null)*/;

  if (autoDismiss ?? false) {
    Timer(const Duration(seconds: 3), dismiss);
  }
}

class BottomSheetWidget extends StatelessWidget {
  final Widget content;
  final bool? isError;
  final CustomButton? primaryButton;
  final CustomButton? secondaryButton;

  const BottomSheetWidget(
      {Key? key,
      required this.content,
      this.isError,
      this.primaryButton,
      this.secondaryButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 26, left: 12, right: 12),
          child: Container(
            decoration: BoxDecoration(
                color: colors.lightColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(color: colors.shadowColor, blurRadius: 10)
                ]),
            child: Row(
              children: [
                Visibility(
                    visible: isError ?? false,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Icon(
                        Icons.error,
                        color: colors.errorColor,
                      ),
                    )),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: content,
                      ),
                      Visibility(
                        visible: !(isError ?? false),
                        child: Row(
                          children: [
                            Visibility(
                              visible: secondaryButton != null,
                              child: Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child:
                                    ButtonWidget(customButton: secondaryButton),
                              )),
                            ),
                            Visibility(
                              visible: primaryButton != null,
                              child: Expanded(
                                  child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child:
                                    ButtonWidget(customButton: primaryButton),
                              )),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
