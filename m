From: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 1/2] drm/amdgpu: Add NBIO SMN headers v2
Date: Wed, 9 Jan 2019 15:11:30 +0000
Message-ID: <DM5PR12MB1707AB8CEDD9303F68EFDE12928B0@DM5PR12MB1707.namprd12.prod.outlook.com>
References: <1547045026-27129-1-git-send-email-kent.russell@amd.com>
 <BN6PR12MB180933A994DA3151BD165801F78B0@BN6PR12MB1809.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0954210462=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB180933A994DA3151BD165801F78B0-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Russell, Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0954210462==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1707AB8CEDD9303F68EFDE12928B0DM5PR12MB1707namp_"

--_000_DM5PR12MB1707AB8CEDD9303F68EFDE12928B0DM5PR12MB1707namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The series is reviewed by me too.

Reviewed-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>

From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of Deucher,=
 Alexander
Sent: Wednesday, January 09, 2019 10:06 AM
To: Russell, Kent <Kent.Russell-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 1/2] drm/amdgpu: Add NBIO SMN headers v2


Series is:

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org<mailto:alexander.deuch=
er-5C7GfCeVMHo@public.gmane.org>>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Russell, Kent <Kent.Russell-5C7GfCeVMHo@public.gmane.org<m=
ailto:Kent.Russell-5C7GfCeVMHo@public.gmane.org>>
Sent: Wednesday, January 9, 2019 9:43:51 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Russell, Kent
Subject: [PATCH 1/2] drm/amdgpu: Add NBIO SMN headers v2

We need these offsets for PCIE perf counters, so include them as well as
the the previously-used defines from the nbio_*.c files

v2: Return NBIF definitions back to previous files

Signed-off-by: Kent Russell <kent.russell-5C7GfCeVMHo@public.gmane.org<mailto:kent.russell@amd.c=
om>>
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
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives.. Using amd-gfx: To post a message to all the list members, send email=
 to amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>. Yo=
u can subscribe to the list, or change your existing subscription, in the s=
ections below.



--_000_DM5PR12MB1707AB8CEDD9303F68EFDE12928B0DM5PR12MB1707namp_
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
@font-face
	{font-family:"Segoe UI Light";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
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
span.EmailStyle18
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
<p class=3D"MsoNormal">The series is reviewed by me too.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Reviewed-by: Felix Kuehling &lt;Felix.Kuehling@amd.c=
om&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32mMSPqsTGOZug@public.gmane.org=
esktop.org&gt;
<b>On Behalf Of </b>Deucher, Alexander<br>
<b>Sent:</b> Wednesday, January 09, 2019 10:06 AM<br>
<b>To:</b> Russell, Kent &lt;Kent.Russell-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: Add NBIO SMN headers v2<o:p></o=
:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div id=3D"divtagdefaultwrapper">
<div id=3D"divtagdefaultwrapper">
<p><span style=3D"font-size:12.0pt;color:black">Series is:<o:p></o:p></span=
></p>
<p><span style=3D"font-size:12.0pt;color:black">Reviewed-by: Alex Deucher &=
lt;</span><a href=3D"mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org"><span style=3D"font-=
size:12.0pt">alexander.deucher-5C7GfCeVMHo@public.gmane.org</span></a><span style=3D"font-size:1=
2.0pt;color:black">&gt;<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center"><span=
 style=3D"font-size:12.0pt;color:black">
<hr size=3D"2" width=3D"98%" align=3D"center">
</span></div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;</span><a href=3D"mailto:amd-gfx-bounce=
s@lists.freedesktop.org">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><span sty=
le=3D"color:black">&gt; on behalf of Russell, Kent
 &lt;</span><a href=3D"mailto:Kent.Russell-5C7GfCeVMHo@public.gmane.org">Kent.Russell-5C7GfCeVMHo@public.gmane.org</a=
><span style=3D"color:black">&gt;<br>
<b>Sent:</b> Wednesday, January 9, 2019 9:43:51 AM<br>
<b>To:</b> </span><a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@=
lists.freedesktop.org</a><span style=3D"color:black"><br>
<b>Cc:</b> Russell, Kent<br>
<b>Subject:</b> [PATCH 1/2] drm/amdgpu: Add NBIO SMN headers v2</span><span=
 style=3D"font-size:12.0pt;color:black">
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;<=
o:p></o:p></span></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">We need these offsets fo=
r PCIE perf counters, so include them as well as<br>
the the previously-used defines from the nbio_*.c files<br>
<br>
v2: Return NBIF definitions back to previous files<br>
<br>
Signed-off-by: Kent Russell &lt;</span><a href=3D"mailto:kent.russell@amd.c=
om">kent.russell-5C7GfCeVMHo@public.gmane.org</a><span style=3D"color:black">&gt;<br>
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
</span><a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32mMSPqsTGOZug@public.gmane.org=
esktop.org</a><span style=3D"color:black"><br>
</span><a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">h=
ttps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><span style=3D"col=
or:black">
<o:p></o:p></span></p>
<div style=3D"margin-bottom:15.0pt;overflow:auto" id=3D"LPBorder_GT_1547046=
3481940.457219419930201">
<table class=3D"MsoNormalTable" border=3D"1" cellspacing=3D"0" cellpadding=
=3D"0" width=3D"90%" style=3D"width:90.0%;background:white;border-top:dotte=
d #C8C8C8 1.0pt;border-left:none;border-bottom:dotted #C8C8C8 1.0pt;border-=
right:none">
<tbody>
<tr>
<td valign=3D"top" style=3D"border:none;padding:0in 0in 0in 0in">
<div id=3D"LPTitle_15470463481920.4898902007569307">
<p class=3D"MsoNormal" style=3D"margin-top:15.0pt;line-height:15.75pt"><a h=
ref=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_b=
lank"><span style=3D"font-size:16.0pt;font-family:&quot;Segoe UI Light&quot=
;,sans-serif;text-decoration:none">amd-gfx Info Page
 - freedesktop.org</span></a><span style=3D"font-size:16.0pt;font-family:&q=
uot;Segoe UI Light&quot;,sans-serif;color:#0078D7"><o:p></o:p></span></p>
</div>
<div style=3D"margin-top:7.5pt;margin-bottom:12.0pt" id=3D"LPMetadata_15470=
463481930.8534761720978721">
<p class=3D"MsoNormal" style=3D"margin-top:15.0pt;line-height:10.5pt"><span=
 style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif;colo=
r:#666666">lists.freedesktop.org<o:p></o:p></span></p>
</div>
<div id=3D"LPDescription_15470463481940.26266687672424405">
<p class=3D"MsoNormal" style=3D"margin-top:15.0pt;line-height:15.0pt"><span=
 style=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif;colo=
r:#666666">To see the collection of prior postings to the list, visit the a=
md-gfx Archives.. Using amd-gfx: To post a message
 to all the list members, send email to </span><a href=3D"mailto:amd-gfx@li=
sts.freedesktop.org"><span style=3D"font-size:10.5pt;font-family:&quot;Sego=
e UI&quot;,sans-serif">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</span></a><span style=
=3D"font-size:10.5pt;font-family:&quot;Segoe UI&quot;,sans-serif;color:#666=
666">.
 You can subscribe to the list, or change your existing subscription, in th=
e sections below.<o:p></o:p></span></p>
</div>
</td>
</tr>
</tbody>
</table>
</div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB1707AB8CEDD9303F68EFDE12928B0DM5PR12MB1707namp_--

--===============0954210462==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0954210462==--
