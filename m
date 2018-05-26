From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: drm/amdgpu: Add helper function to get buffer domain
Date: Sat, 26 May 2018 13:23:37 +0000
Message-ID: <BN6PR12MB18092E2599E79AA9FCE2BB48F7680@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20180526001229.15509-1-Deepak.Sharma@amd.com>,
 <f58bea93-8f1a-bc97-a0c6-a3d2f324275c@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0791017154=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <f58bea93-8f1a-bc97-a0c6-a3d2f324275c-5C7GfCeVMHo@public.gmane.org>
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
To: "Sharma, Deepak" <Deepak.Sharma-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "michel-otUistvHUpPR7s880joybQ@public.gmane.org" <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============0791017154==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18092E2599E79AA9FCE2BB48F7680BN6PR12MB1809namp_"

--_000_BN6PR12MB18092E2599E79AA9FCE2BB48F7680BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Both patches are:

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: Sharma, Deepak
Sent: Friday, May 25, 2018 8:19:26 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander; michel-otUistvHUpPR7s880joybQ@public.gmane.org; =
Koenig, Christian
Subject: Re: drm/amdgpu: Add helper function to get buffer domain

If look fine , please give rb for this and
https://patchwork.freedesktop.org/patch/224850/

Thanks,
Deepak

On 05/25/2018 05:12 PM, Deepak Sharma wrote:
> Move logic of getting supported domain to a helper
> function
>
> Signed-off-by: Deepak Sharma <Deepak.Sharma-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    | 10 +++-------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 17 ++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 ++-
>   3 files changed, 17 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 63758db5e2ea..556406a44da3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -750,19 +750,15 @@ int amdgpu_mode_dumb_create(struct drm_file *file_p=
riv,
>        struct amdgpu_device *adev =3D dev->dev_private;
>        struct drm_gem_object *gobj;
>        uint32_t handle;
> -     u32 domain =3D amdgpu_display_supported_domains(adev);
> +     u32 domain;
>        int r;
>
>        args->pitch =3D amdgpu_align_pitch(adev, args->width,
>                                         DIV_ROUND_UP(args->bpp, 8), 0);
>        args->size =3D (u64)args->pitch * args->height;
>        args->size =3D ALIGN(args->size, PAGE_SIZE);
> -     if (domain =3D=3D (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT))=
 {
> -             domain =3D AMDGPU_GEM_DOMAIN_VRAM;
> -             if (adev->gmc.real_vram_size <=3D AMDGPU_SG_THRESHOLD)
> -                     domain =3D AMDGPU_GEM_DOMAIN_GTT;
> -     }
> -
> +     domain =3D amdgpu_bo_get_preferred_pin_domain(adev,
> +                             amdgpu_display_supported_domains(adev));
>        r =3D amdgpu_gem_object_create(adev, args->size, 0, domain,
>                                     AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED=
,
>                                     false, NULL, &gobj);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.c
> index 6a9e46ae7f0a..5e4e1bd90383 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -703,11 +703,7 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u=
32 domain,
>        /* This assumes only APU display buffers are pinned with (VRAM|GTT=
).
>         * See function amdgpu_display_supported_domains()
>         */
> -     if (domain =3D=3D (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT))=
 {
> -             domain =3D AMDGPU_GEM_DOMAIN_VRAM;
> -             if (adev->gmc.real_vram_size <=3D AMDGPU_SG_THRESHOLD)
> -                     domain =3D AMDGPU_GEM_DOMAIN_GTT;
> -     }
> +     domain =3D amdgpu_bo_get_preferred_pin_domain(adev, domain);
>
>        if (bo->pin_count) {
>                uint32_t mem_type =3D bo->tbo.mem.mem_type;
> @@ -1066,3 +1062,14 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
>
>        return bo->tbo.offset;
>   }
> +
> +uint32_t amdgpu_bo_get_preferred_pin_domain(struct amdgpu_device *adev,
> +                                         uint32_t domain)
> +{
> +     if (domain =3D=3D (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT))=
 {
> +             domain =3D AMDGPU_GEM_DOMAIN_VRAM;
> +             if (adev->gmc.real_vram_size <=3D AMDGPU_SG_THRESHOLD)
> +                     domain =3D AMDGPU_GEM_DOMAIN_GTT;
> +     }
> +     return domain;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_object.h
> index 540e03fa159f..731748033878 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -289,7 +289,8 @@ int amdgpu_bo_restore_from_shadow(struct amdgpu_devic=
e *adev,
>                                  struct reservation_object *resv,
>                                  struct dma_fence **fence,
>                                  bool direct);
> -
> +uint32_t amdgpu_bo_get_preferred_pin_domain(struct amdgpu_device *adev,
> +                                         uint32_t domain);
>
>   /*
>    * sub allocation
>

--_000_BN6PR12MB18092E2599E79AA9FCE2BB48F7680BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Both patches are:</p>
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Sharma, Deepak<br>
<b>Sent:</b> Friday, May 25, 2018 8:19:26 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander; michel@daenze=
r.net; Koenig, Christian<br>
<b>Subject:</b> Re: drm/amdgpu: Add helper function to get buffer domain</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">If look fine , please give rb for this and <br>
<a href=3D"https://patchwork.freedesktop.org/patch/224850/">https://patchwo=
rk.freedesktop.org/patch/224850/</a><br>
<br>
Thanks,<br>
Deepak<br>
<br>
On 05/25/2018 05:12 PM, Deepak Sharma wrote:<br>
&gt; Move logic of getting supported domain to a helper<br>
&gt; function<br>
&gt; <br>
&gt; Signed-off-by: Deepak Sharma &lt;Deepak.Sharma-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c&nbsp;&nbsp;&nbsp; =
| 10 &#43;&#43;&#43;-------<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 17 &#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-----<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |&nbsp; 3 &#43;=
&#43;-<br>
&gt;&nbsp;&nbsp; 3 files changed, 17 insertions(&#43;), 13 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gem.c<br>
&gt; index 63758db5e2ea..556406a44da3 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c<br>
&gt; @@ -750,19 &#43;750,15 @@ int amdgpu_mode_dumb_create(struct drm_file =
*file_priv,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D dev-&gt;dev_private;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gem_object *gobj;=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t handle;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; u32 domain =3D amdgpu_display_supported_doma=
ins(adev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; u32 domain;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;pitch =3D amdgpu_al=
ign_pitch(adev, args-&gt;width,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DIV_ROUND_UP(args-&gt;bpp, 8), 0);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;size =3D (u64)args-=
&gt;pitch * args-&gt;height;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; args-&gt;size =3D ALIGN(args=
-&gt;size, PAGE_SIZE);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (domain =3D=3D (AMDGPU_GEM_DOMAIN_VRAM | =
AMDGPU_GEM_DOMAIN_GTT)) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; domain =3D AMDGPU_GEM_DOMAIN_VRAM;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;gmc.real_vram_size &lt;=3D AMDGPU_SG_THRESHOLD)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; domain =3D AMDGPU_GEM_D=
OMAIN_GTT;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; domain =3D amdgpu_bo_get_preferred_pin_d=
omain(adev,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_display_supported_domains(adev));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_gem_object_crea=
te(adev, args-&gt;size, 0, domain,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDG=
PU_GEM_CREATE_CPU_ACCESS_REQUIRED,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fals=
e, NULL, &amp;gobj);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_object.c<br>
&gt; index 6a9e46ae7f0a..5e4e1bd90383 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt; @@ -703,11 &#43;703,7 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo=
 *bo, u32 domain,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* This assumes only APU dis=
play buffers are pinned with (VRAM|GTT).<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * See function amdgpu_=
display_supported_domains()<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (domain =3D=3D (AMDGPU_GEM_DOMAIN_VRAM | =
AMDGPU_GEM_DOMAIN_GTT)) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; domain =3D AMDGPU_GEM_DOMAIN_VRAM;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (adev-&gt;gmc.real_vram_size &lt;=3D AMDGPU_SG_THRESHOLD)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; domain =3D AMDGPU_GEM_D=
OMAIN_GTT;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; domain =3D amdgpu_bo_get_preferred_pin_d=
omain(adev, domain);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo-&gt;pin_count) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uint32_t mem_type =3D bo-&gt;tbo.mem.mem_type;<br>
&gt; @@ -1066,3 &#43;1062,14 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *=
bo)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return bo-&gt;tbo.offset;<br=
>
&gt;&nbsp;&nbsp; }<br>
&gt; &#43;<br>
&gt; &#43;uint32_t amdgpu_bo_get_preferred_pin_domain(struct amdgpu_device =
*adev,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t domain)<br>
&gt; &#43;{<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (domain =3D=3D (AMDGPU_GEM_DOMAIN_VRA=
M | AMDGPU_GEM_DOMAIN_GTT)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; domain =3D AMDGPU_GEM_DOMAIN_VRAM;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (adev-&gt;gmc.real_vram_size &lt;=3D AMDGPU_SG_THRESHOLD)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; domain =3D AMDGPU_G=
EM_DOMAIN_GTT;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; return domain;<br>
&gt; &#43;}<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_object.h<br>
&gt; index 540e03fa159f..731748033878 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br>
&gt; @@ -289,7 &#43;289,8 @@ int amdgpu_bo_restore_from_shadow(struct amdgp=
u_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct reservation_obj=
ect *resv,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **fen=
ce,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool direct);<br>
&gt; -<br>
&gt; &#43;uint32_t amdgpu_bo_get_preferred_pin_domain(struct amdgpu_device =
*adev,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t domain);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp; * sub allocation<br>
&gt; <br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB18092E2599E79AA9FCE2BB48F7680BN6PR12MB1809namp_--

--===============0791017154==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0791017154==--
