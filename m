From: "Ma, Le" <Le.Ma-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 05/10] drm/amdgpu: enable/disable doorbell interrupt in
 baco entry/exit helper
Date: Wed, 27 Nov 2019 12:14:02 +0000
Message-ID: <MN2PR12MB4285A41D146EDAAE4918FB78F6440@MN2PR12MB4285.namprd12.prod.outlook.com>
References: <1574846129-4826-1-git-send-email-le.ma@amd.com>
 <1574846129-4826-4-git-send-email-le.ma@amd.com>
 <DM5PR12MB14184CF08E965BAF369F4249FC440@DM5PR12MB1418.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0521228470=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB14184CF08E965BAF369F4249FC440-2J9CzHegvk81aAVlcVN8UQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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

--===============0521228470==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4285A41D146EDAAE4918FB78F6440MN2PR12MB4285namp_"

--_000_MN2PR12MB4285A41D146EDAAE4918FB78F6440MN2PR12MB4285namp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable



From: Zhang, Hawking <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, November 27, 2019 8:04 PM
To: Ma, Le <Le.Ma-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Chen, Guchun <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>; Zhou1, Tao <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>; Li,=
 Dennis <Dennis.Li-5C7GfCeVMHo@public.gmane.org>; Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>=
; Ma, Le <Le.Ma-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 05/10] drm/amdgpu: enable/disable doorbell interrupt in=
 baco entry/exit helper


Please check my comments inline



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
Subject: [PATCH 05/10] drm/amdgpu: enable/disable doorbell interrupt in bac=
o entry/exit helper



This operation is needed when baco entry/exit for ras recovery



Change-Id: I535c7231693f3138a8e3d5acd55672e2ac68232f

Signed-off-by: Le Ma <le.ma-5C7GfCeVMHo@public.gmane.org<mailto:le.ma-5C7GfCeVMHo@public.gmane.org>>

---

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 ++++++++++++-------

1 file changed, 12 insertions(+), 7 deletions(-)



diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c

index b1408c5..bd387bb 100644

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c

+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c

@@ -4308,10 +4308,14 @@ static void amdgpu_device_get_pcie_info(struct amdg=
pu_device *adev)  int amdgpu_device_baco_enter(struct drm_device *dev)  {

               struct amdgpu_device *adev =3D dev->dev_private;

+             struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);



                if (!amdgpu_device_supports_baco(adev->ddev))

                               return -ENOTSUPP;



+             if (ras && ras->supported)

+                             adev->nbio.funcs->enable_doorbell_interrupt(a=
dev, false);

+

               if (is_support_sw_smu(adev)) {

                               struct smu_context *smu =3D &adev->smu;

                               int ret;

@@ -4319,8 +4323,6 @@ int amdgpu_device_baco_enter(struct drm_device *dev)

                               ret =3D smu_baco_enter(smu);

                               if (ret)

                                               return ret;

-

-                              return 0;

               } else {

                               void *pp_handle =3D adev->powerplay.pp_handl=
e;

                               const struct amd_pm_funcs *pp_funcs =3D adev=
->powerplay.pp_funcs; @@ -4331,14 +4333,15 @@ int amdgpu_device_baco_enter(=
struct drm_device *dev)

                               /* enter BACO state */

                               if (pp_funcs->set_asic_baco_state(pp_handle,=
 1))

                                               return -EIO;

-

-                              return 0;

               }

+

+             return 0;

}



 int amdgpu_device_baco_exit(struct drm_device *dev)  {

               struct amdgpu_device *adev =3D dev->dev_private;

+             struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);



                if (!amdgpu_device_supports_baco(adev->ddev))

                               return -ENOTSUPP;

@@ -4351,7 +4354,6 @@ int amdgpu_device_baco_exit(struct drm_device *dev)

                               if (ret)

                                               return ret;



-                              return 0;

               } else {

                               void *pp_handle =3D adev->powerplay.pp_handl=
e;

                               const struct amd_pm_funcs *pp_funcs =3D adev=
->powerplay.pp_funcs; @@ -4362,7 +4364,10 @@ int amdgpu_device_baco_exit(st=
ruct drm_device *dev)

                               /* exit BACO state */

                               if (pp_funcs->set_asic_baco_state(pp_handle,=
 0))

                                               return -EIO;

-

-                              return 0;

               }

