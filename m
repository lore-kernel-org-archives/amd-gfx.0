From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH -next] drm/amdgpu: Fix return value check in
 amdgpu_allocate_static_csa()
Date: Tue, 4 Dec 2018 07:39:56 +0000
Message-ID: <BYAPR12MB27752170A0E1594190AD34BAFBAF0@BYAPR12MB2775.namprd12.prod.outlook.com>
References: <1543905576-38015-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1793911854=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1543905576-38015-1-git-send-email-weiyongjun1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
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
To: Wei Yongjun <weiyongjun1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "airlied-cv59FeDIM0c@public.gmane.org" <airlied-cv59FeDIM0c@public.gmane.org>, "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Cc: "kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

--===============1793911854==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB27752170A0E1594190AD34BAFBAF0BYAPR12MB2775namp_"

--_000_BYAPR12MB27752170A0E1594190AD34BAFBAF0BYAPR12MB2775namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Yongjun,


This issue has been fixed.


Thanks.


Best Regards

Rex




commit 51f1f6f51712aade68cabb145ed8bab4a6c3997e
Author: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Date:   Fri Nov 23 18:52:21 2018 +0800

    drm/amdgpu: Fix static checker warning

    drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c:49 amdgpu_allocate_static_csa()
    error: uninitialized symbol 'ptr'.

    the test if (!bo) doesn't work, as the bo is a pointer to a pointer.
    if bo create failed, the *bo will be set to NULL.
    so change to test *bo.

    Reviewed-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
    Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
    Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>




________________________________
From: Wei Yongjun <weiyongjun1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Sent: Tuesday, December 4, 2018 2:39 PM
To: Deucher, Alexander; Koenig, Christian; Zhou, David(ChunMing); airlied@l=
inux.ie; Zhu, Rex; Liu, Monk
Cc: Wei Yongjun; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; dri-devel-PD4FTy7X32lNgt0PjOBp93gSJqDPrsil@public.gmane.org=
.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Subject: [PATCH -next] drm/amdgpu: Fix return value check in amdgpu_allocat=
e_static_csa()

Fix the return value check which testing the wrong variable
in amdgpu_allocate_static_csa().

Fixes: 7946340fa389 ("drm/amdgpu: Move csa related code to separate file")
Signed-off-by: Wei Yongjun <weiyongjun1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_csa.c
index 0c590dd..a5fbc6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
@@ -43,7 +43,7 @@ int amdgpu_allocate_static_csa(struct amdgpu_device *adev=
, struct amdgpu_bo **bo
         r =3D amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
                                 domain, bo,
                                 NULL, &ptr);
-       if (!bo)
+       if (!r)
                 return -ENOMEM;

         memset(ptr, 0, size);




--_000_BYAPR12MB27752170A0E1594190AD34BAFBAF0BYAPR12MB2775namp_
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
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Hi Yongjun,</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">This issue has been fixed<span cl=
ass=3D"op_dict_text2"></span>.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Thanks.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex<br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"></p>
<div>commit 51f1f6f51712aade68cabb145ed8bab4a6c3997e<br>
Author: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
Date:&nbsp;&nbsp; Fri Nov 23 18:52:21 2018 &#43;0800<br>
<br>
&nbsp;&nbsp;&nbsp; drm/amdgpu: Fix static checker warning<br>
&nbsp;&nbsp; &nbsp;<br>
&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c:49 amdgpu_alloca=
te_static_csa()<br>
&nbsp;&nbsp;&nbsp; error: uninitialized symbol 'ptr'.<br>
&nbsp;&nbsp; &nbsp;<br>
&nbsp;&nbsp;&nbsp; the test if (!bo) doesn't work, as the bo is a pointer t=
o a pointer.<br>
&nbsp;&nbsp;&nbsp; if bo create failed, the *bo will be set to NULL.<br>
&nbsp;&nbsp;&nbsp; so change to test *bo.<br>
&nbsp;&nbsp; &nbsp;<br>
&nbsp;&nbsp;&nbsp; Reviewed-by: Christian K=F6nig &lt;christian.koenig@amd.=
com&gt;<br>
&nbsp;&nbsp;&nbsp; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&nbsp;&nbsp;&nbsp; Signed-off-by: Alex Deucher &lt;alexander.deucher-urvtwAKJhsc@public.gmane.org=
m&gt;<br>
<br>
</div>
<br>
<p></p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Wei Yongjun &lt;wei=
yongjun1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, December 4, 2018 2:39 PM<br>
<b>To:</b> Deucher, Alexander; Koenig, Christian; Zhou, David(ChunMing); ai=
rlied-cv59FeDIM0c@public.gmane.org; Zhu, Rex; Liu, Monk<br>
<b>Cc:</b> Wei Yongjun; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; dri-devel-PD4FTy7X32mptlylMvRsHA@public.gmane.org=
desktop.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org<=
br>
<b>Subject:</b> [PATCH -next] drm/amdgpu: Fix return value check in amdgpu_=
allocate_static_csa()</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Fix the return value check which testing the wrong=
 variable<br>
in amdgpu_allocate_static_csa().<br>
<br>
Fixes: 7946340fa389 (&quot;drm/amdgpu: Move csa related code to separate fi=
le&quot;)<br>
Signed-off-by: Wei Yongjun &lt;weiyongjun1-hv44wF8Li93QT0dZR+AlfA@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_csa.c<br>
index 0c590dd..a5fbc6f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c<br>
@@ -43,7 &#43;43,7 @@ int amdgpu_allocate_static_csa(struct amdgpu_device *=
adev, struct amdgpu_bo **bo<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_create_ker=
nel(adev, size, PAGE_SIZE,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; domain, bo,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, &amp;ptr);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bo)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(ptr, 0, size);<br>
<br>
<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB27752170A0E1594190AD34BAFBAF0BYAPR12MB2775namp_--

--===============1793911854==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1793911854==--
