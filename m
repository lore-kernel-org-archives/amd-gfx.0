From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix typo of CGTS
Date: Wed, 11 Jan 2017 12:16:20 +0000
Message-ID: <CY4PR12MB1768118357D71653B5343B60F7660@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <1484101830-2915-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1366269443=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1484101830-2915-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
To: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1366269443==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1768118357D71653B5343B60F7660CY4PR12MB1768namp_"

--_000_CY4PR12MB1768118357D71653B5343B60F7660CY4PR12MB1768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Huang Ru=
i <ray.huang-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, January 10, 2017 21:30
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: StDenis, Tom; Huang, Ray
Subject: [PATCH] drm/amdgpu: fix typo of CGTS

Fixes: 9e8590861e9 ('drm/amdgpu: add parse clock gating state')
Reported-by: Tom StDenis <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Signed-off-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c
index 480bad4..1462ec4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -39,7 +39,7 @@ static const struct cg_flag_name clocks[] =3D {
         {AMD_CG_SUPPORT_GFX_MGLS, "Graphics Medium Grain memory Light Slee=
p"},
         {AMD_CG_SUPPORT_GFX_CGCG, "Graphics Coarse Grain Clock Gating"},
         {AMD_CG_SUPPORT_GFX_CGLS, "Graphics Coarse Grain memory Light Slee=
p"},
-       {AMD_CG_SUPPORT_GFX_CGTS, "Graphics Coarse Grain Tree Shader Light =
Sleep"},
+       {AMD_CG_SUPPORT_GFX_CGTS, "Graphics Coarse Grain Tree Shader Clock =
Gating"},
         {AMD_CG_SUPPORT_GFX_CGTS_LS, "Graphics Coarse Grain Tree Shader Li=
ght Sleep"},
         {AMD_CG_SUPPORT_GFX_CP_LS, "Graphics Command Processor Light Sleep=
"},
         {AMD_CG_SUPPORT_GFX_RLC_LS, "Graphics Run List Controller Light Sl=
eep"},
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB1768118357D71653B5343B60F7660CY4PR12MB1768namp_
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
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p>Reviewed-by: Tom St Denis &lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Huang Rui &lt;ray.huang@amd=
.com&gt;<br>
<b>Sent:</b> Tuesday, January 10, 2017 21:30<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> StDenis, Tom; Huang, Ray<br>
<b>Subject:</b> [PATCH] drm/amdgpu: fix typo of CGTS</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Fixes: 9e8590861e9 ('drm/amdgpu: add parse clock g=
ating state')<br>
Reported-by: Tom StDenis &lt;Tom.StDenis-5C7GfCeVMHo@public.gmane.org&gt;<br>
Signed-off-by: Huang Rui &lt;ray.huang-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_pm.c<br>
index 480bad4..1462ec4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
@@ -39,7 &#43;39,7 @@ static const struct cg_flag_name clocks[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {AMD_CG_SUPPORT_GFX_MGLS, =
&quot;Graphics Medium Grain memory Light Sleep&quot;},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {AMD_CG_SUPPORT_GFX_CGCG, =
&quot;Graphics Coarse Grain Clock Gating&quot;},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {AMD_CG_SUPPORT_GFX_CGLS, =
&quot;Graphics Coarse Grain memory Light Sleep&quot;},<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {AMD_CG_SUPPORT_GFX_CGTS, &quot;Graph=
ics Coarse Grain Tree Shader Light Sleep&quot;},<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {AMD_CG_SUPPORT_GFX_CGTS, &quot;G=
raphics Coarse Grain Tree Shader Clock Gating&quot;},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {AMD_CG_SUPPORT_GFX_CGTS_L=
S, &quot;Graphics Coarse Grain Tree Shader Light Sleep&quot;},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {AMD_CG_SUPPORT_GFX_CP_LS,=
 &quot;Graphics Command Processor Light Sleep&quot;},<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {AMD_CG_SUPPORT_GFX_RLC_LS=
, &quot;Graphics Run List Controller Light Sleep&quot;},<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk458486" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY4PR12MB1768118357D71653B5343B60F7660CY4PR12MB1768namp_--

--===============1366269443==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1366269443==--
