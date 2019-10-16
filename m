From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/psp: declare PSP TA firmware
Date: Wed, 16 Oct 2019 12:45:01 +0000
Message-ID: <BN6PR12MB180987D3A7CD9D402B8997F3F7920@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1571194113-22696-1-git-send-email-curry.gong@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1417797008=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1571194113-22696-1-git-send-email-curry.gong-5C7GfCeVMHo@public.gmane.org>
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
To: "Gong, Curry" <Curry.Gong-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>

--===============1417797008==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB180987D3A7CD9D402B8997F3F7920BN6PR12MB1809namp_"

--_000_BN6PR12MB180987D3A7CD9D402B8997F3F7920BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of chen gon=
g <curry.gong-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, October 15, 2019 10:48 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>; Gong, Curry <Curry.Gong=
@amd.com>
Subject: [PATCH] drm/amdgpu/psp: declare PSP TA firmware

Add PSP TA firmware declaration for raven raven2 picasso

Signed-off-by: chen gong <curry.gong-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v10_0.c
index b96484a..b345e69 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
@@ -40,6 +40,9 @@
 MODULE_FIRMWARE("amdgpu/raven_asd.bin");
 MODULE_FIRMWARE("amdgpu/picasso_asd.bin");
 MODULE_FIRMWARE("amdgpu/raven2_asd.bin");
+MODULE_FIRMWARE("amdgpu/picasso_ta.bin");
+MODULE_FIRMWARE("amdgpu/raven2_ta.bin");
+MODULE_FIRMWARE("amdgpu/raven_ta.bin");

 static int psp_v10_0_init_microcode(struct psp_context *psp)
 {
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB180987D3A7CD9D402B8997F3F7920BN6PR12MB1809namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of chen gong &lt;curry.gong@amd.=
com&gt;<br>
<b>Sent:</b> Tuesday, October 15, 2019 10:48 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org&gt;; Gong, Curr=
y &lt;Curry.Gong-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/psp: declare PSP TA firmware</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Add PSP TA firmware declaration for raven raven2 p=
icasso<br>
<br>
Signed-off-by: chen gong &lt;curry.gong-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/psp_v10_0.c | 3 &#43;&#43;&#43;<br>
&nbsp;1 file changed, 3 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v10_0.c<br>
index b96484a..b345e69 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c<br>
@@ -40,6 &#43;40,9 @@<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/raven_asd.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/picasso_asd.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/raven2_asd.bin&quot;);<br>
&#43;MODULE_FIRMWARE(&quot;amdgpu/picasso_ta.bin&quot;);<br>
&#43;MODULE_FIRMWARE(&quot;amdgpu/raven2_ta.bin&quot;);<br>
&#43;MODULE_FIRMWARE(&quot;amdgpu/raven_ta.bin&quot;);<br>
&nbsp;<br>
&nbsp;static int psp_v10_0_init_microcode(struct psp_context *psp)<br>
&nbsp;{<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB180987D3A7CD9D402B8997F3F7920BN6PR12MB1809namp_--

--===============1417797008==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1417797008==--
