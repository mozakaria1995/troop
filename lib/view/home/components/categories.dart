import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troop/service/home_services/category_service.dart';
import 'package:troop/view/home/categories/components/category_card.dart';
import 'package:troop/view/utils/constant_colors.dart';
import 'package:troop/view/utils/others_helper.dart';

class Categories extends StatelessWidget {
  const Categories({
    Key? key,
    required this.cc,
    required this.asProvider,
  }) : super(key: key);
  final ConstantColors cc;
  final asProvider;
  @override
  Widget build(BuildContext context) {
    // getLineAwsome("las la-charging-station");
    return Consumer<CategoryService>(
      builder: (context, provider, child) {
        return provider.categories != null
            ? provider.categories != 'error'
            ?Wrap(
          runSpacing: 20.0, // set the vertical spacing between each run
          children: <Widget>[
            Row(
              children: [
                for (int i = 0; i < provider.categories.category.length / 2; i++)
                  CategoryCard(
                    name: provider.categories.category[i].name,
                    id: provider.categories.category[i].id,
                    cc: cc,
                    index: i,
                    marginRight: 17.0,
                    imagelink: provider.categories.category[i].mobileIcon,
                  )
              ],
            ),
            //
            Row(
              children: [
                for (int i = provider.categories.category.length ~/ 2;
                i < provider.categories.category.length;
                i++)
                  CategoryCard(
                    name: provider.categories.category[i].name,
                    id: provider.categories.category[i].id,
                    cc: cc,
                    index: i,
                    marginRight: 17.0,
                    imagelink: provider.categories.category[i].mobileIcon,
                  )
              ],
            ),
          ],
        )
            : Text(asProvider.getString('Something went wrong'))
            : OthersHelper().showLoading(cc.primaryColor);
      },
    );
  }
}
