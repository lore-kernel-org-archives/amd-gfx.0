From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: =?UTF-8?Q?Re:_=e7=ad=94=e5=a4=8d:_[PATCH_2/3]_drm/amdgpu:implement_?=
 =?UTF-8?Q?META-DATA_write_routines?=
Date: Mon, 16 Jan 2017 11:50:23 +0100
Message-ID: <d6a5c11f-713a-d2f5-f620-cfae5e4e2423@vodafone.de>
References: <1484206893-18806-1-git-send-email-Monk.Liu@amd.com>
 <1484206893-18806-3-git-send-email-Monk.Liu@amd.com>
 <b750813c-5af3-5353-2f08-5b54e0495375@vodafone.de>
 <BY2PR1201MB111021CE95196ED42C7694E4847D0@BY2PR1201MB1110.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2008902084=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BY2PR1201MB111021CE95196ED42C7694E4847D0-O28G1zQ8oGliQkyLPkmea2rFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============2008902084==
Content-Type: multipart/alternative;
 boundary="------------E941B9AFBCD98DD509A0B8CE"

This is a multi-part message in MIME format.
--------------E941B9AFBCD98DD509A0B8CE
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

That is perfectly fine as long as you add the code using it in the same 
set of patches.

What we should avoid is adding a lot of code and then not using for for 
quite some time, that get certainly removed sooner or later.

Regards,
Christian.