+

+             if (ras && ras->supported)

+                             adev->nbio.funcs->enable_doorbell_interrupt(a=
dev, false);

+





[Hawking] Shouldn't be enabled doorbell interrupt after exit baco? Or do I =
miss something?



[Le]: Yes, the argument should be true. I made a typo here.



+             return 0;

}

--

2.7.4



--_000_MN2PR12MB4285A41D146EDAAE4918FB78F6440MN2PR12MB4285namp_
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
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
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
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
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
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:SimSun;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:SimSun;}
span.EmailStyle21
	{mso-style-type:personal;
	font-family:"Arial",sans-serif;
	color:#0078D7;}
span.EmailStyle23
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt"><o:p>&nbsp;</o:p></=
span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Zhang, Hawking &lt;Hawking.Zhang-urvtwAKJhsc@public.gmane.org=
m&gt; <br>
<b>Sent:</b> Wednesday, November 27, 2019 8:04 PM<br>
<b>To:</b> Ma, Le &lt;Le.Ma-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Chen, Guchun &lt;Guchun.Chen-5C7GfCeVMHo@public.gmane.org&gt;; Zhou1, Tao &lt;Tao.Zho=
u1-5C7GfCeVMHo@public.gmane.org&gt;; Li, Dennis &lt;Dennis.Li-5C7GfCeVMHo@public.gmane.org&gt;; Deucher, Alexander &l=
t;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Ma, Le &lt;Le.Ma-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> RE: [PATCH 05/10] drm/amdgpu: enable/disable doorbell inter=
rupt in baco entry/exit helper<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:SimSun">=
<o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText">Please check my comments inline<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Regards,<br>
Hawking<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">-----Original Message-----<br>
From: Le Ma &lt;<a href=3D"mailto:le.ma-5C7GfCeVMHo@public.gmane.org">le.ma-5C7GfCeVMHo@public.gmane.org</a>&gt; <br>
Sent: 2019<span lang=3D"ZH-CN" style=3D"font-family:DengXian">=1B$BG/=1B(B<=
/span>11<span lang=3D"ZH-CN" style=3D"font-family:DengXian">=1B$B7n=1B(B</s=
pan>27<span lang=3D"ZH-CN" style=3D"font-family:DengXian">=1B$BF|=1B(B</spa=
n> 17:15<br>
To: <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org</a><br>
Cc: Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang-5C7GfCeVMHo@public.gmane.org">Hawking.Zha=
ng-5C7GfCeVMHo@public.gmane.org</a>&gt;; Chen, Guchun &lt;<a href=3D"mailto:Guchun.Chen-5C7GfCeVMHo@public.gmane.org"=
>Guchun.Chen-5C7GfCeVMHo@public.gmane.org</a>&gt;; Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@am=
d.com">Tao.Zhou1-5C7GfCeVMHo@public.gmane.org</a>&gt;; Li, Dennis &lt;<a href=3D"mailto:Dennis.L=
i@amd.com">Dennis.Li-5C7GfCeVMHo@public.gmane.org</a>&gt;;
 Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org">Alexan=
der.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;; Ma, Le &lt;<a href=3D"mailto:Le.Ma-5C7GfCeVMHo@public.gmane.org">Le=
.Ma-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
Subject: [PATCH 05/10] drm/amdgpu: enable/disable doorbell interrupt in bac=
o entry/exit helper<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">This operation is needed when baco entry/exit for=
 ras recovery<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Change-Id: I535c7231693f3138a8e3d5acd55672e2ac682=
32f<o:p></o:p></p>
<p class=3D"MsoPlainText">Signed-off-by: Le Ma &lt;<a href=3D"mailto:le.ma@=
amd.com"><span style=3D"color:windowtext;text-decoration:none">le.ma-urvtwAKJhsc@public.gmane.org=
m</span></a>&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">---<o:p></o:p></p>
<p class=3D"MsoPlainText">drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 &=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-------<o:p></o:=
p></p>
<p class=3D"MsoPlainText">1 file changed, 12 insertions(&#43;), 7 deletions=
(-)<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_de=
vice.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<o:p></o:p></p>
<p class=3D"MsoPlainText">index b1408c5..bd387bb 100644<o:p></o:p></p>
<p class=3D"MsoPlainText">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<=
o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdg=
pu_device.c<o:p></o:p></p>
<p class=3D"MsoPlainText">@@ -4308,10 &#43;4308,14 @@ static void amdgpu_de=
vice_get_pcie_info(struct amdgpu_device *adev)&nbsp; int amdgpu_device_baco=
_enter(struct drm_device *dev)&nbsp; {<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D dev-&gt;=
dev_private;<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *ras =3D amdgpu_ras_get_cont=
ext(adev);<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_device_supports_baco(=
adev-&gt;ddev))<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOTSUPP;<=
o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ras &amp;&amp; ras-&gt;supported)<o:p></o:=
p></p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs-&gt;e=
nable_doorbell_interrupt(adev, false);<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (is_support_sw_smu(adev)) {<o:p></o:=
p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_context=
 *smu =3D &amp;adev-&gt;smu;<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<o:p></o:p=
></p>
<p class=3D"MsoPlainText">@@ -4319,8 &#43;4323,6 @@ int amdgpu_device_baco_=
enter(struct drm_device *dev)<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D smu_baco_e=
nter(smu);<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<o:p></o:p=
></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return ret;<o:p></o:p></p>
<p class=3D"MsoPlainText">-<o:p></o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p=
>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *pp_handle =
=3D adev-&gt;powerplay.pp_handle;<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_p=
m_funcs *pp_funcs =3D adev-&gt;powerplay.pp_funcs; @@ -4331,14 &#43;4333,15=
 @@ int amdgpu_device_baco_enter(struct drm_device *dev)<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* enter BACO stat=
e */<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pp_funcs-&gt;s=
et_asic_baco_state(pp_handle, 1))<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return -EIO;<o:p></o:p></p>
<p class=3D"MsoPlainText">-<o:p></o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p=
>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoPlainText">}<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&nbsp;int amdgpu_device_baco_exit(struct drm_devi=
ce *dev)&nbsp; {<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D dev-&gt;=
dev_private;<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *ras =3D amdgpu_ras_get_cont=
ext(adev);<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!amdgpu_device_supports_baco(=
adev-&gt;ddev))<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ENOTSUPP;<=
o:p></o:p></p>
<p class=3D"MsoPlainText">@@ -4351,7 &#43;4354,6 @@ int amdgpu_device_baco_=
exit(struct drm_device *dev)<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<o:p></o:p=
></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return ret;<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p=
>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *pp_handle =
=3D adev-&gt;powerplay.pp_handle;<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amd_p=
m_funcs *pp_funcs =3D adev-&gt;powerplay.pp_funcs; @@ -4362,7 &#43;4364,10 =
@@ int amdgpu_device_baco_exit(struct drm_device *dev)<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* exit BACO state=
 */<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (pp_funcs-&gt;s=
et_asic_baco_state(pp_handle, 0))<o:p></o:p></p>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; return -EIO;<o:p></o:p></p>
<p class=3D"MsoPlainText">-<o:p></o:p></p>
<p class=3D"MsoPlainText">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p=
>
<p class=3D"MsoPlainText">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ras &amp;&amp; ras-&gt;supported)<o:p></o:=
p></p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs-&gt;e=
nable_doorbell_interrupt(adev, false);<o:p></o:p></p>
<p class=3D"MsoPlainText">&#43;<o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:black"><o:p>&nbsp;</o:p></sp=
an></p>
<p class=3D"MsoPlainText"><span style=3D"color:black"><o:p>&nbsp;</o:p></sp=
an></p>
<p class=3D"MsoPlainText"><span style=3D"color:#2F5597">[Hawking] Shouldn't=
 be enabled doorbell interrupt after exit baco? Or do I miss something?<o:p=
></o:p></span></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">[Le]: Yes, the argument should be true. I made a =
typo here.
<o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"font-size:12.0pt"><o:p>&nbsp;</o:p=
></span></p>
<p class=3D"MsoPlainText">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoPlainText">}<o:p></o:p></p>
<p class=3D"MsoPlainText">--<o:p></o:p></p>
<p class=3D"MsoPlainText">2.7.4<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB4285A41D146EDAAE4918FB78F6440MN2PR12MB4285namp_--

--===============0521228470==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0521228470==--
