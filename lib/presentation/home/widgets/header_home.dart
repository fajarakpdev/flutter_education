import 'package:app_fic10/core/extensions/build_context_ext.dart';
import 'package:app_fic10/data/datasources/auth_local_datasource.dart';
import 'package:app_fic10/data/models/response/auth_response_model.dart';
import 'package:flutter/material.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/search_input.dart';
import '../../../core/constants/colors.dart';

class HeaderHome extends StatefulWidget {
  const HeaderHome({super.key});

  @override
  State<HeaderHome> createState() => _HeaderHomeState();
}

class _HeaderHomeState extends State<HeaderHome> {
  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();

    return Container(
      margin: const EdgeInsets.all(12.0),
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                child: Image.network(
                  'https://i.pravatar.cc/200',
                  width: 64.0,
                  height: 64.0,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16.0),
              SizedBox(
                width: context.deviceWidth - 208.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Halo,',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    FutureBuilder<AuthResponseModel>(
                      future: AuthLocalDatasource().getAuthData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          // child: Text(
                          return Text(
                            //   'Saiful Bahri',
                            snapshot.data!.user.name,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ],
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: Container(
                  width: 40.0,
                  height: 40.0,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.3),
                    borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                  ),
                  child: Assets.icons.notification.image(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40.0),
          SearchInput(
            controller: searchController,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
