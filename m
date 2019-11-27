From: "Ma, Le" <Le.Ma-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 06/10] drm/amdgpu: add condition to enable baco for
 xgmi/ras case
Date: Wed, 27 Nov 2019 12:35:57 +0000
Message-ID: <MN2PR12MB4285E37DF7D44270D5CAD0E5F6440@MN2PR12MB4285.namprd12.prod.outlook.com>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
 <1574846129-4826-5-git-send-email-le.ma@amd.com>
 <DM5PR12MB141825CB772FEEF1FD013EDBFC440@DM5PR12MB1418.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1598236071=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB141825CB772FEEF1FD013EDBFC440-2J9CzHegvk81aAVlcVN8UQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhou1,
 Tao" <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>, "Li, Dennis" <Dennis.Li-5C7GfCeVMHo@public.gmane.org>, "Chen,
 Guchun" <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>

--===============1598236071==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4285E37DF7D44270D5CAD0E5F6440MN2PR12MB4285namp_"

--_000_MN2PR12MB4285E37DF7D44270D5CAD0E5F6440MN2PR12MB4285namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Agree with your thoughts that we drop amdgpu_ras_enable=3D2 condition. The =
only concern in my side is that besides fatal_error, another result may hap=
pen that atombios_init timeout on xgmi by baco (not sure psp mode1 reset ca=
uses this as well).



Assuming no amdgpu_ras_enable=3D2 check, if PMFW > 40.52,  the use cases as=
 my understanding includes:

  1.  sGPU without RAS:
     *   new: baco
     *   old: baco
  2.  sGPU with RAS:

  *   new: baco
  *   old: psp mode1 chain reset and legacy fatal_error handling

  1.  XGMI with RAS: baco
     *   new: baco
     *   old: psp mode1 chain reset and legacy fatal_error handling
  2.  XGMI without RAS: baco
     *   new: baco
     *   old: psp mode1 chain reset



That is to say, all uses cases go on baco road when PMFW > 40.52.



Regards,

Ma Le



-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, November 27, 2019 7:28 PM
To: Ma, Le <Le.Ma-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Chen, Guchun <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>; Zhou1, Tao <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>; Li,=
 Dennis <Dennis.Li-5C7GfCeVMHo@public.gmane.org>; Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>=
; Ma, Le <Le.Ma-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 06/10] drm/amdgpu: add condition to enable baco for xgm=
i/ras case



[AMD Public Use]



After thinking it a bit, I think we can just rely on PMFW version to decide=
 to go RAS recovery or legacy fatal_error handling for the platforms that s=
upport RAS. Leveraging amdgpu_ras_enable as a temporary solution seems not =
necessary? Even baco ras recovery not stable, it is the same result as lega=
cy fatal_error handling that user has to reboot the node manually.



So the new soc reset use cases are:

XGMI (without RAS): use PSP mode1 based chain reset, RAS enabled (with PMFW=
 40.52 and onwards): use BACO based RAS recovery, RAS enabled (with PMFW pr=
ior to 40.52): use legacy fatal_error handling.

Anything else?



Regards,

Hawking

-----Original Message-----

From: Le Ma <le.ma-5C7GfCeVMHo@public.gmane.org<mailto:le.ma-5C7GfCeVMHo@public.gmane.org>>

