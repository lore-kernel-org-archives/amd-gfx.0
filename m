From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Fix copy error in uvd_v6/7_0.c
Date: Wed, 26 Sep 2018 13:49:58 +0000
Message-ID: <BYAPR12MB277566A5231A10337060FB10FB150@BYAPR12MB2775.namprd12.prod.outlook.com>
References: <1537965697-29140-1-git-send-email-Rex.Zhu@amd.com>,
 <241c41f3-8adb-6630-5e53-5a758eb52fac@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0226120961=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <241c41f3-8adb-6630-5e53-5a758eb52fac-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============0226120961==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB277566A5231A10337060FB10FB150BYAPR12MB2775namp_"

--_000_BYAPR12MB277566A5231A10337060FB10FB150BYAPR12MB2775namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Ok. I will remove the code.


Best Regards

Rex


________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Wednesday, September 26, 2018 8:45 PM
To: Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amdgpu: Fix copy error in uvd_v6/7_0.c

Am 26.09.2018 um 14:41 schrieb Rex Zhu:
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

Actually that code can just be removed because uvd_*_enc_get_destroy_msg
is only called with direct=3Dtrue.

Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 2 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v6_0.c
> index 8ef4a53..2ceab76 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -313,7 +313,7 @@ static int uvd_v6_0_enc_get_destroy_msg(struct amdgpu=
_ring *ring,
>        if (direct)
>                r =3D amdgpu_job_submit_direct(job, ring, &f);
>        else
> -             r =3D amdgpu_job_submit(job, &ring->adev->vce.entity,
> +             r =3D amdgpu_job_submit(job, &ring->adev->uvd.entity,
>                                      AMDGPU_FENCE_OWNER_UNDEFINED, &f);
>        if (r)
>                goto err;
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/uvd_v7_0.c
> index a289f6a..31a9665 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -320,7 +320,7 @@ int uvd_v7_0_enc_get_destroy_msg(struct amdgpu_ring *=
ring, uint32_t handle,
>        if (direct)
>                r =3D amdgpu_job_submit_direct(job, ring, &f);
>        else
> -             r =3D amdgpu_job_submit(job, &ring->adev->vce.entity,
> +             r =3D amdgpu_job_submit(job, &ring->adev->uvd.entity,
>                                      AMDGPU_FENCE_OWNER_UNDEFINED, &f);
>        if (r)
>                goto err;


--_000_BYAPR12MB277566A5231A10337060FB10FB150BYAPR12MB2775namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Ok. I will remove the code.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex<br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" color=
=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> Christian K=F6nig &l=
t;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, September 26, 2018 8:45 PM<br>
<b>To:</b> Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Fix copy error in uvd_v6/7_0.c</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 26.09.2018 um 14:41 schrieb Rex Zhu:<br>
&gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Actually that code can just be removed because uvd_*_enc_get_destroy_msg <b=
r>
is only called with direct=3Dtrue.<br>
<br>
Christian.<br>
<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 2 &#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c | 2 &#43;-<br>
&gt;&nbsp;&nbsp; 2 files changed, 2 insertions(&#43;), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/a=
md/amdgpu/uvd_v6_0.c<br>
&gt; index 8ef4a53..2ceab76 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
&gt; @@ -313,7 &#43;313,7 @@ static int uvd_v6_0_enc_get_destroy_msg(struct=
 amdgpu_ring *ring,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (direct)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; r =3D amdgpu_job_submit_direct(job, ring, &amp;f);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D amdgpu_job_submit(job, &amp;ring-&gt;adev-&gt;vce.entity,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D amdgpu_job_submit(job, &amp;ring-&gt;adev-&gt;uvd.entity,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; AMDGPU_FENCE_OWNER_UNDEFINED, &amp;f);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto err;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/a=
md/amdgpu/uvd_v7_0.c<br>
&gt; index a289f6a..31a9665 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c<br>
&gt; @@ -320,7 &#43;320,7 @@ int uvd_v7_0_enc_get_destroy_msg(struct amdgpu=
_ring *ring, uint32_t handle,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (direct)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; r =3D amdgpu_job_submit_direct(job, ring, &amp;f);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D amdgpu_job_submit(job, &amp;ring-&gt;adev-&gt;vce.entity,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D amdgpu_job_submit(job, &amp;ring-&gt;adev-&gt;uvd.entity,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; AMDGPU_FENCE_OWNER_UNDEFINED, &amp;f);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto err;<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB277566A5231A10337060FB10FB150BYAPR12MB2775namp_--

--===============0226120961==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0226120961==--
