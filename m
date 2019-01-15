From: "Wu, Hersen" <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amd/display: eDP fast bootup does not work for
 pre-raven asic
Date: Tue, 15 Jan 2019 16:57:23 +0000
Message-ID: <DM5PR1201MB255383E2B49EFBE55ABA16D4FD810@DM5PR1201MB2553.namprd12.prod.outlook.com>
References: <1547505375-13003-1-git-send-email-sunpeng.li@amd.com>
 <BN6PR12MB1809BE511C1770BED3E4349DF7810@BN6PR12MB1809.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0240023504=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1809BE511C1770BED3E4349DF7810-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>

--===============0240023504==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR1201MB255383E2B49EFBE55ABA16D4FD810DM5PR1201MB2553_"

--_000_DM5PR1201MB255383E2B49EFBE55ABA16D4FD810DM5PR1201MB2553_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi, Alex,

Hersen's change is for older version of eDP fast boot up ( bios_get_vga_ena=
bled_displays  is called).
Chrome tree source still use bios_get_vga_enabled_displays for fast boot up=
.


Harry's change is new implementation of eDP fast boot up.

Hersen's change will not revert Harry's change.

Thanks,
Hersen


From: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, January 15, 2019 10:43 AM
To: Li, Sun peng (Leo) <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Wentland, Harry <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>; Wu, Hersen <hersenxs.wu@amd.c=
om>
Subject: Re: [PATCH] drm/amd/display: eDP fast bootup does not work for pre=
-raven asic


Can this patch be reverted with this change?


commit 95f05a3a2e6895ecfd8b4f64b5d6c6cf0b6a3f4a
Author: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org<mailto:alexander.deucher@am=
d.com>>
Date:   Thu Aug 16 15:35:21 2018 -0500

    drm/amdgpu/display: disable eDP fast boot optimization on DCE8

    Seems to cause blank screens.

    Bug: https://bugs.freedesktop.org/show_bug.cgi?id=3D106940
    Reviewed-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org<mailto:harry.wentla=
nd-5C7GfCeVMHo@public.gmane.org>>
    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org<mailto:alexander=
.deucher-5C7GfCeVMHo@public.gmane.org>>
Other than that, it looks good to me.

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org<mailto:alexander.deuch=
er-5C7GfCeVMHo@public.gmane.org>>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of sunpeng.li-5C7GfCeVMHo@public.gmane.org<mailto:sunpeng.li@=
amd.com> <sunpeng.li-5C7GfCeVMHo@public.gmane.org<mailto:sunpeng.li-5C7GfCeVMHo@public.gmane.org>>
Sent: Monday, January 14, 2019 5:36:15 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Wentland, Harry; Wu, Hersen
Subject: [PATCH] drm/amd/display: eDP fast bootup does not work for pre-rav=
en asic

From: hersen wu <hersenxs.wu-5C7GfCeVMHo@public.gmane.org<mailto:hersenxs.wu-5C7GfCeVMHo@public.gmane.org>>

[Why] bios will light up eDP before sw driver loaded. sw driver will
check if eDP lighted up by bios by reading BIOS_SCRATCH_3. If yes,
sw driver will not power down eDP power, phy to save time.
definition of BIOS_SCRATCH_3 are missed for pre-raven asic. this
cuase eDP fast boot up not work. for some eDP panel, even AMD dp tx
send NoVideoStream_flag =3D1 and dpcd 0x600=3D2, eDP rx may not handle
properly. this may cause short period flash on screen.

[How] add definition of BIOS_SCRATCH_3 for all asic

