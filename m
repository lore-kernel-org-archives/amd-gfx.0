From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Add NBIO SMN headers v2
Date: Wed, 9 Jan 2019 15:05:50 +0000
Message-ID: <BN6PR12MB180933A994DA3151BD165801F78B0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1547045026-27129-1-git-send-email-kent.russell@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0306201849=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1547045026-27129-1-git-send-email-kent.russell-5C7GfCeVMHo@public.gmane.org>
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
To: "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0306201849==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180933A994DA3151BD165801F78B0BN6PR12MB1809namp_"

--_000_BN6PR12MB180933A994DA3151BD165801F78B0BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Series is:

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Russell,=
 Kent <Kent.Russell-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, January 9, 2019 9:43:51 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Russell, Kent
Subject: [PATCH 1/2] drm/amdgpu: Add NBIO SMN headers v2

We need these offsets for PCIE perf counters, so include them as well as
the the previously-used defines from the nbio_*.c files

v2: Return NBIF definitions back to previous files

Signed-off-by: Kent Russell <kent.russell-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c             |  6 +--
 drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c             |  4 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c             |  5 +-
 .../drm/amd/include/asic_reg/nbio/nbio_6_1_smn.h   | 58 ++++++++++++++++++=
++++
 .../drm/amd/include/asic_reg/nbio/nbio_7_0_smn.h   | 54 ++++++++++++++++++=
++
 .../drm/amd/include/asic_reg/nbio/nbio_7_4_0_smn.h | 53 ++++++++++++++++++=
++
 6 files changed, 168 insertions(+), 12 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_6_1_smn.=
h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_0_smn.=
h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_4_0_sm=
n.h

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v6_1.c
index accdedd..1965756 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
@@ -27,13 +27,9 @@
 #include "nbio/nbio_6_1_default.h"
 #include "nbio/nbio_6_1_offset.h"
 #include "nbio/nbio_6_1_sh_mask.h"
+#include "nbio/nbio_6_1_smn.h"
 #include "vega10_enum.h"

-#define smnCPM_CONTROL                                                    =
                              0x11180460
-#define smnPCIE_CNTL2                                                     =
                              0x11180070
-#define smnPCIE_CONFIG_CNTL                                               =
                              0x11180044
-#define smnPCIE_CI_CNTL                                                   =
                              0x11180080
-
 static u32 nbio_v6_1_get_rev_id(struct amdgpu_device *adev)
 {
         u32 tmp =3D RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_STRAP0);
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_0.c
index df34dc7..38291c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c
@@ -27,13 +27,11 @@
 #include "nbio/nbio_7_0_default.h"
 #include "nbio/nbio_7_0_offset.h"
 #include "nbio/nbio_7_0_sh_mask.h"
+#include "nbio/nbio_7_0_smn.h"
 #include "vega10_enum.h"

 #define smnNBIF_MGCG_CTRL_LCLK  0x1013a05c

-#define smnCPM_CONTROL                                                    =
                              0x11180460
-#define smnPCIE_CNTL2                                                     =
                              0x11180070
-
 static u32 nbio_v7_0_get_rev_id(struct amdgpu_device *adev)
 {
         u32 tmp =3D RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_STRAP0);
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_4.c
index 4cd31a2..0a61309 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -26,13 +26,10 @@

 #include "nbio/nbio_7_4_offset.h"
 #include "nbio/nbio_7_4_sh_mask.h"
+#include "nbio/nbio_7_4_0_smn.h"

 #define smnNBIF_MGCG_CTRL_LCLK  0x1013a21c

-#define smnCPM_CONTROL                                                    =
                              0x11180460
-#define smnPCIE_CNTL2                                                     =
                              0x11180070
-#define smnPCIE_CI_CNTL                                                   =
                              0x11180080
-
 static u32 nbio_v7_4_get_rev_id(struct amdgpu_device *adev)
 {
     u32 tmp =3D RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_STRAP0);
diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_6_1_smn.h b/dri=
vers/gpu/drm/amd/include/asic_reg/nbio/nbio_6_1_smn.h
new file mode 100644
index 0000000..8c75669
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_6_1_smn.h
@@ -0,0 +1,58 @@
+/*
+ * Copyright (C) 2019  Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software=
"),
+ * to deal in the Software without restriction, including without limitati=
on
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABIL=
ITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHAL=
L
+ * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABI=
LITY, WHETHER IN
+ * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWA=
RE.
+ */
+
+#ifndef _nbio_6_1_SMN_HEADER
+#define _nbio_6_1_SMN_HEADER
+
+
+#define smnCPM_CONTROL                                 0x11180460
+#define smnPCIE_CNTL2                                  0x11180070
+#define smnPCIE_CONFIG_CNTL                            0x11180044
+#define smnPCIE_CI_CNTL                                        0x11180080
+
+
+#define smnPCIE_PERF_COUNT_CNTL                                0x11180200
+#define smnPCIE_PERF_CNTL_TXCLK                                0x11180204
+#define smnPCIE_PERF_COUNT0_TXCLK                      0x11180208
+#define smnPCIE_PERF_COUNT1_TXCLK                      0x1118020c
+#define smnPCIE_PERF_CNTL_MST_R_CLK                    0x11180210
+#define smnPCIE_PERF_COUNT0_MST_R_CLK                  0x11180214
+#define smnPCIE_PERF_COUNT1_MST_R_CLK                  0x11180218
+#define smnPCIE_PERF_CNTL_MST_C_CLK                    0x1118021c
+#define smnPCIE_PERF_COUNT0_MST_C_CLK                  0x11180220
+#define smnPCIE_PERF_COUNT1_MST_C_CLK                  0x11180224
+#define smnPCIE_PERF_CNTL_SLV_R_CLK                    0x11180228
+#define smnPCIE_PERF_COUNT0_SLV_R_CLK                  0x1118022c
+#define smnPCIE_PERF_COUNT1_SLV_R_CLK                  0x11180230
+#define smnPCIE_PERF_CNTL_SLV_S_C_CLK                  0x11180234
+#define smnPCIE_PERF_COUNT0_SLV_S_C_CLK                        0x11180238
+#define smnPCIE_PERF_COUNT1_SLV_S_C_CLK                        0x1118023c
+#define smnPCIE_PERF_CNTL_SLV_NS_C_CLK                 0x11180240
+#define smnPCIE_PERF_COUNT0_SLV_NS_C_CLK               0x11180244
+#define smnPCIE_PERF_COUNT1_SLV_NS_C_CLK               0x11180248
+#define smnPCIE_PERF_CNTL_EVENT0_PORT_SEL              0x1118024c
+#define smnPCIE_PERF_CNTL_EVENT1_PORT_SEL              0x11180250
+#define smnPCIE_PERF_CNTL_TXCLK2                       0x11180254
+#define smnPCIE_PERF_COUNT0_TXCLK2                     0x11180258
+#define smnPCIE_PERF_COUNT1_TXCLK2                     0x1118025c
+
+#endif // _nbio_6_1_SMN_HEADER
+
diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_0_smn.h b/dri=
vers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_0_smn.h
new file mode 100644
index 0000000..5563f07
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_0_smn.h
@@ -0,0 +1,54 @@
+/*
+ * Copyright (C) 2019  Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software=
"),
+ * to deal in the Software without restriction, including without limitati=
on
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABIL=
ITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHAL=
L
+ * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABI=
LITY, WHETHER IN
+ * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWA=
RE.
+ */
+
+#ifndef _nbio_7_0_SMN_HEADER
+#define _nbio_7_0_SMN_HEADER
+
+
+#define smnCPM_CONTROL                                 0x11180460
+#define smnPCIE_CNTL2                                  0x11180070
+
+#define smnPCIE_PERF_COUNT_CNTL                                0x11180200
+#define smnPCIE_PERF_CNTL_TXCLK                                0x11180204
+#define smnPCIE_PERF_COUNT0_TXCLK                      0x11180208
+#define smnPCIE_PERF_COUNT1_TXCLK                      0x1118020c
+#define smnPCIE_PERF_CNTL_MST_R_CLK                    0x11180210
+#define smnPCIE_PERF_COUNT0_MST_R_CLK                  0x11180214
+#define smnPCIE_PERF_COUNT1_MST_R_CLK                  0x11180218
+#define smnPCIE_PERF_CNTL_MST_C_CLK                    0x1118021c
+#define smnPCIE_PERF_COUNT0_MST_C_CLK                  0x11180220
+#define smnPCIE_PERF_COUNT1_MST_C_CLK                  0x11180224
+#define smnPCIE_PERF_CNTL_SLV_R_CLK                    0x11180228
+#define smnPCIE_PERF_COUNT0_SLV_R_CLK                  0x1118022c
+#define smnPCIE_PERF_COUNT1_SLV_R_CLK                  0x11180230
+#define smnPCIE_PERF_CNTL_SLV_S_C_CLK                  0x11180234
+#define smnPCIE_PERF_COUNT0_SLV_S_C_CLK                        0x11180238
+#define smnPCIE_PERF_COUNT1_SLV_S_C_CLK                        0x1118023c
+#define smnPCIE_PERF_CNTL_SLV_NS_C_CLK                 0x11180240
+#define smnPCIE_PERF_COUNT0_SLV_NS_C_CLK               0x11180244
+#define smnPCIE_PERF_COUNT1_SLV_NS_C_CLK               0x11180248
+#define smnPCIE_PERF_CNTL_EVENT0_PORT_SEL              0x1118024c
+#define smnPCIE_PERF_CNTL_EVENT1_PORT_SEL              0x11180250
+#define smnPCIE_PERF_CNTL_TXCLK2                       0x11180254
+#define smnPCIE_PERF_COUNT0_TXCLK2                     0x11180258
+#define smnPCIE_PERF_COUNT1_TXCLK2                     0x1118025c
+
+#endif // _nbio_7_0_SMN_HEADER
diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_4_0_smn.h b/d=
rivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_4_0_smn.h
new file mode 100644
index 0000000..c1457d8
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_4_0_smn.h
@@ -0,0 +1,53 @@
+/*
+ * Copyright (C) 2019  Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software=
"),
+ * to deal in the Software without restriction, including without limitati=
on
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense=
,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included
+ * in all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+ * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABIL=
ITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHAL=
L
+ * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABI=
LITY, WHETHER IN
+ * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWA=
RE.
+ */
+
+#ifndef _nbio_7_4_0_SMN_HEADER
+#define _nbio_7_4_0_SMN_HEADER
+
+
+#define smnNBIF_MGCG_CTRL_LCLK                         0x1013a21c
+#define smnCPM_CONTROL                                 0x11180460
+#define smnPCIE_CNTL2                                  0x11180070
+#define smnPCIE_CI_CNTL                                        0x11180080
+
+#define smnPCIE_PERF_COUNT_CNTL                                0x11180200
+#define smnPCIE_PERF_CNTL_TXCLK1                       0x11180204
+#define smnPCIE_PERF_COUNT0_TXCLK1                     0x11180208
+#define smnPCIE_PERF_COUNT1_TXCLK1                     0x1118020c
+#define smnPCIE_PERF_CNTL_TXCLK2                       0x11180210
+#define smnPCIE_PERF_COUNT0_TXCLK2                     0x11180214
+#define smnPCIE_PERF_COUNT1_TXCLK2                     0x11180218
+#define smnPCIE_PERF_CNTL_TXCLK3                       0x1118021c
+#define smnPCIE_PERF_COUNT0_TXCLK3                     0x11180220
+#define smnPCIE_PERF_COUNT1_TXCLK3                     0x11180224
+#define smnPCIE_PERF_CNTL_TXCLK4                       0x11180228
+#define smnPCIE_PERF_COUNT0_TXCLK4                     0x1118022c
+#define smnPCIE_PERF_COUNT1_TXCLK4                     0x11180230
+#define smnPCIE_PERF_CNTL_SCLK1                                0x11180234
+#define smnPCIE_PERF_COUNT0_SCLK1                      0x11180238
+#define smnPCIE_PERF_COUNT1_SCLK1                      0x1118023c
+#define smnPCIE_PERF_CNTL_SCLK2                                0x11180240
+#define smnPCIE_PERF_COUNT0_SCLK2                      0x11180244
+#define smnPCIE_PERF_COUNT1_SCLK2                      0x11180248
+#define smnPCIE_PERF_CNTL_EVENT_LC_PORT_SEL            0x1118024c
+#define smnPCIE_PERF_CNTL_EVENT_CI_PORT_SEL            0x11180250
+
+#endif // _nbio_7_4_0_SMN_HEADER
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives.. Using amd-gfx: To post a message to all the list members, send email=
 to amd-gfx-PD4FTy7X32lNgt0PjOBp9xlNPtJONSTn@public.gmane.org You can subscribe to the list, or change=
 your existing subscription, in the sections below.



