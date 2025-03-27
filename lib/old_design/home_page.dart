/*
import 'package:ava_bavly_scouts/generated/assets.dart';
import 'package:ava_bavly_scouts/model/team.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:ionicons/ionicons.dart';
import 'package:meta_seo/meta_seo.dart';
import 'package:shimmer/shimmer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String route = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Team> teams = [];
  List<int> indexOfTeamsThatHaveStory = [];
  bool loading = false;
  final supabase = Supabase.instance.client;

  Future<String?> getStoryUrl(int id) async {
    try {
      // List all files in the 'stories' bucket/folder
      final response = await supabase.storage.from('stories').list();

      // Check if the response is not null and contains files
      if (response.isNotEmpty) {
        // Find the file that starts with the provided element id
        late final FileObject file;
        for (int i = 0; i < response.length; i++) {
          if(response[i].name.startsWith('$id.')) {
            file = response[i];
            break;
          }
        }
        //print(file.name);

        // If the file is found, generate the public URL
        return supabase.storage.from('stories').getPublicUrl(file.name);
      }

      // Return null if no matching file is found
      return null;
    } catch (e) {
      //print('Error fetching story URL: $e');
      return null;
    }
  }

  bool isVideoUrl(String url) {
    // List of common video extensions
    const videoExtensions = ['.mp4', '.mov', '.avi', '.mkv', '.webm', '.flv', '.wmv'];

    // Extract the file extension from the URL
    String fileExtension = url.substring(url.lastIndexOf('.')).toLowerCase();

    // Check if the file extension matches any in the list of video extensions
    return videoExtensions.contains(fileExtension);
  }

  Future<void> getTeams() async {
    if(!loading) {
      setState(() {
        loading = true;
      });

      teams.clear();
      indexOfTeamsThatHaveStory.clear();

      final data = await supabase
          .from('teams')
          .select();

      teams = teamFromListMap(data);
      teams.sort((a, b) => b.points!.compareTo(a.points!));

      for (int i = 0; i < teams.length; i++) {
        final String avatarURL = supabase
            .storage
            .from('avatars')
            .getPublicUrl('${teams[i].id}.jpg');

        final String? storyURL = await getStoryUrl(teams[i].id??0);
        if (storyURL != null) {
          indexOfTeamsThatHaveStory.add(i);
        }
        teams[i].avatarURL = avatarURL;
        teams[i].storyURL = storyURL;
      }

      setState(() {
        loading = false;
      });
    }
  }

  Future<void> refresh() async {
    if(!loading) {
      setState(() {
        loading = true;
      });

      teams.clear();
      indexOfTeamsThatHaveStory.clear();


      final data = await supabase
          .from('teams')
          .select();

      teams = teamFromListMap(data);
      teams.sort((a, b) => b.points!.compareTo(a.points!));

      for (int i = 0; i < teams.length; i++) {
        final String avatarURL = supabase
            .storage
            .from('avatars')
            .getPublicUrl('${teams[i].id}.jpg');

        final String? storyURL = await getStoryUrl(teams[i].id??0);
        if (storyURL != null) {
          indexOfTeamsThatHaveStory.add(i);
        }
        teams[i].avatarURL = avatarURL;
        teams[i].storyURL = storyURL;
      }

      setState(() {
        loading = false;
      });
    }
  }

  Future<void> listen() async {
    supabase.from('teams')
        .stream(primaryKey: ['id'])
        .listen((List<Map<String, dynamic>> data) async {

      if(!loading) {
        indexOfTeamsThatHaveStory.clear();

        teams = teamFromListMap(data);
        teams.sort((a, b) => b.points!.compareTo(a.points!));

        for (int i = 0; i < teams.length; i++) {
          final String avatarURL = supabase
              .storage
              .from('avatars')
              .getPublicUrl('${teams[i].id}.jpg');

          final String? storyURL = await getStoryUrl(teams[i].id??0);
          if (storyURL != null) {
            indexOfTeamsThatHaveStory.add(i);
          }
          teams[i].avatarURL = avatarURL;
          teams[i].storyURL = storyURL;
        }
      }

      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getTeams();
    listen();
  }

  @override
  Widget build(BuildContext context) {
    if(kIsWeb) {
      // Define MetaSEO object
      MetaSEO meta = MetaSEO();
      // add meta seo data for web app as you want
      meta.author(author: 'Eng Joshua George');
      meta.description(description: 'AVA Bavly Beginners Scouts Site');
      meta.keywords(keywords: 'AVA Bavly Beginners Scouts, Scouts, Beginners Scouts, AVA Bavly, AVA Bavly Scouts');
      meta.ogTitle(ogTitle: 'AVA Bavly Beginners Scouts');
      meta.ogDescription(ogDescription: 'AVA Bavly Beginners Scouts');
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const HugeIcon(
          icon: HugeIcons.strokeRoundedCamera01,
          color: Colors.black,
          size: 28.0,
        ),
        title: Text(
          'Clickgarm',
          style: GoogleFonts.grandHotel(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        actions: const [
          HugeIcon(
            icon: HugeIcons.strokeRoundedTv01,
            color: Colors.black,
            size: 28.0,
          ),
          SizedBox(width: 10,),
          Icon(
            Ionicons.paper_plane_outline,
            size: 28,
          ),
          SizedBox(width: 10,),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: ListView(
          children: [
            if (loading)
              SizedBox(
                height: 120,
                child: ListView.builder(
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[300],
                            ),
                            height: 80,
                            width: 80,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 14,
                            width: 50,
                            color: Colors.grey[300],
                          ),
                        ),
                      ],
                    ),
                  ),
                  itemCount: 6,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            if (!loading)
              SizedBox(
                height: indexOfTeamsThatHaveStory.isNotEmpty? 120 : 0,
                child: ListView.builder(
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/story/${(teams[indexOfTeamsThatHaveStory[index]].name??'').replaceAll(RegExp(r'\W+'), '')}', arguments: {
                          'mediaUrl': teams[indexOfTeamsThatHaveStory[index]].storyURL ?? '',
                          'isVideo': isVideoUrl(teams[indexOfTeamsThatHaveStory[index]].storyURL ?? '')
                        },);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xff405DE6),
                                  Color(0xff5B51D8),
                                  Color(0xff833AB4),
                                  Color(0xffC13584),
                                  Color(0xffE1306C),
                                  Color(0xffFD1D1D),
                                  Color(0xffF56040),
                                  Color(0xfff26932),
                                  Color(0xffFCAF45),
                                  Color(0xffFFDC80),
                                ],
                                end: Alignment.bottomLeft,
                                begin: Alignment.topRight,
                              ),
                            ),
                            height: 80,
                            width: 80,
                            padding: const EdgeInsets.all(3),
                            child: Center(
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                height: 74,
                                width: 74,
                                clipBehavior: Clip.antiAlias,
                                padding: const EdgeInsets.all(3),
                                child: Center(
                                  child: Container(
                                    height: 68,
                                    width: 68,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(teams[indexOfTeamsThatHaveStory[index]].avatarURL ?? ''),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Text(
                            teams[indexOfTeamsThatHaveStory[index]].name ?? '',
                            style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  itemCount: indexOfTeamsThatHaveStory.length,
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            if (loading)
              for (int i = 0; i < 6; i++) ...[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: 44,
                              width: 44,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[300],
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                height: 16,
                                width: 80,
                                color: Colors.grey[300],
                              ),
                            ),
                            const SizedBox(height: 4),
                            Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                height: 14,
                                width: 100,
                                color: Colors.grey[300],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                        color: Colors.grey[300],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: 22,
                              width: 22,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[300],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: 14,
                              width: 100,
                              color: Colors.grey[300],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
            if (!loading)
              for (int i = 0; i < teams.length; i++) ...[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 44,
                            width: 44,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(teams[i].avatarURL ?? ''),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  teams[i].name ?? '',
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                                ),
                                const SizedBox(width: 10),
                                const Image(image: AssetImage(Assets.assetsVerifiedLogo), height: 20, width: 20),
                              ],
                            ),
                            const Text(
                              'ava bavly scouts',
                              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Stack(
                      alignment: const Alignment(1, -1),
                      children: [
                        Image(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width,
                          image: NetworkImage(teams[i].avatarURL ?? ''),
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(Icons.favorite_border_rounded),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Icon(Ionicons.chatbubble_outline),
                                ),
                                Icon(Ionicons.paper_plane_outline),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(Icons.bookmark_border_rounded),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Container(
                            height: 22,
                            width: 22,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  'https://plus.unsplash.com/premium_photo-1663040392316-70559a2e0e92?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3w5NjMyOXwwfDF8c2VhcmNofDJ8fGV5ZXN8ZW58MHx8fHwxNjk1NzI0NzQ4fDA&fbclid=IwAR2DaUoYGUqqjNmxu15m7yZKqwm-BxiWzO5GKgCfA3kYXWxhJKrpt6KhDcs',
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Text(
                          'Clicked by',
                          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14, color: Colors.black),
                        ),
                        const SizedBox(width: 4,),
                        Text(
                          '${teams[i].points} Clicks',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(
              icon: Icon(
                HugeIcons.strokeRoundedHome11,
                size: 30,
                color: Colors.black,
              ),
              label: ''
          ),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.search_rounded,
                size: 30,
                color: Colors.black,
              ),
              label: ''
          ),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.add_rounded,
                size: 30,
                color: Colors.black,
              ),
              label: ''
          ),
          const BottomNavigationBarItem(
              icon: Center(
                child: Icon(
                  Icons.favorite_border_rounded,
                  size: 30,
                  color: Colors.black,
                ),
              ),
              label: ''
          ),
          BottomNavigationBarItem(
            icon: Column(
              children: [
                const Text(
                  'Powered by',
                  style: TextStyle(color: Colors.black, fontSize: 7,fontWeight: FontWeight.bold),
                ),
                Container(
                    width: 36,
                    height: 36,
                    padding: const EdgeInsets.all(7),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black
                    ),
                    child: const Image(image: AssetImage(Assets.assetsComindeLogo),fit: BoxFit.contain,)
                ),
              ],
            ),
            label: '',
          ),
        ],
        onTap: (value) {
          if(value == 4) {
            launchUrl(Uri.parse('https://cominde.onrender.com'));
          }
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        iconSize: 30,
      ),
    );
  }
}*/
