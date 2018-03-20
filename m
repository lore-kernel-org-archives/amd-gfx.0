From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: Fix kernel NULL pointer dereference in
 dpm functions
Date: Tue, 20 Mar 2018 14:11:33 +0000
Message-ID: <DM5PR12MB18208D5631DE0C5328D215E0F7AB0@DM5PR12MB1820.namprd12.prod.outlook.com>
References: <1521535031-3100-1-git-send-email-Rex.Zhu@amd.com>,
 <1521535031-3100-2-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0258217538=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1521535031-3100-2-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0258217538==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB18208D5631DE0C5328D215E0F7AB0DM5PR12MB1820namp_"

--_000_DM5PR12MB18208D5631DE0C5328D215E0F7AB0DM5PR12MB1820namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Series is:

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Rex Zhu =
<Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, March 20, 2018 4:37:11 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex
Subject: [PATCH 2/2] drm/amdgpu: Fix kernel NULL pointer dereference in dpm=
 functions

caused by
'commit 83e3c4615872 ("drm/amdgpu: Remove wrapper layer of smu ip functions=
")'

BUG: unable to handle kernel NULL pointer dereference at 00000000000005d8
[  313.241459] IP: ci_dpm_read_sensor+0x37/0xf0 [amdgpu]

Change-Id: Iac0cf26264ccbc60181ccd9bba79fe3c4e420456
Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/ci_dpm.c | 1 +
 drivers/gpu/drm/amd/amdgpu/kv_dpm.c | 1 +
 drivers/gpu/drm/amd/amdgpu/si_dpm.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c b/drivers/gpu/drm/amd/amdg=
pu/ci_dpm.c
index 98d1dd2..47ef3e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
@@ -6244,6 +6244,7 @@ static int ci_dpm_early_init(void *handle)
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

         adev->powerplay.pp_funcs =3D &ci_dpm_funcs;
+       adev->powerplay.pp_handle =3D adev;
         ci_dpm_set_irq_funcs(adev);

         return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/kv_dpm.c b/drivers/gpu/drm/amd/amdg=
pu/kv_dpm.c
index 81babe0..26ba984 100644
--- a/drivers/gpu/drm/amd/amdgpu/kv_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/kv_dpm.c
@@ -2963,6 +2963,7 @@ static int kv_dpm_early_init(void *handle)
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

         adev->powerplay.pp_funcs =3D &kv_dpm_funcs;
+       adev->powerplay.pp_handle =3D adev;
         kv_dpm_set_irq_funcs(adev);

         return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdg=
pu/si_dpm.c
index 3bfcf0d..672eaff 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
@@ -7917,6 +7917,7 @@ static int si_dpm_early_init(void *handle)
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

         adev->powerplay.pp_funcs =3D &si_dpm_funcs;
+       adev->powerplay.pp_handle =3D adev;
         si_dpm_set_irq_funcs(adev);
         return 0;
 }
--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM5PR12MB18208D5631DE0C5328D215E0F7AB0DM5PR12MB1820namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Series is:</p>
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
<b>Sent:</b> Tuesday, March 20, 2018 4:37:11 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: Fix kernel NULL pointer dereference=
 in dpm functions</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">caused by<br>
'commit 83e3c4615872 (&quot;drm/amdgpu: Remove wrapper layer of smu ip func=
tions&quot;)'<br>
<br>
BUG: unable to handle kernel NULL pointer dereference at 00000000000005d8<b=
r>
[&nbsp; 313.241459] IP: ci_dpm_read_sensor&#43;0x37/0xf0 [amdgpu]<br>
<br>
Change-Id: Iac0cf26264ccbc60181ccd9bba79fe3c4e420456<br>
Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/ci_dpm.c | 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/kv_dpm.c | 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/si_dpm.c | 1 &#43;<br>
&nbsp;3 files changed, 3 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c b/drivers/gpu/drm/amd/amdg=
pu/ci_dpm.c<br>
index 98d1dd2..47ef3e6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c<br>
@@ -6244,6 &#43;6244,7 @@ static int ci_dpm_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;powerplay.pp_func=
s =3D &amp;ci_dpm_funcs;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;powerplay.pp_handle =3D =
adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ci_dpm_set_irq_funcs(adev)=
;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/kv_dpm.c b/drivers/gpu/drm/amd/amdg=
pu/kv_dpm.c<br>
index 81babe0..26ba984 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/kv_dpm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/kv_dpm.c<br>
@@ -2963,6 &#43;2963,7 @@ static int kv_dpm_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;powerplay.pp_func=
s =3D &amp;kv_dpm_funcs;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;powerplay.pp_handle =3D =
adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kv_dpm_set_irq_funcs(adev)=
;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdg=
pu/si_dpm.c<br>
index 3bfcf0d..672eaff 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/si_dpm.c<br>
@@ -7917,6 &#43;7917,7 @@ static int si_dpm_early_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;powerplay.pp_func=
s =3D &amp;si_dpm_funcs;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;powerplay.pp_handle =3D =
adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; si_dpm_set_irq_funcs(adev)=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
-- <br>
1.9.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_DM5PR12MB18208D5631DE0C5328D215E0F7AB0DM5PR12MB1820namp_--

--===============0258217538==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0258217538==--
