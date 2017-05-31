From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 18/18] drm/amdgpu: fix the gart table cleared issue for S3
Date: Wed, 31 May 2017 18:58:02 +0200
Message-ID: <e2d9fdd5-7544-8b2c-031d-3894e2a7ec07@amd.com>
References: <1496247293-16429-1-git-send-email-ray.huang@amd.com>
 <1496247293-16429-19-git-send-email-ray.huang@amd.com>
 <BN6PR12MB16529494252B5889988E00BBF7F10@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0773580768=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB16529494252B5889988E00BBF7F10-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Huan, Alvin" <Alvin.Huan-5C7GfCeVMHo@public.gmane.org>, "Wang, Ken" <Ken.Wang-5C7GfCeVMHo@public.gmane.org>

--===============0773580768==
Content-Type: multipart/alternative;
	boundary="------------11E459ED6A7D93420BABE371"
Content-Language: en-US

--------------11E459ED6A7D93420BABE371
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

Am 31.05.2017 um 18:29 schrieb Deucher, Alexander:
> > -----Original Message-----
> > From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf
> > Of Huang Rui
> > Sent: Wednesday, May 31, 2017 12:15 PM
> > To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander; Koenig, Christian
> > Cc: Wang, Ken; Huang, Ray; Huan, Alvin
> > Subject: [PATCH 18/18] drm/amdgpu: fix the gart table cleared issue 
> for S3
> >
> > Signed-off-by: Huang Rui <ray.huang-5C7GfCeVMHo@public.gmane.org>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
> >  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c   | 2 ++
> >  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   | 2 ++
> >  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   | 2 ++
> >  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 3 +++
> >  6 files changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index 37f9869..50ed985 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -624,6 +624,7 @@ struct amdgpu_mc {
> >        uint32_t                srbm_soft_reset;
> >        struct amdgpu_mode_mc_save save;
> >        bool                    prt_warning;
> > +     unsigned long           stollen_size;
>
> Typo: stolen_size
> With that fixed:
> Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

Additional to that this should be an uint64_t otherwise 32bit systems 
will break.

Please also add a "/* TODO: Figure out how to avoid that... */ to 
setting the size to 8MB on Vega10.

With that fixed Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>.

>
> >        /* apertures */
> >        u64 shared_aperture_start;
> >        u64 shared_aperture_end;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > index 29c0deb..0406759 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -1381,7 +1381,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
> >        /* Change the size here instead of the init above so only lpfn is
> > affected */
> >        amdgpu_ttm_set_active_vram_size(adev, adev-
> > >mc.visible_vram_size);
> >
> > -     r = amdgpu_bo_create(adev, 256 * 1024, PAGE_SIZE, true,
> > +     r = amdgpu_bo_create(adev, adev->mc.stollen_size, PAGE_SIZE,
> > true,
> >                             AMDGPU_GEM_DOMAIN_VRAM,
> > AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED
> > |
> > AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> > index d576edc..540adae 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> > @@ -873,6 +873,8 @@ static int gmc_v6_0_sw_init(void *handle)
> >
> >        adev->mc.mc_mask = 0xffffffffffULL;
> >
> > +     adev->mc.stollen_size = 256 * 1024;
> > +
> >        adev->need_dma32 = false;
> >        dma_bits = adev->need_dma32 ? 32 : 40;
> >        r = pci_set_dma_mask(adev->pdev, DMA_BIT_MASK(dma_bits));
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> > index 681dda3..92e6e20 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> > @@ -1060,6 +1060,8 @@ static int gmc_v7_0_sw_init(void *handle)
> >         */
> >        adev->mc.mc_mask = 0xffffffffffULL; /* 40 bit MC */
> >
> > +     adev->mc.stollen_size = 256 * 1024;
> > +
> >        /* set DMA mask + need_dma32 flags.
> >         * PCIE - can handle 40-bits.
> >         * IGP - can handle 40-bits
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > index b5a3852..7738f4c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> > @@ -1148,6 +1148,8 @@ static int gmc_v8_0_sw_init(void *handle)
> >         */
> >        adev->mc.mc_mask = 0xffffffffffULL; /* 40 bit MC */
> >
> > +     adev->mc.stollen_size = 256 * 1024;
> > +
> >        /* set DMA mask + need_dma32 flags.
> >         * PCIE - can handle 40-bits.
> >         * IGP - can handle 40-bits
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > index fed00f7..31f4f44 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > @@ -591,6 +591,9 @@ static int gmc_v9_0_sw_init(void *handle)
> >         */
> >        adev->mc.mc_mask = 0xffffffffffffULL; /* 48 bit MC */
> >
> > +     /* it needs to reserve 8M stollen memory for vega10 */
> > +     adev->mc.stollen_size = 8 * 1024 * 1024;
> > +
> >        /* set DMA mask + need_dma32 flags.
> >         * PCIE - can handle 44-bits.
> >         * IGP - can handle 44-bits
> > --
> > 2.7.4
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------11E459ED6A7D93420BABE371
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 31.05.2017 um 18:29 schrieb Deucher,
      Alexander:<br>
    </div>
    <blockquote type="cite"
cite="mid:BN6PR12MB16529494252B5889988E00BBF7F10-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Exchange Server">
      <!-- converted from text -->
      <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; } --></style>
      <font size="2"><span style="font-size:10pt;">
          <div class="PlainText">&gt; -----Original Message-----<br>
            &gt; From: amd-gfx [<a
              href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
              moz-do-not-send="true">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>]
            On Behalf<br>
            &gt; Of Huang Rui<br>
            &gt; Sent: Wednesday, May 31, 2017 12:15 PM<br>
            &gt; To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>; Deucher, Alexander;
            Koenig, Christian<br>
            &gt; Cc: Wang, Ken; Huang, Ray; Huan, Alvin<br>
            &gt; Subject: [PATCH 18/18] drm/amdgpu: fix the gart table
            cleared issue for S3<br>
            &gt; <br>
            &gt; Signed-off-by: Huang Rui <a class="moz-txt-link-rfc2396E" href="mailto:ray.huang-5C7GfCeVMHo@public.gmane.org">&lt;ray.huang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            &gt; ---<br>
            &gt;  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +<br>
            &gt;  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-<br>
            &gt;  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c   | 2 ++<br>
            &gt;  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   | 2 ++<br>
            &gt;  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   | 2 ++<br>
            &gt;  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 3 +++<br>
            &gt;  6 files changed, 11 insertions(+), 1 deletion(-)<br>
            &gt; <br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
            &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
            &gt; index 37f9869..50ed985 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
            &gt; @@ -624,6 +624,7 @@ struct amdgpu_mc {<br>
            &gt;        uint32_t                srbm_soft_reset;<br>
            &gt;        struct amdgpu_mode_mc_save save;<br>
            &gt;        bool                    prt_warning;<br>
            &gt; +     unsigned long           stollen_size;<br>
            <br>
            Typo: stolen_size<br>
            With that fixed:<br>
            Reviewed-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
          </div>
        </span></font></blockquote>
    <br>
    Additional to that this should be an uint64_t otherwise 32bit
    systems will break.<br>
    <br>
    Please also add a "/* TODO: Figure out how to avoid that... */ to
    setting the size to 8MB on Vega10.<br>
    <br>
    With that fixed Reviewed-by: Christian König
    <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>.<br>
    <br>
    <blockquote type="cite"
cite="mid:BN6PR12MB16529494252B5889988E00BBF7F10-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"><font
        size="2"><span style="font-size:10pt;">
          <div class="PlainText">
            <br>
            &gt;        /* apertures */<br>
            &gt;        u64                                    
            shared_aperture_start;<br>
            &gt;        u64                                    
            shared_aperture_end;<br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
            &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
            &gt; index 29c0deb..0406759 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
            &gt; @@ -1381,7 +1381,7 @@ int amdgpu_ttm_init(struct
            amdgpu_device *adev)<br>
            &gt;        /* Change the size here instead of the init
            above so only lpfn is<br>
            &gt; affected */<br>
            &gt;        amdgpu_ttm_set_active_vram_size(adev, adev-<br>
            &gt; &gt;mc.visible_vram_size);<br>
            &gt; <br>
            &gt; -     r = amdgpu_bo_create(adev, 256 * 1024, PAGE_SIZE,
            true,<br>
            &gt; +     r = amdgpu_bo_create(adev,
            adev-&gt;mc.stollen_size, PAGE_SIZE,<br>
            &gt; true,<br>
            &gt;                             AMDGPU_GEM_DOMAIN_VRAM,<br>
            &gt;                            
            AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED<br>
            &gt; |<br>
            &gt;                            
            AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS,<br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c<br>
            &gt; b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c<br>
            &gt; index d576edc..540adae 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c<br>
            &gt; @@ -873,6 +873,8 @@ static int gmc_v6_0_sw_init(void
            *handle)<br>
            &gt; <br>
            &gt;        adev-&gt;mc.mc_mask = 0xffffffffffULL;<br>
            &gt; <br>
            &gt; +     adev-&gt;mc.stollen_size = 256 * 1024;<br>
            &gt; +<br>
            &gt;        adev-&gt;need_dma32 = false;<br>
            &gt;        dma_bits = adev-&gt;need_dma32 ? 32 : 40;<br>
            &gt;        r = pci_set_dma_mask(adev-&gt;pdev,
            DMA_BIT_MASK(dma_bits));<br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c<br>
            &gt; b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c<br>
            &gt; index 681dda3..92e6e20 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c<br>
            &gt; @@ -1060,6 +1060,8 @@ static int gmc_v7_0_sw_init(void
            *handle)<br>
            &gt;         */<br>
            &gt;        adev-&gt;mc.mc_mask = 0xffffffffffULL; /* 40 bit
            MC */<br>
            &gt; <br>
            &gt; +     adev-&gt;mc.stollen_size = 256 * 1024;<br>
            &gt; +<br>
            &gt;        /* set DMA mask + need_dma32 flags.<br>
            &gt;         * PCIE - can handle 40-bits.<br>
            &gt;         * IGP - can handle 40-bits<br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c<br>
            &gt; b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c<br>
            &gt; index b5a3852..7738f4c 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c<br>
            &gt; @@ -1148,6 +1148,8 @@ static int gmc_v8_0_sw_init(void
            *handle)<br>
            &gt;         */<br>
            &gt;        adev-&gt;mc.mc_mask = 0xffffffffffULL; /* 40 bit
            MC */<br>
            &gt; <br>
            &gt; +     adev-&gt;mc.stollen_size = 256 * 1024;<br>
            &gt; +<br>
            &gt;        /* set DMA mask + need_dma32 flags.<br>
            &gt;         * PCIE - can handle 40-bits.<br>
            &gt;         * IGP - can handle 40-bits<br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
            &gt; b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
            &gt; index fed00f7..31f4f44 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c<br>
            &gt; @@ -591,6 +591,9 @@ static int gmc_v9_0_sw_init(void
            *handle)<br>
            &gt;         */<br>
            &gt;        adev-&gt;mc.mc_mask = 0xffffffffffffULL; /* 48
            bit MC */<br>
            &gt; <br>
            &gt; +     /* it needs to reserve 8M stollen memory for
            vega10 */<br>
            &gt; +     adev-&gt;mc.stollen_size = 8 * 1024 * 1024;<br>
            &gt; +<br>
            &gt;        /* set DMA mask + need_dma32 flags.<br>
            &gt;         * PCIE - can handle 44-bits.<br>
            &gt;         * IGP - can handle 44-bits<br>
            &gt; --<br>
            &gt; 2.7.4<br>
            &gt; <br>
            &gt; _______________________________________________<br>
            &gt; amd-gfx mailing list<br>
            &gt; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            &gt; <a
              href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
              moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
          </div>
        </span></font>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------11E459ED6A7D93420BABE371--

--===============0773580768==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0773580768==--
