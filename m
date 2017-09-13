From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 4/5] drm/amdgpu: cleanup amdgpu_bo_pin_restricted
Date: Wed, 13 Sep 2017 11:21:13 +0200
Message-ID: <47181171-d6d3-9fab-5f1d-1084c24d63d8@vodafone.de>
References: <1505207316-4623-1-git-send-email-deathsimple@vodafone.de>
 <1505207316-4623-4-git-send-email-deathsimple@vodafone.de>
 <BN6PR12MB16523DE24A33EB21926B3AD8F7690@BN6PR12MB1652.namprd12.prod.outlook.com>
 <BLUPR12MB0449555D451CD4F6061AB3FB846E0@BLUPR12MB0449.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1905529264=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BLUPR12MB0449555D451CD4F6061AB3FB846E0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1905529264==
Content-Type: multipart/alternative;
 boundary="------------D3B8F80EF47FC832D9FDD51B"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------D3B8F80EF47FC832D9FDD51B
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

amdgpu_bo_create() doesn't necessarily allocate anything, it just 
creates the BO structure.

The backing memory for GTT and CPU domain is only allocated on first 
use, only VRAM is allocated directly.

So just call amdgpu_bo_create() with AMDGPU_GEM_DOMAIN_CPU and then the 
pin with AMDGPU_GEM_DOMAIN_VRAM and your desired offset.

Regards,
Christian.