Am 16.01.2017 um 09:20 schrieb Liu, Monk:
>
> if ring_write_multiple is organized in a separate patch, doesn't it 
> introduces an function that no client using it ??
>
>
> fine by me although ...
>
>
> BR Monk
>
> ------------------------------------------------------------------------
> *发件人:* Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
> *发送时间:* 2017年1月12日 20:27:48
> *收件人:* Liu, Monk; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *主题:* Re: [PATCH 2/3] drm/amdgpu:implement META-DATA write routines
> Am 12.01.2017 um 08:41 schrieb Monk Liu:
> > Change-Id: I66007a7f7e4e27fb129121f36143dce3cfb43738
> > Signed-off-by: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h   | 31 ++++++++++++++++++
> >   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 61 
> +++++++++++++++++++++++++++++++++++
> >   2 files changed, 92 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index e9983fb..2039da7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -1599,6 +1599,37 @@ static inline void amdgpu_ring_write(struct 
> amdgpu_ring *ring, uint32_t v)
> >        ring->count_dw--;
> >   }
> >
> > +static inline void amdgpu_ring_write_multiple(struct amdgpu_ring 
> *ring, void *src, int count_dw)
> > +{
> > +     unsigned occupied, chunk1, chunk2;
> > +     void *dst;
> > +
> > +     if (ring->count_dw < count_dw)
> > +             DRM_ERROR("amdgpu: writing more dwords to the ring 
> than expected!\n");
> > +     else {
>
> Coding style says when either the "if" or the "else" branch uses "{" and
> "}" both should use them.
>
> I think even better would be to use a return statement in the "if",
> cause this is just checking the prerequisites for errors.
>
> Additional to that adding this function should be a separate patch.
>
> Christian.
>
> > +             occupied = ring->wptr & ring->ptr_mask;
> > +             dst = (void *)&ring->ring[occupied];
> > +             chunk1 = ring->ptr_mask + 1 - occupied;
> > +             chunk1 = (chunk1 >= count_dw) ? count_dw: chunk1;
> > +             chunk2 = count_dw - chunk1;
> > +             chunk1 <<= 2;
> > +             chunk2 <<= 2;
> > +             if (chunk1) {
> > +                     memcpy(dst, src, chunk1);
> > +             }
> > +
> > +             if (chunk2) {
> > +                     src += chunk1;
> > +                     dst = (void *)ring->ring;
> > +                     memcpy(dst, src, chunk2);
> > +             }
> > +
> > +             ring->wptr += count_dw;
> > +             ring->wptr &= ring->ptr_mask;
> > +             ring->count_dw -= count_dw;
> > +     }
> > +}
> > +
> >   static inline struct amdgpu_sdma_instance *
> >   amdgpu_get_sdma_instance(struct amdgpu_ring *ring)
> >   {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c 
> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > index 375784d..3e8cff3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > @@ -657,6 +657,8 @@ static void gfx_v8_0_set_gds_init(struct 
> amdgpu_device *adev);
> >   static void gfx_v8_0_set_rlc_funcs(struct amdgpu_device *adev);
> >   static u32 gfx_v8_0_get_csb_size(struct amdgpu_device *adev);
> >   static void gfx_v8_0_get_cu_info(struct amdgpu_device *adev);
> > +static void gfx_v8_0_ring_emit_ce_meta_init(struct amdgpu_ring 
> *ring, uint64_t addr);
> > +static void gfx_v8_0_ring_emit_de_meta_init(struct amdgpu_ring 
> *ring, uint64_t addr);
> >
> >   static void gfx_v8_0_init_golden_registers(struct amdgpu_device *adev)
> >   {
> > @@ -7212,3 +7214,62 @@ const struct amdgpu_ip_block_version 
> gfx_v8_1_ip_block =
> >        .rev = 0,
> >        .funcs = &gfx_v8_0_ip_funcs,
> >   };
> > +
> > +static void gfx_v8_0_ring_emit_ce_meta_init(struct amdgpu_ring 
> *ring, uint64_t csa_addr)
> > +{
> > +     uint64_t ce_payload_addr;
> > +     int cnt_ce;
> > +     static union {
> > +             struct amdgpu_ce_ib_state regular;
> > +             struct amdgpu_ce_ib_state_chained_ib chained;
> > +     } ce_payload = {0};
> > +
> > +     if (ring->adev->virt.chained_ib_support) {
> > +             ce_payload_addr = csa_addr + offsetof(struct 
> amdgpu_gfx_meta_data_chained_ib, ce_payload);
> > +             cnt_ce = (sizeof(ce_payload.chained) >> 2) + 4 - 2;
> > +     } else {
> > +             ce_payload_addr = csa_addr + offsetof(struct 
> amdgpu_gfx_meta_data, ce_payload);
> > +             cnt_ce = (sizeof(ce_payload.regular) >> 2) + 4 - 2;
> > +     }
> > +
> > +     amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, cnt_ce));
> > +     amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(2) |
> > +                             WRITE_DATA_DST_SEL(8) |
> > +                             WR_CONFIRM) |
> > + WRITE_DATA_CACHE_POLICY(0));
> > +     amdgpu_ring_write(ring, lower_32_bits(ce_payload_addr));
> > +     amdgpu_ring_write(ring, upper_32_bits(ce_payload_addr));
> > +     amdgpu_ring_write_multiple(ring, (void *)&ce_payload, cnt_ce - 2);
> > +}
> > +
> > +static void gfx_v8_0_ring_emit_de_meta_init(struct amdgpu_ring 
> *ring, uint64_t csa_addr)
> > +{
> > +     uint64_t de_payload_addr, gds_addr;
> > +     int cnt_de;
> > +     static union {
> > +             struct amdgpu_de_ib_state regular;
> > +             struct amdgpu_de_ib_state_chained_ib chained;
> > +     } de_payload = {0};
> > +
> > +     gds_addr = csa_addr + 4096;
> > +     if (ring->adev->virt.chained_ib_support) {
> > +             de_payload.chained.gds_backup_addrlo = 
> lower_32_bits(gds_addr);
> > +             de_payload.chained.gds_backup_addrhi = 
> upper_32_bits(gds_addr);
> > +             de_payload_addr = csa_addr + offsetof(struct 
> amdgpu_gfx_meta_data_chained_ib, de_payload);
> > +             cnt_de = (sizeof(de_payload.chained) >> 2) + 4 - 2;
> > +     } else {
> > +             de_payload.regular.gds_backup_addrlo = 
> lower_32_bits(gds_addr);
> > +             de_payload.regular.gds_backup_addrhi = 
> upper_32_bits(gds_addr);
> > +             de_payload_addr = csa_addr + offsetof(struct 
> amdgpu_gfx_meta_data, de_payload);
> > +             cnt_de = (sizeof(de_payload.regular) >> 2) + 4 - 2;
> > +     }
> > +
> > +     amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, cnt_de));
> > +     amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(1) |
> > +                             WRITE_DATA_DST_SEL(8) |
> > +                             WR_CONFIRM) |
> > + WRITE_DATA_CACHE_POLICY(0));
> > +     amdgpu_ring_write(ring, lower_32_bits(de_payload_addr));
> > +     amdgpu_ring_write(ring, upper_32_bits(de_payload_addr));
> > +     amdgpu_ring_write_multiple(ring, (void *)&de_payload, cnt_de - 2);
> > +}
>
>


