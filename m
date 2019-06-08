From: "Pan, Xinhui" <Xinhui.Pan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Fix bounds checking in
 amdgpu_ras_is_supported()
Date: Sat, 8 Jun 2019 12:27:47 +0000
Message-ID: <SN6PR12MB2800185519D425526956EDA687110@SN6PR12MB2800.namprd12.prod.outlook.com>
References: <20190608092357.GB28890@mwanda>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0955856027=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190608092357.GB28890@mwanda>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Quan,
 Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "Zhu, James" <James.Zhu-5C7GfCeVMHo@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============0955856027==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN6PR12MB2800185519D425526956EDA687110SN6PR12MB2800namp_"

--_000_SN6PR12MB2800185519D425526956EDA687110SN6PR12MB2800namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

do you mean that something like 1<<65 might be a none zero value?
________________________________
From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Sent: Saturday, June 8, 2019 5:23:57 PM
To: Deucher, Alexander; Pan, Xinhui
Cc: Koenig, Christian; Zhou, David(ChunMing); David Airlie; Daniel Vetter; =
Quan, Evan; Zhu, James; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; dri-devel-PD4FTy7X32mptlylMvRsHA@public.gmane.org=
desktop.org; kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: [PATCH] drm/amdgpu: Fix bounds checking in amdgpu_ras_is_supported=
()

The "block" variable can be set by the user through debugfs, so it can
be quite large which leads to shift wrapping here.  This means we report
a "block" as supported when it's not, and that leads to array overflows
later on.

This bug is not really a security issue in real life, because debugfs is
generally root only.

Fixes: 36ea1bd2d084 ("drm/amdgpu: add debugfs ctrl node")
Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index c6b34fbd695f..94c652f5265a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -173,6 +173,8 @@ static inline int amdgpu_ras_is_supported(struct amdgpu=
_device *adev,
 {
         struct amdgpu_ras *ras =3D amdgpu_ras_get_context(adev);

+       if (block >=3D AMDGPU_RAS_BLOCK_COUNT)
+               return 0;
         return ras && (ras->supported & (1 << block));
 }

--
2.20.1


--_000_SN6PR12MB2800185519D425526956EDA687110SN6PR12MB2800namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
do you mean that something like 1&lt;&lt;65 might be a none zero value?</di=
v>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Dan Carpenter &lt;d=
an.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org&gt;<br>
<b>Sent:</b> Saturday, June 8, 2019 5:23:57 PM<br>
<b>To:</b> Deucher, Alexander; Pan, Xinhui<br>
<b>Cc:</b> Koenig, Christian; Zhou, David(ChunMing); David Airlie; Daniel V=
etter; Quan, Evan; Zhu, James; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; dri-devel@lis=
ts.freedesktop.org; kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix bounds checking in amdgpu_ras_is_su=
pported()</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">The &quot;block&quot; variable can be set by the u=
ser through debugfs, so it can<br>
be quite large which leads to shift wrapping here.&nbsp; This means we repo=
rt<br>
a &quot;block&quot; as supported when it's not, and that leads to array ove=
rflows<br>
later on.<br>
<br>
This bug is not really a security issue in real life, because debugfs is<br=
>
generally root only.<br>
<br>
Fixes: 36ea1bd2d084 (&quot;drm/amdgpu: add debugfs ctrl node&quot;)<br>
Signed-off-by: Dan Carpenter &lt;dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 2 &#43;&#43;<br>
&nbsp;1 file changed, 2 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h<br>
index c6b34fbd695f..94c652f5265a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
@@ -173,6 &#43;173,8 @@ static inline int amdgpu_ras_is_supported(struct am=
dgpu_device *adev,<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *ras =3D=
 amdgpu_ras_get_context(adev);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (block &gt;=3D AMDGPU_RAS_BLOC=
K_COUNT)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ras &amp;&amp; (ras=
-&gt;supported &amp; (1 &lt;&lt; block));<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.20.1<br>
<br>
</div>
</span></font>
</body>
</html>

--_000_SN6PR12MB2800185519D425526956EDA687110SN6PR12MB2800namp_--

--===============0955856027==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0955856027==--
