From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amd/amdgpu: Various tidy ups for gfx6
Date: Fri, 2 Sep 2016 14:06:23 +0200
Message-ID: <aa1ac326-ed57-21f5-df8f-5ceb4ae32ae8@vodafone.de>
References: <20160901174447.13037-1-tom.stdenis@amd.com>
 <20160901174447.13037-4-tom.stdenis@amd.com>
 <7364a051-e423-57db-5a7f-d66d12cdeec7@vodafone.de>
 <CY4PR12MB1768BF04DBC2C421B0FC969FF7E50@CY4PR12MB1768.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0158857422=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1768BF04DBC2C421B0FC969FF7E50-rpdhrqHFk06yjjPBNVDk/QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0158857422==
Content-Type: multipart/alternative;
 boundary="------------D2814AFE5C7A1F8CD063ECE5"

This is a multi-part message in MIME format.
--------------D2814AFE5C7A1F8CD063ECE5
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit


> We could merge those to reduce the # of LOC.
>
Yes, please do so if you have time.

BTW: Do you know any tool/hack/whatever to find unused structure 
members? E.g. members which are never accessed or only set but never read?

We seem to have quite a number of those in amdgpu, radeon as well as 
TTM. Would be nice to clean such stuff up.

Christian.

Am 02.09.2016 um 13:54 schrieb StDenis, Tom:
>
> Nope your eyes are fine.  Note that the same pattern exists in 
> gfx_v8_0.c as well.  I guess different ring struct pointers are passed 
> so they're not talking to the same ring.
>
>
> We could merge those to reduce the # of LOC.
>
>
> Tom
>
>
>
> ------------------------------------------------------------------------
> *From:* Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
> *Sent:* Thursday, September 1, 2016 13:59
> *To:* Tom St Denis; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Cc:* StDenis, Tom
> *Subject:* Re: [PATCH 3/3] drm/amd/amdgpu: Various tidy ups for gfx6
> Am 01.09.2016 um 19:44 schrieb Tom St Denis:
> > Various whitespace and logical simplifications for gfx6.
> >
> > Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 40 
> +++++------------------------------
> >   1 file changed, 5 insertions(+), 35 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c 
> b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> > index 5f508c96496f..63ca77937714 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> > @@ -1211,11 +1211,8 @@ static void gfx_v6_0_gpu_init(struct 
> amdgpu_device *adev)
> > SC_EARLYZ_TILE_FIFO_SIZE(adev->gfx.config.sc_earlyz_tile_fifo_size)));
> >
> >        WREG32(VGT_NUM_INSTANCES, 1);
> > -
> >        WREG32(CP_PERFMON_CNTL, 0);
> > -
> >        WREG32(SQ_CONFIG, 0);
> > -
> >        WREG32(PA_SC_FORCE_EOV_MAX_CNTS, (FORCE_EOV_MAX_CLK_CNT(4095) |
> > FORCE_EOV_MAX_REZ_CNT(255)));
> >
> > @@ -1240,7 +1237,6 @@ static void gfx_v6_0_gpu_init(struct 
> amdgpu_device *adev)
> >        WREG32(PA_CL_ENHANCE, CLIP_VTX_REORDER_ENA | NUM_CLIP_SEQ(3));
> >
> >        udelay(50);
> > -
> >   }
> >
> >
> > @@ -1661,21 +1657,14 @@ static int gfx_v6_0_cp_gfx_resume(struct 
> amdgpu_device *adev)
> >
> >   static u32 gfx_v6_0_ring_get_rptr_gfx(struct amdgpu_ring *ring)
> >   {
> > -     u32 rptr;
> > -
> > -     rptr = ring->adev->wb.wb[ring->rptr_offs];
> > -
> > -     return rptr;
> > +     return ring->adev->wb.wb[ring->rptr_offs];
> >   }
> >
> >   static u32 gfx_v6_0_ring_get_wptr_gfx(struct amdgpu_ring *ring)
> >   {
> >        struct amdgpu_device *adev = ring->adev;
> > -     u32 wptr;
> >
> > -     wptr = RREG32(CP_RB0_WPTR);
> > -
> > -     return wptr;
> > +     return RREG32(CP_RB0_WPTR);
> >   }
> >
> >   static void gfx_v6_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
> > @@ -1688,9 +1677,7 @@ static void gfx_v6_0_ring_set_wptr_gfx(struct 
> amdgpu_ring *ring)
> >
> >   static u32 gfx_v6_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
> >   {
> > -     u32 rptr = ring->adev->wb.wb[ring->rptr_offs];
> > -
> > -     return rptr;
> > +     return ring->adev->wb.wb[ring->rptr_offs];
> >   }
>
> Am I blind or are the gfx_v6_0_ring_get_rptr_compute() and
> gfx_v6_0_ring_get_rptr_gfx() functions identical?
>
> If that's true might be a good idea to just use one function.
>
> Either way patch is Reviewed-by: Christian König 
> <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>
> Christian.
>
> >
> >   static u32 gfx_v6_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
> > @@ -1770,14 +1757,12 @@ static int gfx_v6_0_cp_compute_resume(struct 
> amdgpu_device *adev)
> >        ring->wptr = 0;
> >        WREG32(CP_RB1_WPTR, ring->wptr);
> >
> > -
> >        rptr_addr = adev->wb.gpu_addr + (ring->rptr_offs * 4);
> >        WREG32(CP_RB1_RPTR_ADDR, lower_32_bits(rptr_addr));
> >        WREG32(CP_RB1_RPTR_ADDR_HI, upper_32_bits(rptr_addr) & 0xFF);
> >
> >        mdelay(1);
> >        WREG32(CP_RB1_CNTL, tmp);
> > -
> >        WREG32(CP_RB1_BASE, ring->gpu_addr >> 8);
> >
> >        ring = &adev->gfx.compute_ring[1];
> > @@ -1797,7 +1782,6 @@ static int gfx_v6_0_cp_compute_resume(struct 
> amdgpu_device *adev)
> >
> >        mdelay(1);
> >        WREG32(CP_RB2_CNTL, tmp);
> > -
> >        WREG32(CP_RB2_BASE, ring->gpu_addr >> 8);
> >
> >        adev->gfx.compute_ring[0].ready = true;
> > @@ -1825,12 +1809,7 @@ static void gfx_v6_0_cp_enable(struct 
> amdgpu_device *adev, bool enable)
> >
> >   static int gfx_v6_0_cp_load_microcode(struct amdgpu_device *adev)
> >   {
> > -     int r;
> > -
> > -     r = gfx_v6_0_cp_gfx_load_microcode(adev);
> > -
> > -     return r;
> > -
> > +     return gfx_v6_0_cp_gfx_load_microcode(adev);
> >   }
> >
> >   static void gfx_v6_0_enable_gui_idle_interrupt(struct 
> amdgpu_device *adev,
> > @@ -2172,7 +2151,6 @@ static void gfx_v6_0_rlc_stop(struct 
> amdgpu_device *adev)
> >        WREG32(RLC_CNTL, 0);
> >
> >        gfx_v6_0_enable_gui_idle_interrupt(adev, false);
> > -
> >        gfx_v6_0_wait_for_rlc_serdes(adev);
> >   }
> >
> > @@ -2223,11 +2201,8 @@ static int gfx_v6_0_rlc_resume(struct 
> amdgpu_device *adev)
> >                return -EINVAL;
> >
> >        gfx_v6_0_rlc_stop(adev);
> > -
> >        gfx_v6_0_rlc_reset(adev);
> > -
> >        gfx_v6_0_init_pg(adev);
> > -
> >        gfx_v6_0_init_cg(adev);
> >
> >        WREG32(RLC_RL_BASE, 0);
> > @@ -2254,7 +2229,6 @@ static int gfx_v6_0_rlc_resume(struct 
> amdgpu_device *adev)
> >        WREG32(RLC_UCODE_ADDR, 0);
> >
> >        gfx_v6_0_enable_lbpw(adev, gfx_v6_0_lbpw_supported(adev));
> > -
> >        gfx_v6_0_rlc_start(adev);
> >
> >        return 0;
> > @@ -2278,7 +2252,6 @@ static void gfx_v6_0_enable_cgcg(struct 
> amdgpu_device *adev, bool enable)
> >                WREG32(RLC_SERDES_WR_CTRL, 0x00b000ff);
> >
> >                gfx_v6_0_wait_for_rlc_serdes(adev);
> > -
> >                gfx_v6_0_update_rlc(adev, tmp);
> >
> >                WREG32(RLC_SERDES_WR_CTRL, 0x007000ff);
> > @@ -2931,13 +2904,10 @@ static bool gfx_v6_0_is_idle(void *handle)
> >   static int gfx_v6_0_wait_for_idle(void *handle)
> >   {
> >        unsigned i;
> > -     u32 tmp;
> >        struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> >
> >        for (i = 0; i < adev->usec_timeout; i++) {
> > -             tmp = RREG32(GRBM_STATUS) & GRBM_STATUS__GUI_ACTIVE_MASK;
> > -
> > -             if (!tmp)
> > +             if (gfx_v6_0_is_idle(handle))
> >                        return 0;
> >                udelay(1);
> >        }
>
>


--------------D2814AFE5C7A1F8CD063ECE5
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix"><br>
      <blockquote type="cite">
        <p>We could merge those to reduce the # of LOC.</p>
      </blockquote>
      Yes, please do so if you have time.<br>
      <br>
      BTW: Do you know any tool/hack/whatever to find unused structure
      members? E.g. members which are never accessed or only set but
      never read?<br>
      <br>
      We seem to have quite a number of those in amdgpu, radeon as well
      as TTM. Would be nice to clean such stuff up.<br>
      <br>
      Christian.<br>
      <br>
      Am 02.09.2016 um 13:54 schrieb StDenis, Tom:<br>
    </div>
    <blockquote
cite="mid:CY4PR12MB1768BF04DBC2C421B0FC969FF7E50-rpdhrqHFk06yjjPBNVDk/QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;background-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
        <p>Nope your eyes are fine.  Note that the same pattern exists
          in gfx_v8_0.c as well.  I guess different ring struct pointers
          are passed so they're not talking to the same ring.</p>
        <p><br>
        </p>
        <p>We could merge those to reduce the # of LOC.</p>
        <p><br>
        </p>
        <p>Tom</p>
        <br>
        <br>
        <div style="color: rgb(0, 0, 0);">
          <div>
            <hr tabindex="-1" style="display:inline-block; width:98%">
            <div id="x_divRplyFwdMsg" dir="ltr"><font
                style="font-size:11pt" color="#000000" face="Calibri,
                sans-serif"><b>From:</b> Christian König
                <a class="moz-txt-link-rfc2396E" href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
                <b>Sent:</b> Thursday, September 1, 2016 13:59<br>
                <b>To:</b> Tom St Denis; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <b>Cc:</b> StDenis, Tom<br>
                <b>Subject:</b> Re: [PATCH 3/3] drm/amd/amdgpu: Various
                tidy ups for gfx6</font>
              <div> </div>
            </div>
          </div>
          <font size="2"><span style="font-size:10pt;">
              <div class="PlainText">Am 01.09.2016 um 19:44 schrieb Tom
                St Denis:<br>
                &gt; Various whitespace and logical simplifications for
                gfx6.<br>
                &gt;<br>
                &gt; Signed-off-by: Tom St Denis
                <a class="moz-txt-link-rfc2396E" href="mailto:tom.stdenis-5C7GfCeVMHo@public.gmane.org">&lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                &gt; ---<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 40
                +++++------------------------------<br>
                &gt;   1 file changed, 5 insertions(+), 35 deletions(-)<br>
                &gt;<br>
                &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
                b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c<br>
                &gt; index 5f508c96496f..63ca77937714 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c<br>
                &gt; @@ -1211,11 +1211,8 @@ static void
                gfx_v6_0_gpu_init(struct amdgpu_device *adev)<br>
                &gt;                                
SC_EARLYZ_TILE_FIFO_SIZE(adev-&gt;gfx.config.sc_earlyz_tile_fifo_size)));<br>
                &gt;   <br>
                &gt;        WREG32(VGT_NUM_INSTANCES, 1);<br>
                &gt; -<br>
                &gt;        WREG32(CP_PERFMON_CNTL, 0);<br>
                &gt; -<br>
                &gt;        WREG32(SQ_CONFIG, 0);<br>
                &gt; -<br>
                &gt;        WREG32(PA_SC_FORCE_EOV_MAX_CNTS,
                (FORCE_EOV_MAX_CLK_CNT(4095) |<br>
                &gt;                                         
                FORCE_EOV_MAX_REZ_CNT(255)));<br>
                &gt;   <br>
                &gt; @@ -1240,7 +1237,6 @@ static void
                gfx_v6_0_gpu_init(struct amdgpu_device *adev)<br>
                &gt;        WREG32(PA_CL_ENHANCE, CLIP_VTX_REORDER_ENA |
                NUM_CLIP_SEQ(3));<br>
                &gt;   <br>
                &gt;        udelay(50);<br>
                &gt; -<br>
                &gt;   }<br>
                &gt;   <br>
                &gt;   <br>
                &gt; @@ -1661,21 +1657,14 @@ static int
                gfx_v6_0_cp_gfx_resume(struct amdgpu_device *adev)<br>
                &gt;   <br>
                &gt;   static u32 gfx_v6_0_ring_get_rptr_gfx(struct
                amdgpu_ring *ring)<br>
                &gt;   {<br>
                &gt; -     u32 rptr;<br>
                &gt; -<br>
                &gt; -     rptr =
                ring-&gt;adev-&gt;wb.wb[ring-&gt;rptr_offs];<br>
                &gt; -<br>
                &gt; -     return rptr;<br>
                &gt; +     return
                ring-&gt;adev-&gt;wb.wb[ring-&gt;rptr_offs];<br>
                &gt;   }<br>
                &gt;   <br>
                &gt;   static u32 gfx_v6_0_ring_get_wptr_gfx(struct
                amdgpu_ring *ring)<br>
                &gt;   {<br>
                &gt;        struct amdgpu_device *adev = ring-&gt;adev;<br>
                &gt; -     u32 wptr;<br>
                &gt;   <br>
                &gt; -     wptr = RREG32(CP_RB0_WPTR);<br>
                &gt; -<br>
                &gt; -     return wptr;<br>
                &gt; +     return RREG32(CP_RB0_WPTR);<br>
                &gt;   }<br>
                &gt;   <br>
                &gt;   static void gfx_v6_0_ring_set_wptr_gfx(struct
                amdgpu_ring *ring)<br>
                &gt; @@ -1688,9 +1677,7 @@ static void
                gfx_v6_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)<br>
                &gt;   <br>
                &gt;   static u32 gfx_v6_0_ring_get_rptr_compute(struct
                amdgpu_ring *ring)<br>
                &gt;   {<br>
                &gt; -     u32 rptr =
                ring-&gt;adev-&gt;wb.wb[ring-&gt;rptr_offs];<br>
                &gt; -<br>
                &gt; -     return rptr;<br>
                &gt; +     return
                ring-&gt;adev-&gt;wb.wb[ring-&gt;rptr_offs];<br>
                &gt;   }<br>
                <br>
                Am I blind or are the gfx_v6_0_ring_get_rptr_compute()
                and <br>
                gfx_v6_0_ring_get_rptr_gfx() functions identical?<br>
                <br>
                If that's true might be a good idea to just use one
                function.<br>
                <br>
                Either way patch is Reviewed-by: Christian König
                <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                <br>
                Christian.<br>
                <br>
                &gt;   <br>
                &gt;   static u32 gfx_v6_0_ring_get_wptr_compute(struct
                amdgpu_ring *ring)<br>
                &gt; @@ -1770,14 +1757,12 @@ static int
                gfx_v6_0_cp_compute_resume(struct amdgpu_device *adev)<br>
                &gt;        ring-&gt;wptr = 0;<br>
                &gt;        WREG32(CP_RB1_WPTR, ring-&gt;wptr);<br>
                &gt;   <br>
                &gt; -<br>
                &gt;        rptr_addr = adev-&gt;wb.gpu_addr +
                (ring-&gt;rptr_offs * 4);<br>
                &gt;        WREG32(CP_RB1_RPTR_ADDR,
                lower_32_bits(rptr_addr));<br>
                &gt;        WREG32(CP_RB1_RPTR_ADDR_HI,
                upper_32_bits(rptr_addr) &amp; 0xFF);<br>
                &gt;   <br>
                &gt;        mdelay(1);<br>
                &gt;        WREG32(CP_RB1_CNTL, tmp);<br>
                &gt; -<br>
                &gt;        WREG32(CP_RB1_BASE, ring-&gt;gpu_addr
                &gt;&gt; 8);<br>
                &gt;   <br>
                &gt;        ring = &amp;adev-&gt;gfx.compute_ring[1];<br>
                &gt; @@ -1797,7 +1782,6 @@ static int
                gfx_v6_0_cp_compute_resume(struct amdgpu_device *adev)<br>
                &gt;   <br>
                &gt;        mdelay(1);<br>
                &gt;        WREG32(CP_RB2_CNTL, tmp);<br>
                &gt; -<br>
                &gt;        WREG32(CP_RB2_BASE, ring-&gt;gpu_addr
                &gt;&gt; 8);<br>
                &gt;   <br>
                &gt;        adev-&gt;gfx.compute_ring[0].ready = true;<br>
                &gt; @@ -1825,12 +1809,7 @@ static void
                gfx_v6_0_cp_enable(struct amdgpu_device *adev, bool
                enable)<br>
                &gt;   <br>
                &gt;   static int gfx_v6_0_cp_load_microcode(struct
                amdgpu_device *adev)<br>
                &gt;   {<br>
                &gt; -     int r;<br>
                &gt; -<br>
                &gt; -     r = gfx_v6_0_cp_gfx_load_microcode(adev);<br>
                &gt; -<br>
                &gt; -     return r;<br>
                &gt; -<br>
                &gt; +     return gfx_v6_0_cp_gfx_load_microcode(adev);<br>
                &gt;   }<br>
                &gt;   <br>
                &gt;   static void
                gfx_v6_0_enable_gui_idle_interrupt(struct amdgpu_device
                *adev,<br>
                &gt; @@ -2172,7 +2151,6 @@ static void
                gfx_v6_0_rlc_stop(struct amdgpu_device *adev)<br>
                &gt;        WREG32(RLC_CNTL, 0);<br>
                &gt;   <br>
                &gt;        gfx_v6_0_enable_gui_idle_interrupt(adev,
                false);<br>
                &gt; -<br>
                &gt;        gfx_v6_0_wait_for_rlc_serdes(adev);<br>
                &gt;   }<br>
                &gt;   <br>
                &gt; @@ -2223,11 +2201,8 @@ static int
                gfx_v6_0_rlc_resume(struct amdgpu_device *adev)<br>
                &gt;                return -EINVAL;<br>
                &gt;   <br>
                &gt;        gfx_v6_0_rlc_stop(adev);<br>
                &gt; -<br>
                &gt;        gfx_v6_0_rlc_reset(adev);<br>
                &gt; -<br>
                &gt;        gfx_v6_0_init_pg(adev);<br>
                &gt; -<br>
                &gt;        gfx_v6_0_init_cg(adev);<br>
                &gt;   <br>
                &gt;        WREG32(RLC_RL_BASE, 0);<br>
                &gt; @@ -2254,7 +2229,6 @@ static int
                gfx_v6_0_rlc_resume(struct amdgpu_device *adev)<br>
                &gt;        WREG32(RLC_UCODE_ADDR, 0);<br>
                &gt;   <br>
                &gt;        gfx_v6_0_enable_lbpw(adev,
                gfx_v6_0_lbpw_supported(adev));<br>
                &gt; -<br>
                &gt;        gfx_v6_0_rlc_start(adev);<br>
                &gt;   <br>
                &gt;        return 0;<br>
                &gt; @@ -2278,7 +2252,6 @@ static void
                gfx_v6_0_enable_cgcg(struct amdgpu_device *adev, bool
                enable)<br>
                &gt;                WREG32(RLC_SERDES_WR_CTRL,
                0x00b000ff);<br>
                &gt;   <br>
                &gt;                gfx_v6_0_wait_for_rlc_serdes(adev);<br>
                &gt; -<br>
                &gt;                gfx_v6_0_update_rlc(adev, tmp);<br>
                &gt;   <br>
                &gt;                WREG32(RLC_SERDES_WR_CTRL,
                0x007000ff);<br>
                &gt; @@ -2931,13 +2904,10 @@ static bool
                gfx_v6_0_is_idle(void *handle)<br>
                &gt;   static int gfx_v6_0_wait_for_idle(void *handle)<br>
                &gt;   {<br>
                &gt;        unsigned i;<br>
                &gt; -     u32 tmp;<br>
                &gt;        struct amdgpu_device *adev = (struct
                amdgpu_device *)handle;<br>
                &gt;   <br>
                &gt;        for (i = 0; i &lt; adev-&gt;usec_timeout;
                i++) {<br>
                &gt; -             tmp = RREG32(GRBM_STATUS) &amp;
                GRBM_STATUS__GUI_ACTIVE_MASK;<br>
                &gt; -<br>
                &gt; -             if (!tmp)<br>
                &gt; +             if (gfx_v6_0_is_idle(handle))<br>
                &gt;                        return 0;<br>
                &gt;                udelay(1);<br>
                &gt;        }<br>
                <br>
                <br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------D2814AFE5C7A1F8CD063ECE5--

--===============0158857422==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0158857422==--
