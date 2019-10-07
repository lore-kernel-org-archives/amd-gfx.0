From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: Fix error handling in
 smu_init_fb_allocations()
Date: Mon, 7 Oct 2019 10:32:01 +0000
Message-ID: <MN2PR12MB32963D6B4480B85DC9DC379FA29B0@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20191007090206.GD3865@mwanda>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0245213102=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191007090206.GD3865@mwanda>
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
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, Rex Zhu <rex.zhu-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Quan, Evan" <Evan.Quan-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============0245213102==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB32963D6B4480B85DC9DC379FA29B0MN2PR12MB3296namp_"

--_000_MN2PR12MB32963D6B4480B85DC9DC379FA29B0MN2PR12MB3296namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

thanks correct it.

Reviewed-by: Kevin Wang <kevin1.wang-5C7GfCeVMHo@public.gmane.org>

Best Regards,
Kevin
________________________________
From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Sent: Monday, October 7, 2019 5:02 PM
To: Rex Zhu <rex.zhu-5C7GfCeVMHo@public.gmane.org>; Wang, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Cc: Quan, Evan <Evan.Quan-5C7GfCeVMHo@public.gmane.org>; Deucher, Alexander <Alexander.Deucher@a=
md.com>; Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>; Zhou, David(ChunMing=
) <David1.Zhou-5C7GfCeVMHo@public.gmane.org>; David Airlie <airlied-cv59FeDIM0c@public.gmane.org>; Daniel Vetter <da=
niel-/w4YWyX8dFk@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9/EVdHwE84te@public.gmane.org=
g>; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; kern=
el-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org <kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Subject: [PATCH] drm/amd/powerplay: Fix error handling in smu_init_fb_alloc=
ations()

The error handling is off by one.  We should not free the first
"tables[i].bo" without decrementing "i" because that might result in a
double free.  The second problem is that when an error occurs, then the
zeroth element "tables[0].bo" isn't freed.

I had make "i" signed int for the error handling to work, so I just
updated "ret" as well as a clean up.

Fixes: f96357a991b9 ("drm/amd/powerplay: implement smu_init(fini)_fb_alloca=
tions function")
Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c
index f1fbbc8b77ee..c9266ea70331 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -896,8 +896,7 @@ static int smu_init_fb_allocations(struct smu_context *=
smu)
         struct amdgpu_device *adev =3D smu->adev;
         struct smu_table_context *smu_table =3D &smu->smu_table;
         struct smu_table *tables =3D smu_table->tables;
-       uint32_t i =3D 0;
-       int32_t ret =3D 0;
+       int ret, i;

         for (i =3D 0; i < SMU_TABLE_COUNT; i++) {
                 if (tables[i].size =3D=3D 0)
@@ -915,7 +914,7 @@ static int smu_init_fb_allocations(struct smu_context *=
smu)

         return 0;
 failed:
-       for (; i > 0; i--) {
+       while (--i >=3D 0) {
                 if (tables[i].size =3D=3D 0)
                         continue;
                 amdgpu_bo_free_kernel(&tables[i].bo,
--
2.20.1


--_000_MN2PR12MB32963D6B4480B85DC9DC379FA29B0MN2PR12MB3296namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif">
thanks correct it.</div>
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif">
<br>
</div>
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif">
Revie<span style=3D"margin: 0px">wed-by: Kevin Wang &lt;kevin1.wang-5C7GfCeVMHo@public.gmane.org=
&gt;</span></div>
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif">
<br>
</div>
<div style=3D"margin: 0px; font-size: 12pt; font-family: Calibri, Arial, He=
lvetica, sans-serif">
Best Regards,<br>
Kevin</div>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Dan Carpenter &lt;dan=
.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, October 7, 2019 5:02 PM<br>
<b>To:</b> Rex Zhu &lt;rex.zhu-5C7GfCeVMHo@public.gmane.org&gt;; Wang, Kevin(Yang) &lt;Kevin1.Wa=
ng-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> Quan, Evan &lt;Evan.Quan-5C7GfCeVMHo@public.gmane.org&gt;; Deucher, Alexander &lt;Ale=
xander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Koenig, Christian &lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&=
gt;; Zhou, David(ChunMing) &lt;David1.Zhou-5C7GfCeVMHo@public.gmane.org&gt;; David Airlie &lt;ai=
rlied-cv59FeDIM0c@public.gmane.org&gt;; Daniel Vetter &lt;daniel-/w4YWyX8dFk@public.gmane.org&gt;; amd-gfx-PD4FTy7X32k@public.gmane.org=
eedesktop.org
 &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt=
;dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;; kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org &lt;k=
ernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/powerplay: Fix error handling in smu_init_f=
b_allocations()</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">The error handling is off by one.&nbsp; We should =
not free the first<br>
&quot;tables[i].bo&quot; without decrementing &quot;i&quot; because that mi=
ght result in a<br>
double free.&nbsp; The second problem is that when an error occurs, then th=
e<br>
zeroth element &quot;tables[0].bo&quot; isn't freed.<br>
<br>
I had make &quot;i&quot; signed int for the error handling to work, so I ju=
st<br>
updated &quot;ret&quot; as well as a clean up.<br>
<br>
Fixes: f96357a991b9 (&quot;drm/amd/powerplay: implement smu_init(fini)_fb_a=
llocations function&quot;)<br>
Signed-off-by: Dan Carpenter &lt;dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/amdgpu_smu.c | 5 &#43;&#43;---<br>
&nbsp;1 file changed, 2 insertions(&#43;), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/a=
md/powerplay/amdgpu_smu.c<br>
index f1fbbc8b77ee..c9266ea70331 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c<br>
@@ -896,8 &#43;896,7 @@ static int smu_init_fb_allocations(struct smu_conte=
xt *smu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D smu-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table_context *=
smu_table =3D &amp;smu-&gt;smu_table;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct smu_table *tables =
=3D smu_table-&gt;tables;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i =3D 0;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int32_t ret =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret, i;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; SMU_T=
ABLE_COUNT; i&#43;&#43;) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (tables[i].size =3D=3D 0)<br>
@@ -915,7 &#43;914,7 @@ static int smu_init_fb_allocations(struct smu_conte=
xt *smu)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;failed:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (; i &gt; 0; i--) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (--i &gt;=3D 0) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (tables[i].size =3D=3D 0)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp;tables[i].bo,<br>
-- <br>
2.20.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB32963D6B4480B85DC9DC379FA29B0MN2PR12MB3296namp_--

--===============0245213102==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0245213102==--
