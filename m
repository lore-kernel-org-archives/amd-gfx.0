From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/6] drm/amdgpu: add more parameters and functions to
 amdgpu_umc structure
Date: Thu, 1 Aug 2019 15:29:05 +0000
Message-ID: <BN6PR12MB1809A6E7001A75A2748EFCD4F7DE0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190801064311.7307-1-tao.zhou1@amd.com>,
 <20190801064311.7307-3-tao.zhou1@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0698754436=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190801064311.7307-3-tao.zhou1-5C7GfCeVMHo@public.gmane.org>
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

--===============0698754436==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809A6E7001A75A2748EFCD4F7DE0BN6PR12MB1809namp_"

--_000_BN6PR12MB1809A6E7001A75A2748EFCD4F7DE0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Please include a patch description.  Explain why you need the new interface=
.

Alex
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Tao Zhou=
 <tao.zhou1-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, August 1, 2019 2:43 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Zhang, H=
awking <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>; Li, Dennis <Dennis.Li-5C7GfCeVMHo@public.gmane.org>; Chen, Guchu=
n <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>; Pan, Xinhui <Xinhui.Pan-5C7GfCeVMHo@public.gmane.org>
Cc: Zhou1, Tao <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 2/6] drm/amdgpu: add more parameters and functions to amdgp=
u_umc structure

Signed-off-by: Tao Zhou <tao.zhou1-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/umc_v6_1.h   |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.h
index dfa1a39e57af..2604f5076867 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -22,15 +22,28 @@
 #define __AMDGPU_UMC_H__

 struct amdgpu_umc_funcs {
+       void (*ras_init)(struct amdgpu_device *adev);
         void (*query_ras_error_count)(struct amdgpu_device *adev,
                                         void *ras_error_status);
         void (*query_ras_error_address)(struct amdgpu_device *adev,
                                         void *ras_error_status);
+       void (*enable_umc_index_mode)(struct amdgpu_device *adev,
+                                       uint32_t umc_instance);
+       void (*disable_umc_index_mode)(struct amdgpu_device *adev);
 };

 struct amdgpu_umc {
         /* max error count in one ras query call */
         uint32_t max_ras_err_cnt_per_query;
+       /* number of umc channel instance with memory map register access *=
/
+       uint32_t channel_inst_num;
+       /* number of umc instance with memory map register access */
+       uint32_t umc_inst_num;
+       /* UMC regiser per channel offset */
+       uint32_t channel_offs;
+       /* channel index table of interleaved memory */
+       const uint32_t *channel_idx_tbl;
+
         const struct amdgpu_umc_funcs *funcs;
 };

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.h b/drivers/gpu/drm/amd/am=
dgpu/umc_v6_1.h
index d25ae414f4d8..bddaf14a77f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.h
@@ -31,6 +31,8 @@
 #define UMC_V6_1_CHANNEL_INSTANCE_NUM           4
 /* number of umc instance with memory map register access */
 #define UMC_V6_1_UMC_INSTANCE_NUM               8
+/* total channel instances in one umc block */
+#define UMC_V6_1_TOTAL_CHANNEL_NUM     (UMC_V6_1_CHANNEL_INSTANCE_NUM * UM=
C_V6_1_UMC_INSTANCE_NUM)
 /* UMC regiser per channel offset */
 #define UMC_V6_1_PER_CHANNEL_OFFSET             0x800

--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809A6E7001A75A2748EFCD4F7DE0BN6PR12MB1809namp_
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
Please include a patch description.&nbsp; Explain why you need the new inte=
rface.</div>
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
<b>Subject:</b> [PATCH 2/6] drm/amdgpu: add more parameters and functions t=
o amdgpu_umc structure</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Signed-off-by: Tao Zhou &lt;tao.zhou1-5C7GfCeVMHo@public.gmane.org&gt;<=
br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h | 13 &#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/umc_v6_1.h&nbsp;&nbsp; |&nbsp; 2 &#43;&#43=
;<br>
&nbsp;2 files changed, 15 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.h<br>
index dfa1a39e57af..2604f5076867 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h<br>
@@ -22,15 &#43;22,28 @@<br>
&nbsp;#define __AMDGPU_UMC_H__<br>
&nbsp;<br>
&nbsp;struct amdgpu_umc_funcs {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*ras_init)(struct amdgpu_de=
vice *adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*query_ras_error_cou=
nt)(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; void *ras_error_status);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*query_ras_error_add=
ress)(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; void *ras_error_status);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*enable_umc_index_mode)(str=
uct amdgpu_device *adev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; uint32_t umc_instance);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*disable_umc_index_mode)(st=
ruct amdgpu_device *adev);<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;struct amdgpu_umc {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* max error count in one =
ras query call */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t max_ras_err_cnt_p=
er_query;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* number of umc channel instance=
 with memory map register access */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t channel_inst_num;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* number of umc instance with me=
mory map register access */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t umc_inst_num;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* UMC regiser per channel offset=
 */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t channel_offs;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* channel index table of interle=
aved memory */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const uint32_t *channel_idx_tbl;<=
br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct amdgpu_umc_fu=
ncs *funcs;<br>
&nbsp;};<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.h b/drivers/gpu/drm/amd/am=
dgpu/umc_v6_1.h<br>
index d25ae414f4d8..bddaf14a77f9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/umc_v6_1.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/umc_v6_1.h<br>
@@ -31,6 &#43;31,8 @@<br>
&nbsp;#define UMC_V6_1_CHANNEL_INSTANCE_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; 4<br>
&nbsp;/* number of umc instance with memory map register access */<br>
&nbsp;#define UMC_V6_1_UMC_INSTANCE_NUM&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8<br>
&#43;/* total channel instances in one umc block */<br>
&#43;#define UMC_V6_1_TOTAL_CHANNEL_NUM&nbsp;&nbsp;&nbsp;&nbsp; (UMC_V6_1_C=
HANNEL_INSTANCE_NUM * UMC_V6_1_UMC_INSTANCE_NUM)<br>
&nbsp;/* UMC regiser per channel offset */<br>
&nbsp;#define UMC_V6_1_PER_CHANNEL_OFFSET&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x800<br>
&nbsp;<br>
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

--_000_BN6PR12MB1809A6E7001A75A2748EFCD4F7DE0BN6PR12MB1809namp_--

--===============0698754436==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0698754436==--
