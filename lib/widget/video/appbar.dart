import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_base/view_util.dart';

//视频appbar
videoAppBar(){
  return Container(
    padding: EdgeInsets.only(right: 8.r),
    decoration: BoxDecoration(gradient: blackLinearGradient(fromTop: true)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BackButton(
          color: Colors.white,
        ),
        Row(
          children: [
            Icon(Icons.live_tv_rounded,size: 20.sp,color: Colors.white,),
            Padding(padding: EdgeInsets.only(left: 12.r),child:
              Icon(Icons.more_vert_rounded,size: 20.sp,color: Colors.white,),),
          ],
        )
      ],
    ),
  );
}