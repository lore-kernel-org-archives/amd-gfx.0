From: "Zhao, Jiange" <Jiange.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/SRIOV: Only reset hw.status for target IP
Date: Wed, 30 Oct 2019 02:26:24 +0000
Message-ID: <MN2PR12MB3056C5DBA2AD474DB9A005C7E1600@MN2PR12MB3056.namprd12.prod.outlook.com>
References: <20191029074248.11942-1-jianzh@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0061905851=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191029074248.11942-1-jianzh-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhao, Jiange" <Jiange.Zhao-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "Chang,
 HaiJun" <HaiJun.Chang-5C7GfCeVMHo@public.gmane.org>

--===============0061905851==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3056C5DBA2AD474DB9A005C7E1600MN2PR12MB3056namp_"

--_000_MN2PR12MB3056C5DBA2AD474DB9A005C7E1600MN2PR12MB3056namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Ping.

@Deng, Emily<mailto:Emily.Deng-5C7GfCeVMHo@public.gmane.org> @Liu, Monk<mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org>=
, can you help review this patch?

Thanks!
Jiange
________________________________
From: Zhao, Jiange <jianzh-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, October 29, 2019 3:43 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Deng, Emily <Emily.Deng-5C7GfCeVMHo@public.gmane.org>; Liu, Monk <Monk.Liu-5C7GfCeVMHo@public.gmane.org>; Chang, =
HaiJun <HaiJun.Chang-5C7GfCeVMHo@public.gmane.org>; Zhao, Jiange <Jiange.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH] drm/amdgpu/SRIOV: Only reset hw.status for target IP

From: Jiange Zhao <Jiange.Zhao-5C7GfCeVMHo@public.gmane.org>

In the old way, when doing IH hw_init, PSP, nv_common
and GMC hw.status would be reset to false, even though
their hw_init have been done. In the next step, fw_loading,
PSP would do hw_init again.

In the new way, only reset hw.status to false for the target
IP in the list. In this way, PSP will only do hw_init once.

Signed-off-by: Jiange Zhao <Jiange.Zhao-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 4eee40b9d0b0..ad6d2452fed9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2352,11 +2352,11 @@ static int amdgpu_device_ip_reinit_early_sriov(stru=
ct amdgpu_device *adev)
                 for (j =3D 0; j < adev->num_ip_blocks; j++) {
                         block =3D &adev->ip_blocks[j];

-                       block->status.hw =3D false;
                         if (block->version->type !=3D ip_order[i] ||
                                 !block->status.valid)
                                 continue;

+                       block->status.hw =3D false;
                         r =3D block->version->funcs->hw_init(adev);
                         DRM_INFO("RE-INIT-early: %s %s\n", block->version-=
>funcs->name, r?"failed":"succeeded");
                         if (r)
--
2.20.1


--_000_MN2PR12MB3056C5DBA2AD474DB9A005C7E1600MN2PR12MB3056namp_
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
Ping.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<a id=3D"OWAAM822686" class=3D"_1OtrSZdhKXVv3UhaivrdJ4 mention ms-bgc-nlr m=
s-fcl-b" href=3D"mailto:Emily.Deng-5C7GfCeVMHo@public.gmane.org">@Deng, Emily</a>
<a id=3D"OWAAM720573" class=3D"_1OtrSZdhKXVv3UhaivrdJ4 mention ms-bgc-nlr m=
s-fcl-b" href=3D"mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">
@Liu, Monk</a>, can you help review this patch?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jiange<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhao, Jiange &lt;jian=
zh-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, October 29, 2019 3:43 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Cc:</b> Deng, Emily &lt;Emily.Deng-5C7GfCeVMHo@public.gmane.org&gt;; Liu, Monk &lt;Monk.Liu@a=
md.com&gt;; Chang, HaiJun &lt;HaiJun.Chang-5C7GfCeVMHo@public.gmane.org&gt;; Zhao, Jiange &lt;Ji=
ange.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/SRIOV: Only reset hw.status for target I=
P</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">From: Jiange Zhao &lt;Jiange.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
In the old way, when doing IH hw_init, PSP, nv_common<br>
and GMC hw.status would be reset to false, even though<br>
their hw_init have been done. In the next step, fw_loading,<br>
PSP would do hw_init again.<br>
<br>
In the new way, only reset hw.status to false for the target<br>
IP in the list. In this way, PSP will only do hw_init once.<br>
<br>
Signed-off-by: Jiange Zhao &lt;Jiange.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 &#43;-<br>
&nbsp;1 file changed, 1 insertion(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 4eee40b9d0b0..ad6d2452fed9 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2352,11 &#43;2352,11 @@ static int amdgpu_device_ip_reinit_early_sriov(=
struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; for (j =3D 0; j &lt; adev-&gt;num_ip_blocks; j&#43;&#=
43;) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; block=
 =3D &amp;adev-&gt;ip_blocks[j];<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; block-&gt;status=
.hw =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (b=
lock-&gt;version-&gt;type !=3D ip_order[i] ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !block-&gt;status.valid)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; continue;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; block-&gt;st=
atus.hw =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D=
 block-&gt;version-&gt;funcs-&gt;hw_init(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_I=
NFO(&quot;RE-INIT-early: %s %s\n&quot;, block-&gt;version-&gt;funcs-&gt;nam=
e, r?&quot;failed&quot;:&quot;succeeded&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r=
)<br>
-- <br>
2.20.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB3056C5DBA2AD474DB9A005C7E1600MN2PR12MB3056namp_--

--===============0061905851==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0061905851==--
