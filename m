From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 10/21] drm/amdgpu: wire up emit_wreg for UVD v6
Date: Wed, 17 Jan 2018 15:49:49 +0100
Message-ID: <2db2e630-2fe3-b3c7-8e7f-de7d4f67266d@amd.com>
References: <20180116194017.39067-1-christian.koenig@amd.com>
 <20180116194017.39067-10-christian.koenig@amd.com>
 <CADnq5_Pc2QujuEDmsb8O2E0-VGmMgSCkN2K-B4O_1y-3zrQE7A@mail.gmail.com>
 <c33f3adf-66d4-1d37-ebc9-cf3ab7d1b967@gmail.com>
 <BN6PR12MB1652DE27EE111B57EC39AA78F7E90@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1821503242=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1652DE27EE111B57EC39AA78F7E90-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1821503242==
Content-Type: multipart/alternative;
 boundary="------------1E27C57CD4C4B0C750A93B51"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------1E27C57CD4C4B0C750A93B51
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.01.2018 um 15:22 schrieb Deucher, Alexander:
>
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Christian König <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Wednesday, January 17, 2018 7:42 AM
> *To:* Alex Deucher
> *Cc:* amd-gfx list
> *Subject:* Re: [PATCH 10/21] drm/amdgpu: wire up emit_wreg for UVD v6
> Am 16.01.2018 um 21:01 schrieb Alex Deucher:
> > On Tue, Jan 16, 2018 at 2:40 PM, Christian König
> > <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >> Needed for vm_flush unification.
> >>
> >> Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 12 ++++++++++++
> >>   1 file changed, 12 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c 
> b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> >> index c6e22eff89e7..b48b843c66ae 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> >> @@ -1059,6 +1059,17 @@ static void uvd_v6_0_enc_ring_emit_ib(struct 
> amdgpu_ring *ring,
> >>          amdgpu_ring_write(ring, ib->length_dw);
> >>   }
> >>
> >> +static void uvd_v6_0_ring_emit_wreg(struct amdgpu_ring *ring,
> >> +                                   uint32_t reg, uint32_t val)
> >> +{
> >> +       amdgpu_ring_write(ring, PACKET0(mmUVD_GPCOM_VCPU_DATA0, 0));
> >> +       amdgpu_ring_write(ring, reg << 2);
> >> +       amdgpu_ring_write(ring, PACKET0(mmUVD_GPCOM_VCPU_DATA1, 0));
> >> +       amdgpu_ring_write(ring, val);
> >> +       amdgpu_ring_write(ring, PACKET0(mmUVD_GPCOM_VCPU_CMD, 0));
> >> +       amdgpu_ring_write(ring, 0x8);
> > Is this valid on UVD6?
>
> This is valid on the decode ring of UVD6, only the HEVC UVD6 encode and
> VCE3 rings use different commands.
>
> >    I think this may be a UVD7 thing.  Looking at
> > the other UVD code, I think we just want:
> >          amdgpu_ring_write(ring, PACKET0(reg, 0));
> >          amdgpu_ring_write(ring, val);
>
> IIRC that won't work. The UVD RBC can only write to UVD registers using
> the PACKET0 command.
>
> We probably need to fix a bunch of functions in uvd4,5,6,7 in that 
> case which use packet0 directly to write non-UVD registers.

Yeah, I see. I briefly remember that I questioned if this works or not 
two years ago when we added the code.

Going to wire things up correctly with the new wreg callback.

Christian.

>
> Alex
>
>
> Regards,
> Christian.
>
> >
> > Alex
> >
> >
> >> +}
> >> +
> >>   static void uvd_v6_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
> >> unsigned vmid, unsigned pasid,
> >> uint64_t pd_addr)
> >> @@ -1595,6 +1606,7 @@ static const struct amdgpu_ring_funcs 
> uvd_v6_0_ring_vm_funcs = {
> >>          .pad_ib = amdgpu_ring_generic_pad_ib,
> >>          .begin_use = amdgpu_uvd_ring_begin_use,
> >>          .end_use = amdgpu_uvd_ring_end_use,
> >> +       .emit_wreg = uvd_v6_0_ring_emit_wreg,
> >>   };
> >>
> >>   static const struct amdgpu_ring_funcs uvd_v6_0_enc_ring_vm_funcs = {
> >> --
> >> 2.14.1
> >>
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> >> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------1E27C57CD4C4B0C750A93B51
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 17.01.2018 um 15:22 schrieb Deucher,
      Alexander:<br>
    </div>
    <blockquote type="cite"
cite="mid:BN6PR12MB1652DE27EE111B57EC39AA78F7E90-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper" style="font-size: 12pt; color:
        rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif,
        &quot;EmojiFont&quot;, &quot;Apple Color Emoji&quot;,
        &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI
        Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;"
        dir="ltr">
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <div style="color: rgb(0, 0, 0);">
          <hr style="display:inline-block;width:98%" tabindex="-1">
          <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
              face="Calibri, sans-serif" color="#000000"><b>From:</b>
              amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on
              behalf of Christian König
              <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
              <b>Sent:</b> Wednesday, January 17, 2018 7:42 AM<br>
              <b>To:</b> Alex Deucher<br>
              <b>Cc:</b> amd-gfx list<br>
              <b>Subject:</b> Re: [PATCH 10/21] drm/amdgpu: wire up
              emit_wreg for UVD v6</font>
            <div> </div>
          </div>
          <div class="BodyFragment"><font size="2"><span
                style="font-size:11pt;">
                <div class="PlainText">Am 16.01.2018 um 21:01 schrieb
                  Alex Deucher:<br>
                  &gt; On Tue, Jan 16, 2018 at 2:40 PM, Christian König<br>
                  &gt; <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a> wrote:<br>
                  &gt;&gt; Needed for vm_flush unification.<br>
                  &gt;&gt;<br>
                  &gt;&gt; Signed-off-by: Christian König
                  <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                  &gt;&gt; ---<br>
                  &gt;&gt;   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c | 12
                  ++++++++++++<br>
                  &gt;&gt;   1 file changed, 12 insertions(+)<br>
                  &gt;&gt;<br>
                  &gt;&gt; diff --git
                  a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
                  b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
                  &gt;&gt; index c6e22eff89e7..b48b843c66ae 100644<br>
                  &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
                  &gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
                  &gt;&gt; @@ -1059,6 +1059,17 @@ static void
                  uvd_v6_0_enc_ring_emit_ib(struct amdgpu_ring *ring,<br>
                  &gt;&gt;          amdgpu_ring_write(ring,
                  ib-&gt;length_dw);<br>
                  &gt;&gt;   }<br>
                  &gt;&gt;<br>
                  &gt;&gt; +static void uvd_v6_0_ring_emit_wreg(struct
                  amdgpu_ring *ring,<br>
                  &gt;&gt; +                                   uint32_t
                  reg, uint32_t val)<br>
                  &gt;&gt; +{<br>
                  &gt;&gt; +       amdgpu_ring_write(ring,
                  PACKET0(mmUVD_GPCOM_VCPU_DATA0, 0));<br>
                  &gt;&gt; +       amdgpu_ring_write(ring, reg &lt;&lt;
                  2);<br>
                  &gt;&gt; +       amdgpu_ring_write(ring,
                  PACKET0(mmUVD_GPCOM_VCPU_DATA1, 0));<br>
                  &gt;&gt; +       amdgpu_ring_write(ring, val);<br>
                  &gt;&gt; +       amdgpu_ring_write(ring,
                  PACKET0(mmUVD_GPCOM_VCPU_CMD, 0));<br>
                  &gt;&gt; +       amdgpu_ring_write(ring, 0x8);<br>
                  &gt; Is this valid on UVD6?<br>
                  <br>
                  This is valid on the decode ring of UVD6, only the
                  HEVC UVD6 encode and <br>
                  VCE3 rings use different commands.<br>
                  <br>
                  &gt;    I think this may be a UVD7 thing.  Looking at<br>
                  &gt; the other UVD code, I think we just want:<br>
                  &gt;          amdgpu_ring_write(ring, PACKET0(reg,
                  0));<br>
                  &gt;          amdgpu_ring_write(ring, val);<br>
                  <br>
                  IIRC that won't work. The UVD RBC can only write to
                  UVD registers using <br>
                  the PACKET0 command.</div>
                <div class="PlainText"><br>
                </div>
                <div class="PlainText">We probably need to fix a bunch
                  of functions in uvd4,5,6,7 in that case which use
                  packet0 directly to write non-UVD registers.<br>
                </div>
              </span></font></div>
        </div>
      </div>
    </blockquote>
    <br>
    Yeah, I see. I briefly remember that I questioned if this works or
    not two years ago when we added the code.<br>
    <br>
    Going to wire things up correctly with the new wreg callback.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:BN6PR12MB1652DE27EE111B57EC39AA78F7E90-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <div id="divtagdefaultwrapper" style="font-size: 12pt; color:
        rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif,
        &quot;EmojiFont&quot;, &quot;Apple Color Emoji&quot;,
        &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI
        Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;"
        dir="ltr">
        <div style="color: rgb(0, 0, 0);">
          <div class="BodyFragment"><font size="2"><span
                style="font-size:11pt;">
                <div class="PlainText">
                </div>
                <div class="PlainText"><br>
                </div>
                <div class="PlainText">Alex<br>
                </div>
                <div class="PlainText"><br>
                  <br>
                  Regards,<br>
                  Christian.<br>
                  <br>
                  &gt;<br>
                  &gt; Alex<br>
                  &gt;<br>
                  &gt;<br>
                  &gt;&gt; +}<br>
                  &gt;&gt; +<br>
                  &gt;&gt;   static void
                  uvd_v6_0_ring_emit_vm_flush(struct amdgpu_ring *ring,<br>
                  &gt;&gt;                                         
                  unsigned vmid, unsigned pasid,<br>
                  &gt;&gt;                                         
                  uint64_t pd_addr)<br>
                  &gt;&gt; @@ -1595,6 +1606,7 @@ static const struct
                  amdgpu_ring_funcs uvd_v6_0_ring_vm_funcs = {<br>
                  &gt;&gt;          .pad_ib =
                  amdgpu_ring_generic_pad_ib,<br>
                  &gt;&gt;          .begin_use =
                  amdgpu_uvd_ring_begin_use,<br>
                  &gt;&gt;          .end_use = amdgpu_uvd_ring_end_use,<br>
                  &gt;&gt; +       .emit_wreg = uvd_v6_0_ring_emit_wreg,<br>
                  &gt;&gt;   };<br>
                  &gt;&gt;<br>
                  &gt;&gt;   static const struct amdgpu_ring_funcs
                  uvd_v6_0_enc_ring_vm_funcs = {<br>
                  &gt;&gt; --<br>
                  &gt;&gt; 2.14.1<br>
                  &gt;&gt;<br>
                  &gt;&gt;
                  _______________________________________________<br>
                  &gt;&gt; amd-gfx mailing list<br>
                  &gt;&gt; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                  &gt;&gt; <a
                    href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                    id="LPlnk963697" previewremoved="true"
                    moz-do-not-send="true">
https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
                  <br>
                  _______________________________________________<br>
                  amd-gfx mailing list<br>
                  <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                  <a
                    href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                    id="LPlnk476865" previewremoved="true"
                    moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
                </div>
              </span></font></div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------1E27C57CD4C4B0C750A93B51--

--===============1821503242==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1821503242==--