Am 13.09.2017 um 11:14 schrieb Liu, Monk:
>
> SRIOV need to reserve a memory at an offset that set by GIM/hypervisor 
> side, but I'm not sure how to do it perfectly,  currently we call 
> bo_create to allocate a VRAM BO, and call pin_restrict with "offset" 
> as parameter for "min" and "offset + size" as "max",
>
>
> I feel strange of above approach frankly speaking (unless the new 
> offset equals to the original offset from bo_create),
>
>
> Because the original gpu offset (from the bo_create) is different with 
> the new "offset" provided by GIM, what will TTM/DRM do on the range of 
> <original offset, new offset> after we pin the bo to <new offset, new 
> offset+ size> ???
>
>
> BR Monk
>
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Tuesday, September 12, 2017 11:59:35 PM
> *To:* 'Christian König'; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* RE: [PATCH 4/5] drm/amdgpu: cleanup amdgpu_bo_pin_restricted
> > -----Original Message-----
> > From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf
> > Of Christian König
> > Sent: Tuesday, September 12, 2017 5:09 AM
> > To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > Subject: [PATCH 4/5] drm/amdgpu: cleanup amdgpu_bo_pin_restricted
> >
> > From: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> >
> > Nobody is using the min/max interface any more.
> >
> > Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>
> I'm not sure it's a good idea to get rid of this.  I can see a need to 
> reserve memory at specific offsets in memory. Specifically I think 
> SR-IOV will be placing structures in memory to communicate 
> configuration details from the host to the guest.  Also, we should be 
> reserving the vbios scratch area, but we don't currently.
>
> Alex
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 39 +++++------------------
> > -------
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 ---
> >  2 files changed, 6 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > index 726a662..8a8add3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > @@ -629,20 +629,15 @@ void amdgpu_bo_unref(struct amdgpu_bo **bo)
> >                *bo = NULL;
> >  }
> >
> > -int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
> > -                          u64 min_offset, u64 max_offset,
> > -                          u64 *gpu_addr)
> > +int amdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain, u64 *gpu_addr)
> >  {
> >        struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> > +     unsigned lpfn;
> >        int r, i;
> > -     unsigned fpfn, lpfn;
> >
> >        if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm))
> >                return -EPERM;
> >
> > -     if (WARN_ON_ONCE(min_offset > max_offset))
> > -             return -EINVAL;
> > -
> >        /* A shared bo cannot be migrated to VRAM */
> >        if (bo->prime_shared_count && (domain ==
> > AMDGPU_GEM_DOMAIN_VRAM))
> >                return -EINVAL;
> > @@ -657,12 +652,6 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo
> > *bo, u32 domain,
> >                if (gpu_addr)
> >                        *gpu_addr = amdgpu_bo_gpu_offset(bo);
> >
> > -             if (max_offset != 0) {
> > -                     u64 domain_start = bo->tbo.bdev-
> > >man[mem_type].gpu_offset;
> > -                     WARN_ON_ONCE(max_offset <
> > - (amdgpu_bo_gpu_offset(bo) -
> > domain_start));
> > -             }
> > -
> >                return 0;
> >        }
> >
> > @@ -671,23 +660,12 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo
> > *bo, u32 domain,
> >        for (i = 0; i < bo->placement.num_placement; i++) {
> >                /* force to pin into visible video ram */
> >                if ((bo->placements[i].flags & TTM_PL_FLAG_VRAM) &&
> > -                 !(bo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS)
> > &&
> > -                 (!max_offset || max_offset >
> > -                  adev->mc.visible_vram_size)) {
> > -                     if (WARN_ON_ONCE(min_offset >
> > - adev->mc.visible_vram_size))
> > -                             return -EINVAL;
> > -                     fpfn = min_offset >> PAGE_SHIFT;
> > +                 !(bo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS))
> > {
> >                        lpfn = adev->mc.visible_vram_size >> PAGE_SHIFT;
> > -             } else {
> > -                     fpfn = min_offset >> PAGE_SHIFT;
> > -                     lpfn = max_offset >> PAGE_SHIFT;
> > +                     if (!bo->placements[i].lpfn ||
> > +                         (lpfn && lpfn < bo->placements[i].lpfn))
> > +                             bo->placements[i].lpfn = lpfn;
> >                }
> > -             if (fpfn > bo->placements[i].fpfn)
> > -                     bo->placements[i].fpfn = fpfn;
> > -             if (!bo->placements[i].lpfn ||
> > -                 (lpfn && lpfn < bo->placements[i].lpfn))
> > -                     bo->placements[i].lpfn = lpfn;
> >                bo->placements[i].flags |= TTM_PL_FLAG_NO_EVICT;
> >        }
> >
> > @@ -718,11 +696,6 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo
> > *bo, u32 domain,
> >        return r;
> >  }
> >
> > -int amdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain, u64 *gpu_addr)
> > -{
> > -     return amdgpu_bo_pin_restricted(bo, domain, 0, 0, gpu_addr);
> > -}
> > -
> >  int amdgpu_bo_unpin(struct amdgpu_bo *bo)
> >  {
> >        struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> > index 39b6bf6..4b2c042 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> > @@ -211,9 +211,6 @@ void amdgpu_bo_kunmap(struct amdgpu_bo *bo);
> >  struct amdgpu_bo *amdgpu_bo_ref(struct amdgpu_bo *bo);
> >  void amdgpu_bo_unref(struct amdgpu_bo **bo);
> >  int amdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain, u64 *gpu_addr);
> > -int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
> > -                          u64 min_offset, u64 max_offset,
> > -                          u64 *gpu_addr);
> >  int amdgpu_bo_unpin(struct amdgpu_bo *bo);
> >  int amdgpu_bo_evict_vram(struct amdgpu_device *adev);
> >  int amdgpu_bo_init(struct amdgpu_device *adev);
> > --
> > 2.7.4
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------D3B8F80EF47FC832D9FDD51B
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">amdgpu_bo_create() doesn't necessarily
      allocate anything, it just creates the BO structure.<br>
      <br>
      The backing memory for GTT and CPU domain is only allocated on
      first use, only VRAM is allocated directly.<br>
      <br>
      So just call amdgpu_bo_create() with AMDGPU_GEM_DOMAIN_CPU and
      then the pin with AMDGPU_GEM_DOMAIN_VRAM and your desired offset.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 13.09.2017 um 11:14 schrieb Liu, Monk:<br>
    </div>
    <blockquote type="cite"
