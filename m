From: "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/discovery: reserve discovery data at the top
 of VRAM
Date: Thu, 10 Oct 2019 12:59:05 +0000
Message-ID: <BN8PR12MB360282C2972F0C781AC23C4889940@BN8PR12MB3602.namprd12.prod.outlook.com>
References: <20191010124757.17427-1-xiaojie.yuan@amd.com>,
 <CADnq5_Mz7SDUs4MWKzhZp3toc0x0guRJjA+JyFb7CcChtBAixw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0111906881=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_Mz7SDUs4MWKzhZp3toc0x0guRJjA+JyFb7CcChtBAixw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

--===============0111906881==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN8PR12MB360282C2972F0C781AC23C4889940BN8PR12MB3602namp_"

--_000_BN8PR12MB360282C2972F0C781AC23C4889940BN8PR12MB3602namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Thanks Alex. I'll try to use the new api and send v2 patch.

BR,
Xiaojie
________________________________
From: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, October 10, 2019 8:57 PM
To: Yuan, Xiaojie <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Xiao, Ja=
ck <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>; Zhang, Hawking <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/discovery: reserve discovery data at the to=
p of VRAM

On Thu, Oct 10, 2019 at 8:48 AM Yuan, Xiaojie <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org> wrote:
>
> IP Discovery data is TMR fenced by the latest PSP BL,
> so we need to reserve this region.
>
> Signed-off-by: Xiaojie Yuan <xiaojie.yuan-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 15 +++++++++++++++
>  2 files changed, 16 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index be0b2c69c223..6775647f0ba5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -812,6 +812,7 @@ struct amdgpu_device {
>         uint8_t                         *bios;
>         uint32_t                        bios_size;
>         struct amdgpu_bo                *stolen_vga_memory;
> +       struct amdgpu_bo                *discovery_memory;
>         uint32_t                        bios_scratch_reg_offset;
>         uint32_t                        bios_scratch[AMDGPU_BIOS_NUM_SCRA=
TCH];
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index edffc883549a..c3d7eb685a23 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1955,6 +1955,18 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>                                     NULL, &stolen_vga_buf);
>         if (r)
>                 return r;
> +
> +       /*
> +        * reserve one TMR (64K) memory at the top of VRAM which holds
> +        * IP Discovery data and is protected by PSP.
> +        */
> +       r =3D amdgpu_bo_create_kernel(adev, 64 << 10, PAGE_SIZE,
> +                                   AMDGPU_GEM_DOMAIN_VRAM,
> +                                   &adev->discovery_memory,
> +                                   NULL, NULL);
> +       if (r)
> +               return r;
> +

I think we should use amdgpu_bo_create_kernel_at() for both this and
stolen_vga_memory so that we make sure we end up reserving the right
location since both of these buffers are created by firmware at fixed
locations.

Alex

>         DRM_INFO("amdgpu: %uM of VRAM memory ready\n",
>                  (unsigned) (adev->gmc.real_vram_size / (1024 * 1024)));
>
> @@ -2024,6 +2036,9 @@ void amdgpu_ttm_late_init(struct amdgpu_device *ade=
v)
>         void *stolen_vga_buf;
>         /* return the VGA stolen memory (if any) back to VRAM */
>         amdgpu_bo_free_kernel(&adev->stolen_vga_memory, NULL, &stolen_vga=
_buf);
> +
> +       /* return the IP Discovery TMR memory back to VRAM */
> +       amdgpu_bo_free_kernel(&adev->discovery_memory, NULL, NULL);
>  }
>
>  /**
> --
> 2.20.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN8PR12MB360282C2972F0C781AC23C4889940BN8PR12MB3602namp_
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
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);">
Thanks Alex. I'll try to use the new api and send v2 patch.<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);">
BR,</div>
<div style=3D"font-family: Calibri, Helvetica, sans-serif; font-size: 11pt;=
 color: rgb(0, 0, 0);">
Xiaojie<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, October 10, 2019 8:57 PM<br>
<b>To:</b> Yuan, Xiaojie &lt;Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;; Xiao, Jack &lt;Jack.Xiao-5C7GfCeVMHo@public.gmane.org&gt;; Zhang, Hawking &lt;Hawking.Zhang=
@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu/discovery: reserve discovery data at=
 the top of VRAM</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Thu, Oct 10, 2019 at 8:48 AM Yuan, Xiaojie &lt;=
Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt;<br>
&gt; IP Discovery data is TMR fenced by the latest PSP BL,<br>
&gt; so we need to reserve this region.<br>
&gt;<br>
&gt; Signed-off-by: Xiaojie Yuan &lt;xiaojie.yuan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp; |&nb=
sp; 1 &#43;<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 15 &#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp; 2 files changed, 16 insertions(&#43;)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu.h<br>
&gt; index be0b2c69c223..6775647f0ba5 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
&gt; @@ -812,6 &#43;812,7 @@ struct amdgpu_device {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *bios;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bios_size;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; *stolen_vga_memory;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; *discovery_memory;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bios_scratch_reg_offset;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bios_scratch[AMDGPU_BIOS_=
NUM_SCRATCH];<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ttm.c<br>
&gt; index edffc883549a..c3d7eb685a23 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt; @@ -1955,6 &#43;1955,18 @@ int amdgpu_ttm_init(struct amdgpu_device *a=
dev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL=
, &amp;stolen_vga_buf);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * reserve one TMR (64K=
) memory at the top of VRAM which holds<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * IP Discovery data an=
d is protected by PSP.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_create_kerne=
l(adev, 64 &lt;&lt; 10, PAGE_SIZE,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GEM=
_DOMAIN_VRAM,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-=
&gt;discovery_memory,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, NULL=
);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; &#43;<br>
<br>
I think we should use amdgpu_bo_create_kernel_at() for both this and<br>
stolen_vga_memory so that we make sure we end up reserving the right<br>
location since both of these buffers are created by firmware at fixed<br>
locations.<br>
<br>
Alex<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;amdgpu:=
 %uM of VRAM memory ready\n&quot;,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (unsigned) (adev-&gt;gmc.real_vram_size / (=
1024 * 1024)));<br>
&gt;<br>
&gt; @@ -2024,6 &#43;2036,9 @@ void amdgpu_ttm_late_init(struct amdgpu_devi=
ce *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *stolen_vga_buf;<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* return the VGA stol=
en memory (if any) back to VRAM */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(=
&amp;adev-&gt;stolen_vga_memory, NULL, &amp;stolen_vga_buf);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* return the IP Discovery T=
MR memory back to VRAM */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_free_kernel(&amp;a=
dev-&gt;discovery_memory, NULL, NULL);<br>
&gt;&nbsp; }<br>
&gt;<br>
&gt;&nbsp; /**<br>
&gt; --<br>
&gt; 2.20.1<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN8PR12MB360282C2972F0C781AC23C4889940BN8PR12MB3602namp_--

--===============0111906881==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0111906881==--
