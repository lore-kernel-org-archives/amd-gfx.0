From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/4] drm/amd/powerplay: update Arcturus smc fw and driver
 interface header
Date: Fri, 16 Aug 2019 06:50:58 +0000
Message-ID: <MN2PR12MB329670F40D0517DF8A983D29A2AF0@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20190816060807.11922-1-evan.quan@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2021937462=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190816060807.11922-1-evan.quan-5C7GfCeVMHo@public.gmane.org>
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

--===============2021937462==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB329670F40D0517DF8A983D29A2AF0MN2PR12MB3296namp_"

--_000_MN2PR12MB329670F40D0517DF8A983D29A2AF0MN2PR12MB3296namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Evan Qua=
n <evan.quan-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, August 16, 2019 2:08 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 1/4] drm/amd/powerplay: update Arcturus smc fw and driver i=
nterface header

Update smc fw and driver interface header.

Change-Id: If4ac09c41b1309f746b757f78880fffb491d50f8
Signed-off-by: Evan Quan <evan.quan-5C7GfCeVMHo@public.gmane.org>
---
 .../powerplay/inc/smu11_driver_if_arcturus.h    | 17 +++++++++++------
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h   |  2 +-
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h b=
/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
index b99e98c40720..e02950b505fa 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h
@@ -27,7 +27,7 @@
 // *** IMPORTANT ***
 // SMU TEAM: Always increment the interface version if
 // any structure is changed in this file
-//#define SMU11_DRIVER_IF_VERSION 0x08
+//#define SMU11_DRIVER_IF_VERSION 0x09

 #define PPTABLE_ARCTURUS_SMU_VERSION 4

