From: "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] drm/amdgpu/gmc10: apply the 'invalidation from sdma'
 workaround for navi
Date: Thu, 26 Sep 2019 12:24:31 +0000
Message-ID: <MN2PR12MB3344DE303C67119711B88DB5E4860@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20190926080746.20765-1-xiaojie.yuan@amd.com>
 <BN8PR12MB36027CA5662543E7F956657589860@BN8PR12MB3602.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0912493067=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN8PR12MB36027CA5662543E7F956657589860-h6+T2+wrnx1lGJ5xs4l7kQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
Cc: "alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--===============0912493067==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3344DE303C67119711B88DB5E4860MN2PR12MB3344namp_"

--_000_MN2PR12MB3344DE303C67119711B88DB5E4860MN2PR12MB3344namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This patch was already reviewed-by. I think you can land it on the branch d=
irectly.

From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of Yuan, Xi=
aojie
Sent: Thursday, September 26, 2019 4:09 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: Re: [PATCH] drm/amdgpu/gmc10: apply the 'invalidation from sdma' w=
orkaround for navi

Hi Alex,

This patch is to add the asic_type check which is missing after drm-next br=
anch rebase.

BR,
Xiaojie
________________________________
From: Yuan, Xiaojie <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org<mailto:Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>>
Sent: Thursday, September 26, 2019 4:08 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> <am=
d-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>>
Cc: alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> <alexdeucher@gmail.=
com<mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>; Yuan, Xiaojie <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org<mai=
lto:Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>>
Subject: [PATCH] drm/amdgpu/gmc10: apply the 'invalidation from sdma' worka=
round for navi

Fixes: 767acabdac81 ("drm/amd/powerplay: add baco smu reset function for sm=
u11")
Signed-off-by: Xiaojie Yuan <xiaojie.yuan-5C7GfCeVMHo@public.gmane.org<mailto:xiaojie.yuan@amd.c=
om>>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c
index cb3f61873baa..dc2e68e019eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -292,6 +292,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_devic=
e *adev, uint32_t vmid,

         if (!adev->mman.buffer_funcs_enabled ||
             !adev->ib_pool_ready ||
+           !(adev->asic_type >=3D CHIP_NAVI10 && adev->asic_type <=3D CHIP=
_NAVI12) ||
             adev->in_gpu_reset) {
                 gmc_v10_0_flush_vm_hub(adev, vmid, AMDGPU_GFXHUB_0, 0);
                 mutex_unlock(&adev->mman.gtt_window_lock);
--
2.20.1

--_000_MN2PR12MB3344DE303C67119711B88DB5E4860MN2PR12MB3344namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">This patch was already reviewed-by. I think you can =
land it on the branch directly.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32mMSPqsTGOZug@public.gmane.org=
esktop.org&gt;
<b>On Behalf Of </b>Yuan, Xiaojie<br>
<b>Sent:</b> Thursday, September 26, 2019 4:09 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu/gmc10: apply the 'invalidation from =
sdma' workaround for navi<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Hi Alex,<o:p></o:p></spa=
n></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">This patch is to add the=
 asic_type check which is missing after drm-next branch rebase.<o:p></o:p><=
/span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">BR,<o:p></o:p></span></p=
>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Xiaojie<o:p></o:p></span=
></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Yuan, Xiaojie &lt;<a href=3D"mailto:Xiaojie.Yuan@am=
d.com">Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<b>Sent:</b> Thursday, September 26, 2019 4:08 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</=
a> &lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&g=
t;; Yuan, Xiaojie &lt;<a href=3D"mailto:Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org">Xiaojie.Yuan@=
amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/gmc10: apply the 'invalidation from sdma=
' workaround for navi</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Fixes: 767acabdac81 (=
&quot;drm/amd/powerplay: add baco smu reset function for smu11&quot;)<br>
Signed-off-by: Xiaojie Yuan &lt;<a href=3D"mailto:xiaojie.yuan-5C7GfCeVMHo@public.gmane.org">xia=
ojie.yuan-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 1 &#43;<br>
&nbsp;1 file changed, 1 insertion(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/a=
mdgpu/gmc_v10_0.c<br>
index cb3f61873baa..dc2e68e019eb 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
@@ -292,6 &#43;292,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_d=
evice *adev, uint32_t vmid,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;mman.buffer_=
funcs_enabled ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !a=
dev-&gt;ib_pool_ready ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !(adev-&g=
t;asic_type &gt;=3D CHIP_NAVI10 &amp;&amp; adev-&gt;asic_type &lt;=3D CHIP_=
NAVI12) ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ad=
ev-&gt;in_gpu_reset) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; gmc_v10_0_flush_vm_hub(adev, vmid, AMDGPU_GFXHUB_0, 0=
);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;mman.gtt_window_lock);<br>
-- <br>
2.20.1<o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB3344DE303C67119711B88DB5E4860MN2PR12MB3344namp_--

--===============0912493067==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0912493067==--
