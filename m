From: "Yin, Tianci (Rico)" <Tianci.Yin-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/psp: move TMR to cpu invisible vram region
Date: Mon, 19 Aug 2019 08:16:28 +0000
Message-ID: <MN2PR12MB2974D98262E42F1C6FB6644A95A80@MN2PR12MB2974.namprd12.prod.outlook.com>
References: <1566201945-18101-1-git-send-email-tianci.yin@amd.com>,
 <b1b7dd46-8ee5-deaf-1a24-ef152c96dcb6@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0057479078=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <b1b7dd46-8ee5-deaf-1a24-ef152c96dcb6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>, "Zhang, Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>, "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>

--===============0057479078==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB2974D98262E42F1C6FB6644A95A80MN2PR12MB2974namp_"

--_000_MN2PR12MB2974D98262E42F1C6FB6644A95A80MN2PR12MB2974namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks very much Christian!

I scanned the whole code, only two functions pass in NULL cpu_addr,
amdgpu_ttm_init() and gfx_v9_0_ngg_create_buf(),
but the related BOs are not further mapped for cpu access.
so I think this change is safe.


________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Monday, August 19, 2019 16:07
To: Yin, Tianci (Rico) <Tianci.Yin-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org =
<amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Xiao, Jack <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>; Yuan, Xiaojie <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>; Z=
hang, Hawking <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/psp: move TMR to cpu invisible vram region

Am 19.08.19 um 10:05 schrieb Tianci Yin:
> From: "Tianci.Yin" <tianci.yin-5C7GfCeVMHo@public.gmane.org>
>
> so that more visible vram can be available for umd.
>
> Signed-off-by: Tianci.Yin <tianci.yin-5C7GfCeVMHo@public.gmane.org>

