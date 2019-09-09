From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amd/powerplay: update smu11_driver_if_arcturus.h
Date: Mon, 9 Sep 2019 13:17:40 +0000
Message-ID: <MN2PR12MB329671D3DA7398FB0610418CA2B70@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20190909113311.28497-1-evan.quan@amd.com>,
 <20190909113311.28497-2-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0371146703=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190909113311.28497-2-evan.quan-5C7GfCeVMHo@public.gmane.org>
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
To: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Li, Candice" <Candice.Li-5C7GfCeVMHo@public.gmane.org>, "Gui, Jack" <Jack.Gui-5C7GfCeVMHo@public.gmane.org>

--===============0371146703==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB329671D3DA7398FB0610418CA2B70MN2PR12MB3296namp_"

--_000_MN2PR12MB329671D3DA7398FB0610418CA2B70MN2PR12MB3296namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Quan, Ev=
an <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, September 9, 2019 7:33 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Li, Candice <Candice.Li-5C7GfCeVMHo@public.gmane.org>; Gui, Jack <Jack.Gui-5C7GfCeVMHo@public.gmane.org>; Quan, E=
van <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/2] drm/amd/powerplay: update smu11_driver_if_arcturus.h

Also bump the SMU11_DRIVER_IF_VERSION_ARCT.

Change-Id: I786047d93bf4e1f0905069e2c742479740778fe6
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
---
 .../gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h    | 6 +++++-
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h               | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h b=
/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
index e02950b505fa..40a51a141336 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
@@ -696,7 +696,11 @@ typedef struct {
   uint8_t      GpioI2cSda;          // Serial Data
   uint16_t     GpioPadding;

-  uint32_t     BoardReserved[9];
+  // Platform input telemetry voltage coefficient
+  uint32_t     BoardVoltageCoeffA;    // decode by /1000
+  uint32_t     BoardVoltageCoeffB;    // decode by /1000
+
+  uint32_t     BoardReserved[7];

   // Padding for MMHUB - do not modify this
   uint32_t     MmHubPadding[8]; // SMU internal use
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/dr=
m/amd/powerplay/inc/smu_v11_0.h
index b1e370e19d22..3b9e3a277ded 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -27,7 +27,7 @@

 #define SMU11_DRIVER_IF_VERSION_INV 0xFFFFFFFF
 #define SMU11_DRIVER_IF_VERSION_VG20 0x13
-#define SMU11_DRIVER_IF_VERSION_ARCT 0x09
+#define SMU11_DRIVER_IF_VERSION_ARCT 0x0A
 #define SMU11_DRIVER_IF_VERSION_NV10 0x33
 #define SMU11_DRIVER_IF_VERSION_NV12 0x33
 #define SMU11_DRIVER_IF_VERSION_NV14 0x34
--
2.23.0

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MN2PR12MB329671D3DA7398FB0610418CA2B70MN2PR12MB3296namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div id=3D"appendonsend" style=3D"font-family: Calibri, Arial, Helvetica, s=
ans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Reviewed-by: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt;</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Quan, Evan &lt;Evan.Quan@amd.=
com&gt;<br>
<b>Sent:</b> Monday, September 9, 2019 7:33 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> Li, Candice &lt;Candice.Li-5C7GfCeVMHo@public.gmane.org&gt;; Gui, Jack &lt;Jack.Gui@a=
md.com&gt;; Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amd/powerplay: update smu11_driver_if_arctu=
rus.h</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Also bump the SMU11_DRIVER_IF_VERSION_ARCT.<br>
<br>
Change-Id: I786047d93bf4e1f0905069e2c742479740778fe6<br>
Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h&nbsp;&nbsp;&=
nbsp; | 6 &#43;&#43;&#43;&#43;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 &#43;-<br>
&nbsp;2 files changed, 6 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h b=
/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h<br>
index e02950b505fa..40a51a141336 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturu=
s.h<br>
@@ -696,7 &#43;696,11 @@ typedef struct {<br>
&nbsp;&nbsp; uint8_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GpioI2cSda;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Serial Data<br>
&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp; GpioPadding;<br>
&nbsp;<br>
-&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp; BoardReserved[9];<br>
&#43;&nbsp; // Platform input telemetry voltage coefficient<br>
&#43;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp; BoardVoltageCoeffA;&nbsp;&nbsp=
;&nbsp; // decode by /1000<br>
&#43;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp; BoardVoltageCoeffB;&nbsp;&nbsp=
;&nbsp; // decode by /1000<br>
&#43;<br>
&#43;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp; BoardReserved[7];<br>
&nbsp;<br>
&nbsp;&nbsp; // Padding for MMHUB - do not modify this<br>
&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp; MmHubPadding[8]; // SMU inter=
nal use<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/dr=
m/amd/powerplay/inc/smu_v11_0.h<br>
index b1e370e19d22..3b9e3a277ded 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h<br>
@@ -27,7 &#43;27,7 @@<br>
&nbsp;<br>
&nbsp;#define SMU11_DRIVER_IF_VERSION_INV 0xFFFFFFFF<br>
&nbsp;#define SMU11_DRIVER_IF_VERSION_VG20 0x13<br>
-#define SMU11_DRIVER_IF_VERSION_ARCT 0x09<br>
&#43;#define SMU11_DRIVER_IF_VERSION_ARCT 0x0A<br>
&nbsp;#define SMU11_DRIVER_IF_VERSION_NV10 0x33<br>
&nbsp;#define SMU11_DRIVER_IF_VERSION_NV12 0x33<br>
&nbsp;#define SMU11_DRIVER_IF_VERSION_NV14 0x34<br>
-- <br>
2.23.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB329671D3DA7398FB0610418CA2B70MN2PR12MB3296namp_--

--===============0371146703==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0371146703==--
