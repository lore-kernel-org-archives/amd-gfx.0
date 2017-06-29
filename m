From: "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2] drm/amdgpu: fix the memory corruption on S3
Date: Thu, 29 Jun 2017 08:27:33 +0000
Message-ID: <BY2PR1201MB0968FF9F474337CB95E039B289D20@BY2PR1201MB0968.namprd12.prod.outlook.com>
References: <1498723761-6723-1-git-send-email-ray.huang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0448041043=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1498723761-6723-1-git-send-email-ray.huang-5C7GfCeVMHo@public.gmane.org>
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
Cc: "Jiang, Sonny" <Sonny.Jiang-5C7GfCeVMHo@public.gmane.org>, "Huan, Alvin" <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>, "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>, "Qiao, Joe(Markham)" <Joe2.Qiao-5C7GfCeVMHo@public.gmane.org>

--===============0448041043==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY2PR1201MB0968FF9F474337CB95E039B289D20BY2PR1201MB0968_"

--_000_BY2PR1201MB0968FF9F474337CB95E039B289D20BY2PR1201MB0968_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Tested-by: Xiaojie Yuan <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>


Regards,

Xiaojie

________________________________
From: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, June 29, 2017 4:09:21 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander; Koenig, Christian
Cc: Wang, Ken; Qiao, Joe(Markham); Jiang, Sonny; Huan, Alvin; Yuan, Xiaojie=
; Huang, Ray
Subject: [PATCH v2] drm/amdgpu: fix the memory corruption on S3

psp->cmd will be used on resume phase, so we can not free it on hw_init.
Otherwise, a memory corruption will be triggered.

Signed-off-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
---

V1 -> V2:
- remove "cmd" variable.
- fix typo of check.

Alex, Christian,

This is the final fix for vega10 S3. The random memory corruption issue is =
root
caused.

Thanks,
Ray

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 5bed483..711476792 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -330,14 +330,11 @@ static int psp_load_fw(struct amdgpu_device *adev)
 {
         int ret;
         struct psp_context *psp =3D &adev->psp;
-       struct psp_gfx_cmd_resp *cmd;

-       cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
-       if (!cmd)
+       psp->cmd =3D kzalloc(sizeof(struct psp_gfx_cmd_resp), GFP_KERNEL);
+       if (!psp->cmd)
                 return -ENOMEM;

-       psp->cmd =3D cmd;
-
         ret =3D amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
                                       AMDGPU_GEM_DOMAIN_GTT,
                                       &psp->fw_pri_bo,
@@ -376,8 +373,6 @@ static int psp_load_fw(struct amdgpu_device *adev)
         if (ret)
                 goto failed_mem;

-       kfree(cmd);
-
         return 0;

 failed_mem:
@@ -387,7 +382,8 @@ static int psp_load_fw(struct amdgpu_device *adev)
         amdgpu_bo_free_kernel(&psp->fw_pri_bo,
                               &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
 failed:
-       kfree(cmd);
+       kfree(psp->cmd);
+       psp->cmd =3D NULL;
         return ret;
 }

@@ -447,6 +443,11 @@ static int psp_hw_fini(void *handle)
                 amdgpu_bo_free_kernel(&psp->fence_buf_bo,
                                       &psp->fence_buf_mc_addr, &psp->fence=
_buf);

+       if (psp->cmd) {
+               kfree(psp->cmd);
+               psp->cmd =3D NULL;
+       }
+
         return 0;
 }

--
2.7.4


--_000_BY2PR1201MB0968FF9F474337CB95E039B289D20BY2PR1201MB0968_
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
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p><span style=3D"font-size:11pt">Tested-by: Xiaojie Yuan &lt;Xiaojie.Yuan@=
amd.com&gt;</span></p>
<p><br>
</p>
<p><span style=3D"font-size:11pt">Regards,</span></p>
<p><span style=3D"font-size:11pt">Xiaojie</span><br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Huang Rui &lt;ray.h=
uang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, June 29, 2017 4:09:21 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander; Koenig, Chris=
tian<br>
<b>Cc:</b> Wang, Ken; Qiao, Joe(Markham); Jiang, Sonny; Huan, Alvin; Yuan, =
Xiaojie; Huang, Ray<br>
<b>Subject:</b> [PATCH v2] drm/amdgpu: fix the memory corruption on S3</fon=
t>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">psp-&gt;cmd will be used on resume phase, so we ca=
n not free it on hw_init.<br>
Otherwise, a memory corruption will be triggered.<br>
<br>
Signed-off-by: Huang Rui &lt;ray.huang-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
<br>
V1 -&gt; V2:<br>
- remove &quot;cmd&quot; variable.<br>
- fix typo of check.<br>
<br>
Alex, Christian,<br>
<br>
This is the final fix for vega10 S3. The random memory corruption issue is =
root<br>
caused.<br>
<br>
Thanks,<br>
Ray<br>
<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 17 &#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;--------<br>
&nbsp;1 file changed, 9 insertions(&#43;), 8 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index 5bed483..711476792 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -330,14 &#43;330,11 @@ static int psp_load_fw(struct amdgpu_device *adev=
)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_context *psp =
=3D &amp;adev-&gt;psp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct psp_gfx_cmd_resp *cmd;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cmd =3D kzalloc(sizeof(struct psp_gfx=
_cmd_resp), GFP_KERNEL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!cmd)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;cmd =3D kzalloc(sizeof(st=
ruct psp_gfx_cmd_resp), GFP_KERNEL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!psp-&gt;cmd)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;cmd =3D cmd;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_create_k=
ernel(adev, PSP_1_MEG, PSP_1_MEG,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; AMDGPU_GEM_DOMAIN_GTT,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; &amp;psp-&gt;fw_pri_bo,<br>
@@ -376,8 &#43;373,6 @@ static int psp_load_fw(struct amdgpu_device *adev)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto failed_mem;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(cmd);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
&nbsp;failed_mem:<br>
@@ -387,7 &#43;382,8 @@ static int psp_load_fw(struct amdgpu_device *adev)<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp=
;psp-&gt;fw_pri_bo,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;psp-&gt;fw_pri_mc_addr, &amp;psp-&gt;fw=
_pri_buf);<br>
&nbsp;failed:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(cmd);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(psp-&gt;cmd);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp-&gt;cmd =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
@@ -447,6 &#43;443,11 @@ static int psp_hw_fini(void *handle)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp;psp-&gt;fence_buf_bo,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; &amp;psp-&gt;fence_buf_mc_addr, &amp;psp-&gt;fence_buf);<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psp-&gt;cmd) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; kfree(psp-&gt;cmd);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; psp-&gt;cmd =3D NULL;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.7.4<br>
<br>
</div>
</span></font>
</body>
</html>

--_000_BY2PR1201MB0968FF9F474337CB95E039B289D20BY2PR1201MB0968_--

--===============0448041043==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0448041043==--
