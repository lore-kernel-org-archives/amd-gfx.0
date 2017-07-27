From: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: remove unused power control for vcn
Date: Thu, 27 Jul 2017 11:58:54 -0400
Message-ID: <1a151b41-e78d-e0c9-ecad-0b90130947c4@amd.com>
References: <1501096057-10197-1-git-send-email-leo.liu@amd.com>
 <BN6PR12MB1652D771EA8F795335E7372DF7BE0@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1692673812=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1652D771EA8F795335E7372DF7BE0-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Content-Language: en-GB
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1692673812==
Content-Type: multipart/alternative;
 boundary="------------25D2E2E914B173C375E7A321"
Content-Language: en-GB

This is a multi-part message in MIME format.
--------------25D2E2E914B173C375E7A321
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



On 07/26/2017 10:44 PM, Deucher, Alexander wrote:
> > -----Original Message-----
> > From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf
> > Of Leo Liu
> > Sent: Wednesday, July 26, 2017 3:08 PM
> > To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > Cc: Liu, Leo
> > Subject: [PATCH] drm/amdgpu: remove unused power control for vcn
> >
> > The power control for vcn has been moved to firmware, kernel'll spins
> > "amdgpu: [powerplay] pp_dpm_powergate_uvd was not implemented",
> > each
> > time when application runs, so let's remove it.
> >
> > Signed-off-by: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>
>
> Does firmware cover powergating/clockgating as well or just dpm?
No. dpm only.

> I think we may still need to handle clock and powergating  manually.
I will keep the function and comment it out till pg/cg, since it's 
annoying to spin that error message.

The new patch will follow shortly.

Leo

>
> Alex
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 23 +----------------------
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 -
> >  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  4 ++--
> >  3 files changed, 3 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > index 09190fa..4186f45 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> > @@ -207,29 +207,8 @@ static void amdgpu_vcn_idle_work_handler(struct
> > work_struct *work)
> >                container_of(work, struct amdgpu_device,
> > vcn.idle_work.work);
> >        unsigned fences = amdgpu_fence_count_emitted(&adev-
> > >vcn.ring_dec);
> >
> > -     if (fences == 0) {
> > -             if (adev->pm.dpm_enabled) {
> > -                     amdgpu_dpm_enable_uvd(adev, false);
> > -             } else {
> > -                     amdgpu_asic_set_uvd_clocks(adev, 0, 0);
> > -             }
> > -     } else {
> > +     if (fences != 0)
> > schedule_delayed_work(&adev->vcn.idle_work,
> > VCN_IDLE_TIMEOUT);
> > -     }
> > -}
> > -
> > -void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
> > -{
> > -     struct amdgpu_device *adev = ring->adev;
> > -     bool set_clocks = !cancel_delayed_work_sync(&adev-
> > >vcn.idle_work);
> > -
> > -     if (set_clocks) {
> > -             if (adev->pm.dpm_enabled) {
> > -                     amdgpu_dpm_enable_uvd(adev, true);
> > -             } else {
> > -                     amdgpu_asic_set_uvd_clocks(adev, 53300, 40000);
> > -             }
> > -     }
> >  }
> >
> >  void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > index d50ba06..930903d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
> > @@ -65,7 +65,6 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
> >  int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);
> >  int amdgpu_vcn_suspend(struct amdgpu_device *adev);
> >  int amdgpu_vcn_resume(struct amdgpu_device *adev);
> > -void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
> >  void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
> >
> >  int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > index 21e7b88..94814f0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> > @@ -1122,7 +1122,7 @@ static const struct amdgpu_ring_funcs
> > vcn_v1_0_dec_ring_vm_funcs = {
> >        .insert_start = vcn_v1_0_dec_ring_insert_start,
> >        .insert_end = vcn_v1_0_dec_ring_insert_end,
> >        .pad_ib = amdgpu_ring_generic_pad_ib,
> > -     .begin_use = amdgpu_vcn_ring_begin_use,
> > +     .begin_use = NULL,
> >        .end_use = amdgpu_vcn_ring_end_use,
> >  };
> >
> > @@ -1148,7 +1148,7 @@ static const struct amdgpu_ring_funcs
> > vcn_v1_0_enc_ring_vm_funcs = {
> >        .insert_nop = amdgpu_ring_insert_nop,
> >        .insert_end = vcn_v1_0_enc_ring_insert_end,
> >        .pad_ib = amdgpu_ring_generic_pad_ib,
> > -     .begin_use = amdgpu_vcn_ring_begin_use,
> > +     .begin_use = NULL,
> >        .end_use = amdgpu_vcn_ring_end_use,
> >  };
> >
> > --
> > 2.7.4
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------25D2E2E914B173C375E7A321
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 07/26/2017 10:44 PM, Deucher,
      Alexander wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:BN6PR12MB1652D771EA8F795335E7372DF7BE0-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
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
            &gt; Of Leo Liu<br>
            &gt; Sent: Wednesday, July 26, 2017 3:08 PM<br>
            &gt; To: <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            &gt; Cc: Liu, Leo<br>
            &gt; Subject: [PATCH] drm/amdgpu: remove unused power
            control for vcn<br>
            &gt; <br>
            &gt; The power control for vcn has been moved to firmware,
            kernel'll spins<br>
            &gt; "amdgpu: [powerplay] pp_dpm_powergate_uvd was not
            implemented",<br>
            &gt; each<br>
            &gt; time when application runs, so let's remove it.<br>
            &gt; <br>
            &gt; Signed-off-by: Leo Liu <a class="moz-txt-link-rfc2396E" href="mailto:leo.liu-5C7GfCeVMHo@public.gmane.org">&lt;leo.liu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            <br>
            Does firmware cover powergating/clockgating as well or just
            dpm? <br>
          </div>
        </span></font></blockquote>
    No. dpm only.<br>
    <br>
    <blockquote type="cite"
