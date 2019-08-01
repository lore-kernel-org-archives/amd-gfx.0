From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/6] drm/amdgpu: initialize new parameters and functions
 for amdgpu_umc structure
Date: Thu, 1 Aug 2019 15:29:25 +0000
Message-ID: <BN6PR12MB1809BF9509C442E4F3284F7CF7DE0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190801064311.7307-1-tao.zhou1@amd.com>,
 <20190801064311.7307-4-tao.zhou1@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1236868536=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190801064311.7307-4-tao.zhou1-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhou1, Tao" <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "Li, Dennis" <Dennis.Li-5C7GfCeVMHo@public.gmane.org>, "Chen, Guchun" <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>, "Pan,
 Xinhui" <Xinhui.Pan-5C7GfCeVMHo@public.gmane.org>

--===============1236868536==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809BF9509C442E4F3284F7CF7DE0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809BF9509C442E4F3284F7CF7DE0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Please include a patch description.

Alex
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Tao Zhou=
 <tao.zhou1-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, August 1, 2019 2:43 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Zhang, H=
awking <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>; Li, Dennis <Dennis.Li-5C7GfCeVMHo@public.gmane.org>; Chen, Guchu=
n <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>; Pan, Xinhui <Xinhui.Pan-5C7GfCeVMHo@public.gmane.org>
Cc: Zhou1, Tao <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/6] drm/amdgpu: initialize new parameters and functions fo=
r amdgpu_umc structure

