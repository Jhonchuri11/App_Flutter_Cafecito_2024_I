import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final Widget? child;
  final Color? backgroundColor;
  final double? ml, mr, mt, mb, pl, pr, pt, pb, ma, pa, mh, mv, ph, pv;

  CardWidget({
    this.child,
    this.ml,
    this.mr,
    this.mb,
    this.mt,
    this.pb,
    this.pt,
    this.pr,
    this.pl,
    this.ma,
    this.pa,
    this.mh,
    this.mv,
    this.ph,
    this.pv,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    double finalMl = ml ?? mh ?? ma ?? 15.0;
    double finalMr = mr ?? mh ?? ma ?? 15.0;
    double finalMt = mt ?? mv ?? ma ?? 15.0;
    double finalMb = mb ?? mv ?? ma ?? 15.0;
    double finalPl = pl ?? ph ?? pa ?? 15.0;
    double finalPr = pr ?? ph ?? pa ?? 15.0;
    double finalPt = pt ?? pv ?? pa ?? 15.0;
    double finalPb = pb ?? pv ?? pa ?? 15.0;

    return Stack(
      children: [
        Positioned(
          left: 20,
          right: 10,
          bottom: 10,
          top: 20,
          child: Container(
            decoration: BoxDecoration(
              color:
                  backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).cardColor,
            border: Border.all(color: Colors.black),
          ),
          margin: EdgeInsets.only(
              left: finalMl, right: finalMr, top: finalMt, bottom: finalMb),
          padding: EdgeInsets.only(
              left: finalPl, right: finalPr, top: finalPt, bottom: finalPb),
          child: child,
        ),
      ],
    );
  }
}
