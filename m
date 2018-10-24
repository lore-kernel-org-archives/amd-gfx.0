From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2] drm/amdgpu: Patch csa mc address in IB packet
Date: Wed, 24 Oct 2018 07:00:15 +0000
Message-ID: <BYAPR12MB2775BEA8CAE420B02B12552AFBF60@BYAPR12MB2775.namprd12.prod.outlook.com>
References: <1540361003-3443-1-git-send-email-Rex.Zhu@amd.com>,
 <BY1PR12MB0502AE01F45D60C7BD199D8AB4F60@BY1PR12MB0502.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0465960023=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BY1PR12MB0502AE01F45D60C7BD199D8AB4F60-PicGAnIBOobrCwm+z9iKNgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0465960023==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB2775BEA8CAE420B02B12552AFBF60BYAPR12MB2775namp_"

--_000_BYAPR12MB2775BEA8CAE420B02B12552AFBF60BYAPR12MB2775namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Sorry, Please ignore this patch.


Best Regards

Rex


________________________________
From: Zhou, David(ChunMing)
Sent: Wednesday, October 24, 2018 2:55 PM
To: Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex
Subject: RE: [PATCH v2] drm/amdgpu: Patch csa mc address in IB packet



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of Rex
> Zhu
> Sent: Wednesday, October 24, 2018 2:03 PM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> Cc: Zhu, Rex <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> Subject: [PATCH v2] drm/amdgpu: Patch csa mc address in IB packet
>
> the csa buffer is used by sdma engine to do context save when preemption
> happens. it the mc address is zero, mean the preemtpion feature(MCBP) is
> disabled.
>
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 13 +++++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  2 ++
>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   |  8 ++++++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   |  8 ++++++--
>  4 files changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 0fb9907..24b80bc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -40,3 +40,16 @@ struct amdgpu_sdma_instance *
> amdgpu_get_sdma_instance(struct amdgpu_ring *ring)
>
>        return NULL;
>  }
> +
> +int amdgpu_get_sdma_index(struct amdgpu_ring *ring, uint32_t *index) {
> +     struct amdgpu_device *adev =3D ring->adev;
> +     int i;
> +
> +     for (i =3D 0; i < adev->sdma.num_instances; i++)
> +             if (ring =3D=3D &adev->sdma.instance[i].ring ||
> +                 ring =3D=3D &adev->sdma.instance[i].page)
> +                     return i;
> +
> +     return -EINVAL;
> +}

Loop for checking works,  but looks not good.

If you need ring index, you can define them first as enum, and evaluate enu=
m index to ring when ring initializing.