@@ -691,7 +691,12 @@ typedef struct {
   uint16_t          XgmiFclkFreq    [NUM_XGMI_PSTATE_LEVELS];
   uint16_t          XgmiSocVoltage  [NUM_XGMI_PSTATE_LEVELS];

-  uint32_t     BoardReserved[10];
+  // GPIO pins for I2C communications with 2nd controller for Input Teleme=
try Sequence
+  uint8_t      GpioI2cScl;          // Serial Clock
+  uint8_t      GpioI2cSda;          // Serial Data
+  uint16_t     GpioPadding;
+
+  uint32_t     BoardReserved[9];

   // Padding for MMHUB - do not modify this
   uint32_t     MmHubPadding[8]; // SMU internal use
@@ -738,7 +743,7 @@ typedef struct {
   uint32_t Padding[4];

   // Padding - ignore
-  uint32_t     MmHubPadding[7]; // SMU internal use
+  uint32_t     MmHubPadding[8]; // SMU internal use
 } SmuMetrics_t;


@@ -748,7 +753,7 @@ typedef struct {
   float    avgPsmVoltage[75];
   float    minPsmVoltage[75];

-  uint32_t MmHubPadding[3]; // SMU internal use
+  uint32_t MmHubPadding[8]; // SMU internal use
 } AvfsDebugTable_t;

 typedef struct {
@@ -797,9 +802,9 @@ typedef struct {

   uint32_t P2VCharzFreq[AVFS_VOLTAGE_COUNT]; // in 10KHz units

-  uint32_t EnabledAvfsModules;
+  uint32_t EnabledAvfsModules[2];

-  uint32_t MmHubPadding[7]; // SMU internal use
+  uint32_t MmHubPadding[8]; // SMU internal use
 } AvfsFuseOverride_t;

 /* NOT CURRENTLY USED
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/dr=
m/amd/powerplay/inc/smu_v11_0.h
index 5fbf082be091..0a22fa48ff5a 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -27,7 +27,7 @@

 #define SMU11_DRIVER_IF_VERSION_INV 0xFFFFFFFF
 #define SMU11_DRIVER_IF_VERSION_VG20 0x13
-#define SMU11_DRIVER_IF_VERSION_ARCT 0x08
+#define SMU11_DRIVER_IF_VERSION_ARCT 0x09
 #define SMU11_DRIVER_IF_VERSION_NV10 0x33
 #define SMU11_DRIVER_IF_VERSION_NV12 0x33
 #define SMU11_DRIVER_IF_VERSION_NV14 0x33
--
2.22.0

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_MN2PR12MB329670F40D0517DF8A983D29A2AF0MN2PR12MB3296namp_
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
Reviewed-by: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org&gt;</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Best Regards,<br>
Kevin</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Evan Quan &lt;evan.quan@amd.c=
om&gt;<br>
<b>Sent:</b> Friday, August 16, 2019 2:08 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH 1/4] drm/amd/powerplay: update Arcturus smc fw and d=
river interface header</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Update smc fw and driver interface header.<br>
<br>
Change-Id: If4ac09c41b1309f746b757f78880fffb491d50f8<br>
Signed-off-by: Evan Quan &lt;evan.quan-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;.../powerplay/inc/smu11_driver_if_arcturus.h&nbsp;&nbsp;&nbsp; | 17 &=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;------<br>
&nbsp;drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h&nbsp;&nbsp; |&nbsp; 2 &=
#43;-<br>
&nbsp;2 files changed, 12 insertions(&#43;), 7 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h b=
/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h<br>
index b99e98c40720..e02950b505fa 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturus.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/smu11_driver_if_arcturu=
s.h<br>
@@ -27,7 &#43;27,7 @@<br>
&nbsp;// *** IMPORTANT ***<br>
&nbsp;// SMU TEAM: Always increment the interface version if<br>
&nbsp;// any structure is changed in this file<br>
-//#define SMU11_DRIVER_IF_VERSION 0x08<br>
&#43;//#define SMU11_DRIVER_IF_VERSION 0x09<br>
&nbsp;<br>
&nbsp;#define PPTABLE_ARCTURUS_SMU_VERSION 4<br>
&nbsp;<br>
@@ -691,7 &#43;691,12 @@ typedef struct {<br>
&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 XgmiFclkFreq&nbsp;&nbsp;&nbsp; [NUM_XGMI_PSTATE_LEVELS];<br>
&nbsp;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 XgmiSocVoltage&nbsp; [NUM_XGMI_PSTATE_LEVELS];<br>
&nbsp;<br>
-&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp; BoardReserved[10];<br>
&#43;&nbsp; // GPIO pins for I2C communications with 2nd controller for Inp=
ut Telemetry Sequence<br>
&#43;&nbsp; uint8_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GpioI2cScl;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Serial Clock<br>
&#43;&nbsp; uint8_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; GpioI2cSda;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Serial Data<br>
&#43;&nbsp; uint16_t&nbsp;&nbsp;&nbsp;&nbsp; GpioPadding;<br>
&#43;<br>
&#43;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp; BoardReserved[9];<br>
&nbsp;<br>
&nbsp;&nbsp; // Padding for MMHUB - do not modify this<br>
&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp; MmHubPadding[8]; // SMU inter=
nal use<br>
@@ -738,7 &#43;743,7 @@ typedef struct {<br>
&nbsp;&nbsp; uint32_t Padding[4];<br>
&nbsp;<br>
&nbsp;&nbsp; // Padding - ignore<br>
-&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp; MmHubPadding[7]; // SMU internal u=
se<br>
&#43;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&nbsp; MmHubPadding[8]; // SMU intern=
al use<br>
&nbsp;} SmuMetrics_t;<br>
&nbsp;<br>
&nbsp;<br>
@@ -748,7 &#43;753,7 @@ typedef struct {<br>
&nbsp;&nbsp; float&nbsp;&nbsp;&nbsp; avgPsmVoltage[75];<br>
&nbsp;&nbsp; float&nbsp;&nbsp;&nbsp; minPsmVoltage[75];<br>
&nbsp;<br>
-&nbsp; uint32_t MmHubPadding[3]; // SMU internal use<br>
&#43;&nbsp; uint32_t MmHubPadding[8]; // SMU internal use<br>
&nbsp;} AvfsDebugTable_t;<br>
&nbsp;<br>
&nbsp;typedef struct {<br>
@@ -797,9 &#43;802,9 @@ typedef struct {<br>
&nbsp;<br>
&nbsp;&nbsp; uint32_t P2VCharzFreq[AVFS_VOLTAGE_COUNT]; // in 10KHz units<b=
r>
&nbsp;<br>
-&nbsp; uint32_t EnabledAvfsModules;<br>
&#43;&nbsp; uint32_t EnabledAvfsModules[2];<br>
&nbsp;<br>
-&nbsp; uint32_t MmHubPadding[7]; // SMU internal use<br>
&#43;&nbsp; uint32_t MmHubPadding[8]; // SMU internal use<br>
&nbsp;} AvfsFuseOverride_t;<br>
&nbsp;<br>
&nbsp;/* NOT CURRENTLY USED<br>
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/dr=
m/amd/powerplay/inc/smu_v11_0.h<br>
index 5fbf082be091..0a22fa48ff5a 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h<br>
@@ -27,7 &#43;27,7 @@<br>
&nbsp;<br>
&nbsp;#define SMU11_DRIVER_IF_VERSION_INV 0xFFFFFFFF<br>
&nbsp;#define SMU11_DRIVER_IF_VERSION_VG20 0x13<br>
-#define SMU11_DRIVER_IF_VERSION_ARCT 0x08<br>
&#43;#define SMU11_DRIVER_IF_VERSION_ARCT 0x09<br>
&nbsp;#define SMU11_DRIVER_IF_VERSION_NV10 0x33<br>
&nbsp;#define SMU11_DRIVER_IF_VERSION_NV12 0x33<br>
&nbsp;#define SMU11_DRIVER_IF_VERSION_NV14 0x33<br>
-- <br>
2.22.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB329670F40D0517DF8A983D29A2AF0MN2PR12MB3296namp_--

--===============2021937462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============2021937462==--
