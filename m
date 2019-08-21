From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/sdma5: fix number of sdma5 trap irq types for
 navi1x
Date: Wed, 21 Aug 2019 17:43:19 +0000
Message-ID: <BN6PR12MB18092E70EEF7E6DEB2A2C3CEF7AA0@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190821135226.16967-1-xiaojie.yuan@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0685397713=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190821135226.16967-1-xiaojie.yuan-5C7GfCeVMHo@public.gmane.org>
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
To: "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Xiao,
 Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

--===============0685397713==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18092E70EEF7E6DEB2A2C3CEF7AA0BN6PR12MB1809namp_"

--_000_BN6PR12MB18092E70EEF7E6DEB2A2C3CEF7AA0BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Yuan, Xi=
aojie <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
Sent: Wednesday, August 21, 2019 9:52 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; Xiao, Jack <Jack.Xiao@am=
d.com>; Yuan, Xiaojie <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>; Zhang, Hawking <Hawking.Zhang=
@amd.com>
Subject: [PATCH] drm/amdgpu/sdma5: fix number of sdma5 trap irq types for n=
avi1x

v2: set num_types based on num_instances

navi1x has 2 sdma engines but commit
"e7b58d03b678 drm/amdgpu: reorganize sdma v4 code to support more instances=
"
changes the max number of sdma irq types (AMDGPU_SDMA_IRQ_LAST) from 2 to 8
which causes amdgpu_irq_gpu_reset_resume_helper() to recover irq of sdma
engines with following logic:

(enable irq for sdma0) * 1 time
(enable irq for sdma1) * 1 time
(disable irq for sdma1) * 6 times

as a result, after gpu reset, interrupt for sdma1 is lost.

Signed-off-by: Xiaojie Yuan <xiaojie.yuan-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_0.c
index 41932d8b88c3..89174e778d2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1625,7 +1625,8 @@ static const struct amdgpu_irq_src_funcs sdma_v5_0_il=
legal_inst_irq_funcs =3D {

 static void sdma_v5_0_set_irq_funcs(struct amdgpu_device *adev)
 {
-       adev->sdma.trap_irq.num_types =3D AMDGPU_SDMA_IRQ_LAST;
+       adev->sdma.trap_irq.num_types =3D AMDGPU_SDMA_IRQ_INSTANCE0 +
+                                       adev->sdma.num_instances;
         adev->sdma.trap_irq.funcs =3D &sdma_v5_0_trap_irq_funcs;
         adev->sdma.illegal_inst_irq.funcs =3D &sdma_v5_0_illegal_inst_irq_=
funcs;
 }
--
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB18092E70EEF7E6DEB2A2C3CEF7AA0BN6PR12MB1809namp_
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
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Yuan, Xiaojie &lt;Xiaojie.Yua=
n@amd.com&gt;<br>
<b>Sent:</b> Wednesday, August 21, 2019 9:52 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;; Xiao, Jack =
&lt;Jack.Xiao-5C7GfCeVMHo@public.gmane.org&gt;; Yuan, Xiaojie &lt;Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org&gt;; Zhan=
g, Hawking &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/sdma5: fix number of sdma5 trap irq type=
s for navi1x</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">v2: set num_types based on num_instances<br>
<br>
navi1x has 2 sdma engines but commit<br>
&quot;e7b58d03b678 drm/amdgpu: reorganize sdma v4 code to support more inst=
ances&quot;<br>
changes the max number of sdma irq types (AMDGPU_SDMA_IRQ_LAST) from 2 to 8=
<br>
which causes amdgpu_irq_gpu_reset_resume_helper() to recover irq of sdma<br=
>
engines with following logic:<br>
<br>
(enable irq for sdma0) * 1 time<br>
(enable irq for sdma1) * 1 time<br>
(disable irq for sdma1) * 6 times<br>
<br>
as a result, after gpu reset, interrupt for sdma1 is lost.<br>
<br>
Signed-off-by: Xiaojie Yuan &lt;xiaojie.yuan-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 3 &#43;&#43;-<br>
&nbsp;1 file changed, 2 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_0.c<br>
index 41932d8b88c3..89174e778d2f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c<br>
@@ -1625,7 &#43;1625,8 @@ static const struct amdgpu_irq_src_funcs sdma_v5_=
0_illegal_inst_irq_funcs =3D {<br>
&nbsp;<br>
&nbsp;static void sdma_v5_0_set_irq_funcs(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;sdma.trap_irq.num_types =3D =
AMDGPU_SDMA_IRQ_LAST;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;sdma.trap_irq.num_types =
=3D AMDGPU_SDMA_IRQ_INSTANCE0 &#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; adev-&gt;sdma.num_instances;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;sdma.trap_irq.fun=
cs =3D &amp;sdma_v5_0_trap_irq_funcs;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;sdma.illegal_inst=
_irq.funcs =3D &amp;sdma_v5_0_illegal_inst_irq_funcs;<br>
&nbsp;}<br>
-- <br>
2.20.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB18092E70EEF7E6DEB2A2C3CEF7AA0BN6PR12MB1809namp_--

--===============0685397713==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0685397713==--