--_000_BN6PR12MB180933A994DA3151BD165801F78B0BN6PR12MB1809namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size: 12pt; colo=
r: rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFo=
nt&quot;, &quot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoCo=
lorEmoji, &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymb=
ols;">
<p style=3D"margin-top:0; margin-bottom:0">Series is:</p>
<p style=3D"margin-top:0; margin-bottom:0">Reviewed-by: Alex Deucher &lt;al=
exander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Russell, Kent &lt;Kent.Russ=
ell-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, January 9, 2019 9:43:51 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Russell, Kent<br>
<b>Subject:</b> [PATCH 1/2] drm/amdgpu: Add NBIO SMN headers v2</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">We need these offsets for PCIE perf counters, so i=
nclude them as well as<br>
the the previously-used defines from the nbio_*.c files<br>
<br>
v2: Return NBIF definitions back to previous files<br>
<br>
Signed-off-by: Kent Russell &lt;kent.russell-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 6 &#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 4 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 5 &#43;-<br>
&nbsp;.../drm/amd/include/asic_reg/nbio/nbio_6_1_smn.h&nbsp;&nbsp; | 58 &#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;.../drm/amd/include/asic_reg/nbio/nbio_7_0_smn.h&nbsp;&nbsp; | 54 &#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;<br>
&nbsp;.../drm/amd/include/asic_reg/nbio/nbio_7_4_0_smn.h | 53 &#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;<br>
&nbsp;6 files changed, 168 insertions(&#43;), 12 deletions(-)<br>
&nbsp;create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_6_1=
_smn.h<br>
&nbsp;create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_0=
_smn.h<br>
&nbsp;create mode 100644 drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_4=
_0_smn.h<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v6_1.c<br>
index accdedd..1965756 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c<br>
@@ -27,13 &#43;27,9 @@<br>
&nbsp;#include &quot;nbio/nbio_6_1_default.h&quot;<br>
&nbsp;#include &quot;nbio/nbio_6_1_offset.h&quot;<br>
&nbsp;#include &quot;nbio/nbio_6_1_sh_mask.h&quot;<br>
&#43;#include &quot;nbio/nbio_6_1_smn.h&quot;<br>
&nbsp;#include &quot;vega10_enum.h&quot;<br>
&nbsp;<br>
-#define smnCPM_CONTROL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x11180460<br>
-#define smnPCIE_CNTL2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x11180070=
<br>
-#define smnPCIE_CONFIG_CNTL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x11180044<br>
-#define smnPCIE_CI_CNTL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x11180080<br>
-<br>
&nbsp;static u32 nbio_v6_1_get_rev_id(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp =3D RREG32_SOC15(N=
BIO, 0, mmRCC_DEV0_EPF0_STRAP0);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_0.c<br>
index df34dc7..38291c5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/nbio_v7_0.c<br>
@@ -27,13 &#43;27,11 @@<br>
&nbsp;#include &quot;nbio/nbio_7_0_default.h&quot;<br>
&nbsp;#include &quot;nbio/nbio_7_0_offset.h&quot;<br>
&nbsp;#include &quot;nbio/nbio_7_0_sh_mask.h&quot;<br>
&#43;#include &quot;nbio/nbio_7_0_smn.h&quot;<br>
&nbsp;#include &quot;vega10_enum.h&quot;<br>
&nbsp;<br>
&nbsp;#define smnNBIF_MGCG_CTRL_LCLK&nbsp; 0x1013a05c<br>
&nbsp;<br>
-#define smnCPM_CONTROL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x11180460<br>
-#define smnPCIE_CNTL2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x11180070=
<br>
-<br>
&nbsp;static u32 nbio_v7_0_get_rev_id(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp =3D RREG32_SOC15(N=
BIO, 0, mmRCC_DEV0_EPF0_STRAP0);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/a=
mdgpu/nbio_v7_4.c<br>
index 4cd31a2..0a61309 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c<br>
@@ -26,13 &#43;26,10 @@<br>
&nbsp;<br>
&nbsp;#include &quot;nbio/nbio_7_4_offset.h&quot;<br>
&nbsp;#include &quot;nbio/nbio_7_4_sh_mask.h&quot;<br>
&#43;#include &quot;nbio/nbio_7_4_0_smn.h&quot;<br>
&nbsp;<br>
&nbsp;#define smnNBIF_MGCG_CTRL_LCLK&nbsp; 0x1013a21c<br>
&nbsp;<br>
-#define smnCPM_CONTROL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x11180460<br>
-#define smnPCIE_CNTL2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x11180070=
<br>
-#define smnPCIE_CI_CNTL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x11180080<br>
-<br>
&nbsp;static u32 nbio_v7_4_get_rev_id(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp =3D RREG32_SOC15(NBIO, 0, mmRCC_DEV0_EPF0_=
STRAP0);<br>
diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_6_1_smn.h b/dri=
vers/gpu/drm/amd/include/asic_reg/nbio/nbio_6_1_smn.h<br>
new file mode 100644<br>
index 0000000..8c75669<br>
--- /dev/null<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_6_1_smn.h<=
br>
@@ -0,0 &#43;1,58 @@<br>
&#43;/*<br>
&#43; * Copyright (C) 2019&nbsp; Advanced Micro Devices, Inc.<br>
&#43; *<br>
&#43; * Permission is hereby granted, free of charge, to any person obtaini=
ng a<br>
&#43; * copy of this software and associated documentation files (the &quot=
;Software&quot;),<br>
&#43; * to deal in the Software without restriction, including without limi=
tation<br>
&#43; * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,<br>
&#43; * and/or sell copies of the Software, and to permit persons to whom t=
he<br>
&#43; * Software is furnished to do so, subject to the following conditions=
:<br>
&#43; *<br>
&#43; * The above copyright notice and this permission notice shall be incl=
uded<br>
&#43; * in all copies or substantial portions of the Software.<br>
&#43; *<br>
&#43; * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY=
 KIND, EXPRESS<br>
&#43; * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANT=
ABILITY,<br>
&#43; * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO E=
VENT SHALL<br>
&#43; * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER L=
IABILITY, WHETHER IN<br>
&#43; * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR I=
N<br>
&#43; * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SO=
FTWARE.<br>
&#43; */<br>
&#43;<br>
&#43;#ifndef _nbio_6_1_SMN_HEADER<br>
&#43;#define _nbio_6_1_SMN_HEADER<br>
&#43;<br>
&#43;<br>
&#43;#define smnCPM_CONTROL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x111=
80460<br>
&#43;#define smnPCIE_CNTL2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x11180070<br>
&#43;#define smnPCIE_CONFIG_CNTL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x11180044<br>
&#43;#define smnPCIE_CI_CNTL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x11180080<br>
&#43;<br>
&#43;<br>
&#43;#define smnPCIE_PERF_COUNT_CNTL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x=
11180200<br>
&#43;#define smnPCIE_PERF_CNTL_TXCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x=
11180204<br>
&#43;#define smnPCIE_PERF_COUNT0_TXCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0x11180208<br>
&#43;#define smnPCIE_PERF_COUNT1_TXCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0x1118020c<br>
&#43;#define smnPCIE_PERF_CNTL_MST_R_CLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0x11180210<br>
&#43;#define smnPCIE_PERF_COUNT0_MST_R_CLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x111=
80214<br>
&#43;#define smnPCIE_PERF_COUNT1_MST_R_CLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x111=
80218<br>
&#43;#define smnPCIE_PERF_CNTL_MST_C_CLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0x1118021c<br>
&#43;#define smnPCIE_PERF_COUNT0_MST_C_CLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x111=
80220<br>
&#43;#define smnPCIE_PERF_COUNT1_MST_C_CLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x111=
80224<br>
&#43;#define smnPCIE_PERF_CNTL_SLV_R_CLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0x11180228<br>
&#43;#define smnPCIE_PERF_COUNT0_SLV_R_CLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x111=
8022c<br>
&#43;#define smnPCIE_PERF_COUNT1_SLV_R_CLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x111=
80230<br>
&#43;#define smnPCIE_PERF_CNTL_SLV_S_C_CLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x111=
80234<br>
&#43;#define smnPCIE_PERF_COUNT0_SLV_S_C_CLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x11180238<br>
&#43;#define smnPCIE_PERF_COUNT1_SLV_S_C_CLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1118023c<br>
&#43;#define smnPCIE_PERF_CNTL_SLV_NS_C_CLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x11180240=
<br>
&#43;#define smnPCIE_PERF_COUNT0_SLV_NS_C_CLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x11180244<br>
&#43;#define smnPCIE_PERF_COUNT1_SLV_NS_C_CLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x11180248<br>
&#43;#define smnPCIE_PERF_CNTL_EVENT0_PORT_SEL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1118024c<br>
&#43;#define smnPCIE_PERF_CNTL_EVENT1_PORT_SEL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x11180250<br>
&#43;#define smnPCIE_PERF_CNTL_TXCLK2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0x11180254<br>
&#43;#define smnPCIE_PERF_COUNT0_TXCLK2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x11180258<br>
&#43;#define smnPCIE_PERF_COUNT1_TXCLK2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x1118025c<br>
&#43;<br>
&#43;#endif // _nbio_6_1_SMN_HEADER<br>
&#43;<br>
diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_0_smn.h b/dri=
vers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_0_smn.h<br>
new file mode 100644<br>
index 0000000..5563f07<br>
--- /dev/null<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_0_smn.h<=
br>
@@ -0,0 &#43;1,54 @@<br>
&#43;/*<br>
&#43; * Copyright (C) 2019&nbsp; Advanced Micro Devices, Inc.<br>
&#43; *<br>
&#43; * Permission is hereby granted, free of charge, to any person obtaini=
ng a<br>
&#43; * copy of this software and associated documentation files (the &quot=
;Software&quot;),<br>
&#43; * to deal in the Software without restriction, including without limi=
tation<br>
&#43; * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,<br>
&#43; * and/or sell copies of the Software, and to permit persons to whom t=
he<br>
&#43; * Software is furnished to do so, subject to the following conditions=
:<br>
&#43; *<br>
&#43; * The above copyright notice and this permission notice shall be incl=
uded<br>
&#43; * in all copies or substantial portions of the Software.<br>
&#43; *<br>
&#43; * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY=
 KIND, EXPRESS<br>
&#43; * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANT=
ABILITY,<br>
&#43; * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO E=
VENT SHALL<br>
&#43; * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER L=
IABILITY, WHETHER IN<br>
&#43; * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR I=
N<br>
&#43; * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SO=
FTWARE.<br>
&#43; */<br>
&#43;<br>
&#43;#ifndef _nbio_7_0_SMN_HEADER<br>
&#43;#define _nbio_7_0_SMN_HEADER<br>
&#43;<br>
&#43;<br>
&#43;#define smnCPM_CONTROL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x111=
80460<br>
&#43;#define smnPCIE_CNTL2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x11180070<br>
&#43;<br>
&#43;#define smnPCIE_PERF_COUNT_CNTL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x=
11180200<br>
&#43;#define smnPCIE_PERF_CNTL_TXCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x=
11180204<br>
&#43;#define smnPCIE_PERF_COUNT0_TXCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0x11180208<br>
&#43;#define smnPCIE_PERF_COUNT1_TXCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0x1118020c<br>
&#43;#define smnPCIE_PERF_CNTL_MST_R_CLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0x11180210<br>
&#43;#define smnPCIE_PERF_COUNT0_MST_R_CLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x111=
80214<br>
&#43;#define smnPCIE_PERF_COUNT1_MST_R_CLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x111=
80218<br>
&#43;#define smnPCIE_PERF_CNTL_MST_C_CLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0x1118021c<br>
&#43;#define smnPCIE_PERF_COUNT0_MST_C_CLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x111=
80220<br>
&#43;#define smnPCIE_PERF_COUNT1_MST_C_CLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x111=
80224<br>
&#43;#define smnPCIE_PERF_CNTL_SLV_R_CLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 0x11180228<br>
&#43;#define smnPCIE_PERF_COUNT0_SLV_R_CLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x111=
8022c<br>
&#43;#define smnPCIE_PERF_COUNT1_SLV_R_CLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x111=
80230<br>
&#43;#define smnPCIE_PERF_CNTL_SLV_S_C_CLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x111=
80234<br>
&#43;#define smnPCIE_PERF_COUNT0_SLV_S_C_CLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x11180238<br>
&#43;#define smnPCIE_PERF_COUNT1_SLV_S_C_CLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1118023c<br>
&#43;#define smnPCIE_PERF_CNTL_SLV_NS_C_CLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x11180240=
<br>
&#43;#define smnPCIE_PERF_COUNT0_SLV_NS_C_CLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x11180244<br>
&#43;#define smnPCIE_PERF_COUNT1_SLV_NS_C_CLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x11180248<br>
&#43;#define smnPCIE_PERF_CNTL_EVENT0_PORT_SEL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1118024c<br>
&#43;#define smnPCIE_PERF_CNTL_EVENT1_PORT_SEL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x11180250<br>
&#43;#define smnPCIE_PERF_CNTL_TXCLK2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0x11180254<br>
&#43;#define smnPCIE_PERF_COUNT0_TXCLK2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x11180258<br>
&#43;#define smnPCIE_PERF_COUNT1_TXCLK2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x1118025c<br>
&#43;<br>
&#43;#endif // _nbio_7_0_SMN_HEADER<br>
diff --git a/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_4_0_smn.h b/d=
rivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_4_0_smn.h<br>
new file mode 100644<br>
index 0000000..c1457d8<br>
--- /dev/null<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/include/asic_reg/nbio/nbio_7_4_0_smn.=
h<br>
@@ -0,0 &#43;1,53 @@<br>
&#43;/*<br>
&#43; * Copyright (C) 2019&nbsp; Advanced Micro Devices, Inc.<br>
&#43; *<br>
&#43; * Permission is hereby granted, free of charge, to any person obtaini=
ng a<br>
&#43; * copy of this software and associated documentation files (the &quot=
;Software&quot;),<br>
&#43; * to deal in the Software without restriction, including without limi=
tation<br>
&#43; * the rights to use, copy, modify, merge, publish, distribute, sublic=
ense,<br>
&#43; * and/or sell copies of the Software, and to permit persons to whom t=
he<br>
&#43; * Software is furnished to do so, subject to the following conditions=
:<br>
&#43; *<br>
&#43; * The above copyright notice and this permission notice shall be incl=
uded<br>
&#43; * in all copies or substantial portions of the Software.<br>
&#43; *<br>
&#43; * THE SOFTWARE IS PROVIDED &quot;AS IS&quot;, WITHOUT WARRANTY OF ANY=
 KIND, EXPRESS<br>
&#43; * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANT=
ABILITY,<br>
&#43; * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.&nbsp; IN NO E=
VENT SHALL<br>
&#43; * THE COPYRIGHT HOLDER(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER L=
IABILITY, WHETHER IN<br>
&#43; * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR I=
N<br>
&#43; * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SO=
FTWARE.<br>
&#43; */<br>
&#43;<br>
&#43;#ifndef _nbio_7_4_0_SMN_HEADER<br>
&#43;#define _nbio_7_4_0_SMN_HEADER<br>
&#43;<br>
&#43;<br>
&#43;#define smnNBIF_MGCG_CTRL_LCLK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1013a21c<br>
&#43;#define smnCPM_CONTROL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x111=
80460<br>
&#43;#define smnPCIE_CNTL2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
0x11180070<br>
&#43;#define smnPCIE_CI_CNTL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x11180080<br>
&#43;<br>
&#43;#define smnPCIE_PERF_COUNT_CNTL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x=
11180200<br>
&#43;#define smnPCIE_PERF_CNTL_TXCLK1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0x11180204<br>
&#43;#define smnPCIE_PERF_COUNT0_TXCLK1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x11180208<br>
&#43;#define smnPCIE_PERF_COUNT1_TXCLK1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x1118020c<br>
&#43;#define smnPCIE_PERF_CNTL_TXCLK2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0x11180210<br>
&#43;#define smnPCIE_PERF_COUNT0_TXCLK2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x11180214<br>
&#43;#define smnPCIE_PERF_COUNT1_TXCLK2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x11180218<br>
&#43;#define smnPCIE_PERF_CNTL_TXCLK3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0x1118021c<br>
&#43;#define smnPCIE_PERF_COUNT0_TXCLK3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x11180220<br>
&#43;#define smnPCIE_PERF_COUNT1_TXCLK3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x11180224<br>
&#43;#define smnPCIE_PERF_CNTL_TXCLK4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; 0x11180228<br>
&#43;#define smnPCIE_PERF_COUNT0_TXCLK4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x1118022c<br>
&#43;#define smnPCIE_PERF_COUNT1_TXCLK4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; 0x11180230<br>
&#43;#define smnPCIE_PERF_CNTL_SCLK1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x=
11180234<br>
&#43;#define smnPCIE_PERF_COUNT0_SCLK1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0x11180238<br>
&#43;#define smnPCIE_PERF_COUNT1_SCLK1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0x1118023c<br>
&#43;#define smnPCIE_PERF_CNTL_SCLK2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x=
11180240<br>
&#43;#define smnPCIE_PERF_COUNT0_SCLK2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0x11180244<br>
&#43;#define smnPCIE_PERF_COUNT1_SCLK2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; 0x11180248<br>
&#43;#define smnPCIE_PERF_CNTL_EVENT_LC_PORT_SEL&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1118024c<br>
&#43;#define smnPCIE_PERF_CNTL_EVENT_CI_PORT_SEL&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x11180250<br>
&#43;<br>
&#43;#endif // _nbio_7_4_0_SMN_HEADER<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk94473" class=3D"OWAAutoLink" previewremoved=3D"true">https://lists.freed=
esktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15470463481940.457219419930201" style=3D"margin-bott=
om: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15470463481900.990987111723645" style=3D"width: 90=
%; background-color: rgb(255, 255, 255); position: relative; overflow: auto=
; padding-top: 20px; padding-bottom: 20px; margin-top: 20px; border-top: 1p=
x dotted rgb(200, 200, 200); border-bottom: 1px dotted rgb(200, 200, 200);"=
 role=3D"presentation" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing: 0px;" valign=3D"top">
<td id=3D"TextCell_15470463481910.7071543803411071" style=3D"vertical-align=
: top; position: relative; padding: 0px; display: table-cell;" colspan=3D"2=
">
<div id=3D"LPRemovePreviewContainer_15470463481920.3706927522531692"></div>
<div id=3D"LPTitle_15470463481920.4898902007569307" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: 400; font-size: 21px; font-family: &quot;=
wf_segoe-ui_light&quot;, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&q=
uot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif=
; line-height: 21px;">
<a id=3D"LPUrlAnchor_15470463481920.9458157574087794" style=3D"text-decorat=
ion: none;" href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
 target=3D"_blank">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15470463481930.8534761720978721" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot=
;wf_segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Taho=
ma, Arial, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15470463481940.26266687672424405" style=3D"display=
: block; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot;wf=
_segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma,=
 Arial, sans-serif; font-size: 14px; line-height: 20px; max-height: 100px; =
overflow: hidden;">
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives.. Using amd-gfx: To post a message to all the list members, send email=
 to amd-gfx-PD4FTy7X32lNgt0PjOBp9xlNPtJONSTn@public.gmane.org You can subscribe to the list, or change=
 your existing subscription, in
 the sections below.</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BN6PR12MB180933A994DA3151BD165801F78B0BN6PR12MB1809namp_--

--===============0306201849==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0306201849==--