cite="mid:BLUPR12MB0449555D451CD4F6061AB3FB846E0-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <meta name="Generator" content="Microsoft Exchange Server">
      <!-- converted from text -->
      <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; } --></style>
      <meta content="text/html; charset=UTF-8">
      <style type="text/css" style="">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
      <div dir="ltr">
        <div id="x_divtagdefaultwrapper" dir="ltr"
          style="font-size:12pt; color:#000000;
          font-family:Calibri,Helvetica,sans-serif">
          <p>SRIOV need to reserve a memory at an offset that set by
            GIM/hypervisor side, but I'm not sure how to do it
            perfectly,  currently we call bo_create to allocate a VRAM
            BO, and call pin_restrict with "offset" as parameter for
            "min" and "offset + size" as "max", 
            <br>
          </p>
          <p><br>
          </p>
          <p>I feel strange of above approach frankly speaking (unless
            the new offset equals to the original offset from
            bo_create),
            <br>
          </p>
          <p><br>
          </p>
          <p>Because the original gpu offset (from the bo_create) is
            different with the new "offset" provided by GIM, what will
            TTM/DRM do on the range of &lt;original offset, new
            offset&gt; after we pin the bo to &lt;new offset, new
            offset+ size&gt; ???</p>
          <p><br>
          </p>
          <p>BR Monk<br>
          </p>
          <p><br>
          </p>
        </div>
        <hr tabindex="-1" style="display:inline-block; width:98%">
        <div id="x_divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            face="Calibri, sans-serif" color="#000000"><b>From:</b>
            amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on
            behalf of Deucher, Alexander
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org">&lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            <b>Sent:</b> Tuesday, September 12, 2017 11:59:35 PM<br>
            <b>To:</b> 'Christian König'; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            <b>Subject:</b> RE: [PATCH 4/5] drm/amdgpu: cleanup
            amdgpu_bo_pin_restricted</font>
          <div> </div>
        </div>
      </div>
      <font size="2"><span style="font-size:10pt;">
          <div class="PlainText">&gt; -----Original Message-----<br>
            &gt; From: amd-gfx [<a
              href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
              moz-do-not-send="true">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>]
            On Behalf<br>
            &gt; Of Christian König<br>
            &gt; Sent: Tuesday, September 12, 2017 5:09 AM<br>
            &gt; To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            &gt; Subject: [PATCH 4/5] drm/amdgpu: cleanup
            amdgpu_bo_pin_restricted<br>
            &gt; <br>
            &gt; From: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            &gt; <br>
            &gt; Nobody is using the min/max interface any more.<br>
            &gt; <br>
            &gt; Signed-off-by: Christian König
            <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            <br>
            I'm not sure it's a good idea to get rid of this.  I can see
            a need to reserve memory at specific offsets in memory. 
            Specifically I think SR-IOV will be placing structures in
            memory to communicate configuration details from the host to
            the guest.  Also, we should be reserving the vbios scratch
            area, but we don't currently.<br>
            <br>
            Alex<br>
            <br>
            &gt; ---<br>
            &gt;  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 39
            +++++------------------<br>
            &gt; -------<br>
            &gt;  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 ---<br>
            &gt;  2 files changed, 6 insertions(+), 36 deletions(-)<br>
            &gt; <br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
            &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
            &gt; index 726a662..8a8add3 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
            &gt; @@ -629,20 +629,15 @@ void amdgpu_bo_unref(struct
            amdgpu_bo **bo)<br>
            &gt;                *bo = NULL;<br>
            &gt;  }<br>
            &gt; <br>
            &gt; -int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32
            domain,<br>
            &gt; -                          u64 min_offset, u64
            max_offset,<br>
            &gt; -                          u64 *gpu_addr)<br>
            &gt; +int amdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain,
            u64 *gpu_addr)<br>
            &gt;  {<br>
            &gt;        struct amdgpu_device *adev =
            amdgpu_ttm_adev(bo-&gt;tbo.bdev);<br>
            &gt; +     unsigned lpfn;<br>
            &gt;        int r, i;<br>
            &gt; -     unsigned fpfn, lpfn;<br>
            &gt; <br>
            &gt;        if (amdgpu_ttm_tt_get_usermm(bo-&gt;tbo.ttm))<br>
            &gt;                return -EPERM;<br>
            &gt; <br>
            &gt; -     if (WARN_ON_ONCE(min_offset &gt; max_offset))<br>
            &gt; -             return -EINVAL;<br>
            &gt; -<br>
            &gt;        /* A shared bo cannot be migrated to VRAM */<br>
            &gt;        if (bo-&gt;prime_shared_count &amp;&amp; (domain
            ==<br>
            &gt; AMDGPU_GEM_DOMAIN_VRAM))<br>
            &gt;                return -EINVAL;<br>
            &gt; @@ -657,12 +652,6 @@ int
            amdgpu_bo_pin_restricted(struct amdgpu_bo<br>
            &gt; *bo, u32 domain,<br>
            &gt;                if (gpu_addr)<br>
            &gt;                        *gpu_addr =
            amdgpu_bo_gpu_offset(bo);<br>
            &gt; <br>
            &gt; -             if (max_offset != 0) {<br>
            &gt; -                     u64 domain_start =
            bo-&gt;tbo.bdev-<br>
            &gt; &gt;man[mem_type].gpu_offset;<br>
            &gt; -                     WARN_ON_ONCE(max_offset &lt;<br>
            &gt; -                                 
            (amdgpu_bo_gpu_offset(bo) -<br>
            &gt; domain_start));<br>
            &gt; -             }<br>
            &gt; -<br>
            &gt;                return 0;<br>
            &gt;        }<br>
            &gt; <br>
            &gt; @@ -671,23 +660,12 @@ int
            amdgpu_bo_pin_restricted(struct amdgpu_bo<br>
            &gt; *bo, u32 domain,<br>
            &gt;        for (i = 0; i &lt;
            bo-&gt;placement.num_placement; i++) {<br>
            &gt;                /* force to pin into visible video ram
            */<br>
            &gt;                if ((bo-&gt;placements[i].flags &amp;
            TTM_PL_FLAG_VRAM) &amp;&amp;<br>
            &gt; -                 !(bo-&gt;flags &amp;
            AMDGPU_GEM_CREATE_NO_CPU_ACCESS)<br>
            &gt; &amp;&amp;<br>
            &gt; -                 (!max_offset || max_offset &gt;<br>
            &gt; -                  adev-&gt;mc.visible_vram_size)) {<br>
            &gt; -                     if (WARN_ON_ONCE(min_offset &gt;<br>
            &gt; -                                     
            adev-&gt;mc.visible_vram_size))<br>
            &gt; -                             return -EINVAL;<br>
            &gt; -                     fpfn = min_offset &gt;&gt;
            PAGE_SHIFT;<br>
            &gt; +                 !(bo-&gt;flags &amp;
            AMDGPU_GEM_CREATE_NO_CPU_ACCESS))<br>
            &gt; {<br>
            &gt;                        lpfn =
            adev-&gt;mc.visible_vram_size &gt;&gt; PAGE_SHIFT;<br>
            &gt; -             } else {<br>
            &gt; -                     fpfn = min_offset &gt;&gt;
            PAGE_SHIFT;<br>
            &gt; -                     lpfn = max_offset &gt;&gt;
            PAGE_SHIFT;<br>
            &gt; +                     if (!bo-&gt;placements[i].lpfn ||<br>
            &gt; +                         (lpfn &amp;&amp; lpfn &lt;
            bo-&gt;placements[i].lpfn))<br>
            &gt; +                             bo-&gt;placements[i].lpfn
            = lpfn;<br>
            &gt;                }<br>
            &gt; -             if (fpfn &gt; bo-&gt;placements[i].fpfn)<br>
            &gt; -                     bo-&gt;placements[i].fpfn = fpfn;<br>
            &gt; -             if (!bo-&gt;placements[i].lpfn ||<br>
            &gt; -                 (lpfn &amp;&amp; lpfn &lt;
            bo-&gt;placements[i].lpfn))<br>
            &gt; -                     bo-&gt;placements[i].lpfn = lpfn;<br>
            &gt;                bo-&gt;placements[i].flags |=
            TTM_PL_FLAG_NO_EVICT;<br>
            &gt;        }<br>
            &gt; <br>
            &gt; @@ -718,11 +696,6 @@ int
            amdgpu_bo_pin_restricted(struct amdgpu_bo<br>
            &gt; *bo, u32 domain,<br>
            &gt;        return r;<br>
            &gt;  }<br>
            &gt; <br>
            &gt; -int amdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain,
            u64 *gpu_addr)<br>
            &gt; -{<br>
            &gt; -     return amdgpu_bo_pin_restricted(bo, domain, 0, 0,
            gpu_addr);<br>
            &gt; -}<br>
            &gt; -<br>
            &gt;  int amdgpu_bo_unpin(struct amdgpu_bo *bo)<br>
            &gt;  {<br>
            &gt;        struct amdgpu_device *adev =
            amdgpu_ttm_adev(bo-&gt;tbo.bdev);<br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br>
            &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br>
            &gt; index 39b6bf6..4b2c042 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h<br>
            &gt; @@ -211,9 +211,6 @@ void amdgpu_bo_kunmap(struct
            amdgpu_bo *bo);<br>
            &gt;  struct amdgpu_bo *amdgpu_bo_ref(struct amdgpu_bo *bo);<br>
            &gt;  void amdgpu_bo_unref(struct amdgpu_bo **bo);<br>
            &gt;  int amdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain,
            u64 *gpu_addr);<br>
            &gt; -int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32
            domain,<br>
            &gt; -                          u64 min_offset, u64
            max_offset,<br>
            &gt; -                          u64 *gpu_addr);<br>
            &gt;  int amdgpu_bo_unpin(struct amdgpu_bo *bo);<br>
            &gt;  int amdgpu_bo_evict_vram(struct amdgpu_device *adev);<br>
            &gt;  int amdgpu_bo_init(struct amdgpu_device *adev);<br>
            &gt; --<br>
            &gt; 2.7.4<br>
            &gt; <br>
            &gt; _______________________________________________<br>
            &gt; amd-gfx mailing list<br>
            &gt; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            &gt; <a
              href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
              moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
            _______________________________________________<br>
            amd-gfx mailing list<br>
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            <a
              href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
              moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
          </div>
        </span></font>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------D3B8F80EF47FC832D9FDD51B--

--===============1905529264==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1905529264==--