Signed-off-by: Tao Zhou <tao.zhou1-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c |  7 +++++--
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.c | 10 +++++++++-
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.h |  3 +++
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c
index ee06cbe2a7e7..3486b4ce7770 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -631,8 +631,11 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_devic=
e *adev)
 {
         switch (adev->asic_type) {
         case CHIP_VEGA20:
-               adev->umc.max_ras_err_cnt_per_query =3D
-                       UMC_V6_1_UMC_INSTANCE_NUM * UMC_V6_1_CHANNEL_INSTAN=
CE_NUM;
+               adev->umc.max_ras_err_cnt_per_query =3D UMC_V6_1_TOTAL_CHAN=
NEL_NUM;
+               adev->umc.channel_inst_num =3D UMC_V6_1_CHANNEL_INSTANCE_NU=
M;
+               adev->umc.umc_inst_num =3D UMC_V6_1_UMC_INSTANCE_NUM;
+               adev->umc.channel_offs =3D UMC_V6_1_PER_CHANNEL_OFFSET;
+               adev->umc.channel_idx_tbl =3D &umc_v6_1_channel_idx_tbl[0][=
0];
                 adev->umc.funcs =3D &umc_v6_1_funcs;
                 break;
         default:
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c b/drivers/gpu/drm/amd/am=
dgpu/umc_v6_1.c
index 035e4fea472c..9ba015d7eb57 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c
@@ -41,7 +41,7 @@
 /* offset in 256B block */
 #define OFFSET_IN_256B_BLOCK(addr)              ((addr) & 0xffULL)

-static uint32_t
+const uint32_t
         umc_v6_1_channel_idx_tbl[UMC_V6_1_UMC_INSTANCE_NUM][UMC_V6_1_CHANN=
EL_INSTANCE_NUM] =3D {
                 {2, 18, 11, 27},        {4, 20, 13, 29},
                 {1, 17, 8, 24},         {7, 23, 14, 30},
@@ -235,7 +235,15 @@ static void umc_v6_1_query_ras_error_address(struct am=
dgpu_device *adev,
         umc_v6_1_disable_umc_index_mode(adev);
 }

+static void umc_v6_1_ras_init(struct amdgpu_device *adev)
+{
+
+}
+
 const struct amdgpu_umc_funcs umc_v6_1_funcs =3D {
+       .ras_init =3D umc_v6_1_ras_init,
         .query_ras_error_count =3D umc_v6_1_query_ras_error_count,
         .query_ras_error_address =3D umc_v6_1_query_ras_error_address,
+       .enable_umc_index_mode =3D umc_v6_1_enable_umc_index_mode,
+       .disable_umc_index_mode =3D umc_v6_1_disable_umc_index_mode,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.h b/drivers/gpu/drm/amd/am=
dgpu/umc_v6_1.h
index bddaf14a77f9..ad4598c0e495 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.h
@@ -24,6 +24,7 @@
 #define __UMC_V6_1_H__

 #include "soc15_common.h"
+#include "amdgpu.h"

 /* HBM  Memory Channel Width */
 #define UMC_V6_1_HBM_MEMORY_CHANNEL_WIDTH       128
@@ -37,5 +38,7 @@
 #define UMC_V6_1_PER_CHANNEL_OFFSET             0x800

 extern const struct amdgpu_umc_funcs umc_v6_1_funcs;
+extern const uint32_t
+       umc_v6_1_channel_idx_tbl[UMC_V6_1_UMC_INSTANCE_NUM][UMC_V6_1_CHANNE=
L_INSTANCE_NUM];

 #endif
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809BF9509C442E4F3284F7CF7DE0BN6PR12MB1809namp_
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
Please include a patch description. <br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Tao Zhou &lt;tao.zhou1-urvtwAKJhsc@public.gmane.org=
m&gt;<br>
<b>Sent:</b> Thursday, August 1, 2019 2:43 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;; Zhang, Hawking &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;; Li, Dennis &lt;Dennis.Li=
@amd.com&gt;; Chen, Guchun &lt;Guchun.Chen-5C7GfCeVMHo@public.gmane.org&gt;; Pan, Xinhui &lt;Xin=
hui.Pan-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> Zhou1, Tao &lt;Tao.Zhou1-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH 3/6] drm/amdgpu: initialize new parameters and funct=
ions for amdgpu_umc structure</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Signed-off-by: Tao Zhou &lt;tao.zhou1-5C7GfCeVMHo@public.gmane.org&gt;<=
br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c |&nbsp; 7 &#43;&#43;&#43;&#43;&=
#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/umc_v6_1.c | 10 &#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/umc_v6_1.h |&nbsp; 3 &#43;&#43;&#43;<br>
&nbsp;3 files changed, 17 insertions(&#43;), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v9_0.c<br>
index ee06cbe2a7e7..3486b4ce7770 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
@@ -631,8 &#43;631,11 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_d=
evice *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;asic_type=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_VEGA20:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; adev-&gt;umc.max_ras_err_cnt_per_query =3D<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UMC_V6_1_UMC_INS=
TANCE_NUM * UMC_V6_1_CHANNEL_INSTANCE_NUM;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;umc.max_ras_err_cnt_per_query =3D UMC_V6_1_TOTAL_CH=
ANNEL_NUM;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;umc.channel_inst_num =3D UMC_V6_1_CHANNEL_INSTANCE_=
NUM;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;umc.umc_inst_num =3D UMC_V6_1_UMC_INSTANCE_NUM;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;umc.channel_offs =3D UMC_V6_1_PER_CHANNEL_OFFSET;<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;umc.channel_idx_tbl =3D &amp;umc_v6_1_channel_idx_t=
bl[0][0];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;umc.funcs =3D &amp;umc_v6_1_funcs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; break;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c b/drivers/gpu/drm/amd/am=
dgpu/umc_v6_1.c<br>
index 035e4fea472c..9ba015d7eb57 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.c<br>
@@ -41,7 &#43;41,7 @@<br>
&nbsp;/* offset in 256B block */<br>
&nbsp;#define OFFSET_IN_256B_BLOCK(addr)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((addr) &amp; 0xffULL)<br>
&nbsp;<br>
-static uint32_t<br>
&#43;const uint32_t<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_v6_1_channel_idx_tbl[U=
MC_V6_1_UMC_INSTANCE_NUM][UMC_V6_1_CHANNEL_INSTANCE_NUM] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; {2, 18, 11, 27},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; {4, 20, 13, 29},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; {1, 17, 8, 24},&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; {7, 23, 14, 30},<br>
@@ -235,7 &#43;235,15 @@ static void umc_v6_1_query_ras_error_address(struc=
t amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_v6_1_disable_umc_index=
_mode(adev);<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static void umc_v6_1_ras_init(struct amdgpu_device *adev)<br>
&#43;{<br>
&#43;<br>
&#43;}<br>
&#43;<br>
&nbsp;const struct amdgpu_umc_funcs umc_v6_1_funcs =3D {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .ras_init =3D umc_v6_1_ras_init,<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .query_ras_error_count =3D=
 umc_v6_1_query_ras_error_count,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .query_ras_error_address =
=3D umc_v6_1_query_ras_error_address,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .enable_umc_index_mode =3D umc_v6=
_1_enable_umc_index_mode,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .disable_umc_index_mode =3D umc_v=
6_1_disable_umc_index_mode,<br>
&nbsp;};<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.h b/drivers/gpu/drm/amd/am=
dgpu/umc_v6_1.h<br>
index bddaf14a77f9..ad4598c0e495 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.h<br>
@@ -24,6 &#43;24,7 @@<br>
&nbsp;#define __UMC_V6_1_H__<br>
&nbsp;<br>
&nbsp;#include &quot;soc15_common.h&quot;<br>
&#43;#include &quot;amdgpu.h&quot;<br>
&nbsp;<br>
&nbsp;/* HBM&nbsp; Memory Channel Width */<br>
&nbsp;#define UMC_V6_1_HBM_MEMORY_CHANNEL_WIDTH&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 128<br>
@@ -37,5 &#43;38,7 @@<br>
&nbsp;#define UMC_V6_1_PER_CHANNEL_OFFSET&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x800<br>
&nbsp;<br>
&nbsp;extern const struct amdgpu_umc_funcs umc_v6_1_funcs;<br>
&#43;extern const uint32_t<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_v6_1_channel_idx_tbl[UMC_V6_1=
_UMC_INSTANCE_NUM][UMC_V6_1_CHANNEL_INSTANCE_NUM];<br>
&nbsp;<br>
&nbsp;#endif<br>
-- <br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB1809BF9509C442E4F3284F7CF7DE0BN6PR12MB1809namp_--

--===============1236868536==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1236868536==--