Assuming that you checked that we don't have other users who are using
amdgpu_bo_create_kernel() without a CPU pointer this patch is
Reviewed-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 5 +++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    | 1 -
>   3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index 1059771..0476790 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -246,8 +246,9 @@ int amdgpu_bo_create_reserved(struct amdgpu_device *a=
dev,
>        bp.size =3D size;
>        bp.byte_align =3D align;
>        bp.domain =3D domain;
> -     bp.flags =3D AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
> -             AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
> +     bp.flags =3D cpu_addr ? AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED
> +             : AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
> +     bp.flags |=3D AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
>        bp.type =3D ttm_bo_type_kernel;
>        bp.resv =3D NULL;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 7715c0d..5e7fbbe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -264,7 +264,7 @@ static int psp_tmr_init(struct psp_context *psp)
>
>        ret =3D amdgpu_bo_create_kernel(psp->adev, tmr_size, PSP_TMR_SIZE,
>                                      AMDGPU_GEM_DOMAIN_VRAM,
> -                                   &psp->tmr_bo, &psp->tmr_mc_addr, &psp=
->tmr_buf);
> +                                   &psp->tmr_bo, &psp->tmr_mc_addr, NULL=
);
>
>        return ret;
>   }
> @@ -1215,7 +1215,7 @@ static int psp_hw_fini(void *handle)
>
>        psp_ring_destroy(psp, PSP_RING_TYPE__KM);
>
> -     amdgpu_bo_free_kernel(&psp->tmr_bo, &psp->tmr_mc_addr, &psp->tmr_bu=
f);
> +     amdgpu_bo_free_kernel(&psp->tmr_bo, &psp->tmr_mc_addr, NULL);
>        amdgpu_bo_free_kernel(&psp->fw_pri_bo,
>                              &psp->fw_pri_mc_addr, &psp->fw_pri_buf);
>        amdgpu_bo_free_kernel(&psp->fence_buf_bo,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.h
> index 0029fa2..48b057d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> @@ -172,7 +172,6 @@ struct psp_context
>        /* tmr buffer */
>        struct amdgpu_bo                *tmr_bo;
>        uint64_t                        tmr_mc_addr;
> -     void                            *tmr_buf;
>
>        /* asd firmware and buffer */
>        const struct firmware           *asd_fw;


--_000_MN2PR12MB2974D98262E42F1C6FB6644A95A80MN2PR12MB2974namp_
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
Thanks very much Christian!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I scanned the whole code, only two functions pass in NULL cpu_addr,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
amdgpu_ttm_init() and gfx_v9_0_ngg_create_buf(),</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
but the related BOs are not further mapped for cpu access.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
so I think this change is safe.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, August 19, 2019 16:07<br>
<b>To:</b> Yin, Tianci (Rico) &lt;Tianci.Yin-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;<br>
<b>Cc:</b> Xiao, Jack &lt;Jack.Xiao-5C7GfCeVMHo@public.gmane.org&gt;; Yuan, Xiaojie &lt;Xiaojie.=
Yuan-5C7GfCeVMHo@public.gmane.org&gt;; Zhang, Hawking &lt;Hawking.Zhang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu/psp: move TMR to cpu invisible vram =
region</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 19.08.19 um 10:05 schrieb Tianci Yin:<br>
&gt; From: &quot;Tianci.Yin&quot; &lt;tianci.yin-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;<br>
&gt; so that more visible vram can be available for umd.<br>
&gt;<br>
&gt; Signed-off-by: Tianci.Yin &lt;tianci.yin-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Assuming that you checked that we don't have other users who are using <br>
amdgpu_bo_create_kernel() without a CPU pointer this patch is <br>
Reviewed-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;.<br>
<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 5 &#43;&#43;&=
#43;--<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c&nbsp;&nbsp;&nbsp; =
| 4 &#43;&#43;--<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h&nbsp;&nbsp;&nbsp; =
| 1 -<br>
&gt;&nbsp;&nbsp; 3 files changed, 5 insertions(&#43;), 5 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_object.c<br>
&gt; index 1059771..0476790 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt; @@ -246,8 &#43;246,9 @@ int amdgpu_bo_create_reserved(struct amdgpu_de=
vice *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.size =3D size;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.byte_align =3D align;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.domain =3D domain;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; bp.flags =3D AMDGPU_GEM_CREATE_CPU_ACCESS_RE=
QUIRED |<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; bp.flags =3D cpu_addr ? AMDGPU_GEM_CREAT=
E_CPU_ACCESS_REQUIRED<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; : AMDGPU_GEM_CREATE_NO_CPU_ACCESS;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; bp.flags |=3D AMDGPU_GEM_CREATE_VRAM_CON=
TIGUOUS;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.type =3D ttm_bo_type_kern=
el;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bp.resv =3D NULL;<br>
&gt;&nbsp;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_psp.c<br>
&gt; index 7715c0d..5e7fbbe 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
&gt; @@ -264,7 &#43;264,7 @@ static int psp_tmr_init(struct psp_context *ps=
p)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_create_ker=
nel(psp-&gt;adev, tmr_size, PSP_TMR_SIZE,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; AMDGPU_GEM_DOMAIN_VRAM,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;psp-&gt;t=
mr_bo, &amp;psp-&gt;tmr_mc_addr, &amp;psp-&gt;tmr_buf);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;psp-&=
gt;tmr_bo, &amp;psp-&gt;tmr_mc_addr, NULL);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&gt;&nbsp;&nbsp; }<br>
&gt; @@ -1215,7 &#43;1215,7 @@ static int psp_hw_fini(void *handle)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; psp_ring_destroy(psp, PSP_RI=
NG_TYPE__KM);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp;psp-&gt;tmr_bo, &=
amp;psp-&gt;tmr_mc_addr, &amp;psp-&gt;tmr_buf);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp;psp-&gt;tmr_b=
o, &amp;psp-&gt;tmr_mc_addr, NULL);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp;p=
sp-&gt;fw_pri_bo,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;psp-&gt;fw_pri_mc_addr, &amp;psp-&gt;fw_p=
ri_buf);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp;p=
sp-&gt;fence_buf_bo,<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_psp.h<br>
&gt; index 0029fa2..48b057d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h<br>
&gt; @@ -172,7 &#43;172,6 @@ struct psp_context<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* tmr buffer */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *tmr_bo;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmr_mc_addr;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *tmr_buf;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* asd firmware and buffer *=
/<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const struct firmware&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *asd_fw;<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB2974D98262E42F1C6FB6644A95A80MN2PR12MB2974namp_--

--===============0057479078==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0057479078==--
