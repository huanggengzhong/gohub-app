import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hi_barrage/hi_barrage.dart';
import 'package:hi_base/color.dart';
import 'package:hi_video/video_view.dart';
import 'package:gohub/widget/common/navigation_bar.dart';
import 'package:gohub/widget/video/appbar.dart';
import 'package:provider/provider.dart';
import 'package:gohub/provider/theme_provider.dart';
import 'package:gohub/utils/constants.dart';
import 'package:gohub/utils/view.dart';
import 'package:flutter_overlay/flutter_overlay.dart';
import 'package:gohub/widget/video/barrage_input.dart';
import 'package:gohub/widget/video/barrage_switch.dart';
class VideoPage extends StatefulWidget {
  const VideoPage({Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> with TickerProviderStateMixin {
  String url = "https://frontend-1251027788.cos.ap-guangzhou.myqcloud.com/fuli/movie.mp4";
  String cover = "https://o.devio.org/images/fa/woman-3083379__340.webp";
  String vid="BV1WV411y7F8";
  var _barrageKey = GlobalKey<HiBarrageState>();
  late ThemeProvider _themeProvider;
  List tabs = ["简介", "评论288"];
  late TabController _controller;
  bool _inoutShowing = false;

  @override
  void initState() {
    super.initState();
    _themeProvider = context.read<ThemeProvider>();
    //黑色状态栏，仅Android
    changeStatusBar(
        color: Colors.black, statusStyle: StatusStyle.LIGHT_CONTENT);
    _controller = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: MediaQuery.removePadding(
            removeTop: Platform.isIOS,
            context: context,
            child: url != null ? Column(
          children: [
            //IOS黑色状态栏
            NavigationBarPlus(
              color: Colors.black,
              statusStyle: StatusStyle.LIGHT_CONTENT,
              height: Platform.isAndroid?0:46,
            ),
            _buildVideoView(),
            _buildTabNavigation(),
          ],
        ) : Container()));
  }
  //视频组件
  _buildVideoView(){
    return VideoView(
        url,
        cover: cover,
        overlayUI: videoAppBar(),
        barrageUI:HiBarrage(vid: vid, headers: HiConstants.headers(),autoPlay: true,key: _barrageKey,)
    );
  }
  //发送弹幕
  _buildTabNavigation(){
    return Material(
      elevation: 5,
      shadowColor: _themeProvider.isDark()?HiColor.dark_bg:Colors.grey[100],
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20.r),
        height: 30.h,
        color: _themeProvider.isDark()?HiColor.dark_bg:Colors.white,
        child: Row(
          children: [
            _buildBarrageBtn()
          ],
        ),
      ),
    );
  }
  //创建弹幕
  _buildBarrageBtn(){
    return BarrageSwitch(
        inoutShowing: _inoutShowing,
        onShowInput: () {
          setState(() {
            _inoutShowing = true;
          });
          HiOverlay.show(context, child: BarrageInput(
            onTabClose: () {
              setState(() {
                _inoutShowing = false;
              });
            },
          )).then((value) {
            print('---input:$value');
            _barrageKey.currentState!.send(value);
          });
        },
        onBarrageSwitch: (open) {
          if (open) {
            _barrageKey.currentState!.play();
          } else {
            _barrageKey.currentState!.pause();
          }
        });
  }
}
