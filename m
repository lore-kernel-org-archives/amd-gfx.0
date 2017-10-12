From: "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: correct reference clock value on vega10
Date: Thu, 12 Oct 2017 02:41:54 +0000
Message-ID: <BY1PR12MB04720594366544666A7AE8478C4B0@BY1PR12MB0472.namprd12.prod.outlook.com>
References: <CY1PR12MB0474780D27899B282A97EE988C4A0@CY1PR12MB0474.namprd12.prod.outlook.com>,
 <CADnq5_N0Nw5ZzDaqq5iwBrCKEhfC8eZPTUBxMw-vqCefy1sA4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0136510552=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_N0Nw5ZzDaqq5iwBrCKEhfC8eZPTUBxMw-vqCefy1sA4g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0136510552==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BY1PR12MB04720594366544666A7AE8478C4B0BY1PR12MB0472namp_"

--_000_BY1PR12MB04720594366544666A7AE8478C4B0BY1PR12MB0472namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

got it, I will send another patch for reviewing.

________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Wednesday, October 11, 2017 9:30:01 PM
To: Wang, Ken
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander
Subject: Re: [PATCH] drm/amdgpu: correct reference clock value on vega10

On Wed, Oct 11, 2017 at 4:48 AM, Wang, Ken <Ken.Wang-5C7GfCeVMHo@public.gmane.org> wrote:
> From: Ken Wang <Ken.Wang-5C7GfCeVMHo@public.gmane.org>
>
> Change-Id: I377029075af1e2e002f7cfd793ddd58d8610e474
> Signed-off-by: Ken Wang <Ken.Wang-5C7GfCeVMHo@public.gmane.org>

NAK.  We use 10khz units for all other asics.  We already multiply
this by 10 in amdgpu_kms.c before sending it to userspace:
        /* return all clocks in KHz */
        dev_info.gpu_counter_freq =3D amdgpu_asic_get_xclk(adev) * 10;

Just return adev->clock.spll.reference_freq.

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 7839677..a510c8c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -279,10 +279,8 @@ static void soc15_init_golden_registers(struct
> amdgpu_device *adev)
>  }
>  static u32 soc15_get_xclk(struct amdgpu_device *adev)
>  {
> -       if (adev->asic_type =3D=3D CHIP_VEGA10)
> -               return adev->clock.spll.reference_freq/4;
> -       else
> -               return adev->clock.spll.reference_freq;
> +       /* return the value in Khz instead of 10Khz*/
> +       return adev->clock.spll.reference_freq * 10;
>  }
>
>
> --
> 2.7.4
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--_000_BY1PR12MB04720594366544666A7AE8478C4B0BY1PR12MB0472namp_
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
<p>got it, I will send another patch for reviewing.<br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Alex Deucher &lt;al=
exdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, October 11, 2017 9:30:01 PM<br>
<b>To:</b> Wang, Ken<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: correct reference clock value on ve=
ga10</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On Wed, Oct 11, 2017 at 4:48 AM, Wang, Ken &lt;Ken=
.Wang-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt; From: Ken Wang &lt;Ken.Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;<br>
&gt; Change-Id: I377029075af1e2e002f7cfd793ddd58d8610e474<br>
&gt; Signed-off-by: Ken Wang &lt;Ken.Wang-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
NAK.&nbsp; We use 10khz units for all other asics.&nbsp; We already multipl=
y<br>
this by 10 in amdgpu_kms.c before sending it to userspace:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* return all clocks in KHz */<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info.gpu_counter_freq =3D am=
dgpu_asic_get_xclk(adev) * 10;<br>
<br>
Just return adev-&gt;clock.spll.reference_freq.<br>
<br>
Alex<br>
<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/soc15.c | 6 &#43;&#43;----<br>
&gt;&nbsp; 1 file changed, 2 insertions(&#43;), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; index 7839677..a510c8c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
&gt; @@ -279,10 &#43;279,8 @@ static void soc15_init_golden_registers(struc=
t<br>
&gt; amdgpu_device *adev)<br>
&gt;&nbsp; }<br>
&gt;&nbsp; static u32 soc15_get_xclk(struct amdgpu_device *adev)<br>
&gt;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;asic_type =3D=3D CH=
IP_VEGA10)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return adev-&gt;clock.spll.reference_freq/4;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return adev-&gt;clock.spll.reference_freq;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* return the value in Khz i=
nstead of 10Khz*/<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return adev-&gt;clock.spll.r=
eference_freq * 10;<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
&gt;<br>
</div>
</span></font>
</body>
</html>

--_000_BY1PR12MB04720594366544666A7AE8478C4B0BY1PR12MB0472namp_--

--===============0136510552==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0136510552==--
