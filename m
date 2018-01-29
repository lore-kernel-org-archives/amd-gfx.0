From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: disable coarse grain clockgating for ST
Date: Mon, 29 Jan 2018 14:52:14 +0000
Message-ID: <BN6PR12MB16529C7F8ACD0AF0C1225A5CF7E50@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <1516854622-9227-1-git-send-email-shirish.s12@gmail.com>,
 <BN6PR12MB182641C9629DD1AEADBD3188F2E10@BN6PR12MB1826.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0204560488=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB182641C9629DD1AEADBD3188F2E10-/b2+HYfkarSCndJ3FSsNdQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "S, Shirish" <Shirish.S-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0204560488==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB16529C7F8ACD0AF0C1225A5CF7E50BN6PR12MB1652namp_"

--_000_BN6PR12MB16529C7F8ACD0AF0C1225A5CF7E50BN6PR12MB1652namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: S, Shirish
Sent: Wednesday, January 24, 2018 11:32:56 PM
To: Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: [PATCH] drm/amdgpu: disable coarse grain clockgating for ST


From: Shirish S <shirish.s-5C7GfCeVMHo@public.gmane.org>

The CGCG feature on Stoney is causing GFX related issues such as freezes
and blank outs.

Signed-off-by: Shirish S <shirish.s-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/vi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c
b/drivers/gpu/drm/amd/amdgpu/vi.c index 3b66e1a..ebfac67 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1045,7 +1045,6 @@ static int vi_common_early_init(void *handle)
                         AMD_CG_SUPPORT_GFX_CP_LS |
                         AMD_CG_SUPPORT_GFX_CGTS |
                         AMD_CG_SUPPORT_GFX_CGTS_LS |
-                       AMD_CG_SUPPORT_GFX_CGCG |
                         AMD_CG_SUPPORT_GFX_CGLS |
                         AMD_CG_SUPPORT_BIF_LS |
                         AMD_CG_SUPPORT_HDP_MGCG |
--
2.7.4


--_000_BN6PR12MB16529C7F8ACD0AF0C1225A5CF7E50BN6PR12MB1652namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Acked-by: Alex Deucher &lt;alexan=
der.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> S, Shirish<br>
<b>Sent:</b> Wednesday, January 24, 2018 11:32:56 PM<br>
<b>To:</b> Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> [PATCH] drm/amdgpu: disable coarse grain clockgating for ST=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
From: Shirish S &lt;shirish.s-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
The CGCG feature on Stoney is causing GFX related issues such as freezes<br=
>
and blank outs.<br>
<br>
Signed-off-by: Shirish S &lt;shirish.s-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vi.c | 1 -<br>
&nbsp;1 file changed, 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c<br>
b/drivers/gpu/drm/amd/amdgpu/vi.c index 3b66e1a..ebfac67 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vi.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vi.c<br>
@@ -1045,7 &#43;1045,6 @@ static int vi_common_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_GFX_CP_LS |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_GFX_CGTS |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_GFX_CGTS_LS |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_CG_SUPPORT_G=
FX_CGCG |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_GFX_CGLS |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_BIF_LS |<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMD_C=
G_SUPPORT_HDP_MGCG |<br>
--<br>
2.7.4<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB16529C7F8ACD0AF0C1225A5CF7E50BN6PR12MB1652namp_--

--===============0204560488==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0204560488==--