--------------E941B9AFBCD98DD509A0B8CE
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">That is perfectly fine as long as you
      add the code using it in the same set of patches.<br>
      <br>
      What we should avoid is adding a lot of code and then not using
      for for quite some time, that get certainly removed sooner or
      later.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 16.01.2017 um 09:20 schrieb Liu, Monk:<br>
    </div>
    <blockquote
cite="mid:BY2PR1201MB111021CE95196ED42C7694E4847D0-O28G1zQ8oGliQkyLPkmea2rFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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
          font-family:Calibri,Arial,Helvetica,sans-serif">
          <p>if ring_write_multiple is organized in a separate patch,
            doesn't it introduces an function that no client using it ??</p>
          <p><br>
          </p>
          <p>fine by me although ...<br>
          </p>
          <p><br>
          </p>
          <p>BR Monk<br>
          </p>
        </div>
        <hr tabindex="-1" style="display:inline-block; width:98%">
        <div id="x_divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            color="#000000" face="Calibri, sans-serif"><b>发件人:</b>
            Christian König <a class="moz-txt-link-rfc2396E" href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
            <b>发送时间:</b> 2017年1月12日 20:27:48<br>
            <b>收件人:</b> Liu, Monk; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            <b>主题:</b> Re: [PATCH 2/3] drm/amdgpu:implement META-DATA
            write routines</font>
          <div> </div>
        </div>
      </div>
      <font size="2"><span style="font-size:10pt;">
          <div class="PlainText">Am 12.01.2017 um 08:41 schrieb Monk
            Liu:<br>
            &gt; Change-Id: I66007a7f7e4e27fb129121f36143dce3cfb43738<br>
            &gt; Signed-off-by: Monk Liu <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            &gt; ---<br>
            &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu.h   | 31
            ++++++++++++++++++<br>
            &gt;   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 61
            +++++++++++++++++++++++++++++++++++<br>
            &gt;   2 files changed, 92 insertions(+)<br>
            &gt;<br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
            b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
            &gt; index e9983fb..2039da7 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
            &gt; @@ -1599,6 +1599,37 @@ static inline void
            amdgpu_ring_write(struct amdgpu_ring *ring, uint32_t v)<br>
            &gt;        ring-&gt;count_dw--;<br>
            &gt;   }<br>
            &gt;   <br>
            &gt; +static inline void amdgpu_ring_write_multiple(struct
            amdgpu_ring *ring, void *src, int count_dw)<br>
            &gt; +{<br>
            &gt; +     unsigned occupied, chunk1, chunk2;<br>
            &gt; +     void *dst;<br>
            &gt; +<br>
            &gt; +     if (ring-&gt;count_dw &lt; count_dw)<br>
            &gt; +             DRM_ERROR("amdgpu: writing more dwords to
            the ring than expected!\n");<br>
            &gt; +     else {<br>
            <br>
            Coding style says when either the "if" or the "else" branch
            uses "{" and <br>
            "}" both should use them.<br>
            <br>
            I think even better would be to use a return statement in
            the "if", <br>
            cause this is just checking the prerequisites for errors.<br>
            <br>
            Additional to that adding this function should be a separate
            patch.<br>
            <br>
            Christian.<br>
            <br>
            &gt; +             occupied = ring-&gt;wptr &amp;
            ring-&gt;ptr_mask;<br>
            &gt; +             dst = (void
            *)&amp;ring-&gt;ring[occupied];<br>
            &gt; +             chunk1 = ring-&gt;ptr_mask + 1 -
            occupied;<br>
            &gt; +             chunk1 = (chunk1 &gt;= count_dw) ?
            count_dw: chunk1;<br>
            &gt; +             chunk2 = count_dw - chunk1;<br>
            &gt; +             chunk1 &lt;&lt;= 2;<br>
            &gt; +             chunk2 &lt;&lt;= 2;<br>
            &gt; +             if (chunk1) {<br>
            &gt; +                     memcpy(dst, src, chunk1);<br>
            &gt; +             }<br>
            &gt; +<br>
            &gt; +             if (chunk2) {<br>
            &gt; +                     src += chunk1;<br>
            &gt; +                     dst = (void *)ring-&gt;ring;<br>
            &gt; +                     memcpy(dst, src, chunk2);<br>
            &gt; +             }<br>
            &gt; +<br>
            &gt; +             ring-&gt;wptr += count_dw;<br>
            &gt; +             ring-&gt;wptr &amp;= ring-&gt;ptr_mask;<br>
            &gt; +             ring-&gt;count_dw -= count_dw;<br>
            &gt; +     }<br>
            &gt; +}<br>
            &gt; +<br>
            &gt;   static inline struct amdgpu_sdma_instance *<br>
            &gt;   amdgpu_get_sdma_instance(struct amdgpu_ring *ring)<br>
            &gt;   {<br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
            b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
            &gt; index 375784d..3e8cff3 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
            &gt; @@ -657,6 +657,8 @@ static void
            gfx_v8_0_set_gds_init(struct amdgpu_device *adev);<br>
            &gt;   static void gfx_v8_0_set_rlc_funcs(struct
            amdgpu_device *adev);<br>
            &gt;   static u32 gfx_v8_0_get_csb_size(struct amdgpu_device
            *adev);<br>
            &gt;   static void gfx_v8_0_get_cu_info(struct amdgpu_device
            *adev);<br>
            &gt; +static void gfx_v8_0_ring_emit_ce_meta_init(struct
            amdgpu_ring *ring, uint64_t addr);<br>
            &gt; +static void gfx_v8_0_ring_emit_de_meta_init(struct
            amdgpu_ring *ring, uint64_t addr);<br>
            &gt;   <br>
            &gt;   static void gfx_v8_0_init_golden_registers(struct
            amdgpu_device *adev)<br>
            &gt;   {<br>
            &gt; @@ -7212,3 +7214,62 @@ const struct
            amdgpu_ip_block_version gfx_v8_1_ip_block =<br>
            &gt;        .rev = 0,<br>
            &gt;        .funcs = &amp;gfx_v8_0_ip_funcs,<br>
            &gt;   };<br>
            &gt; +<br>
            &gt; +static void gfx_v8_0_ring_emit_ce_meta_init(struct
            amdgpu_ring *ring, uint64_t csa_addr)<br>
            &gt; +{<br>
            &gt; +     uint64_t ce_payload_addr;<br>
            &gt; +     int cnt_ce;<br>
            &gt; +     static union {<br>
            &gt; +             struct amdgpu_ce_ib_state regular;<br>
            &gt; +             struct amdgpu_ce_ib_state_chained_ib
            chained;<br>
            &gt; +     } ce_payload = {0};<br>
            &gt; +<br>
            &gt; +     if (ring-&gt;adev-&gt;virt.chained_ib_support) {<br>
            &gt; +             ce_payload_addr = csa_addr +
            offsetof(struct amdgpu_gfx_meta_data_chained_ib,
            ce_payload);<br>
            &gt; +             cnt_ce = (sizeof(ce_payload.chained)
            &gt;&gt; 2) + 4 - 2;<br>
            &gt; +     } else {<br>
            &gt; +             ce_payload_addr = csa_addr +
            offsetof(struct amdgpu_gfx_meta_data, ce_payload);<br>
            &gt; +             cnt_ce = (sizeof(ce_payload.regular)
            &gt;&gt; 2) + 4 - 2;<br>
            &gt; +     }<br>
            &gt; +<br>
            &gt; +     amdgpu_ring_write(ring,
            PACKET3(PACKET3_WRITE_DATA, cnt_ce));<br>
            &gt; +     amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(2)
            |<br>
            &gt; +                             WRITE_DATA_DST_SEL(8) |<br>
            &gt; +                             WR_CONFIRM) |<br>
            &gt; +                            
            WRITE_DATA_CACHE_POLICY(0));<br>
            &gt; +     amdgpu_ring_write(ring,
            lower_32_bits(ce_payload_addr));<br>
            &gt; +     amdgpu_ring_write(ring,
            upper_32_bits(ce_payload_addr));<br>
            &gt; +     amdgpu_ring_write_multiple(ring, (void
            *)&amp;ce_payload, cnt_ce - 2);<br>
            &gt; +}<br>
            &gt; +<br>
            &gt; +static void gfx_v8_0_ring_emit_de_meta_init(struct
            amdgpu_ring *ring, uint64_t csa_addr)<br>
            &gt; +{<br>
            &gt; +     uint64_t de_payload_addr, gds_addr;<br>
            &gt; +     int cnt_de;<br>
            &gt; +     static union {<br>
            &gt; +             struct amdgpu_de_ib_state regular;<br>
            &gt; +             struct amdgpu_de_ib_state_chained_ib
            chained;<br>
            &gt; +     } de_payload = {0};<br>
            &gt; +<br>
            &gt; +     gds_addr = csa_addr + 4096;<br>
            &gt; +     if (ring-&gt;adev-&gt;virt.chained_ib_support) {<br>
            &gt; +             de_payload.chained.gds_backup_addrlo =
            lower_32_bits(gds_addr);<br>
            &gt; +             de_payload.chained.gds_backup_addrhi =
            upper_32_bits(gds_addr);<br>
            &gt; +             de_payload_addr = csa_addr +
            offsetof(struct amdgpu_gfx_meta_data_chained_ib,
            de_payload);<br>
            &gt; +             cnt_de = (sizeof(de_payload.chained)
            &gt;&gt; 2) + 4 - 2;<br>
            &gt; +     } else {<br>
            &gt; +             de_payload.regular.gds_backup_addrlo =
            lower_32_bits(gds_addr);<br>
            &gt; +             de_payload.regular.gds_backup_addrhi =
            upper_32_bits(gds_addr);<br>
            &gt; +             de_payload_addr = csa_addr +
            offsetof(struct amdgpu_gfx_meta_data, de_payload);<br>
            &gt; +             cnt_de = (sizeof(de_payload.regular)
            &gt;&gt; 2) + 4 - 2;<br>
            &gt; +     }<br>
            &gt; +<br>
            &gt; +     amdgpu_ring_write(ring,
            PACKET3(PACKET3_WRITE_DATA, cnt_de));<br>
            &gt; +     amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(1)
            |<br>
            &gt; +                             WRITE_DATA_DST_SEL(8) |<br>
            &gt; +                             WR_CONFIRM) |<br>
            &gt; +                            
            WRITE_DATA_CACHE_POLICY(0));<br>
            &gt; +     amdgpu_ring_write(ring,
            lower_32_bits(de_payload_addr));<br>
            &gt; +     amdgpu_ring_write(ring,
            upper_32_bits(de_payload_addr));<br>
            &gt; +     amdgpu_ring_write_multiple(ring, (void
            *)&amp;de_payload, cnt_de - 2);<br>
            &gt; +}<br>
            <br>
            <br>
          </div>
        </span></font>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------E941B9AFBCD98DD509A0B8CE--

--===============2008902084==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2008902084==--
