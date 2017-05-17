From: "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: fix re-program vm invalidate eng address
 range for mmhub on resume
Date: Wed, 17 May 2017 08:01:49 +0000
Message-ID: <CY1PR12MB0474B6637DAC760676BAAFAE8CE70@CY1PR12MB0474.namprd12.prod.outlook.com>
References: <1495006729-17310-1-git-send-email-ray.huang@amd.com>,
 <1495006729-17310-2-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1900283494=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1495006729-17310-2-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Huan,
 Alvin" <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>

--===============1900283494==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY1PR12MB0474B6637DAC760676BAAFAE8CE70CY1PR12MB0474namp_"

--_000_CY1PR12MB0474B6637DAC760676BAAFAE8CE70CY1PR12MB0474namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>

________________________________
From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, May 17, 2017 3:38:49 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander; Koenig, Christian
Cc: Zhou, David(ChunMing); Wang, Ken; Huan, Alvin; Huang, Ray
Subject: [PATCH 2/2] drm/amdgpu: fix re-program vm invalidate eng address r=
ange for mmhub on resume

Signed-off-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v1_0.c
index dbfe48d..8979bc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -386,7 +386,7 @@ static int mmhub_v1_0_suspend(void *handle)

 static int mmhub_v1_0_resume(void *handle)
 {
-       return 0;
+       return mmhub_v1_0_hw_init(handle);
 }

 static bool mmhub_v1_0_is_idle(void *handle)
--
2.7.4


--_000_CY1PR12MB0474B6637DAC760676BAAFAE8CE70CY1PR12MB0474namp_
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
<p>Reviewed-by: Ken Wang &lt;Qingqing.Wang-5C7GfCeVMHo@public.gmane.org&gt;</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Huang Rui &lt;ray.h=
uang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, May 17, 2017 3:38:49 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander; Koenig, Chris=
tian<br>
<b>Cc:</b> Zhou, David(ChunMing); Wang, Ken; Huan, Alvin; Huang, Ray<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: fix re-program vm invalidate eng ad=
dress range for mmhub on resume</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Signed-off-by: Huang Rui &lt;ray.huang-5C7GfCeVMHo@public.gmane.org&gt;=
<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/=
amdgpu/mmhub_v1_0.c<br>
index dbfe48d..8979bc2 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c<br>
@@ -386,7 &#43;386,7 @@ static int mmhub_v1_0_suspend(void *handle)<br>
&nbsp;<br>
&nbsp;static int mmhub_v1_0_resume(void *handle)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return mmhub_v1_0_hw_init(handle)=
;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static bool mmhub_v1_0_is_idle(void *handle)<br>
-- <br>
2.7.4<br>
<br>
</div>
</span></font>
</body>
</html>

--_000_CY1PR12MB0474B6637DAC760676BAAFAE8CE70CY1PR12MB0474namp_--

--===============1900283494==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1900283494==--
