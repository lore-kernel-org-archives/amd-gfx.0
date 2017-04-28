From: "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add cu info wave_front_size
Date: Fri, 28 Apr 2017 03:20:23 +0000
Message-ID: <CY4PR12MB1831304F8CE5E84033D19A768C130@CY4PR12MB1831.namprd12.prod.outlook.com>
References: <1493349046-23232-1-git-send-email-Jerry.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0485768357=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1493349046-23232-1-git-send-email-Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhang, Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

--===============0485768357==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1831304F8CE5E84033D19A768C130CY4PR12MB1831namp_"

--_000_CY4PR12MB1831304F8CE5E84033D19A768C130CY4PR12MB1831namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>

________________________________
From: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, April 28, 2017 11:10:46 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Deucher, Alexander; Wang, Ken; Zhang, Jerry
Subject: [PATCH] drm/amdgpu: add cu info wave_front_size

missed that for gfx v9 info export

Signed-off-by: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h
index 503010a..e330009 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -986,6 +986,7 @@ struct amdgpu_gfx_config {
 struct amdgpu_cu_info {
         uint32_t number; /* total active CU number */
         uint32_t ao_cu_mask;
+       uint32_t wave_front_size;
         uint32_t bitmap[4][4];
 };

--
1.9.1


--_000_CY4PR12MB1831304F8CE5E84033D19A768C130CY4PR12MB1831namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p>Reviewed-by: Ken Wang &lt;Qingqing.Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Junwei Zhang &lt;Je=
rry.Zhang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, April 28, 2017 11:10:46 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Deucher, Alexander; Wang, Ken; Zhang, Jerry<br>
<b>Subject:</b> [PATCH] drm/amdgpu: add cu info wave_front_size</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">missed that for gfx v9 info export<br>
<br>
Signed-off-by: Junwei Zhang &lt;Jerry.Zhang-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu.h | 1 &#43;<br>
&nbsp;1 file changed, 1 insertion(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdg=
pu/amdgpu.h<br>
index 503010a..e330009 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
@@ -986,6 &#43;986,7 @@ struct amdgpu_gfx_config {<br>
&nbsp;struct amdgpu_cu_info {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t number; /* total =
active CU number */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t ao_cu_mask;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t wave_front_size;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t bitmap[4][4];<br>
&nbsp;};<br>
&nbsp;<br>
-- <br>
1.9.1<br>
<br>
</div>
</span></font>
</body>
</html>

--_000_CY4PR12MB1831304F8CE5E84033D19A768C130CY4PR12MB1831namp_--

--===============0485768357==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0485768357==--