Regards,
David Zhou
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> index 479a245..314078a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -26,6 +26,7 @@
>
>  /* max number of IP instances */
>  #define AMDGPU_MAX_SDMA_INSTANCES            2
> +#define AMDGPU_SDMA_CSA_SIZE                 (1024)
>
>  enum amdgpu_sdma_irq {
>        AMDGPU_SDMA_IRQ_TRAP0 =3D 0,
> @@ -96,4 +97,5 @@ struct amdgpu_buffer_funcs {  struct
> amdgpu_sdma_instance *  amdgpu_get_sdma_instance(struct amdgpu_ring
> *ring);
>
> +int amdgpu_get_sdma_index(struct amdgpu_ring *ring, uint32_t *index);
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> index f5e6aa2..fdc5d75 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -424,7 +424,11 @@ static void sdma_v3_0_ring_emit_ib(struct
> amdgpu_ring *ring,
>                                   bool ctx_switch)
>  {
>        unsigned vmid =3D GET_VMID(job);
> +     uint64_t csa_mc_addr =3D job ? job->csa_mc_addr : 0;
> +     uint32_t i =3D 0;
>
> +     if (amdgpu_get_sdma_index(ring, &i))
> +             return -EINVAL;
>        /* IB packet must end on a 8 DW boundary */
>        sdma_v3_0_ring_insert_nop(ring, (10 - (lower_32_bits(ring->wptr) &
> 7)) % 8);
>
> @@ -434,8 +438,8 @@ static void sdma_v3_0_ring_emit_ib(struct
> amdgpu_ring *ring,
>        amdgpu_ring_write(ring, lower_32_bits(ib->gpu_addr) & 0xffffffe0);
>        amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
>        amdgpu_ring_write(ring, ib->length_dw);
> -     amdgpu_ring_write(ring, 0);
> -     amdgpu_ring_write(ring, 0);
> +     amdgpu_ring_write(ring, lower_32_bits(csa_mc_addr + i *
> AMDGPU_SDMA_CSA_SIZE));
> +     amdgpu_ring_write(ring, upper_32_bits(csa_mc_addr + i *
> +AMDGPU_SDMA_CSA_SIZE));
>
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 2282ac1..e69a584 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -507,7 +507,11 @@ static void sdma_v4_0_ring_emit_ib(struct
> amdgpu_ring *ring,
>                                   bool ctx_switch)
>  {
>        unsigned vmid =3D GET_VMID(job);
> +     uint64_t csa_mc_addr =3D job ? job->csa_mc_addr : 0;
> +     uint32_t i =3D 0;
>
> +     if (amdgpu_get_sdma_index(ring, &i))
> +             return -EINVAL;
>        /* IB packet must end on a 8 DW boundary */
>        sdma_v4_0_ring_insert_nop(ring, (10 - (lower_32_bits(ring->wptr) &
> 7)) % 8);
>
> @@ -517,8 +521,8 @@ static void sdma_v4_0_ring_emit_ib(struct
> amdgpu_ring *ring,
>        amdgpu_ring_write(ring, lower_32_bits(ib->gpu_addr) & 0xffffffe0);
>        amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
>        amdgpu_ring_write(ring, ib->length_dw);
> -     amdgpu_ring_write(ring, 0);
> -     amdgpu_ring_write(ring, 0);
> +     amdgpu_ring_write(ring, lower_32_bits(csa_mc_addr + i *
> AMDGPU_SDMA_CSA_SIZE));
> +     amdgpu_ring_write(ring, upper_32_bits(csa_mc_addr + i *
> +AMDGPU_SDMA_CSA_SIZE));
>
>  }
>
> --
> 1.9.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives.. Using amd-gfx: To post a message to all the list members, send email=
 to amd-gfx-PD4FTy7X32lNgt0PjOBp9xlNPtJONSTn@public.gmane.org You can subscribe to the list, or change=
 your existing subscription, in the sections below.



--_000_BYAPR12MB2775BEA8CAE420B02B12552AFBF60BYAPR12MB2775namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Sorry, Please ignore this patch.<=
/p>
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
=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> Zhou, David(ChunMing=
)<br>
<b>Sent:</b> Wednesday, October 24, 2018 2:55 PM<br>
<b>To:</b> Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> RE: [PATCH v2] drm/amdgpu: Patch csa mc address in IB packe=
t</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText"><br>
<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; On Behalf =
Of Rex<br>
&gt; Zhu<br>
&gt; Sent: Wednesday, October 24, 2018 2:03 PM<br>
&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; Cc: Zhu, Rex &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; Subject: [PATCH v2] drm/amdgpu: Patch csa mc address in IB packet<br>
&gt; <br>
&gt; the csa buffer is used by sdma engine to do context save when preempti=
on<br>
&gt; happens. it the mc address is zero, mean the preemtpion feature(MCBP) =
is<br>
&gt; disabled.<br>
&gt; <br>
&gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 13 &#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt; drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |&nbsp; 2 &#43;&#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c&nbsp;&nbsp; |&nbsp; 8 &#4=
3;&#43;&#43;&#43;&#43;&#43;--<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c&nbsp;&nbsp; |&nbsp; 8 &#4=
3;&#43;&#43;&#43;&#43;&#43;--<br>
&gt;&nbsp; 4 files changed, 27 insertions(&#43;), 4 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c<br>
&gt; index 0fb9907..24b80bc 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c<br>
&gt; @@ -40,3 &#43;40,16 @@ struct amdgpu_sdma_instance *<br>
&gt; amdgpu_get_sdma_instance(struct amdgpu_ring *ring)<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;int amdgpu_get_sdma_index(struct amdgpu_ring *ring, uint32_t *ind=
ex) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D ring-&gt;=
adev;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; adev-&gt;sdma.num_i=
nstances; i&#43;&#43;)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (ring =3D=3D &amp;adev-&gt;sdma.instance[i].ring ||<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =3D=3D &amp;adev-&gt;sdma.instance[i].=
page)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return i;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;}<br>
<br>
Loop for checking works,&nbsp; but looks not good.<br>
<br>
If you need ring index, you can define them first as enum, and evaluate enu=
m index to ring when ring initializing.<br>
<br>
Regards,<br>
David Zhou<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h<br>
&gt; index 479a245..314078a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h<br>
&gt; @@ -26,6 &#43;26,7 @@<br>
&gt; <br>
&gt;&nbsp; /* max number of IP instances */<br>
&gt;&nbsp; #define AMDGPU_MAX_SDMA_INSTANCES&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2<br>
&gt; &#43;#define AMDGPU_SDMA_CSA_SIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1024)<br>
&gt; <br>
&gt;&nbsp; enum amdgpu_sdma_irq {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_SDMA_IRQ_TRAP0 =3D 0,=
<br>
&gt; @@ -96,4 &#43;97,5 @@ struct amdgpu_buffer_funcs {&nbsp; struct<br>
&gt; amdgpu_sdma_instance *&nbsp; amdgpu_get_sdma_instance(struct amdgpu_ri=
ng<br>
&gt; *ring);<br>
&gt; <br>
&gt; &#43;int amdgpu_get_sdma_index(struct amdgpu_ring *ring, uint32_t *ind=
ex);<br>
&gt;&nbsp; #endif<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c<br>
&gt; index f5e6aa2..fdc5d75 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c<br>
&gt; @@ -424,7 &#43;424,11 @@ static void sdma_v3_0_ring_emit_ib(struct<br>
&gt; amdgpu_ring *ring,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ctx_switch)=
<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D GET_VMID(j=
ob);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t csa_mc_addr =3D job ? job-&gt;c=
sa_mc_addr : 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i =3D 0;<br>
&gt; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_get_sdma_index(ring, &amp;i))=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return -EINVAL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IB packet must end on a 8=
 DW boundary */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_v3_0_ring_insert_nop(ri=
ng, (10 - (lower_32_bits(ring-&gt;wptr) &amp;<br>
&gt; 7)) % 8);<br>
&gt; <br>
&gt; @@ -434,8 &#43;438,8 @@ static void sdma_v3_0_ring_emit_ib(struct<br>
&gt; amdgpu_ring *ring,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, lowe=
r_32_bits(ib-&gt;gpu_addr) &amp; 0xffffffe0);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, uppe=
r_32_bits(ib-&gt;gpu_addr));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, ib-&=
gt;length_dw);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, lower_32_bits(cs=
a_mc_addr &#43; i *<br>
&gt; AMDGPU_SDMA_CSA_SIZE));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, upper_32_bits(cs=
a_mc_addr &#43; i *<br>
&gt; &#43;AMDGPU_SDMA_CSA_SIZE));<br>
&gt; <br>
&gt;&nbsp; }<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
&gt; index 2282ac1..e69a584 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
&gt; @@ -507,7 &#43;507,11 @@ static void sdma_v4_0_ring_emit_ib(struct<br>
&gt; amdgpu_ring *ring,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ctx_switch)=
<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D GET_VMID(j=
ob);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t csa_mc_addr =3D job ? job-&gt;c=
sa_mc_addr : 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i =3D 0;<br>
&gt; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_get_sdma_index(ring, &amp;i))=
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; return -EINVAL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* IB packet must end on a 8=
 DW boundary */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sdma_v4_0_ring_insert_nop(ri=
ng, (10 - (lower_32_bits(ring-&gt;wptr) &amp;<br>
&gt; 7)) % 8);<br>
&gt; <br>
&gt; @@ -517,8 &#43;521,8 @@ static void sdma_v4_0_ring_emit_ib(struct<br>
&gt; amdgpu_ring *ring,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, lowe=
r_32_bits(ib-&gt;gpu_addr) &amp; 0xffffffe0);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, uppe=
r_32_bits(ib-&gt;gpu_addr));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, ib-&=
gt;length_dw);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, lower_32_bits(cs=
a_mc_addr &#43; i *<br>
&gt; AMDGPU_SDMA_CSA_SIZE));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, upper_32_bits(cs=
a_mc_addr &#43; i *<br>
&gt; &#43;AMDGPU_SDMA_CSA_SIZE));<br>
&gt; <br>
&gt;&nbsp; }<br>
&gt; <br>
&gt; --<br>
&gt; 1.9.1<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=
=3D"LPlnk678787" class=3D"OWAAutoLink" previewremoved=3D"true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_15403643288900.9389810958492499" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_15403643288620.05097377372827949" style=3D"width: =
90%; background-color: rgb(255, 255, 255); position: relative; overflow: au=
to; padding-top: 20px; padding-bottom: 20px; margin-top: 20px; border-top: =
1px dotted rgb(200, 200, 200); border-bottom: 1px dotted rgb(200, 200, 200)=
;" role=3D"presentation" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing: 0px;" valign=3D"top">
<td id=3D"TextCell_15403643288820.060056346354324885" style=3D"vertical-ali=
gn: top; position: relative; padding: 0px; display: table-cell;" colspan=3D=
"2">
<div id=3D"LPRemovePreviewContainer_15403643288820.009954324085404198"></di=
v>
<div id=3D"LPTitle_15403643288820.8192472788978892" style=3D"top: 0px; colo=
r: rgb(0, 120, 215); font-weight: 400; font-size: 21px; font-family: &quot;=
wf_segoe-ui_light&quot;, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&q=
uot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif=
; line-height: 21px;">
<a id=3D"LPUrlAnchor_15403643288880.8875590676966787" style=3D"text-decorat=
ion: none;" href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
 target=3D"_blank">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_15403643288880.35548407863940923" style=3D"margin: 10=
px 0px 16px; color: rgb(102, 102, 102); font-weight: 400; font-family: &quo=
t;wf_segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tah=
oma, Arial, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_15403643288900.6201448818586388" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot;wf_=
segoe-ui_normal&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, =
Arial, sans-serif; font-size: 14px; line-height: 20px; max-height: 100px; o=
verflow: hidden;">
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives.. Using amd-gfx: To post a message to all the list members, send email=
 to amd-gfx-PD4FTy7X32lNgt0PjOBp9xlNPtJONSTn@public.gmane.org You can subscribe to the list, or change=
 your existing subscription, in
 the sections below.</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB2775BEA8CAE420B02B12552AFBF60BYAPR12MB2775namp_--

--===============0465960023==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0465960023==--
