From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: eDP fast bootup does not work for
 pre-raven asic
Date: Tue, 15 Jan 2019 15:42:56 +0000
Message-ID: <BN6PR12MB1809BE511C1770BED3E4349DF7810@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1547505375-13003-1-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1541507154=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1547505375-13003-1-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
To: "Li, Sun peng (Leo)" <Sunpeng.Li-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Wu, Hersen" <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>, "Wentland,
 Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>

--===============1541507154==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809BE511C1770BED3E4349DF7810BN6PR12MB1809namp_"

--_000_BN6PR12MB1809BE511C1770BED3E4349DF7810BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Can this patch be reverted with this change?


commit 95f05a3a2e6895ecfd8b4f64b5d6c6cf0b6a3f4a
Author: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Date:   Thu Aug 16 15:35:21 2018 -0500

    drm/amdgpu/display: disable eDP fast boot optimization on DCE8

    Seems to cause blank screens.

    Bug: https://bugs.freedesktop.org/show_bug.cgi?id=3D106940
    Reviewed-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

Other than that, it looks good to me.

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of sunpeng.=
li-5C7GfCeVMHo@public.gmane.org <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, January 14, 2019 5:36:15 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Wentland, Harry; Wu, Hersen
Subject: [PATCH] drm/amd/display: eDP fast bootup does not work for pre-rav=
en asic

From: hersen wu <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>

[Why] bios will light up eDP before sw driver loaded. sw driver will
check if eDP lighted up by bios by reading BIOS_SCRATCH_3. If yes,
sw driver will not power down eDP power, phy to save time.
definition of BIOS_SCRATCH_3 are missed for pre-raven asic. this
cuase eDP fast boot up not work. for some eDP panel, even AMD dp tx
send NoVideoStream_flag =3D1 and dpcd 0x600=3D2, eDP rx may not handle
properly. this may cause short period flash on screen.

[How] add definition of BIOS_SCRATCH_3 for all asic

CC: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: hersen wu <hersenxs.wu-5C7GfCeVMHo@public.gmane.org>
Reviewed-by: Charlene Liu <Charlene.Liu-5C7GfCeVMHo@public.gmane.org>
Acked-by: Yongqiang Sun <yongqiang.sun-5C7GfCeVMHo@public.gmane.org>
Acked-by: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809BE511C1770BED3E4349DF7810BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Can this patch be reverted with t=
his change?</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div>commit 95f05a3a2e6895ecfd8b4f64b5d6c6cf0b6a3f4a<br>
Author: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
Date:&nbsp;&nbsp; Thu Aug 16 15:35:21 2018 -0500<br>
<br>
&nbsp;&nbsp;&nbsp; drm/amdgpu/display: disable eDP fast boot optimization o=
n DCE8<br>
&nbsp;&nbsp; &nbsp;<br>
&nbsp;&nbsp;&nbsp; Seems to cause blank screens.<br>
&nbsp;&nbsp; &nbsp;<br>
&nbsp;&nbsp;&nbsp; Bug: https://bugs.freedesktop.org/show_bug.cgi?id=3D1069=
40<br>
&nbsp;&nbsp;&nbsp; Reviewed-by: Harry Wentland &lt;harry.wentland-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
&nbsp;&nbsp;&nbsp; Signed-off-by: Alex Deucher &lt;alexander.deucher-urvtwAKJhsc@public.gmane.org=
m&gt;<br>
<br>
</div>
Other than that, it looks good to me.
<p></p>
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of sunpeng.li-5C7GfCeVMHo@public.gmane.org &lt;sunpen=
g.li-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, January 14, 2019 5:36:15 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Wentland, Harry; Wu, Hersen<br>
<b>Subject:</b> [PATCH] drm/amd/display: eDP fast bootup does not work for =
pre-raven asic</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: hersen wu &lt;hersenxs.wu-5C7GfCeVMHo@public.gmane.org&gt;<br>
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
CC: Harry Wentland &lt;harry.wentland-5C7GfCeVMHo@public.gmane.org&gt;<br>
Signed-off-by: hersen wu &lt;hersenxs.wu-5C7GfCeVMHo@public.gmane.org&gt;<br>
Reviewed-by: Charlene Liu &lt;Charlene.Liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
Acked-by: Yongqiang Sun &lt;yongqiang.sun-5C7GfCeVMHo@public.gmane.org&gt;<br>
Acked-by: Leo Li &lt;sunpeng.li-5C7GfCeVMHo@public.gmane.org&gt;<br>
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
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809BE511C1770BED3E4349DF7810BN6PR12MB1809namp_--

--===============1541507154==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1541507154==--
