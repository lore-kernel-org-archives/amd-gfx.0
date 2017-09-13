From: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/5] drm/amdgpu: cleanup amdgpu_bo_pin_restricted
Date: Wed, 13 Sep 2017 09:26:03 +0000
Message-ID: <BLUPR12MB044941B9DCD5972C0F2496C6846E0@BLUPR12MB0449.namprd12.prod.outlook.com>
References: <1505207316-4623-1-git-send-email-deathsimple@vodafone.de>
 <1505207316-4623-4-git-send-email-deathsimple@vodafone.de>
 <BN6PR12MB16523DE24A33EB21926B3AD8F7690@BN6PR12MB1652.namprd12.prod.outlook.com>
 <BLUPR12MB0449555D451CD4F6061AB3FB846E0@BLUPR12MB0449.namprd12.prod.outlook.com>,
 <47181171-d6d3-9fab-5f1d-1084c24d63d8@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1144716044=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <47181171-d6d3-9fab-5f1d-1084c24d63d8-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?Windows-1252?Q?Christian_K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1144716044==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BLUPR12MB044941B9DCD5972C0F2496C6846E0BLUPR12MB0449namp_"

--_000_BLUPR12MB044941B9DCD5972C0F2496C6846E0BLUPR12MB0449namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

but we use VRAM domain in the first bo_create stage,  so this BO is allocat=
ed directly ...


I think our current approach is incorrect ... because the space from bo_cre=
ate(VRAM_DOMAIN) is missed somehow

________________________________
From: Christian K=F6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Sent: Wednesday, September 13, 2017 5:21:13 PM
To: Liu, Monk; Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 4/5] drm/amdgpu: cleanup amdgpu_bo_pin_restricted

amdgpu_bo_create() doesn't necessarily allocate anything, it just creates t=
he BO structure.

The backing memory for GTT and CPU domain is only allocated on first use, o=
nly VRAM is allocated directly.

So just call amdgpu_bo_create() with AMDGPU_GEM_DOMAIN_CPU and then the pin=
 with AMDGPU_GEM_DOMAIN_VRAM and your desired offset.

Regards,
Christian.

Am 13.09.2017 um 11:14 schrieb Liu, Monk:

SRIOV need to reserve a memory at an offset that set by GIM/hypervisor side=
, but I'm not sure how to do it perfectly,  currently we call bo_create to =
allocate a VRAM BO, and call pin_restrict with "offset" as parameter for "m=
in" and "offset + size" as "max",


I feel strange of above approach frankly speaking (unless the new offset eq=
uals to the original offset from bo_create),


Because the original gpu offset (from the bo_create) is different with the =
new "offset" provided by GIM, what will TTM/DRM do on the range of <origina=
l offset, new offset> after we pin the bo to <new offset, new offset+ size>=
 ???


BR Monk


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of Deucher, Alexander <Alexander.Deucher=
@amd.com><mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Sent: Tuesday, September 12, 2017 11:59:35 PM
To: 'Christian K=F6nig'; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx@lists=
.freedesktop.org>
Subject: RE: [PATCH 4/5] drm/amdgpu: cleanup amdgpu_bo_pin_restricted

> -----Original Message-----
> From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf
> Of Christian K=F6nig
> Sent: Tuesday, September 12, 2017 5:09 AM
> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> Subject: [PATCH 4/5] drm/amdgpu: cleanup amdgpu_bo_pin_restricted
>
> From: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org><mailto:christian.koeni=
g@amd.com>
>
> Nobody is using the min/max interface any more.
>
> Signed-off-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org><mailto:christ=
ian.koenig-5C7GfCeVMHo@public.gmane.org>

I'm not sure it's a good idea to get rid of this.  I can see a need to rese=
rve memory at specific offsets in memory.  Specifically I think SR-IOV will=
 be placing structures in memory to communicate configuration details from =
