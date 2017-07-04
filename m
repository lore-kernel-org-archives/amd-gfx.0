From: "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix S3 failure on specific platform
Date: Tue, 4 Jul 2017 05:01:48 +0000
Message-ID: <CY1PR12MB0474694F9C433DC14267DBEF8CD70@CY1PR12MB0474.namprd12.prod.outlook.com>
References: <1499142367-3809-1-git-send-email-Qingqing.Wang@amd.com>,
 <BN6PR12MB165223A90A11C15208776C22F7D70@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0023289323=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB165223A90A11C15208776C22F7D70-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0023289323==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY1PR12MB0474694F9C433DC14267DBEF8CD70CY1PR12MB0474namp_"

--_000_CY1PR12MB0474694F9C433DC14267DBEF8CD70CY1PR12MB0474namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

sure, I will add the delay to io_wreg.

________________________________
From: Deucher, Alexander
Sent: Tuesday, July 4, 2017 12:47:38 PM
To: Wang, Ken; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Wang, Ken
Subject: RE: [PATCH] drm/amdgpu: fix S3 failure on specific platform

> -----Original Message-----
> From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf
> Of Ken Wang
> Sent: Tuesday, July 04, 2017 12:26 AM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Wang, Ken
> Subject: [PATCH] drm/amdgpu: fix S3 failure on specific platform
>
> Change-Id: Ie932508ad6949f8bfc7c8db1f5874d3440d09fc6
> Signed-off-by: Ken Wang <Qingqing.Wang-5C7GfCeVMHo@public.gmane.org>

Do we need to add this to the io_rreg and io_wreg functions as well?  Atom =
uses them for IIO tables.  Might also want to give a brief description of t=
he problem.  Something like:
Certain MC registers need a delay after writing them to properly update in =
the init sequence.
Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index ecc33c4..54c30fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1702,6 +1702,9 @@ struct amdgpu_device {
>        /* record hw reset is performed */
>        bool has_hw_reset;
>
> +     /* record last mm index being written through WREG32*/
> +     unsigned long last_mm_index;
> +
>  };
>
>  static inline struct amdgpu_device *amdgpu_ttm_adev(struct
> ttm_bo_device *bdev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 21e504a..24b908c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -124,6 +124,10 @@ void amdgpu_mm_wreg(struct amdgpu_device
> *adev, uint32_t reg, uint32_t v,
>  {
>        trace_amdgpu_mm_wreg(adev->pdev->device, reg, v);
>
> +     if (adev->asic_type >=3D CHIP_VEGA10 && reg =3D=3D 0) {
> +             adev->last_mm_index =3D v;
> +     }
> +
>        if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
> amdgpu_sriov_runtime(adev)) {
>                BUG_ON(in_interrupt());
>                return amdgpu_virt_kiq_wreg(adev, reg, v);
> @@ -139,6 +143,10 @@ void amdgpu_mm_wreg(struct amdgpu_device
> *adev, uint32_t reg, uint32_t v,
>                writel(v, ((void __iomem *)adev->rmmio) + (mmMM_DATA
> * 4));
>                spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
>        }
> +
> +     if (adev->asic_type >=3D CHIP_VEGA10 && reg =3D=3D 1 && adev-
> >last_mm_index =3D=3D 0x5702C) {
> +             udelay(500);
> +     }
>  }
>
>  u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY1PR12MB0474694F9C433DC14267DBEF8CD70CY1PR12MB0474namp_
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
<p>sure, I will add the delay to io_wreg.<br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Deucher, Alexander<=
br>
<b>Sent:</b> Tuesday, July 4, 2017 12:47:38 PM<br>
<b>To:</b> Wang, Ken; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Wang, Ken<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: fix S3 failure on specific platform=
</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">&gt; -----Original Message-----<br>
&gt; From: amd-gfx [<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org=
">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>] On Behalf<br>
&gt; Of Ken Wang<br>
&gt; Sent: Tuesday, July 04, 2017 12:26 AM<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Wang, Ken<br>
&gt; Subject: [PATCH] drm/amdgpu: fix S3 failure on specific platform<br>
&gt; <br>
&gt; Change-Id: Ie932508ad6949f8bfc7c8db1f5874d3440d09fc6<br>
&gt; Signed-off-by: Ken Wang &lt;Qingqing.Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Do we need to add this to the io_rreg and io_wreg functions as well?&nbsp; =
Atom uses them for IIO tables.&nbsp; Might also want to give a brief descri=
ption of the problem.&nbsp; Something like:<br>
Certain MC registers need a delay after writing them to properly update in =
the init sequence.<br>
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; | 3 &#43;&#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 &#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; 2 files changed, 11 insertions(&#43;)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; index ecc33c4..54c30fe 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -1702,6 &#43;1702,9 @@ struct amdgpu_device {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* record hw reset is perfor=
med */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool has_hw_reset;<br>
&gt; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* record last mm index being written th=
rough WREG32*/<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned long last_mm_index;<br>
&gt; &#43;<br>
&gt;&nbsp; };<br>
&gt; <br>
&gt;&nbsp; static inline struct amdgpu_device *amdgpu_ttm_adev(struct<br>
&gt; ttm_bo_device *bdev)<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; index 21e504a..24b908c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; @@ -124,6 &#43;124,10 @@ void amdgpu_mm_wreg(struct amdgpu_device<br>
&gt; *adev, uint32_t reg, uint32_t v,<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; trace_amdgpu_mm_wreg(adev-&g=
t;pdev-&gt;device, reg, v);<br>
&gt; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type &gt;=3D CHIP_VEGA=
10 &amp;&amp; reg =3D=3D 0) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; adev-&gt;last_mm_index =3D v;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(acc_flags &amp; AMDGPU=
_REGS_NO_KIQ) &amp;&amp;<br>
&gt; amdgpu_sriov_runtime(adev)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; BUG_ON(in_interrupt());<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return amdgpu_virt_kiq_wreg(adev, reg, v);<br>
&gt; @@ -139,6 &#43;143,10 @@ void amdgpu_mm_wreg(struct amdgpu_device<br>
&gt; *adev, uint32_t reg, uint32_t v,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; writel(v, ((void __iomem *)adev-&gt;rmmio) &#43; (mmMM_=
DATA<br>
&gt; * 4));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; spin_unlock_irqrestore(&amp;adev-&gt;mmio_idx_lock, fla=
gs);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type &gt;=3D CHIP_VEGA=
10 &amp;&amp; reg =3D=3D 1 &amp;&amp; adev-<br>
&gt; &gt;last_mm_index =3D=3D 0x5702C) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; udelay(500);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp; }<br>
&gt; <br>
&gt;&nbsp; u32 amdgpu_io_rreg(struct amdgpu_device *adev, u32 reg)<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font>
</body>
</html>

--_000_CY1PR12MB0474694F9C433DC14267DBEF8CD70CY1PR12MB0474namp_--

--===============0023289323==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0023289323==--
