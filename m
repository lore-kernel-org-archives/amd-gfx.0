From: "Yin, Tianci (Rico)" <Tianci.Yin-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: update smu11_driver_if_navi10.h
Date: Fri, 28 Jun 2019 07:01:43 +0000
Message-ID: <MN2PR12MB29749635290092A031CB5A4C95FC0@MN2PR12MB2974.namprd12.prod.outlook.com>
References: <1561618176-27968-1-git-send-email-tianci.yin@amd.com>,
 <BN6PR12MB18093E64A4289711D31BCED8F7FD0@BN6PR12MB1809.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0514965742=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB18093E64A4289711D31BCED8F7FD0-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

--===============0514965742==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB29749635290092A031CB5A4C95FC0MN2PR12MB2974namp_"

--_000_MN2PR12MB29749635290092A031CB5A4C95FC0MN2PR12MB2974namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks Alex!
________________________________
From: Deucher, Alexander
Sent: Thursday, June 27, 2019 23:38
To: Yin, Tianci (Rico); amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Xiao, Jack; Zhang, Hawking
Subject: Re: [PATCH] drm/amd/powerplay: update smu11_driver_if_navi10.h

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Tianci Y=
in <tianci.yin-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, June 27, 2019 2:49 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Xiao, Jack; Yin, Tianci (Rico); Zhang, Hawking
Subject: [PATCH] drm/amd/powerplay: update smu11_driver_if_navi10.h

From: tiancyin <tianci.yin-5C7GfCeVMHo@public.gmane.org>

update the smu11_driver_if_navi10.h since navi10 smu fw
update to 42.28

Signed-off-by: tiancyin <tianci.yin-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h | 6 +++---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c                 | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h b/d=
rivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h
index a8b31bc..adbbfeb 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h
@@ -26,7 +26,7 @@
 // *** IMPORTANT ***
 // SMU TEAM: Always increment the interface version if
 // any structure is changed in this file
-#define SMU11_DRIVER_IF_VERSION 0x32
+#define SMU11_DRIVER_IF_VERSION 0x33

 #define PPTABLE_NV10_SMU_VERSION 8

@@ -813,8 +813,8 @@ typedef struct {
   uint16_t     UclkAverageLpfTau;
   uint16_t     GfxActivityLpfTau;
   uint16_t     UclkActivityLpfTau;
+  uint16_t     SocketPowerLpfTau;

-  uint16_t     Padding;
   // Padding - ignore
   uint32_t     MmHubPadding[8]; // SMU internal use
 } DriverSmuConfig_t;
@@ -853,7 +853,7 @@ typedef struct {
   uint8_t  CurrGfxVoltageOffset  ;
   uint8_t  CurrMemVidOffset      ;
   uint8_t  Padding8              ;
-  uint16_t CurrSocketPower       ;
+  uint16_t AverageSocketPower    ;
   uint16_t TemperatureEdge       ;
   uint16_t TemperatureHotspot    ;
   uint16_t TemperatureMem        ;
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c
index 99566de..373aeba 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -863,7 +863,7 @@ static int navi10_get_gpu_power(struct smu_context *smu=
, uint32_t *value)
         if (ret)
                 return ret;

-       *value =3D metrics.CurrSocketPower << 8;
+       *value =3D metrics.AverageSocketPower << 8;

         return 0;
 }
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MN2PR12MB29749635290092A031CB5A4C95FC0MN2PR12MB2974namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks&nbsp;Alex!</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Deucher, Alexander<br=
>
<b>Sent:</b> Thursday, June 27, 2019 23:38<br>
<b>To:</b> Yin, Tianci (Rico); amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Xiao, Jack; Zhang, Hawking<br>
<b>Subject:</b> Re: [PATCH] drm/amd/powerplay: update smu11_driver_if_navi1=
0.h</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Acked-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Tianci Yin &lt;tianci.yin@a=
md.com&gt;<br>
<b>Sent:</b> Thursday, June 27, 2019 2:49 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Xiao, Jack; Yin, Tianci (Rico); Zhang, Hawking<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: update smu11_driver_if_navi10.h<=
/font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">From: tiancyin &lt;tianci.yin-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
update the smu11_driver_if_navi10.h since navi10 smu fw<br>
update to 42.28<br>
<br>
Signed-off-by: tiancyin &lt;tianci.yin-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h | 6 &#43;&=
#43;&#43;---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/navi10_ppt.c&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 &=
#43;-<br>
&nbsp;2 files changed, 4 insertions(&#43;), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h b/d=
rivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h<br>
index a8b31bc..adbbfeb 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_navi10.=
h<br>
@@ -26,7 &#43;26,7 @@<br>
&nbsp;// *** IMPORTANT ***<br>
&nbsp;// SMU TEAM: Always increment the interface version if <br>
&nbsp;// any structure is changed in this file<br>
-#define SMU11_DRIVER_IF_VERSION 0x32<br>
&#43;#define SMU11_DRIVER_IF_VERSION 0x33<br>
&nbsp;<br>
&nbsp;#define PPTABLE_NV10_SMU_VERSION 8<br>
&nbsp;<br>
@@ -813,8 &#43;813,8 @@ typedef struct {<br>
&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp; UclkAverageLpfTau;<br>
&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp; GfxActivityLpfTau;<br>
&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp; UclkActivityLpfTau;<br>
&#43;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp; SocketPowerLpfTau;<br>
&nbsp;<br>
-&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp; Padding;&nbsp; <br>
&nbsp;&nbsp; // Padding - ignore<br>
&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp; MmHubPadding[8]; // SMU inter=
nal use<br>
&nbsp;} DriverSmuConfig_t;<br>
@@ -853,7 &#43;853,7 @@ typedef struct {<br>
&nbsp;&nbsp; uint8_t&nbsp; CurrGfxVoltageOffset&nbsp; ;<br>
&nbsp;&nbsp; uint8_t&nbsp; CurrMemVidOffset&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;=
<br>
&nbsp;&nbsp; uint8_t&nbsp; Padding8&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;<br>
-&nbsp; uint16_t CurrSocketPower&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;<br>
&#43;&nbsp; uint16_t AverageSocketPower&nbsp;&nbsp;&nbsp; ;<br>
&nbsp;&nbsp; uint16_t TemperatureEdge&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ;=
<br>
&nbsp;&nbsp; uint16_t TemperatureHotspot&nbsp;&nbsp;&nbsp; ;<br>
&nbsp;&nbsp; uint16_t TemperatureMem&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ;<br>
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/a=
md/powerplay/navi10_ppt.c<br>
index 99566de..373aeba 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c<br>
@@ -863,7 &#43;863,7 @@ static int navi10_get_gpu_power(struct smu_context =
*smu, uint32_t *value)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *value =3D metrics.CurrSocketPower &l=
t;&lt; 8;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *value =3D metrics.AverageSocketP=
ower &lt;&lt; 8;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB29749635290092A031CB5A4C95FC0MN2PR12MB2974namp_--

--===============0514965742==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0514965742==--