the host to the guest.  Also, we should be reserving the vbios scratch area=
, but we don't currently.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 39 +++++------------------
> -------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 ---
>  2 files changed, 6 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 726a662..8a8add3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -629,20 +629,15 @@ void amdgpu_bo_unref(struct amdgpu_bo **bo)
>                *bo =3D NULL;
>  }
>
> -int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
> -                          u64 min_offset, u64 max_offset,
> -                          u64 *gpu_addr)
> +int amdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain, u64 *gpu_addr)
>  {
>        struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
> +     unsigned lpfn;
>        int r, i;
> -     unsigned fpfn, lpfn;
>
>        if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm))
>                return -EPERM;
>
> -     if (WARN_ON_ONCE(min_offset > max_offset))
> -             return -EINVAL;
> -
>        /* A shared bo cannot be migrated to VRAM */
>        if (bo->prime_shared_count && (domain =3D=3D
> AMDGPU_GEM_DOMAIN_VRAM))
>                return -EINVAL;
> @@ -657,12 +652,6 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo
> *bo, u32 domain,
>                if (gpu_addr)
>                        *gpu_addr =3D amdgpu_bo_gpu_offset(bo);
>
> -             if (max_offset !=3D 0) {
> -                     u64 domain_start =3D bo->tbo.bdev-
> >man[mem_type].gpu_offset;
> -                     WARN_ON_ONCE(max_offset <
> -                                  (amdgpu_bo_gpu_offset(bo) -
> domain_start));
> -             }
> -
>                return 0;
>        }
>
> @@ -671,23 +660,12 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo
> *bo, u32 domain,
>        for (i =3D 0; i < bo->placement.num_placement; i++) {
>                /* force to pin into visible video ram */
>                if ((bo->placements[i].flags & TTM_PL_FLAG_VRAM) &&
> -                 !(bo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS)
> &&
> -                 (!max_offset || max_offset >
> -                  adev->mc.visible_vram_size)) {
> -                     if (WARN_ON_ONCE(min_offset >
> -                                      adev->mc.visible_vram_size))
> -                             return -EINVAL;
> -                     fpfn =3D min_offset >> PAGE_SHIFT;
> +                 !(bo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS))
> {
>                        lpfn =3D adev->mc.visible_vram_size >> PAGE_SHIFT;
> -             } else {
> -                     fpfn =3D min_offset >> PAGE_SHIFT;
> -                     lpfn =3D max_offset >> PAGE_SHIFT;
> +                     if (!bo->placements[i].lpfn ||
> +                         (lpfn && lpfn < bo->placements[i].lpfn))
> +                             bo->placements[i].lpfn =3D lpfn;
>                }
> -             if (fpfn > bo->placements[i].fpfn)
> -                     bo->placements[i].fpfn =3D fpfn;
> -             if (!bo->placements[i].lpfn ||
> -                 (lpfn && lpfn < bo->placements[i].lpfn))
> -                     bo->placements[i].lpfn =3D lpfn;
>                bo->placements[i].flags |=3D TTM_PL_FLAG_NO_EVICT;
>        }
>
> @@ -718,11 +696,6 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo
> *bo, u32 domain,
>        return r;
>  }
>
> -int amdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain, u64 *gpu_addr)
> -{
> -     return amdgpu_bo_pin_restricted(bo, domain, 0, 0, gpu_addr);
> -}
> -
>  int amdgpu_bo_unpin(struct amdgpu_bo *bo)
>  {
>        struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 39b6bf6..4b2c042 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -211,9 +211,6 @@ void amdgpu_bo_kunmap(struct amdgpu_bo *bo);
>  struct amdgpu_bo *amdgpu_bo_ref(struct amdgpu_bo *bo);
>  void amdgpu_bo_unref(struct amdgpu_bo **bo);
>  int amdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain, u64 *gpu_addr);
> -int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
> -                          u64 min_offset, u64 max_offset,
> -                          u64 *gpu_addr);
>  int amdgpu_bo_unpin(struct amdgpu_bo *bo);
>  int amdgpu_bo_evict_vram(struct amdgpu_device *adev);
>  int amdgpu_bo_init(struct amdgpu_device *adev);
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--_000_BLUPR12MB044941B9DCD5972C0F2496C6846E0BLUPR12MB0449namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body text=3D"#000000" bgcolor=3D"#FFFFFF">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p>but we use VRAM domain in the first bo_create stage,&nbsp; so this BO is=
 allocated directly ...</p>
<p><br>
</p>
<p>I think our current approach is incorrect ... because the space from bo_=
create(VRAM_DOMAIN) is missed somehow
<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, September 13, 2017 5:21:13 PM<br>
<b>To:</b> Liu, Monk; Deucher, Alexander; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 4/5] drm/amdgpu: cleanup amdgpu_bo_pin_restricte=
d</font>
<div>&nbsp;</div>
</div>
<div>
<div class=3D"moz-cite-prefix">amdgpu_bo_create() doesn't necessarily alloc=
ate anything, it just creates the BO structure.<br>
<br>
The backing memory for GTT and CPU domain is only allocated on first use, o=
nly VRAM is allocated directly.<br>
<br>
So just call amdgpu_bo_create() with AMDGPU_GEM_DOMAIN_CPU and then the pin=
 with AMDGPU_GEM_DOMAIN_VRAM and your desired offset.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 13.09.2017 um 11:14 schrieb Liu, Monk:<br>
