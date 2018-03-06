From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/pp: fix "Delete the wrapper layer of
 smu_allocate/free_memory"
Date: Tue, 6 Mar 2018 14:00:27 +0000
Message-ID: <CY4PR12MB1687F118C2D9C07F397AADF5FBD90@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <20180306135811.2147-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0006957576=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180306135811.2147-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0006957576==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687F118C2D9C07F397AADF5FBD90CY4PR12MB1687namp_"

--_000_CY4PR12MB1687F118C2D9C07F397AADF5FBD90CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Rex Zhu<rezhu-5C7GfCeVMHo@public.gmane.org>

Best Regards
Rex


________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Tuesday, March 6, 2018 9:58 PM
To: Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: [PATCH] drm/amd/pp: fix "Delete the wrapper layer of smu_allocate/=
free_memory"

For amdgpu_bo_create_kernel to work the handle must be NULL initialized,
otherwise we only try to pin and map the BO.

Signed-off-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.c     | 2 +-
 drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.c b/drivers/gpu=
/drm/amd/powerplay/smumgr/rv_smumgr.c
index cf9ef7add56b..e2ee23ade5c5 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.c
@@ -327,10 +327,10 @@ static int rv_start_smu(struct pp_hwmgr *hwmgr)

 static int rv_smu_init(struct pp_hwmgr *hwmgr)
 {
+       struct amdgpu_bo *handle =3D NULL;
         struct rv_smumgr *priv;
         uint64_t mc_addr;
         void *kaddr =3D NULL;
-       struct amdgpu_bo *handle;
         int r;

         priv =3D kzalloc(sizeof(struct rv_smumgr), GFP_KERNEL);
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c b/drivers=
/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
index b7be91e7235b..15e1afa28018 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c
@@ -377,11 +377,11 @@ static int vega10_verify_smc_interface(struct pp_hwmg=
r *hwmgr)

 static int vega10_smu_init(struct pp_hwmgr *hwmgr)
 {
+       struct amdgpu_bo *handle =3D NULL;
         struct vega10_smumgr *priv;
         uint64_t mc_addr;
         void *kaddr =3D NULL;
         unsigned long tools_size;
-       struct amdgpu_bo *handle;
         int ret;
         struct cgs_firmware_info info =3D {0};

--
2.14.1


--_000_CY4PR12MB1687F118C2D9C07F397AADF5FBD90CY4PR12MB1687namp_
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
<p style=3D"margin-top:0;margin-bottom:0"><span style=3D"color: rgb(33, 33,=
 33); font-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP=
&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14.6667px;"=
>Reviewed-by: Rex Zhu&lt;rezhu-5C7GfCeVMHo@public.gmane.org&gt;</span><br style=3D"color: rgb(33=
, 33, 33); font-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Seg=
oe WP&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14.666=
7px;">
<br style=3D"color: rgb(33, 33, 33); font-family: wf_segoe-ui_normal, &quot=
;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif, serif, Em=
ojiFont; font-size: 14.6667px;">
<span style=3D"color: rgb(33, 33, 33); font-family: wf_segoe-ui_normal, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif, serif, =
EmojiFont; font-size: 14.6667px;">Best Regards</span><br style=3D"color: rg=
b(33, 33, 33); font-family: wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot=
;Segoe WP&quot;, Tahoma, Arial, sans-serif, serif, EmojiFont; font-size: 14=
.6667px;">
<span style=3D"color: rgb(33, 33, 33); font-family: wf_segoe-ui_normal, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif, serif, =
EmojiFont; font-size: 14.6667px;">Rex</span><br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, March 6, 2018 9:58 PM<br>
<b>To:</b> Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> [PATCH] drm/amd/pp: fix &quot;Delete the wrapper layer of s=
mu_allocate/free_memory&quot;</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">For amdgpu_bo_create_kernel to work the handle mus=
t be NULL initialized,<br>
otherwise we only try to pin and map the BO.<br>
<br>
Signed-off-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.c&nbsp;&nbsp;&nbsp;&nb=
sp; | 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c | 2 &#43;-<br>
&nbsp;2 files changed, 2 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.c b/drivers/gpu=
/drm/amd/powerplay/smumgr/rv_smumgr.c<br>
index cf9ef7add56b..e2ee23ade5c5 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/rv_smumgr.c<br>
@@ -327,10 &#43;327,10 @@ static int rv_start_smu(struct pp_hwmgr *hwmgr)<b=
r>
&nbsp;<br>
&nbsp;static int rv_smu_init(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *handle =3D NULL=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct rv_smumgr *priv;<br=
>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t mc_addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *kaddr =3D NULL;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priv =3D kzalloc(sizeof(st=
ruct rv_smumgr), GFP_KERNEL);<br>
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c b/drivers=
/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c<br>
index b7be91e7235b..15e1afa28018 100644<br>
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/powerplay/smumgr/vega10_smumgr.c<br>
@@ -377,11 &#43;377,11 @@ static int vega10_verify_smc_interface(struct pp_=
hwmgr *hwmgr)<br>
&nbsp;<br>
&nbsp;static int vega10_smu_init(struct pp_hwmgr *hwmgr)<br>
&nbsp;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *handle =3D NULL=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct vega10_smumgr *priv=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t mc_addr;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *kaddr =3D NULL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long tools_size;<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *handle;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct cgs_firmware_info i=
nfo =3D {0};<br>
&nbsp;<br>
-- <br>
2.14.1<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB1687F118C2D9C07F397AADF5FBD90CY4PR12MB1687namp_--

--===============0006957576==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0006957576==--
