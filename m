From: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix regresstion on SR-IOV gpu reset failed
Date: Wed, 18 Oct 2017 09:48:27 +0000
Message-ID: <BLUPR12MB0449D47F84822BEFF2B7F996844D0@BLUPR12MB0449.namprd12.prod.outlook.com>
References: <1508318979-30613-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2109494834=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1508318979-30613-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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

--===============2109494834==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BLUPR12MB0449D47F84822BEFF2B7F996844D0BLUPR12MB0449namp_"

--_000_BLUPR12MB0449D47F84822BEFF2B7F996844D0BLUPR12MB0449namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

yeah, that  way another of my fix patch is not neede


Reviewed-by: Monk Liu <monk.liu-5C7GfCeVMHo@public.gmane.org>


BR Monk

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Rex Zhu =
<Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, October 18, 2017 5:29:39 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex
Subject: [PATCH] drm/amdgpu: fix regresstion on SR-IOV gpu reset failed

fw ucode is corrupted after vf flr by PSP so ucode_init() is
a must in psp_hw_init othewise KIQ/KCQ enabling will fail

Revert "drm/amdgpu: refine code delete duplicated error handling"
This reverts commit e57b87ff828f95efe992468e6d18c2c059b27aa9.
Revert "drm/amdgpu: move amdgpu_ucode_init_bo to amdgpu_device.c"
This reverts commit 815b8f8595148d06a64d2ce4282e8e80dfcb02f1.

Change-Id: I4c4f05ce85f7828e7ac19a2bfffa223614cca59a
Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 8 --------
 drivers/gpu/drm/amd/amdgpu/amdgpu_powerplay.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 9 +++++++++
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 2ae488b..0e35e09 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1680,7 +1680,6 @@ static int amdgpu_init(struct amdgpu_device *adev)
                         return r;
                 }
                 adev->ip_blocks[i].status.sw =3D true;
-
                 /* need to do gmc hw init early so we can allocate gpu mem=
 */
                 if (adev->ip_blocks[i].version->type =3D=3D AMD_IP_BLOCK_T=
YPE_GMC) {
                         r =3D amdgpu_vram_scratch_init(adev);
@@ -1711,11 +1710,6 @@ static int amdgpu_init(struct amdgpu_device *adev)
                 }
         }

-       mutex_lock(&adev->firmware.mutex);
-       if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_DIRECT)
-               amdgpu_ucode_init_bo(adev);
-       mutex_unlock(&adev->firmware.mutex);
-
         for (i =3D 0; i < adev->num_ip_blocks; i++) {
                 if (!adev->ip_blocks[i].status.sw)
                         continue;
@@ -1851,8 +1845,6 @@ static int amdgpu_fini(struct amdgpu_device *adev)

                 adev->ip_blocks[i].status.hw =3D false;
         }