CC: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org<mailto:harry.wentland-5C7GfCeVMHo@public.gmane.org>>
Signed-off-by: hersen wu <hersenxs.wu-5C7GfCeVMHo@public.gmane.org<mailto:hersenxs.wu-5C7GfCeVMHo@public.gmane.org>>
Reviewed-by: Charlene Liu <Charlene.Liu-5C7GfCeVMHo@public.gmane.org<mailto:Charlene.Liu-5C7GfCeVMHo@public.gmane.org=
>>
Acked-by: Yongqiang Sun <yongqiang.sun-5C7GfCeVMHo@public.gmane.org<mailto:yongqiang.sun-5C7GfCeVMHo@public.gmane.org=
>>
Acked-by: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org<mailto:sunpeng.li-5C7GfCeVMHo@public.gmane.org>>
---
 drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c | 3 +--
 drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c  | 2 ++
 drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c  | 2 ++
 drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c  | 2 ++
 drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c  | 1 +
 drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c    | 2 ++
 6 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c b/dri=
vers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c
index fdda8aa..d8275ceb 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c
@@ -83,8 +83,7 @@ uint32_t bios_get_vga_enabled_displays(
 {
         uint32_t active_disp =3D 1;

-       if (bios->regs->BIOS_SCRATCH_3) /*follow up with other asic, todo*/
-               active_disp =3D REG_READ(BIOS_SCRATCH_3) & 0XFFFF;
+       active_disp =3D REG_READ(BIOS_SCRATCH_3) & 0XFFFF;
         return active_disp;
 }

diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
index c3f616a..23044e6 100644
--- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c
@@ -76,6 +76,7 @@

 #ifndef mmBIOS_SCRATCH_2
         #define mmBIOS_SCRATCH_2 0x05CB
+       #define mmBIOS_SCRATCH_3 0x05CC
         #define mmBIOS_SCRATCH_6 0x05CF
 #endif

@@ -365,6 +366,7 @@ static const struct dce_abm_mask abm_mask =3D {
 #define DCFE_MEM_PWR_CTRL_REG_BASE 0x1b03

 static const struct bios_registers bios_regs =3D {
+       .BIOS_SCRATCH_3 =3D mmBIOS_SCRATCH_3,
         .BIOS_SCRATCH_6 =3D mmBIOS_SCRATCH_6
 };

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
index 7d46eb7..7549ada 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
@@ -84,6 +84,7 @@

 #ifndef mmBIOS_SCRATCH_2
         #define mmBIOS_SCRATCH_2 0x05CB
+       #define mmBIOS_SCRATCH_3 0x05CC
         #define mmBIOS_SCRATCH_6 0x05CF
 #endif

@@ -369,6 +370,7 @@ static const struct dce110_clk_src_mask cs_mask =3D {
 };

 static const struct bios_registers bios_regs =3D {
+       .BIOS_SCRATCH_3 =3D mmBIOS_SCRATCH_3,
         .BIOS_SCRATCH_6 =3D mmBIOS_SCRATCH_6
 };

diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
index d930e09..ea3065d6 100644
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c
@@ -76,6 +76,7 @@

 #ifndef mmBIOS_SCRATCH_2
         #define mmBIOS_SCRATCH_2 0x05CB
+       #define mmBIOS_SCRATCH_3 0x05CC
         #define mmBIOS_SCRATCH_6 0x05CF
 #endif

@@ -376,6 +377,7 @@ static const struct dce110_clk_src_mask cs_mask =3D {
 };

 static const struct bios_registers bios_regs =3D {
+       .BIOS_SCRATCH_3 =3D mmBIOS_SCRATCH_3,
         .BIOS_SCRATCH_6 =3D mmBIOS_SCRATCH_6
 };

diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
index 23d7d4d..312a0ae 100644
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c
@@ -442,6 +442,7 @@ struct dce_i2c_hw *dce120_i2c_hw_create(
         return dce_i2c_hw;
 }
 static const struct bios_registers bios_regs =3D {
+       .BIOS_SCRATCH_3 =3D mmBIOS_SCRATCH_3 + NBIO_BASE(mmBIOS_SCRATCH_3_B=
ASE_IDX),
         .BIOS_SCRATCH_6 =3D mmBIOS_SCRATCH_6 + NBIO_BASE(mmBIOS_SCRATCH_6_=
BASE_IDX)
 };

diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/driver=
s/gpu/drm/amd/display/dc/dce80/dce80_resource.c
index e0bba0bc..2eca81b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
@@ -77,6 +77,7 @@

 #ifndef mmBIOS_SCRATCH_2
         #define mmBIOS_SCRATCH_2 0x05CB
+       #define mmBIOS_SCRATCH_3 0x05CC
         #define mmBIOS_SCRATCH_6 0x05CF
 #endif

@@ -358,6 +359,7 @@ static const struct dce110_clk_src_mask cs_mask =3D {
 };

 static const struct bios_registers bios_regs =3D {
+       .BIOS_SCRATCH_3 =3D mmBIOS_SCRATCH_3,
         .BIOS_SCRATCH_6 =3D mmBIOS_SCRATCH_6
 };

--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR1201MB255383E2B49EFBE55ABA16D4FD810DM5PR1201MB2553_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
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
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi, Alex,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hersen&#8217;s change is for older version of eDP fa=
st boot up ( bios_get_vga_enabled_displays &nbsp;is called).
<o:p></o:p></p>
<p class=3D"MsoNormal">Chrome tree source still use bios_get_vga_enabled_di=
splays for fast boot up.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Harry&#8217;s change is new implementation of eDP fa=
st boot up.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hersen&#8217;s change will not revert Harry&#8217;s =
change.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Hersen<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Tuesday, January 15, 2019 10:43 AM<br>
<b>To:</b> Li, Sun peng (Leo) &lt;Sunpeng.Li-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org<br>
<b>Cc:</b> Wentland, Harry &lt;Harry.Wentland-5C7GfCeVMHo@public.gmane.org&gt;; Wu, Hersen &lt;h=
ersenxs.wu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/display: eDP fast bootup does not work =
for pre-raven asic<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-size:12.0pt;color:black">Can this patch be reverted =
with this change?<o:p></o:p></span></p>
<p><span style=3D"font-size:12.0pt;color:black"><o:p>&nbsp;</o:p></span></p=
>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:12.0pt;color:black">commit 95f05a3a2e6895ecfd8b4f64b5d6c6cf0b6a3f4a<br>
Author: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">alexa=
nder.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
Date:&nbsp;&nbsp; Thu Aug 16 15:35:21 2018 -0500<br>
<br>
&nbsp;&nbsp;&nbsp; drm/amdgpu/display: disable eDP fast boot optimization o=
n DCE8<br>
&nbsp;&nbsp; &nbsp;<br>
&nbsp;&nbsp;&nbsp; Seems to cause blank screens.<br>
&nbsp;&nbsp; &nbsp;<br>
&nbsp;&nbsp;&nbsp; Bug: <a href=3D"https://bugs.freedesktop.org/show_bug.cg=
i?id=3D106940">https://bugs.freedesktop.org/show_bug.cgi?id=3D106940</a><br=
>
&nbsp;&nbsp;&nbsp; Reviewed-by: Harry Wentland &lt;<a href=3D"mailto:harry.=
wentland-5C7GfCeVMHo@public.gmane.org">harry.wentland-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&nbsp;&nbsp;&nbsp; Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexan=
der.deucher-5C7GfCeVMHo@public.gmane.org">alexander.deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;<o:p></o:p></span></p=
>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Other t=
han that, it looks good to me.
<o:p></o:p></span></p>
<p><span style=3D"font-size:12.0pt;color:black">Reviewed-by: Alex Deucher &=
lt;<a href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">alexander.deucher-5C7GfCeVMHo@public.gmane.org</=
a>&gt;<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt; on behalf o=
f
<a href=3D"mailto:sunpeng.li-5C7GfCeVMHo@public.gmane.org">sunpeng.li-5C7GfCeVMHo@public.gmane.org</a> &lt;<a href=3D=
"mailto:sunpeng.li-5C7GfCeVMHo@public.gmane.org">sunpeng.li-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Monday, January 14, 2019 5:36:15 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a><br>
<b>Cc:</b> Wentland, Harry; Wu, Hersen<br>
<b>Subject:</b> [PATCH] drm/amd/display: eDP fast bootup does not work for =
pre-raven asic</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">From: hersen wu &lt;<a href=3D"mailto:hersenxs.wu@am=
d.com">hersenxs.wu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<br>
[Why] bios will light up eDP before sw driver loaded. sw driver will<br>
check if eDP lighted up by bios by reading BIOS_SCRATCH_3. If yes,<br>
sw driver will not power down eDP power, phy to save time.<br>
definition of BIOS_SCRATCH_3 are missed for pre-raven asic. this<br>
cuase eDP fast boot up not work. for some eDP panel, even AMD dp tx<br>
send NoVideoStream_flag =3D1 and dpcd 0x600=3D2, eDP rx may not handle<br>
properly. this may cause short period flash on screen.<br>
<br>
[How] add definition of BIOS_SCRATCH_3 for all asic<br>
<br>
CC: Harry Wentland &lt;<a href=3D"mailto:harry.wentland-5C7GfCeVMHo@public.gmane.org">harry.went=
land-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
Signed-off-by: hersen wu &lt;<a href=3D"mailto:hersenxs.wu-5C7GfCeVMHo@public.gmane.org">hersenx=
s.wu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
Reviewed-by: Charlene Liu &lt;<a href=3D"mailto:Charlene.Liu-5C7GfCeVMHo@public.gmane.org">Charl=
ene.Liu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
Acked-by: Yongqiang Sun &lt;<a href=3D"mailto:yongqiang.sun-5C7GfCeVMHo@public.gmane.org">yongqi=
ang.sun-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
Acked-by: Leo Li &lt;<a href=3D"mailto:sunpeng.li-5C7GfCeVMHo@public.gmane.org">sunpeng.li@amd.c=
om</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c | 3 &#43;--<=
br>
&nbsp;drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c&nbsp; | 2 &#4=
3;&#43;<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c&nbsp; | 2 &#4=
3;&#43;<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c&nbsp; | 2 &#4=
3;&#43;<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c&nbsp; | 1 &#4=
3;<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c&nbsp;&nbsp;&nbs=
p; | 2 &#43;&#43;<br>
&nbsp;6 files changed, 10 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c b/dri=
vers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c<br>
index fdda8aa..d8275ceb 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/bios/bios_parser_helper.c<=
br>
@@ -83,8 &#43;83,7 @@ uint32_t bios_get_vga_enabled_displays(<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t active_disp =3D 1=
;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bios-&gt;regs-&gt;BIOS_SCRATCH_3)=
 /*follow up with other asic, todo*/<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; active_disp =3D REG_READ(BIOS_SCRATCH_3) &amp; 0XFFFF;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; active_disp =3D REG_READ(BIOS_SCR=
ATCH_3) &amp; 0XFFFF;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return active_disp;<br>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dce100/dce100_resource.c<br>
index c3f616a..23044e6 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce100/dce100_resource.c<b=
r>
@@ -76,6 &#43;76,7 @@<br>
&nbsp;<br>
&nbsp;#ifndef mmBIOS_SCRATCH_2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define mmBIOS_SCRATCH_2 0=
x05CB<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define mmBIOS_SCRATCH_3 0x05CC<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define mmBIOS_SCRATCH_6 0=
x05CF<br>
&nbsp;#endif<br>
&nbsp;<br>
@@ -365,6 &#43;366,7 @@ static const struct dce_abm_mask abm_mask =3D {<br>
&nbsp;#define DCFE_MEM_PWR_CTRL_REG_BASE 0x1b03<br>
&nbsp;<br>
&nbsp;static const struct bios_registers bios_regs =3D {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .BIOS_SCRATCH_3 =3D mmBIOS_SCRATC=
H_3,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .BIOS_SCRATCH_6 =3D mmBIOS=
_SCRATCH_6<br>
&nbsp;};<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dce110/dce110_resource.c<br>
index 7d46eb7..7549ada 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c<b=
r>
@@ -84,6 &#43;84,7 @@<br>
&nbsp;<br>
&nbsp;#ifndef mmBIOS_SCRATCH_2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define mmBIOS_SCRATCH_2 0=
x05CB<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define mmBIOS_SCRATCH_3 0x05CC<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define mmBIOS_SCRATCH_6 0=
x05CF<br>
&nbsp;#endif<br>
&nbsp;<br>
@@ -369,6 &#43;370,7 @@ static const struct dce110_clk_src_mask cs_mask =3D=
 {<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static const struct bios_registers bios_regs =3D {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .BIOS_SCRATCH_3 =3D mmBIOS_SCRATC=
H_3,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .BIOS_SCRATCH_6 =3D mmBIOS=
_SCRATCH_6<br>
&nbsp;};<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dce112/dce112_resource.c<br>
index d930e09..ea3065d6 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce112/dce112_resource.c<b=
r>
@@ -76,6 &#43;76,7 @@<br>
&nbsp;<br>
&nbsp;#ifndef mmBIOS_SCRATCH_2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define mmBIOS_SCRATCH_2 0=
x05CB<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define mmBIOS_SCRATCH_3 0x05CC<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define mmBIOS_SCRATCH_6 0=
x05CF<br>
&nbsp;#endif<br>
&nbsp;<br>
@@ -376,6 &#43;377,7 @@ static const struct dce110_clk_src_mask cs_mask =3D=
 {<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static const struct bios_registers bios_regs =3D {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .BIOS_SCRATCH_3 =3D mmBIOS_SCRATC=
H_3,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .BIOS_SCRATCH_6 =3D mmBIOS=
_SCRATCH_6<br>
&nbsp;};<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c b/driv=
ers/gpu/drm/amd/display/dc/dce120/dce120_resource.c<br>
index 23d7d4d..312a0ae 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce120/dce120_resource.c<b=
r>
@@ -442,6 &#43;442,7 @@ struct dce_i2c_hw *dce120_i2c_hw_create(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return dce_i2c_hw;<br>
&nbsp;}<br>
&nbsp;static const struct bios_registers bios_regs =3D {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .BIOS_SCRATCH_3 =3D mmBIOS_SCRATC=
H_3 &#43; NBIO_BASE(mmBIOS_SCRATCH_3_BASE_IDX),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .BIOS_SCRATCH_6 =3D mmBIOS=
_SCRATCH_6 &#43; NBIO_BASE(mmBIOS_SCRATCH_6_BASE_IDX)<br>
&nbsp;};<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/driver=
s/gpu/drm/amd/display/dc/dce80/dce80_resource.c<br>
index e0bba0bc..2eca81b 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c<br>
@@ -77,6 &#43;77,7 @@<br>
&nbsp;<br>
&nbsp;#ifndef mmBIOS_SCRATCH_2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define mmBIOS_SCRATCH_2 0=
x05CB<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define mmBIOS_SCRATCH_3 0x05CC<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #define mmBIOS_SCRATCH_6 0=
x05CF<br>
&nbsp;#endif<br>
&nbsp;<br>
@@ -358,6 &#43;359,7 @@ static const struct dce110_clk_src_mask cs_mask =3D=
 {<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static const struct bios_registers bios_regs =3D {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .BIOS_SCRATCH_3 =3D mmBIOS_SCRATC=
H_3,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .BIOS_SCRATCH_6 =3D mmBIOS=
_SCRATCH_6<br>
&nbsp;};<br>
&nbsp;<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9/rsn8yoX9R0@public.gmane.org=
org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR1201MB255383E2B49EFBE55ABA16D4FD810DM5PR1201MB2553_--

--===============0240023504==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0240023504==--