</div>
<blockquote type=3D"cite" cite=3D"mid:BLUPR12MB0449555D451CD4F6061AB3FB846E=
0@BLUPR12MB0449.namprd12.prod.outlook.com">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
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
or:#000000;
          font-family:Calibri,Helvetica,sans-serif">
<p>SRIOV need to reserve a memory at an offset that set by GIM/hypervisor s=
ide, but I'm not sure how to do it perfectly,&nbsp; currently we call bo_cr=
eate to allocate a VRAM BO, and call pin_restrict with &quot;offset&quot; a=
s parameter for &quot;min&quot; and &quot;offset &#43; size&quot; as &quot;=
max&quot;,&nbsp;
<br>
</p>
<p><br>
</p>
<p>I feel strange of above approach frankly speaking (unless the new offset=
 equals to the original offset from bo_create),
<br>
</p>
<p><br>
</p>
<p>Because the original gpu offset (from the bo_create) is different with t=
he new &quot;offset&quot; provided by GIM, what will TTM/DRM do on the rang=
e of &lt;original offset, new offset&gt; after we pin the bo to &lt;new off=
set, new offset&#43; size&gt; ???</p>
<p><br>
</p>
<p>BR Monk<br>
</p>
<p><br>
</p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:amd-gfx-bounces-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org">
&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on behalf of Deucher, Ale=
xander <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:Alexander.Deucher@=
amd.com">
&lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<b>Sent:</b> Tuesday, September 12, 2017 11:59:35 PM<br>
<b>To:</b> 'Christian K=F6nig'; <a class=3D"moz-txt-link-abbreviated" href=
=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> RE: [PATCH 4/5] drm/amdgpu: cleanup amdgpu_bo_pin_restricte=
d</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">&gt; -----Original Message-----<br>
&gt; From: amd-gfx [<a href=3D"mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org=
" moz-do-not-send=3D"true">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>=
] On Behalf<br>
&gt; Of Christian K=F6nig<br>
&gt; Sent: Tuesday, September 12, 2017 5:09 AM<br>
&gt; To: <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx@lists=
.freedesktop.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; Subject: [PATCH 4/5] drm/amdgpu: cleanup amdgpu_bo_pin_restricted<br>
&gt; <br>
&gt; From: Christian K=F6nig <a class=3D"moz-txt-link-rfc2396E" href=3D"mai=
lto:christian.koenig-5C7GfCeVMHo@public.gmane.org">
&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
&gt; <br>
&gt; Nobody is using the min/max interface any more.<br>
&gt; <br>
&gt; Signed-off-by: Christian K=F6nig <a class=3D"moz-txt-link-rfc2396E" hr=
ef=3D"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">
&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<br>
I'm not sure it's a good idea to get rid of this.&nbsp; I can see a need to=
 reserve memory at specific offsets in memory.&nbsp; Specifically I think S=
R-IOV will be placing structures in memory to communicate configuration det=
ails from the host to the guest.&nbsp; Also, we
 should be reserving the vbios scratch area, but we don't currently.<br>
