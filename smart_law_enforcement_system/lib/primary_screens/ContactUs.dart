
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:smart_law_enforcement_system/login_signup/values/values.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  TextEditingController Fullname = TextEditingController();
  TextEditingController EmailId = TextEditingController();
  TextEditingController Message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 32),
      physics: BouncingScrollPhysics(),
      children: [
        Center(
          child: Ink.image(
            image: AssetImage("assets/images/contactus.jpg"),
            fit: BoxFit.cover,
            width: 170,
            height: 170,
          ),
        ),
        //Full Name
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                "Full Name",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 40,
              child: TextField(
                controller: Fullname,
                style: TextStyle(color: AppColors.pink, fontSize: 16.5),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  prefixIcon: Icon(
                    FeatherIcons.user,
                    color: AppColors.pink,
                    size: Sizes.ICON_SIZE_20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            // Email Id
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                "Email ID",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              height: 40,
              child: TextField(
                controller: EmailId,
                style: TextStyle(color: AppColors.pink, fontSize: 16.5),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  prefixIcon: Icon(
                    FeatherIcons.mail,
                    color: AppColors.pink,
                    size: Sizes.ICON_SIZE_20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            // Message.
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                "Message",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              // height: 40,
              child: TextField(
                controller: Message,
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                style: TextStyle(color: AppColors.pink, fontSize: 16.5,),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 20.0,),
                  prefixIcon: Icon(
                    FeatherIcons.messageSquare,
                    color: AppColors.pink,
                    size: Sizes.ICON_SIZE_20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            Center(
              child: ElevatedButton.icon(
                icon: Icon(FeatherIcons.send,size: 18,),
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                label: Text("Send"),
                onPressed: ()
                {
                  if(Fullname.text.isEmpty || EmailId.text.isEmpty || Message.text.isEmpty)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill all the fields.")));
                  }
                  else
                  {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Thank You For Contacting Us.!")));
                  }
                },
              ),
            ),

              const SizedBox(width: 30,),

              ],
            ),

            const SizedBox(
              height: 20,
            ),
          ],
        );
  }
}