cite="mid:BN6PR12MB1652D771EA8F795335E7372DF7BE0-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"><font
        size="2"><span style="font-size:10pt;">
          <div class="PlainText"> I think we may still need to handle
            clock and powergating  manually.<br>
          </div>
        </span></font></blockquote>
    I will keep the function and comment it out till pg/cg, since it's
    annoying to spin that error message.<br>
    <br>
    The new patch will follow shortly.<br>
    <br>
    Leo<br>
    <br>
    <blockquote type="cite"
cite="mid:BN6PR12MB1652D771EA8F795335E7372DF7BE0-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"><font
        size="2"><span style="font-size:10pt;">
          <div class="PlainText">
            <br>
            Alex<br>
            <br>
            &gt; ---<br>
            &gt;  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 23
            +----------------------<br>
            &gt;  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 -<br>
            &gt;  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  4 ++--<br>
            &gt;  3 files changed, 3 insertions(+), 25 deletions(-)<br>
            &gt; <br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
            &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
            &gt; index 09190fa..4186f45 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c<br>
            &gt; @@ -207,29 +207,8 @@ static void
            amdgpu_vcn_idle_work_handler(struct<br>
            &gt; work_struct *work)<br>
            &gt;                container_of(work, struct amdgpu_device,<br>
            &gt; vcn.idle_work.work);<br>
            &gt;        unsigned fences =
            amdgpu_fence_count_emitted(&amp;adev-<br>
            &gt; &gt;vcn.ring_dec);<br>
            &gt; <br>
            &gt; -     if (fences == 0) {<br>
            &gt; -             if (adev-&gt;pm.dpm_enabled) {<br>
            &gt; -                     amdgpu_dpm_enable_uvd(adev,
            false);<br>
            &gt; -             } else {<br>
            &gt; -                     amdgpu_asic_set_uvd_clocks(adev,
            0, 0);<br>
            &gt; -             }<br>
            &gt; -     } else {<br>
            &gt; +     if (fences != 0)<br>
            &gt;               
            schedule_delayed_work(&amp;adev-&gt;vcn.idle_work,<br>
            &gt; VCN_IDLE_TIMEOUT);<br>
            &gt; -     }<br>
            &gt; -}<br>
            &gt; -<br>
            &gt; -void amdgpu_vcn_ring_begin_use(struct amdgpu_ring
            *ring)<br>
            &gt; -{<br>
            &gt; -     struct amdgpu_device *adev = ring-&gt;adev;<br>
            &gt; -     bool set_clocks =
            !cancel_delayed_work_sync(&amp;adev-<br>
            &gt; &gt;vcn.idle_work);<br>
            &gt; -<br>
            &gt; -     if (set_clocks) {<br>
            &gt; -             if (adev-&gt;pm.dpm_enabled) {<br>
            &gt; -                     amdgpu_dpm_enable_uvd(adev,
            true);<br>
            &gt; -             } else {<br>
            &gt; -                     amdgpu_asic_set_uvd_clocks(adev,
            53300, 40000);<br>
            &gt; -             }<br>
            &gt; -     }<br>
            &gt;  }<br>
            &gt; <br>
            &gt;  void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring)<br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h<br>
            &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h<br>
            &gt; index d50ba06..930903d 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h<br>
            &gt; @@ -65,7 +65,6 @@ int amdgpu_vcn_sw_init(struct
            amdgpu_device *adev);<br>
            &gt;  int amdgpu_vcn_sw_fini(struct amdgpu_device *adev);<br>
            &gt;  int amdgpu_vcn_suspend(struct amdgpu_device *adev);<br>
            &gt;  int amdgpu_vcn_resume(struct amdgpu_device *adev);<br>
            &gt; -void amdgpu_vcn_ring_begin_use(struct amdgpu_ring
            *ring);<br>
            &gt;  void amdgpu_vcn_ring_end_use(struct amdgpu_ring
            *ring);<br>
            &gt; <br>
            &gt;  int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring
            *ring);<br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
            &gt; b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
            &gt; index 21e7b88..94814f0 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
            &gt; @@ -1122,7 +1122,7 @@ static const struct
            amdgpu_ring_funcs<br>
            &gt; vcn_v1_0_dec_ring_vm_funcs = {<br>
            &gt;        .insert_start = vcn_v1_0_dec_ring_insert_start,<br>
            &gt;        .insert_end = vcn_v1_0_dec_ring_insert_end,<br>
            &gt;        .pad_ib = amdgpu_ring_generic_pad_ib,<br>
            &gt; -     .begin_use = amdgpu_vcn_ring_begin_use,<br>
            &gt; +     .begin_use = NULL,<br>
            &gt;        .end_use = amdgpu_vcn_ring_end_use,<br>
            &gt;  };<br>
            &gt; <br>
            &gt; @@ -1148,7 +1148,7 @@ static const struct
            amdgpu_ring_funcs<br>
            &gt; vcn_v1_0_enc_ring_vm_funcs = {<br>
            &gt;        .insert_nop = amdgpu_ring_insert_nop,<br>
            &gt;        .insert_end = vcn_v1_0_enc_ring_insert_end,<br>
            &gt;        .pad_ib = amdgpu_ring_generic_pad_ib,<br>
            &gt; -     .begin_use = amdgpu_vcn_ring_begin_use,<br>
            &gt; +     .begin_use = NULL,<br>
            &gt;        .end_use = amdgpu_vcn_ring_end_use,<br>
            &gt;  };<br>
            &gt; <br>
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
    <br>
  </body>
</html>

--------------25D2E2E914B173C375E7A321--

--===============1692673812==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1692673812==--