Sent: 2019=1B$BG/=1B(B11=1B$B7n=1B(B27=1B$BF|=1B(B 17:15

To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

Cc: Zhang, Hawking <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org<mailto:Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>>; C=
hen, Guchun <Guchun.Chen-5C7GfCeVMHo@public.gmane.org<mailto:Guchun.Chen-5C7GfCeVMHo@public.gmane.org>>; Zhou1, Tao <=
Tao.Zhou1-5C7GfCeVMHo@public.gmane.org<mailto:Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>>; Li, Dennis <Dennis.Li-5C7GfCeVMHo@public.gmane.org=
<mailto:Dennis.Li-5C7GfCeVMHo@public.gmane.org>>; Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org<=
mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>>; Ma, Le <Le.Ma-5C7GfCeVMHo@public.gmane.org<mailto:Le.Ma@amd.=
com>>

Subject: [PATCH 06/10] drm/amdgpu: add condition to enable baco for xgmi/ra=
s case



Avoid to change default reset behavior for production card by checking amdg=
pu_ras_enable equal to 2. And only new enough smu ucode can support baco fo=
r xgmi/ras case.



Change-Id: I07c3e6862be03e068745c73db8ea71f428ecba6b

Signed-off-by: Le Ma <le.ma-5C7GfCeVMHo@public.gmane.org<mailto:le.ma-5C7GfCeVMHo@public.gmane.org>>

---

drivers/gpu/drm/amd/amdgpu/soc15.c | 4 +++-

1 file changed, 3 insertions(+), 1 deletion(-)



diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgp=
u/soc15.c

index 951327f..6202333 100644

--- a/drivers/gpu/drm/amd/amdgpu/soc15.c

+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c

@@ -577,7 +577,9 @@ soc15_asic_reset_method(struct amdgpu_device *adev)

                                   struct amdgpu_hive_info *hive =3D amdgpu=
_get_xgmi_hive(adev, 0);

                                   struct amdgpu_ras *ras =3D amdgpu_ras_ge=
t_context(adev);

-                                   if (hive || (ras && ras->supported))

+                                  if ((hive || (ras && ras->supported)) &&

+                                      (amdgpu_ras_enable !=3D 2 ||

+                                      adev->pm.fw_version <=3D 0x283400))

                                               baco_reset =3D false;

                       }

                       break;

--

2.7.4

--_000_MN2PR12MB4285E37DF7D44270D5CAD0E5F6440MN2PR12MB4285namp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Microsoft YaHei";
	panose-1:2 11 5 3 2 2 4 2 2 4;}
@font-face
	{font-family:"\@Microsoft YaHei";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:14.0pt;
	font-family:"Calibri",sans-serif;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:758333370;
	mso-list-type:hybrid;
	mso-list-template-ids:-1255109936 67698703 67698689 67698715 67698703 6769=
8713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:39.0pt;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:75.0pt;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:111.0pt;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:183.0pt;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:219.0pt;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:255.0pt;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:291.0pt;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:327.0pt;
	text-indent:-9.0pt;}
@list l1
	{mso-list-id:1100415748;
	mso-list-type:hybrid;
	mso-list-template-ids:-1587907358 67698689 67698691 67698693 67698689 6769=
8691 67698693 67698689 67698691 67698693;}
@list l1:level1
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:75.0pt;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:111.0pt;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:183.0pt;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:219.0pt;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:255.0pt;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:291.0pt;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:327.0pt;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:363.0pt;
	text-indent:-.25in;
	font-family:Wingdings;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoPlainText">Agree with your thoughts that we drop amdgpu_ras_=
enable=3D2 condition. The only concern in my side is that besides fatal_err=
or, another result may happen that atombios_init timeout on xgmi by baco (n=
ot sure psp mode1 reset causes this
 as well). <o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Assuming no amdgpu_ras_enable=3D2 check, if PMFW =
&gt; 40.52, &nbsp;the use cases as my understanding includes:
<o:p></o:p></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoPlainText" style=3D"margin-left:3.0pt;mso-list:l0 level1 lf=
o1">sGPU without RAS:<o:p></o:p></li><ul style=3D"margin-top:0in" type=3D"d=
isc">
<li class=3D"MsoPlainText" style=3D"margin-left:3.0pt;mso-list:l0 level2 lf=
o1">new: baco<o:p></o:p></li><li class=3D"MsoPlainText" style=3D"margin-lef=
t:3.0pt;mso-list:l0 level2 lfo1">old: baco<o:p></o:p></li></ul>
<li class=3D"MsoPlainText" style=3D"margin-left:3.0pt;mso-list:l0 level1 lf=
o1">sGPU with RAS:<o:p></o:p></li></ol>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoPlainText" style=3D"margin-left:39.0pt;mso-list:l1 level1 l=
fo2">new: baco<o:p></o:p></li><li class=3D"MsoPlainText" style=3D"margin-le=
ft:39.0pt;mso-list:l1 level1 lfo2">old: psp mode1 chain reset and legacy fa=
tal_error handling<o:p></o:p></li></ul>
<ol style=3D"margin-top:0in" start=3D"3" type=3D"1">
<li class=3D"MsoPlainText" style=3D"margin-left:3.0pt;mso-list:l0 level1 lf=
o1">XGMI with RAS: baco<o:p></o:p></li><ul style=3D"margin-top:0in" type=3D=
"disc">
<li class=3D"MsoPlainText" style=3D"margin-left:3.0pt;mso-list:l0 level2 lf=
o1">new: baco<o:p></o:p></li><li class=3D"MsoPlainText" style=3D"margin-lef=
t:3.0pt;mso-list:l0 level2 lfo1">old: psp mode1 chain reset and legacy fata=
l_error handling<o:p></o:p></li></ul>
<li class=3D"MsoPlainText" style=3D"margin-left:3.0pt;mso-list:l0 level1 lf=
o1">XGMI without RAS: baco<o:p></o:p></li><ul style=3D"margin-top:0in" type=
=3D"disc">
<li class=3D"MsoPlainText" style=3D"margin-left:3.0pt;mso-list:l0 level2 lf=
o1">new: baco<o:p></o:p></li><li class=3D"MsoPlainText" style=3D"margin-lef=
t:3.0pt;mso-list:l0 level2 lfo1">old: psp mode1 chain reset<o:p></o:p></li>=
</ul>
</ol>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">That is to say, all uses cases go on baco road wh=
en PMFW &gt; 40.52.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Regards,<o:p></o:p></p>
<p class=3D"MsoPlainText">Ma Le<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">-----Original Message-----<br>
From: Zhang, Hawking &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt; <br>
Sent: Wednesday, November 27, 2019 7:28 PM<br>
To: Ma, Le &lt;Le.Ma-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
Cc: Chen, Guchun &lt;Guchun.Chen-5C7GfCeVMHo@public.gmane.org&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.=
com&gt;; Li, Dennis &lt;Dennis.Li-5C7GfCeVMHo@public.gmane.org&gt;; Deucher, Alexander &lt;Alexa=
nder.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Ma, Le &lt;Le.Ma-5C7GfCeVMHo@public.gmane.org&gt;<br>
Subject: RE: [PATCH 06/10] drm/amdgpu: add condition to enable baco for xgm=
i/ras case</p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">[AMD Public Use]<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">After thinking it a bit, I think we can just rely=
 on PMFW version to decide to go RAS recovery or legacy fatal_error handlin=
g for the platforms that support RAS. Leveraging amdgpu_ras_enable as a tem=
porary solution seems not necessary?
 Even baco ras recovery not stable, it is the same result as legacy fatal_e=
rror handling that user has to reboot the node manually.
<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">So the new soc reset use cases are:<o:p></o:p></p=
>
<p class=3D"MsoPlainText">XGMI (without RAS): use PSP mode1 based chain res=
et, RAS enabled (with PMFW 40.52 and onwards): use BACO based RAS recovery,=
 RAS enabled (with PMFW prior to 40.52): use legacy fatal_error handling.<o=
:p></o:p></p>
<p class=3D"MsoPlainText"><o:p></o:p></p>
<p class=3D"MsoPlainText">Anything else?<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Regards,<o:p></o:p></p>
<p class=3D"MsoPlainText">Hawking<o:p></o:p></p>
<p class=3D"MsoPlainText">-----Original Message-----<o:p></o:p></p>
<p class=3D"MsoPlainText">From: Le Ma &lt;<a href=3D"mailto:le.ma-5C7GfCeVMHo@public.gmane.org">=
<span style=3D"color:windowtext;text-decoration:none">le.ma-5C7GfCeVMHo@public.gmane.org</span><=
/a>&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">Sent: 2019<span lang=3D"ZH-CN" style=3D"font-fami=
ly:&quot;Microsoft YaHei&quot;,sans-serif">=1B$BG/=1B(B</span>11<span lang=
=3D"ZH-CN" style=3D"font-family:&quot;Microsoft YaHei&quot;,sans-serif">=1B=
$B7n=1B(B</span>27<span lang=3D"ZH-CN" style=3D"font-family:&quot;Microsoft=
 YaHei&quot;,sans-serif">=1B$BF|=1B(B</span>
 17:15<o:p></o:p></p>
<p class=3D"MsoPlainText">To: <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp93rCq3LdnpKM@public.gmane.org=
rg"><span style=3D"color:windowtext;text-decoration:none">amd-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org</span></a><o:p></o:p></p>
<p class=3D"MsoPlainText">Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.=
Zhang-5C7GfCeVMHo@public.gmane.org"><span style=3D"color:windowtext;text-decoration:none">Hawkin=
g.Zhang-5C7GfCeVMHo@public.gmane.org</span></a>&gt;; Chen, Guchun &lt;<a href=3D"mailto:Guchun.C=
hen-5C7GfCeVMHo@public.gmane.org"><span style=3D"color:windowtext;text-decoration:none">Guchun.C=
hen-5C7GfCeVMHo@public.gmane.org</span></a>&gt;;
 Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1-5C7GfCeVMHo@public.gmane.org"><span style=3D"color:w=
indowtext;text-decoration:none">Tao.Zhou1-5C7GfCeVMHo@public.gmane.org</span></a>&gt;; Li, Denni=
s &lt;<a href=3D"mailto:Dennis.Li-5C7GfCeVMHo@public.gmane.org"><span style=3D"color:windowtext;=
text-decoration:none">Dennis.Li-5C7GfCeVMHo@public.gmane.org</span></a>&gt;;
 Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org"><span =
style=3D"color:windowtext;text-decoration:none">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</=
span></a>&gt;; Ma, Le &lt;<a href=3D"mailto:Le.Ma-5C7GfCeVMHo@public.gmane.org"><span style=3D"c=
olor:windowtext;text-decoration:none">Le.Ma-5C7GfCeVMHo@public.gmane.org</span></a>&gt;<o:p></o:=
p></p>
<p class=3D"MsoPlainText">Subject: [PATCH 06/10] drm/amdgpu: add condition =
to enable baco for xgmi/ras case<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Avoid to change default reset behavior for produc=
tion card by checking amdgpu_ras_enable equal to 2. And only new enough smu=
 ucode can support baco for xgmi/ras case.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Change-Id: I07c3e6862be03e068745c73db8ea71f428ecb=
a6b<o:p></o:p></p>
<p class=3D"MsoPlainText">Signed-off-by: Le Ma &lt;<a href=3D"mailto:le.ma@=
amd.com"><span style=3D"color:windowtext;text-decoration:none">le.ma-urvtwAKJhsc@public.gmane.org=
m</span></a>&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">---<o:p></o:p></p>
<p class=3D"MsoPlainText">drivers/gpu/drm/amd/amdgpu/soc15.c | 4 &#43;&#43;=
&#43;-<o:p></o:p></p>
<p class=3D"MsoPlainText">1 file changed, 3 insertions(&#43;), 1 deletion(-=
)<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b=
/drivers/gpu/drm/amd/amdgpu/soc15.c<o:p></o:p></p>
<p class=3D"MsoPlainText">index 951327f..6202333 100644<o:p></o:p></p>
<p class=3D"MsoPlainText">--- a/drivers/gpu/drm/amd/amdgpu/soc15.c<o:p></o:=
p></p>
<p class=3D"MsoPlainText">&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/soc1=
5.c<o:p></o:p></p>
<p class=3D"MsoPlainText">@@ -577,7 &#43;577,9 @@ soc15_asic_reset_method(s=
truct amdgpu_device *adev)<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; struct amdgpu_hive_info *hive =3D amdgpu_get_xgmi_hive(adev, 0);<o:p>=
</o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);<o:p></o:p></=
p>
<p class=3D"MsoPlainText"><o:p></o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; if (hive || (ras &amp;&amp; ras-&gt;supported))<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if ((hive || (ras &amp;&amp; ras-&gt;supported)) &amp;&amp;<o:p></o:p>=
</p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp; (amdgpu_ras_enable !=3D 2 ||<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; &nbsp;&nbsp;&nbsp; adev-&gt;pm.fw_version &lt;=3D 0x283400))<o:p></o:p=
></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; baco_reset =3D false;<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; break;<o:p></o:p></p>
<p class=3D"MsoPlainText">--<o:p></o:p></p>
<p class=3D"MsoPlainText">2.7.4<o:p></o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB4285E37DF7D44270D5CAD0E5F6440MN2PR12MB4285namp_--

--===============1598236071==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1598236071==--