<br>
Alex<br>
<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 39 &#43;&#43;&#43;&=
#43;&#43;------------------<br>
&gt; -------<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |&nbsp; 3 ---<br>
&gt;&nbsp; 2 files changed, 6 insertions(&#43;), 36 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt; index 726a662..8a8add3 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt; @@ -629,20 &#43;629,15 @@ void amdgpu_bo_unref(struct amdgpu_bo **bo)<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; *bo =3D NULL;<br>
&gt;&nbsp; }<br>
&gt; <br>
&gt; -int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; u64 min_offset, u64 max_offset,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; u64 *gpu_addr)<br>
&gt; &#43;int amdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain, u64 *gpu_addr=
)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D amdgpu_ttm_adev(bo-&gt;tbo.bdev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned lpfn;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, i;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; unsigned fpfn, lpfn;<br>
&gt; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ttm_tt_get_usermm=
(bo-&gt;tbo.ttm))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EPERM;<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (WARN_ON_ONCE(min_offset &gt; max_offset)=
)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EINVAL;<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* A shared bo cannot be mig=
rated to VRAM */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (bo-&gt;prime_shared_coun=
t &amp;&amp; (domain =3D=3D<br>
&gt; AMDGPU_GEM_DOMAIN_VRAM))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; @@ -657,12 &#43;652,6 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo=
<br>
&gt; *bo, u32 domain,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (gpu_addr)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *gpu_ad=
dr =3D amdgpu_bo_gpu_offset(bo);<br>
&gt; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (max_offset !=3D 0) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64 domain_start =3D bo=
-&gt;tbo.bdev-<br>
&gt; &gt;man[mem_type].gpu_offset;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON_ONCE(max_offset=
 &lt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (amdgpu_bo_gpu_offse=
t(bo) -<br>
&gt; domain_start));<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; -<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt; @@ -671,23 &#43;660,12 @@ int amdgpu_bo_pin_restricted(struct amdgpu_b=
o<br>
&gt; *bo, u32 domain,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; bo-&gt;=
placement.num_placement; i&#43;&#43;) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* force to pin into visible video ram */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if ((bo-&gt;placements[i].flags &amp; TTM_PL_FLAG_VRAM)=
 &amp;&amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; !(bo-&gt;flags &amp; AMDGPU_GEM_CREATE_NO_CPU_A=
CCESS)<br>
&gt; &amp;&amp;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; (!max_offset || max_offset &gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;mc.visible_vram_size)) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (WARN_ON_ONCE(min_of=
fset &gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; adev-&gt;mc.visible_vram_size))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fpfn =3D min_offset &gt=
;&gt; PAGE_SHIFT;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !(bo-&gt;flags &amp; AMDGPU_GEM_CREATE_NO_C=
PU_ACCESS))<br>
&gt; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lpfn =
=3D adev-&gt;mc.visible_vram_size &gt;&gt; PAGE_SHIFT;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fpfn =3D min_offset &gt=
;&gt; PAGE_SHIFT;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lpfn =3D max_offset &gt=
;&gt; PAGE_SHIFT;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!bo-&gt;placeme=
nts[i].lpfn ||<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; (lpfn &amp;&amp; lpfn &lt; bo-&gt;placements[i].lpfn))<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-&gt;placements[i].lpfn =3D lpfn;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (fpfn &gt; bo-&gt;placements[i].fpfn)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-&gt;placements[i].fp=
fn =3D fpfn;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!bo-&gt;placements[i].lpfn ||<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; (lpfn &amp;&amp; lpfn &lt; bo-&gt;placements[i]=
.lpfn))<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bo-&gt;placements[i].lp=
fn =3D lpfn;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; bo-&gt;placements[i].flags |=3D TTM_PL_FLAG_NO_EVICT;<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; <br>
&gt; @@ -718,11 &#43;696,6 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo=
<br>
&gt; *bo, u32 domain,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp; }<br>
&gt; <br>
&gt; -int amdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain, u64 *gpu_addr)<br=
>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_bo_pin_restricted(bo, domain, =
0, 0, gpu_addr);<br>
&gt; -}<br>
&gt; -<br>
&gt;&nbsp; int amdgpu_bo_unpin(struct amdgpu_bo *bo)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =
=3D amdgpu_ttm_adev(bo-&gt;tbo.bdev);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br>
&gt; index 39b6bf6..4b2c042 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br>
&gt; @@ -211,9 &#43;211,6 @@ void amdgpu_bo_kunmap(struct amdgpu_bo *bo);<b=
r>
&gt;&nbsp; struct amdgpu_bo *amdgpu_bo_ref(struct amdgpu_bo *bo);<br>
&gt;&nbsp; void amdgpu_bo_unref(struct amdgpu_bo **bo);<br>
&gt;&nbsp; int amdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain, u64 *gpu_add=
r);<br>
&gt; -int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; u64 min_offset, u64 max_offset,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; u64 *gpu_addr);<br>
&gt;&nbsp; int amdgpu_bo_unpin(struct amdgpu_bo *bo);<br>
&gt;&nbsp; int amdgpu_bo_evict_vram(struct amdgpu_device *adev);<br>
&gt;&nbsp; int amdgpu_bo_init(struct amdgpu_device *adev);<br>
&gt; --<br>
&gt; 2.7.4<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz=
-do-not-send=3D"true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-n=
ot-send=3D"true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>=
<br>
</div>
</span></font></blockquote>
<p><br>
</p>
</div>
</body>
</html>

--_000_BLUPR12MB044941B9DCD5972C0F2496C6846E0BLUPR12MB0449namp_--

--===============1144716044==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1144716044==--