-       if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_DIRECT)
-               amdgpu_ucode_fini_bo(adev);

         for (i =3D adev->num_ip_blocks - 1; i >=3D 0; i--) {
                 if (!adev->ip_blocks[i].status.sw)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_powerplay.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_powerplay.c
index 3b42f40..5f5aa5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_powerplay.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_powerplay.c
@@ -145,6 +145,8 @@ static int amdgpu_pp_hw_init(void *handle)
         int ret =3D 0;
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

+       if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_SMU)
+               amdgpu_ucode_init_bo(adev);

         if (adev->powerplay.ip_funcs->hw_init)
                 ret =3D adev->powerplay.ip_funcs->hw_init(
@@ -162,6 +164,9 @@ static int amdgpu_pp_hw_fini(void *handle)
                 ret =3D adev->powerplay.ip_funcs->hw_fini(
                                         adev->powerplay.pp_handle);

+       if (adev->firmware.load_type =3D=3D AMDGPU_FW_LOAD_SMU)
+               amdgpu_ucode_fini_bo(adev);
+
         return ret;
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index f1035a6..447d446 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -411,6 +411,13 @@ static int psp_hw_init(void *handle)
                 return 0;

         mutex_lock(&adev->firmware.mutex);
+       /*
+        * This sequence is just used on hw_init only once, no need on
+        * resume.
+        */
+       ret =3D amdgpu_ucode_init_bo(adev);
+       if (ret)
+               goto failed;

         ret =3D psp_load_fw(adev);
         if (ret) {
@@ -435,6 +442,8 @@ static int psp_hw_fini(void *handle)
         if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP)
                 return 0;

+       amdgpu_ucode_fini_bo(adev);
+
         psp_ring_destroy(psp, PSP_RING_TYPE__KM);

         amdgpu_bo_free_kernel(&psp->tmr_bo, &psp->tmr_mc_addr, &psp->tmr_b=
uf);
--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BLUPR12MB0449D47F84822BEFF2B7F996844D0BLUPR12MB0449namp_
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
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p>yeah, that&nbsp; way another of&nbsp;my fix patch is not neede</p>
<p><br>
</p>
<p>Reviewed-by: Monk Liu &lt;monk.liu-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
<p><br>
</p>
<p>BR Monk<br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org=
&gt;<br>
<b>Sent:</b> Wednesday, October 18, 2017 5:29:39 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH] drm/amdgpu: fix regresstion on SR-IOV gpu reset fai=
led</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">fw ucode is corrupted after vf flr by PSP so ucode=
_init() is<br>
a must in psp_hw_init othewise KIQ/KCQ enabling will fail<br>
<br>
Revert &quot;drm/amdgpu: refine code delete duplicated error handling&quot;=
<br>
This reverts commit e57b87ff828f95efe992468e6d18c2c059b27aa9.<br>
Revert &quot;drm/amdgpu: move amdgpu_ucode_init_bo to amdgpu_device.c&quot;=
<br>
This reverts commit 815b8f8595148d06a64d2ce4282e8e80dfcb02f1.<br>
<br>
Change-Id: I4c4f05ce85f7828e7ac19a2bfffa223614cca59a<br>
Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&nbsp;&nbsp; | 8 ----=
----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_powerplay.c | 5 &#43;&#43;&#43;&#43=
;&#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 9 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;3 files changed, 14 insertions(&#43;), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 2ae488b..0e35e09 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -1680,7 &#43;1680,6 @@ static int amdgpu_init(struct amdgpu_device *adev=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retur=
n r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i].status.sw =3D true;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* need to do gmc hw init early so we can allocate gp=
u mem */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;ip_blocks[i].version-&gt;type =3D=3D AMD=
_IP_BLOCK_TYPE_GMC) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D=
 amdgpu_vram_scratch_init(adev);<br>
@@ -1711,11 &#43;1710,6 @@ static int amdgpu_init(struct amdgpu_device *ade=
v)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;firmware.mut=
ex);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load_type !=3D =
AMDGPU_FW_LOAD_DIRECT)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_ucode_init_bo(adev);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;firmware.m=
utex);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-=
&gt;num_ip_blocks; i&#43;&#43;) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;ip_blocks[i].status.sw)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
@@ -1851,8 &#43;1845,6 @@ static int amdgpu_fini(struct amdgpu_device *adev=
)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;ip_blocks[i].status.hw =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load_type !=3D =
AMDGPU_FW_LOAD_DIRECT)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_ucode_fini_bo(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D adev-&gt;num_ip=
_blocks - 1; i &gt;=3D 0; i--) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;ip_blocks[i].status.sw)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_powerplay.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_powerplay.c<br>
index 3b42f40..5f5aa5f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_powerplay.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_powerplay.c<br>
@@ -145,6 &#43;145,8 @@ static int amdgpu_pp_hw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load_type =
=3D=3D AMDGPU_FW_LOAD_SMU)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_ucode_init_bo(adev);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;powerplay.ip_=
funcs-&gt;hw_init)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D adev-&gt;powerplay.ip_funcs-&gt;hw_init(<br>
@@ -162,6 &#43;164,9 @@ static int amdgpu_pp_hw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ret =3D adev-&gt;powerplay.ip_funcs-&gt;hw_fini(<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; adev-&gt;powerplay.pp_handle);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load_type =
=3D=3D AMDGPU_FW_LOAD_SMU)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_ucode_fini_bo(adev);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index f1035a6..447d446 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -411,6 &#43;411,13 @@ static int psp_hw_init(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;adev-&gt;f=
irmware.mutex);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * This sequence is just use=
d on hw_init only once, no need on<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * resume.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_ucode_init_bo(adev=
);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto failed;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_load_fw(adev);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret) {<br>
@@ -435,6 &#43;442,8 @@ static int psp_hw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;firmware.load=
_type !=3D AMDGPU_FW_LOAD_PSP)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ucode_fini_bo(adev);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_ring_destroy(psp, PSP_=
RING_TYPE__KM);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp=
;psp-&gt;tmr_bo, &amp;psp-&gt;tmr_mc_addr, &amp;psp-&gt;tmr_buf);<br>
-- <br>
1.9.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font>
</body>
</html>

--_000_BLUPR12MB0449D47F84822BEFF2B7F996844D0BLUPR12MB0449namp_--

--===============2109494834==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2109494834==--
