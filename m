From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/6] drm/amdgpu: add macro of umc for each channel
Date: Thu, 1 Aug 2019 15:29:55 +0000
Message-ID: <BN6PR12MB18091E05F855AC098E2E7011F7DE0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190801064311.7307-1-tao.zhou1@amd.com>,
 <20190801064311.7307-5-tao.zhou1@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1262487834=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190801064311.7307-5-tao.zhou1-5C7GfCeVMHo@public.gmane.org>
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

--===============1262487834==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18091E05F855AC098E2E7011F7DE0BN6PR12MB1809namp_"

--_000_BN6PR12MB18091E05F855AC098E2E7011F7DE0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Please include a patch description.  Explain why you need the new helper fu=
nction.

Alex
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Tao Zhou=
 <tao.zhou1-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, August 1, 2019 2:43 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Zhang, H=
awking <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>; Li, Dennis <Dennis.Li-5C7GfCeVMHo@public.gmane.org>; Chen, Guchu=
n <Guchun.Chen-5C7GfCeVMHo@public.gmane.org>; Pan, Xinhui <Xinhui.Pan-5C7GfCeVMHo@public.gmane.org>
Cc: Zhou1, Tao <Tao.Zhou1-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 4/6] drm/amdgpu: add macro of umc for each channel

common function for all umc versions

Signed-off-by: Tao Zhou <tao.zhou1-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.h
index 2604f5076867..9efdd66279e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -21,6 +21,29 @@
 #ifndef __AMDGPU_UMC_H__
 #define __AMDGPU_UMC_H__

+/*
+ * void (*func)(struct amdgpu_device *adev, struct ras_err_data *err_data,
+ *                             uint32_t umc_reg_offset, uint32_t channel_i=
ndex)
+ */
+#define amdgpu_umc_for_each_channel(func)      \
+       struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_=
status;        \
+       uint32_t umc_inst, channel_inst, umc_reg_offset, channel_index; \
+       for (umc_inst =3D 0; umc_inst < adev->umc.umc_inst_num; umc_inst++)=
 {     \
+               /* enable the index mode to query eror count per channel */=
     \
+               adev->umc.funcs->enable_umc_index_mode(adev, umc_inst); \
+               for (channel_inst =3D 0;  \
+                       channel_inst < adev->umc.channel_inst_num;      \
+                       channel_inst++) {       \
+                       /* calc the register offset according to channel in=
stance */    \
+                       umc_reg_offset =3D adev->umc.channel_offs * channel=
_inst; \
+                       /* get channel index of interleaved memory */   \
+                       channel_index =3D adev->umc.channel_idx_tbl[      \
+                               umc_inst * adev->umc.channel_inst_num + cha=
nnel_inst];  \
+                       (func)(adev, err_data, umc_reg_offset, channel_inde=
x);  \
+               }       \
+       }       \
+       adev->umc.funcs->disable_umc_index_mode(adev);
+
 struct amdgpu_umc_funcs {
         void (*ras_init)(struct amdgpu_device *adev);
         void (*query_ras_error_count)(struct amdgpu_device *adev,
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB18091E05F855AC098E2E7011F7DE0BN6PR12MB1809namp_
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
Please include a patch description.&nbsp; Explain why you need the new help=
er function.</div>
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
<b>Subject:</b> [PATCH 4/6] drm/amdgpu: add macro of umc for each channel</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">common function for all umc versions<br>
<br>
Signed-off-by: Tao Zhou &lt;tao.zhou1-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h | 23 &#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;<br>
&nbsp;1 file changed, 23 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_umc.h<br>
index 2604f5076867..9efdd66279e5 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h<br>
@@ -21,6 &#43;21,29 @@<br>
&nbsp;#ifndef __AMDGPU_UMC_H__<br>
&nbsp;#define __AMDGPU_UMC_H__<br>
&nbsp;<br>
&#43;/*<br>
&#43; * void (*func)(struct amdgpu_device *adev, struct ras_err_data *err_d=
ata,<br>
&#43; *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t umc_reg_offset, uint32_t channel_index)<=
br>
&#43; */<br>
&#43;#define amdgpu_umc_for_each_channel(func)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_err_data *err_data =3D=
 (struct ras_err_data *)ras_error_status;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t umc_inst, channel_inst, =
umc_reg_offset, channel_index; \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (umc_inst =3D 0; umc_inst &lt=
; adev-&gt;umc.umc_inst_num; umc_inst&#43;&#43;) {&nbsp;&nbsp;&nbsp;&nbsp; =
\<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* enable the index mode to query eror count per channel */&=
nbsp;&nbsp;&nbsp;&nbsp; \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;umc.funcs-&gt;enable_umc_index_mode(adev, umc_inst)=
; \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; for (channel_inst =3D 0;&nbsp; \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; channel_inst=
 &lt; adev-&gt;umc.channel_inst_num;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; channel_inst=
&#43;&#43;) {&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* calc the =
register offset according to channel instance */&nbsp;&nbsp;&nbsp; \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_reg_offs=
et =3D adev-&gt;umc.channel_offs * channel_inst; \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* get chann=
el index of interleaved memory */&nbsp;&nbsp; \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; channel_inde=
x =3D adev-&gt;umc.channel_idx_tbl[&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; umc_inst * adev-&gt;umc.channel_inst_nu=
m &#43; channel_inst];&nbsp; \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (func)(adev,=
 err_data, umc_reg_offset, channel_index);&nbsp; \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; \<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;umc.funcs-&gt;disable_um=
c_index_mode(adev);<br>
&#43;<br>
&nbsp;struct amdgpu_umc_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*ras_init)(struct am=
dgpu_device *adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*query_ras_error_cou=
nt)(struct amdgpu_device *adev,<br>
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

--_000_BN6PR12MB18091E05F855AC098E2E7011F7DE0BN6PR12MB1809namp_--

--===============1262487834==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1262487834==--
