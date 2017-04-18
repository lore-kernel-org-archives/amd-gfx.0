From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Fix module unload hang by KIQ on Vega10
Date: Tue, 18 Apr 2017 14:21:07 +0000
Message-ID: <CY4PR12MB16873E1CB343FE73B464899DFB190@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1492481623-23177-1-git-send-email-trigger.huang@amd.com>,
 <BN6PR12MB16520E5F38D00D46AAE77A5CF7190@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1511386375=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB16520E5F38D00D46AAE77A5CF7190-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Huang, Trigger" <Trigger.Huang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1511386375==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB16873E1CB343FE73B464899DFB190CY4PR12MB1687namp_"

--_000_CY4PR12MB16873E1CB343FE73B464899DFB190CY4PR12MB1687namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I think no need to check function type.

Best Regards
Rex
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Deucher,=
 Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, April 18, 2017 9:33:58 PM
To: Huang, Trigger; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Huang, Trigger
Subject: RE: [PATCH] drm/amdgpu: Fix module unload hang by KIQ on Vega10

> -----Original Message-----
> From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf
> Of Trigger Huang
> Sent: Monday, April 17, 2017 10:14 PM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Huang, Trigger
> Subject: [PATCH] drm/amdgpu: Fix module unload hang by KIQ on Vega10
>
> Apply commit 4e683cb2644f ("drm/amdgpu: Fix module unload hang by
> KIQ IRQ set")to vega10
>
> Signed-off-by: Trigger Huang <trigger.huang-5C7GfCeVMHo@public.gmane.org>

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index f6b2329..b7b2ed8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -631,7 +631,6 @@ static int gfx_v9_0_kiq_init_ring(struct
> amdgpu_device *adev,
>                ring->pipe =3D 1;
>        }
>
> -     irq->data =3D ring;
>        ring->queue =3D 0;
>        ring->eop_gpu_addr =3D kiq->eop_gpu_addr;
>        sprintf(ring->name, "kiq %d.%d.%d", ring->me, ring->pipe, ring-
> >queue);
> @@ -647,7 +646,6 @@ static void gfx_v9_0_kiq_free_ring(struct
> amdgpu_ring *ring,
>  {
>        amdgpu_wb_free(ring->adev, ring->adev->virt.reg_val_offs);
>        amdgpu_ring_fini(ring);
> -     irq->data =3D NULL;
>  }
>
>  /* create MQD for each compute queue */
> @@ -3367,9 +3365,9 @@ static int gfx_v9_0_kiq_set_interrupt_state(struct
> amdgpu_device *adev,
>                                            enum amdgpu_interrupt_state
> state)
>  {
>        uint32_t tmp, target;
> -     struct amdgpu_ring *ring =3D (struct amdgpu_ring *)src->data;
> +     struct amdgpu_ring *ring =3D &(adev->gfx.kiq.ring);
>
> -     BUG_ON(!ring || (ring->funcs->type !=3D
> AMDGPU_RING_TYPE_KIQ));
> +     BUG_ON(ring->funcs->type !=3D AMDGPU_RING_TYPE_KIQ);
>
>        if (ring->me =3D=3D 1)
>                target =3D SOC15_REG_OFFSET(GC, 0,
> mmCP_ME1_PIPE0_INT_CNTL);
> @@ -3413,9 +3411,9 @@ static int gfx_v9_0_kiq_irq(struct amdgpu_device
> *adev,
>                            struct amdgpu_iv_entry *entry)
>  {
>        u8 me_id, pipe_id, queue_id;
> -     struct amdgpu_ring *ring =3D (struct amdgpu_ring *)source->data;
> +     struct amdgpu_ring *ring =3D &(adev->gfx.kiq.ring);
>
> -     BUG_ON(!ring || (ring->funcs->type !=3D
> AMDGPU_RING_TYPE_KIQ));
> +     BUG_ON(ring->funcs->type !=3D AMDGPU_RING_TYPE_KIQ);
>
>        me_id =3D (entry->ring_id & 0x0c) >> 2;
>        pipe_id =3D (entry->ring_id & 0x03) >> 0;
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_CY4PR12MB16873E1CB343FE73B464899DFB190CY4PR12MB1687namp_
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
<div>I think no need to check function type.<br>
<br>
Best Regards<br>
Rex
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Deucher, Alexander &lt;Alex=
ander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, April 18, 2017 9:33:58 PM<br>
<b>To:</b> Huang, Trigger; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Huang, Trigger<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Fix module unload hang by KIQ on Ve=
ga10</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">&gt; -----Original Message-----<br>
&gt; From: amd-gfx [<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org=
">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>] On Behalf<br>
&gt; Of Trigger Huang<br>
&gt; Sent: Monday, April 17, 2017 10:14 PM<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Huang, Trigger<br>
&gt; Subject: [PATCH] drm/amdgpu: Fix module unload hang by KIQ on Vega10<b=
r>
&gt; <br>
&gt; Apply commit 4e683cb2644f (&quot;drm/amdgpu: Fix module unload hang by=
<br>
&gt; KIQ IRQ set&quot;)to vega10<br>
&gt; <br>
&gt; Signed-off-by: Trigger Huang &lt;trigger.huang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 &#43;&#43;&#43;&#43;-=
-----<br>
&gt;&nbsp; 1 file changed, 4 insertions(&#43;), 6 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; index f6b2329..b7b2ed8 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; @@ -631,7 &#43;631,6 @@ static int gfx_v9_0_kiq_init_ring(struct<br>
&gt; amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ring-&gt;pipe =3D 1;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; irq-&gt;data =3D ring;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;queue =3D 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;eop_gpu_addr =3D ki=
q-&gt;eop_gpu_addr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sprintf(ring-&gt;name, &quot=
;kiq %d.%d.%d&quot;, ring-&gt;me, ring-&gt;pipe, ring-<br>
&gt; &gt;queue);<br>
&gt; @@ -647,7 &#43;646,6 @@ static void gfx_v9_0_kiq_free_ring(struct<br>
&gt; amdgpu_ring *ring,<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_wb_free(ring-&gt;adev=
, ring-&gt;adev-&gt;virt.reg_val_offs);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_fini(ring);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; irq-&gt;data =3D NULL;<br>
&gt;&nbsp; }<br>
&gt; <br>
&gt;&nbsp; /* create MQD for each compute queue */<br>
&gt; @@ -3367,9 &#43;3365,9 @@ static int gfx_v9_0_kiq_set_interrupt_state(=
struct<br>
&gt; amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amdgpu_interrupt_state<br>
&gt; state)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tmp, target;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D (struct amdgpu_=
ring *)src-&gt;data;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D &amp;(adev-=
&gt;gfx.kiq.ring);<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(!ring || (ring-&gt;funcs-&gt;type !=
=3D<br>
&gt; AMDGPU_RING_TYPE_KIQ));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(ring-&gt;funcs-&gt;type !=3D AMDG=
PU_RING_TYPE_KIQ);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring-&gt;me =3D=3D 1)<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; target =3D SOC15_REG_OFFSET(GC, 0,<br>
&gt; mmCP_ME1_PIPE0_INT_CNTL);<br>
&gt; @@ -3413,9 &#43;3411,9 @@ static int gfx_v9_0_kiq_irq(struct amdgpu_de=
vice<br>
&gt; *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; struct amdgpu_iv_entry *entry)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u8 me_id, pipe_id, queue_id;=
<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D (struct amdgpu_=
ring *)source-&gt;data;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D &amp;(adev-=
&gt;gfx.kiq.ring);<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(!ring || (ring-&gt;funcs-&gt;type !=
=3D<br>
&gt; AMDGPU_RING_TYPE_KIQ));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(ring-&gt;funcs-&gt;type !=3D AMDG=
PU_RING_TYPE_KIQ);<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; me_id =3D (entry-&gt;ring_id=
 &amp; 0x0c) &gt;&gt; 2;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pipe_id =3D (entry-&gt;ring_=
id &amp; 0x03) &gt;&gt; 0;<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font>
</body>
</html>

--_000_CY4PR12MB16873E1CB343FE73B464899DFB190CY4PR12MB1687namp_--

--===============1511386375==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1511386375==--
