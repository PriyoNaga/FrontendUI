import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_aarnyacatalog_project/controllers/cart_controller.dart';
import 'package:flutter_aarnyacatalog_project/controllers/popular_product_controller.dart';
import 'package:flutter_aarnyacatalog_project/pages/cart/cart_page.dart';
import 'package:flutter_aarnyacatalog_project/pages/home/main_food_page.dart';
import 'package:flutter_aarnyacatalog_project/routes/route_helper.dart';
import 'package:flutter_aarnyacatalog_project/utils/app_constants.dart';
import 'package:flutter_aarnyacatalog_project/utils/dimensions.dart';
import 'package:flutter_aarnyacatalog_project/widgets/app_column.dart';
import 'package:flutter_aarnyacatalog_project/widgets/app_icon.dart';
import 'package:flutter_aarnyacatalog_project/widgets/expandable_text_widgets.dart';
import 'package:get/get.dart';

import '../../utils/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const PopularFoodDetail({Key? key, required this.pageId, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background Image
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImgSize,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(AppConstants.BASE_URL +
                            AppConstants.UPLOAD_URL +
                            product.img!))),
              )),
          //Icon Widget
          Positioned(
              top: Dimensions.height45,
              left: Dimensions.widht20,
              right: Dimensions.widht20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        if (page == "cartpage") {
                          Get.toNamed(RouteHelper.getCartPage());
                        } else {
                          Get.toNamed(RouteHelper.getInitial());
                        }
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios)),
                  SizedBox(
                    width: Dimensions.widht20 * 8,
                  ),
                  AppIcon(
                    icon: Icons.favorite,
                    iconColor: AppColors.mainColor,
                  ),
                  GetBuilder<PopularProductController>(builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        if (controller.totalItems >= 1)
                          Get.toNamed(RouteHelper.getCartPage());
                      },
                      child: Stack(
                        children: [
                          AppIcon(icon: Icons.shopping_cart_outlined),
                          controller.totalItems >= 1
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: AppIcon(
                                    icon: Icons.circle,
                                    size: 20,
                                    iconColor: Colors.transparent,
                                    backgroundColor: AppColors.mainColor,
                                  ),
                                )
                              : Container(),
                          Get.find<PopularProductController>().totalItems >= 1
                              ? Positioned(
                                  right: 3,
                                  top: 3,
                                  child: BigText(
                                    text: Get.find<PopularProductController>()
                                        .totalItems
                                        .toString(),
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    );
                  })
                ],
              )),
          //Introduction of Food
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.popularFoodImgSize - 20,
              child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.widht20,
                    right: Dimensions.widht20,
                    top: Dimensions.height20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radius20),
                        topLeft: Radius.circular(Dimensions.radius20)),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name!),
                    SizedBox(height: Dimensions.height20),
                    BigText(text: "Introduce"),
                    SizedBox(height: Dimensions.height20),
                    TextButton.icon(
                        onPressed: () {},
                        icon: Text(
                          "Share",
                          style: TextStyle(
                              color: AppColors.mainBlackColor,
                              fontSize: Dimensions.font16),
                        ),
                        label: Icon(
                          Icons.share,
                          color: AppColors.mainBlackColor,
                          size: Dimensions.iconSize24,
                        )),
                    SizedBox(height: Dimensions.height20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExpandableTextWidget(text: product.description!),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(
        builder: (popularProduct) {
          return Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(
                top: Dimensions.height30,
                bottom: Dimensions.height30,
                left: Dimensions.widht20,
                right: Dimensions.widht20),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20 * 2),
                    topRight: Radius.circular(Dimensions.radius20 * 2))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.widht20,
                      right: Dimensions.widht20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(false);
                        },
                        child: Icon(
                          Icons.remove,
                          color: AppColors.signColor,
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      BigText(text: popularProduct.inCartItems.toString()),
                      SizedBox(
                        width: Dimensions.width10 / 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(true);
                        },
                        child: Icon(
                          Icons.add,
                          color: AppColors.signColor,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    popularProduct.addItem(product);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        left: Dimensions.widht20,
                        right: Dimensions.widht20),
                    child: BigText(
                      text: "\$ ${product.price!} | Add to Cart",
                      color: Colors.white,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
