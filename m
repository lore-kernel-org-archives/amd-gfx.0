Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AA4C38A2A
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 16:58:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C272075E
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 16:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpmK6jXE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C272075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0CEF6EA34;
	Thu,  7 May 2020 16:58:58 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78D3F6EA34
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2020 16:58:57 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id h9so7277760wrt.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 May 2020 09:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Dbkka8rNeHLTl7Zw4iZ5Gadac/1IsQEBoflHwvIvLGI=;
 b=LpmK6jXE+ndbyD3sbH+zgZDEEGoF6izoHPzVGI9xeCpPpWNbXGZgYhmuCO4r64C4Hq
 ndlyQi48+muxIdpgVqrLRMyTJ6QxFmw2c5dENtkdmgyE2tuXZTOb2QsH7L15YlLxA3Sv
 +l3455z2G0OI1pKGTDNYok+o5lo6tBlFd4nRJY2+QutaGxYZGdCFBSYA7O6GLi0jPSTr
 ZpdeznDG1tHZXNtpCm19w3T3s33KbTatVhqDdsJjLAqymsvK7+lAhx95yYCN4alJu0Ll
 ZFRBkQt/FrvNFDhVC3+7i/3tXmdCvVp8mynFf5F4aeJsjMCVjyDuMMjH4hAsQJ+4K40i
 KUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Dbkka8rNeHLTl7Zw4iZ5Gadac/1IsQEBoflHwvIvLGI=;
 b=cVoszWp1cagpmDDV2OMWohLoa68ai6mwd/ZiHdakIKOhpI0DesLTyKYnQu4EppdHOT
 eWW97jmgwdVAXXz0/Vr/VELBe96U6G4bgS04ylYF0QqUcxDPS32bgbLrIn7Pvd0UV/Zz
 YB9sX6od5/puGIt0hjjFr/I/gNMtb95XfpjT28ZYt4Pnp6qvM43Ii5tiX13Fr/4cuUZR
 lXjelIqdldNuM9hiq1JrfNA6ySkuHMUogfvwSg90ijyxcdVgZ97F3gFoC49+lE5pM5s3
 owni23zaDYoypKOB5E3jXRyC0aLxoxvbG5AWnHLOZ0/YCAHlERvKYruBkn49Bdmnlux6
 4X3w==
X-Gm-Message-State: AGi0PuZclLQhDQ/n9wmkxcfBrI6sVYE04ty7PO/vvVNipIKBs7bMWbLX
 7pdOwBvPdlZ3udVDt5PP0FJCiOT9Z9bifaeql4Ie7OzT4B0=
X-Google-Smtp-Source: APiQypLjhGa4uK1p4LsXcbZ9cMKMzdiMQU+73GXJ/5AcB66au4XnsD5udQfSLM5Kd2akgy9j+kJU3wb40IHIJ3Ivobw=
X-Received: by 2002:a5d:6b8c:: with SMTP id n12mr14488235wrx.107.1588870736059; 
 Thu, 07 May 2020 09:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200506194754.10780-1-nicholas.kazlauskas@amd.com>
 <33b0a4ad-496a-51f7-dbd4-ace5e807b3e9@amd.com>
In-Reply-To: <33b0a4ad-496a-51f7-dbd4-ace5e807b3e9@amd.com>
From: Mario Kleiner <mario.kleiner.de@gmail.com>
Date: Thu, 7 May 2020 18:58:44 +0200
Message-ID: <CAEsyxyg0Vt=t=Ukt9H_6DQV_ikwqVKkkC3LtGQB3RPg8p=QUeg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix vblank and pageflip event handling
 for FreeSync
To: Leo Li <sunpeng.li@amd.com>
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0423196247=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0423196247==
Content-Type: multipart/alternative; boundary="000000000000d1231005a511cbbd"

--000000000000d1231005a511cbbd
Content-Type: text/plain; charset="UTF-8"

Looking over it now, will do some testing. Alex amdgpu-drm-next branch
would be the best to test this?

It looks like a revert of the whole vstartup series, except for that one
if(acrtc_state->active_planes == 0)  special case, so i expect it should be
fine?

thanks,
-mario


On Thu, May 7, 2020 at 5:56 PM Leo Li <sunpeng.li@amd.com> wrote:

>
>
> On 2020-05-06 3:47 p.m., Nicholas Kazlauskas wrote:
> > [Why]
> > We're the drm vblank event a frame too early in the case where the
>         ^sending
>
> Thanks for catching this!
>
> Reviewed-by: Leo Li <sunpeng.li@amd.com>
>
> > pageflip happens close to VUPDATE and ends up blocking the signal.
> >
> > The implementation in DM was previously correct *before* we started
> > sending vblank events from VSTARTUP unconditionally to handle cases
> > where HUBP was off, OTG was ON and userspace was still requesting some
> > DRM planes enabled. As part of that patch series we dropped VUPDATE
> > since it was deemed close enough to VSTARTUP, but there's a key
> > difference betweeen VSTARTUP and VUPDATE - the VUPDATE signal can be
> > blocked if we're holding the pipe lock >
> > There was a fix recently to revert the unconditional behavior for the
> > DCN VSTARTUP vblank event since it was sending the pageflip event on
> > the wrong frame - once again, due to blocking VUPDATE and having the
> > address start scanning out two frames later.
> >
> > The problem with this fix is it didn't update the logic that calls
> > drm_crtc_handle_vblank(), so the timestamps are totally bogus now.
> >
> > [How]
> > Essentially reverts most of the original VSTARTUP series but retains
> > the behavior to send back events when active planes == 0.
> >
> > Some refactoring/cleanup was done to not have duplicated code in both
> > the handlers.
> >
> > Fixes: 16f17eda8bad ("drm/amd/display: Send vblank and user events at
> vsartup for DCN")
> > Fixes: 3a2ce8d66a4b ("drm/amd/display: Disable VUpdate interrupt for DCN
> hardware")
> > Fixes: 2b5aed9ac3f7 ("drm/amd/display: Fix pageflip event race condition
> for DCN.")
> >
> > Cc: Leo Li <sunpeng.li@amd.com>
> > Cc: Mario Kleiner <mario.kleiner.de@gmail.com>
> > Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> > ---
> >   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 137 +++++++-----------
> >   1 file changed, 55 insertions(+), 82 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index 59f1d4a94f12..30ce28f7c444 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -441,7 +441,7 @@ static void dm_vupdate_high_irq(void
> *interrupt_params)
> >
> >   /**
> >    * dm_crtc_high_irq() - Handles CRTC interrupt
> > - * @interrupt_params: ignored
> > + * @interrupt_params: used for determining the CRTC instance
> >    *
> >    * Handles the CRTC/VSYNC interrupt by notfying DRM's VBLANK
> >    * event handler.
> > @@ -455,70 +455,6 @@ static void dm_crtc_high_irq(void *interrupt_params)
> >       unsigned long flags;
> >
> >       acrtc = get_crtc_by_otg_inst(adev, irq_params->irq_src -
> IRQ_TYPE_VBLANK);
> > -
> > -     if (acrtc) {
> > -             acrtc_state = to_dm_crtc_state(acrtc->base.state);
> > -
> > -             DRM_DEBUG_VBL("crtc:%d, vupdate-vrr:%d\n",
> > -                           acrtc->crtc_id,
> > -                           amdgpu_dm_vrr_active(acrtc_state));
> > -
> > -             /* Core vblank handling at start of front-porch is only
> possible
> > -              * in non-vrr mode, as only there vblank timestamping will
> give
> > -              * valid results while done in front-porch. Otherwise
> defer it
> > -              * to dm_vupdate_high_irq after end of front-porch.
> > -              */
> > -             if (!amdgpu_dm_vrr_active(acrtc_state))
> > -                     drm_crtc_handle_vblank(&acrtc->base);
> > -
> > -             /* Following stuff must happen at start of vblank, for crc
> > -              * computation and below-the-range btr support in vrr mode.
> > -              */
> > -             amdgpu_dm_crtc_handle_crc_irq(&acrtc->base);
> > -
> > -             if (acrtc_state->stream && adev->family >=
> AMDGPU_FAMILY_AI &&
> > -                 acrtc_state->vrr_params.supported &&
> > -                 acrtc_state->freesync_config.state ==
> VRR_STATE_ACTIVE_VARIABLE) {
> > -                     spin_lock_irqsave(&adev->ddev->event_lock, flags);
> > -                     mod_freesync_handle_v_update(
> > -                             adev->dm.freesync_module,
> > -                             acrtc_state->stream,
> > -                             &acrtc_state->vrr_params);
> > -
> > -                     dc_stream_adjust_vmin_vmax(
> > -                             adev->dm.dc,
> > -                             acrtc_state->stream,
> > -                             &acrtc_state->vrr_params.adjust);
> > -                     spin_unlock_irqrestore(&adev->ddev->event_lock,
> flags);
> > -             }
> > -     }
> > -}
> > -
> > -#if defined(CONFIG_DRM_AMD_DC_DCN)
> > -/**
> > - * dm_dcn_crtc_high_irq() - Handles VStartup interrupt for DCN
> generation ASICs
> > - * @interrupt params - interrupt parameters
> > - *
> > - * Notify DRM's vblank event handler at VSTARTUP
> > - *
> > - * Unlike DCE hardware, we trigger the handler at VSTARTUP. at which:
> > - * * We are close enough to VUPDATE - the point of no return for hw
> > - * * We are in the fixed portion of variable front porch when vrr is
> enabled
> > - * * We are before VUPDATE, where double-buffered vrr registers are
> swapped
> > - *
> > - * It is therefore the correct place to signal vblank, send user flip
> events,
> > - * and update VRR.
> > - */
> > -static void dm_dcn_crtc_high_irq(void *interrupt_params)
> > -{
> > -     struct common_irq_params *irq_params = interrupt_params;
> > -     struct amdgpu_device *adev = irq_params->adev;
> > -     struct amdgpu_crtc *acrtc;
> > -     struct dm_crtc_state *acrtc_state;
> > -     unsigned long flags;
> > -
> > -     acrtc = get_crtc_by_otg_inst(adev, irq_params->irq_src -
> IRQ_TYPE_VBLANK);
> > -
> >       if (!acrtc)
> >               return;
> >
> > @@ -528,22 +464,35 @@ static void dm_dcn_crtc_high_irq(void
> *interrupt_params)
> >                        amdgpu_dm_vrr_active(acrtc_state),
> >                        acrtc_state->active_planes);
> >
> > +     /**
> > +      * Core vblank handling at start of front-porch is only possible
> > +      * in non-vrr mode, as only there vblank timestamping will give
> > +      * valid results while done in front-porch. Otherwise defer it
> > +      * to dm_vupdate_high_irq after end of front-porch.
> > +      */
> > +     if (!amdgpu_dm_vrr_active(acrtc_state))
> > +             drm_crtc_handle_vblank(&acrtc->base);
> > +
> > +     /**
> > +      * Following stuff must happen at start of vblank, for crc
> > +      * computation and below-the-range btr support in vrr mode.
> > +      */
> >       amdgpu_dm_crtc_handle_crc_irq(&acrtc->base);
> > -     drm_crtc_handle_vblank(&acrtc->base);
> > +
> > +     /* BTR updates need to happen before VUPDATE on Vega and above. */
> > +     if (adev->family < AMDGPU_FAMILY_AI)
> > +             return;
> >
> >       spin_lock_irqsave(&adev->ddev->event_lock, flags);
> >
> > -     if (acrtc_state->vrr_params.supported &&
> > +     if (acrtc_state->stream && acrtc_state->vrr_params.supported &&
> >           acrtc_state->freesync_config.state ==
> VRR_STATE_ACTIVE_VARIABLE) {
> > -             mod_freesync_handle_v_update(
> > -             adev->dm.freesync_module,
> > -             acrtc_state->stream,
> > -             &acrtc_state->vrr_params);
> > +             mod_freesync_handle_v_update(adev->dm.freesync_module,
> > +                                          acrtc_state->stream,
> > +                                          &acrtc_state->vrr_params);
> >
> > -             dc_stream_adjust_vmin_vmax(
> > -                     adev->dm.dc,
> > -                     acrtc_state->stream,
> > -                     &acrtc_state->vrr_params.adjust);
> > +             dc_stream_adjust_vmin_vmax(adev->dm.dc,
> acrtc_state->stream,
> > +
> &acrtc_state->vrr_params.adjust);
> >       }
> >
> >       /*
> > @@ -556,7 +505,8 @@ static void dm_dcn_crtc_high_irq(void
> *interrupt_params)
> >        * avoid race conditions between flip programming and completion,
> >        * which could cause too early flip completion events.
> >        */
> > -     if (acrtc->pflip_status == AMDGPU_FLIP_SUBMITTED &&
> > +     if (adev->family >= AMDGPU_FAMILY_RV &&
> > +         acrtc->pflip_status == AMDGPU_FLIP_SUBMITTED &&
> >           acrtc_state->active_planes == 0) {
> >               if (acrtc->event) {
> >                       drm_crtc_send_vblank_event(&acrtc->base,
> acrtc->event);
> > @@ -568,7 +518,6 @@ static void dm_dcn_crtc_high_irq(void
> *interrupt_params)
> >
> >       spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
> >   }
> > -#endif
> >
> >   static int dm_set_clockgating_state(void *handle,
> >                 enum amd_clockgating_state state)
> > @@ -2454,8 +2403,36 @@ static int dcn10_register_irq_handlers(struct
> amdgpu_device *adev)
> >               c_irq_params->adev = adev;
> >               c_irq_params->irq_src = int_params.irq_source;
> >
> > +             amdgpu_dm_irq_register_interrupt(
> > +                     adev, &int_params, dm_crtc_high_irq, c_irq_params);
> > +     }
> > +
> > +     /* Use VUPDATE_NO_LOCK interrupt on DCN, which seems to correspond
> to
> > +      * the regular VUPDATE interrupt on DCE. We want
> DC_IRQ_SOURCE_VUPDATEx
> > +      * to trigger at end of each vblank, regardless of state of the
> lock,
> > +      * matching DCE behaviour.
> > +      */
> > +     for (i = DCN_1_0__SRCID__OTG0_IHC_V_UPDATE_NO_LOCK_INTERRUPT;
> > +          i <= DCN_1_0__SRCID__OTG0_IHC_V_UPDATE_NO_LOCK_INTERRUPT +
> adev->mode_info.num_crtc - 1;
> > +          i++) {
> > +             r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, i,
> &adev->vupdate_irq);
> > +
> > +             if (r) {
> > +                     DRM_ERROR("Failed to add vupdate irq id!\n");
> > +                     return r;
> > +             }
> > +
> > +             int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
> > +             int_params.irq_source =
> > +                     dc_interrupt_to_irq_source(dc, i, 0);
> > +
> > +             c_irq_params =
> &adev->dm.vupdate_params[int_params.irq_source - DC_IRQ_SOURCE_VUPDATE1];
> > +
> > +             c_irq_params->adev = adev;
> > +             c_irq_params->irq_src = int_params.irq_source;
> > +
> >               amdgpu_dm_irq_register_interrupt(adev, &int_params,
> > -                             dm_dcn_crtc_high_irq, c_irq_params);
> > +                             dm_vupdate_high_irq, c_irq_params);
> >       }
> >
> >       /* Use GRPH_PFLIP interrupt */
> > @@ -4544,10 +4521,6 @@ static inline int dm_set_vupdate_irq(struct
> drm_crtc *crtc, bool enable)
> >       struct amdgpu_device *adev = crtc->dev->dev_private;
> >       int rc;
> >
> > -     /* Do not set vupdate for DCN hardware */
> > -     if (adev->family > AMDGPU_FAMILY_AI)
> > -             return 0;
> > -
> >       irq_source = IRQ_TYPE_VUPDATE + acrtc->otg_inst;
> >
> >       rc = dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 :
> -EBUSY;
> >
>

--000000000000d1231005a511cbbd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Looking over it now, will do some testing. Alex amdgp=
u-drm-next branch would be the best to test this?</div><div><br></div><div>=
It looks like a revert of the whole vstartup series, except for that one=C2=
=A0=20
if(acrtc_state-&gt;active_planes =3D=3D 0)=C2=A0 special case, so i expect =
it should be fine?</div><div><br></div><div>thanks,<br></div><div>-mario</d=
iv><div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Thu, May 7, 2020 at 5:56 PM Leo Li &lt;<a href=3D"mail=
to:sunpeng.li@amd.com">sunpeng.li@amd.com</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On 2020-05-06 3:47 p.m., Nicholas Kazlauskas wrote:<br>
&gt; [Why]<br>
&gt; We&#39;re the drm vblank event a frame too early in the case where the=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ^sending<br>
<br>
Thanks for catching this!<br>
<br>
Reviewed-by: Leo Li &lt;<a href=3D"mailto:sunpeng.li@amd.com" target=3D"_bl=
ank">sunpeng.li@amd.com</a>&gt;<br>
<br>
&gt; pageflip happens close to VUPDATE and ends up blocking the signal.<br>
&gt; <br>
&gt; The implementation in DM was previously correct *before* we started<br=
>
&gt; sending vblank events from VSTARTUP unconditionally to handle cases<br=
>
&gt; where HUBP was off, OTG was ON and userspace was still requesting some=
<br>
&gt; DRM planes enabled. As part of that patch series we dropped VUPDATE<br=
>
&gt; since it was deemed close enough to VSTARTUP, but there&#39;s a key<br=
>
&gt; difference betweeen VSTARTUP and VUPDATE - the VUPDATE signal can be<b=
r>
&gt; blocked if we&#39;re holding the pipe lock &gt;<br>
&gt; There was a fix recently to revert the unconditional behavior for the<=
br>
&gt; DCN VSTARTUP vblank event since it was sending the pageflip event on<b=
r>
&gt; the wrong frame - once again, due to blocking VUPDATE and having the<b=
r>
&gt; address start scanning out two frames later.<br>
&gt; <br>
&gt; The problem with this fix is it didn&#39;t update the logic that calls=
<br>
&gt; drm_crtc_handle_vblank(), so the timestamps are totally bogus now.<br>
&gt; <br>
&gt; [How]<br>
&gt; Essentially reverts most of the original VSTARTUP series but retains<b=
r>
&gt; the behavior to send back events when active planes =3D=3D 0.<br>
&gt; <br>
&gt; Some refactoring/cleanup was done to not have duplicated code in both<=
br>
&gt; the handlers.<br>
&gt; <br>
&gt; Fixes: 16f17eda8bad (&quot;drm/amd/display: Send vblank and user event=
s at vsartup for DCN&quot;)<br>
&gt; Fixes: 3a2ce8d66a4b (&quot;drm/amd/display: Disable VUpdate interrupt =
for DCN hardware&quot;)<br>
&gt; Fixes: 2b5aed9ac3f7 (&quot;drm/amd/display: Fix pageflip event race co=
ndition for DCN.&quot;)<br>
&gt; <br>
&gt; Cc: Leo Li &lt;<a href=3D"mailto:sunpeng.li@amd.com" target=3D"_blank"=
>sunpeng.li@amd.com</a>&gt;<br>
&gt; Cc: Mario Kleiner &lt;<a href=3D"mailto:mario.kleiner.de@gmail.com" ta=
rget=3D"_blank">mario.kleiner.de@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Nicholas Kazlauskas &lt;<a href=3D"mailto:nicholas.kazl=
auskas@amd.com" target=3D"_blank">nicholas.kazlauskas@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 137 ++++++=
+-----------<br>
&gt;=C2=A0 =C2=A01 file changed, 55 insertions(+), 82 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; index 59f1d4a94f12..30ce28f7c444 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; @@ -441,7 +441,7 @@ static void dm_vupdate_high_irq(void *interrupt_pa=
rams)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0/**<br>
&gt;=C2=A0 =C2=A0 * dm_crtc_high_irq() - Handles CRTC interrupt<br>
&gt; - * @interrupt_params: ignored<br>
&gt; + * @interrupt_params: used for determining the CRTC instance<br>
&gt;=C2=A0 =C2=A0 *<br>
&gt;=C2=A0 =C2=A0 * Handles the CRTC/VSYNC interrupt by notfying DRM&#39;s =
VBLANK<br>
&gt;=C2=A0 =C2=A0 * event handler.<br>
&gt; @@ -455,70 +455,6 @@ static void dm_crtc_high_irq(void *interrupt_para=
ms)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0acrtc =3D get_crtc_by_otg_inst(adev, irq_par=
ams-&gt;irq_src - IRQ_TYPE_VBLANK);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (acrtc) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acrtc_state =3D to_dm=
_crtc_state(acrtc-&gt;base.state);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DRM_DEBUG_VBL(&quot;c=
rtc:%d, vupdate-vrr:%d\n&quot;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0acrtc-&gt;crtc_id,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_dm_vrr_active(acrtc_state));<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Core vblank handli=
ng at start of front-porch is only possible<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * in non-vrr mode, a=
s only there vblank timestamping will give<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * valid results whil=
e done in front-porch. Otherwise defer it<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * to dm_vupdate_high=
_irq after end of front-porch.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!amdgpu_dm_vrr_ac=
tive(acrtc_state))<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0drm_crtc_handle_vblank(&amp;acrtc-&gt;base);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Following stuff mu=
st happen at start of vblank, for crc<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * computation and be=
low-the-range btr support in vrr mode.<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_dm_crtc_handle=
_crc_irq(&amp;acrtc-&gt;base);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (acrtc_state-&gt;s=
tream &amp;&amp; adev-&gt;family &gt;=3D AMDGPU_FAMILY_AI &amp;&amp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acrtc_s=
tate-&gt;vrr_params.supported &amp;&amp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acrtc_s=
tate-&gt;freesync_config.state =3D=3D VRR_STATE_ACTIVE_VARIABLE) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0spin_lock_irqsave(&amp;adev-&gt;ddev-&gt;event_lock, flags);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0mod_freesync_handle_v_update(<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;dm.freesync_module,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acrtc_state-&gt;stream,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;acrtc_state-&gt;vrr_params);<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0dc_stream_adjust_vmin_vmax(<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;dm.dc,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acrtc_state-&gt;stream,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;acrtc_state-&gt;vrr_params.adjust);=
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0spin_unlock_irqrestore(&amp;adev-&gt;ddev-&gt;event_lock, flags);<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; -=C2=A0 =C2=A0 =C2=A0}<br>
&gt; -}<br>
&gt; -<br>
&gt; -#if defined(CONFIG_DRM_AMD_DC_DCN)<br>
&gt; -/**<br>
&gt; - * dm_dcn_crtc_high_irq() - Handles VStartup interrupt for DCN genera=
tion ASICs<br>
&gt; - * @interrupt params - interrupt parameters<br>
&gt; - *<br>
&gt; - * Notify DRM&#39;s vblank event handler at VSTARTUP<br>
&gt; - *<br>
&gt; - * Unlike DCE hardware, we trigger the handler at VSTARTUP. at which:=
<br>
&gt; - * * We are close enough to VUPDATE - the point of no return for hw<b=
r>
&gt; - * * We are in the fixed portion of variable front porch when vrr is =
enabled<br>
&gt; - * * We are before VUPDATE, where double-buffered vrr registers are s=
wapped<br>
&gt; - *<br>
&gt; - * It is therefore the correct place to signal vblank, send user flip=
 events,<br>
&gt; - * and update VRR.<br>
&gt; - */<br>
&gt; -static void dm_dcn_crtc_high_irq(void *interrupt_params)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct common_irq_params *irq_params =3D interrup=
t_params;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct amdgpu_device *adev =3D irq_params-&gt;ade=
v;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct amdgpu_crtc *acrtc;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0struct dm_crtc_state *acrtc_state;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0unsigned long flags;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 =C2=A0acrtc =3D get_crtc_by_otg_inst(adev, irq_params-&=
gt;irq_src - IRQ_TYPE_VBLANK);<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!acrtc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -528,22 +464,35 @@ static void dm_dcn_crtc_high_irq(void *interrupt=
_params)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 amdgpu_dm_vrr_active(acrtc_state),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 acrtc_state-&gt;active_planes);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/**<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * Core vblank handling at start of front-porch i=
s only possible<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * in non-vrr mode, as only there vblank timestam=
ping will give<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * valid results while done in front-porch. Other=
wise defer it<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * to dm_vupdate_high_irq after end of front-porc=
h.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!amdgpu_dm_vrr_active(acrtc_state))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drm_crtc_handle_vblan=
k(&amp;acrtc-&gt;base);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/**<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * Following stuff must happen at start of vblank=
, for crc<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * computation and below-the-range btr support in=
 vrr mode.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_dm_crtc_handle_crc_irq(&amp;acrtc-&gt=
;base);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0drm_crtc_handle_vblank(&amp;acrtc-&gt;base);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* BTR updates need to happen before VUPDATE on V=
ega and above. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (adev-&gt;family &lt; AMDGPU_FAMILY_AI)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_lock_irqsave(&amp;adev-&gt;ddev-&gt;eve=
nt_lock, flags);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (acrtc_state-&gt;vrr_params.supported &amp;&am=
p;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (acrtc_state-&gt;stream &amp;&amp; acrtc_state=
-&gt;vrr_params.supported &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acrtc_state-&gt;freesync_confi=
g.state =3D=3D VRR_STATE_ACTIVE_VARIABLE) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mod_freesync_handle_v=
_update(<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;dm.freesync_=
module,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acrtc_state-&gt;strea=
m,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;acrtc_state-&gt;=
vrr_params);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mod_freesync_handle_v=
_update(adev-&gt;dm.freesync_module,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 acrtc_state-&gt;stream,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &amp;acrtc_state-&gt;vrr_params);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dc_stream_adjust_vmin=
_vmax(<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0adev-&gt;dm.dc,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0acrtc_state-&gt;stream,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0&amp;acrtc_state-&gt;vrr_params.adjust);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dc_stream_adjust_vmin=
_vmax(adev-&gt;dm.dc, acrtc_state-&gt;stream,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp=
;acrtc_state-&gt;vrr_params.adjust);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt; @@ -556,7 +505,8 @@ static void dm_dcn_crtc_high_irq(void *interrupt_p=
arams)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * avoid race conditions between flip progra=
mming and completion,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * which could cause too early flip completi=
on events.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (acrtc-&gt;pflip_status =3D=3D AMDGPU_FLIP_SUB=
MITTED &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (adev-&gt;family &gt;=3D AMDGPU_FAMILY_RV &amp=
;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acrtc-&gt;pflip_status =3D=3D AMDGP=
U_FLIP_SUBMITTED &amp;&amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0acrtc_state-&gt;active_planes =
=3D=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (acrtc-&gt;ev=
ent) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0drm_crtc_send_vblank_event(&amp;acrtc-&gt;base, acrtc-&gt;even=
t);<br>
&gt; @@ -568,7 +518,6 @@ static void dm_dcn_crtc_high_irq(void *interrupt_p=
arams)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0spin_unlock_irqrestore(&amp;adev-&gt;ddev-&g=
t;event_lock, flags);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; -#endif<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static int dm_set_clockgating_state(void *handle,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0enum amd_=
clockgating_state state)<br>
&gt; @@ -2454,8 +2403,36 @@ static int dcn10_register_irq_handlers(struct a=
mdgpu_device *adev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c_irq_params-&gt=
;adev =3D adev;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c_irq_params-&gt=
;irq_src =3D int_params.irq_source;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_dm_irq_registe=
r_interrupt(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0adev, &amp;int_params, dm_crtc_high_irq, c_irq_params);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Use VUPDATE_NO_LOCK interrupt on DCN, which se=
ems to correspond to<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * the regular VUPDATE interrupt on DCE. We want =
DC_IRQ_SOURCE_VUPDATEx<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * to trigger at end of each vblank, regardless o=
f state of the lock,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 * matching DCE behaviour.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (i =3D DCN_1_0__SRCID__OTG0_IHC_V_UPDATE_NO_L=
OCK_INTERRUPT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i &lt;=3D DCN_1_0__SRCID__OTG0_IHC=
_V_UPDATE_NO_LOCK_INTERRUPT + adev-&gt;mode_info.num_crtc - 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_irq_add_=
id(adev, SOC15_IH_CLIENTID_DCE, i, &amp;adev-&gt;vupdate_irq);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0DRM_ERROR(&quot;Failed to add vupdate irq id!\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return r;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int_params.int_contex=
t =3D INTERRUPT_HIGH_IRQ_CONTEXT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int_params.irq_source=
 =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0dc_interrupt_to_irq_source(dc, i, 0);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c_irq_params =3D &amp=
;adev-&gt;dm.vupdate_params[int_params.irq_source - DC_IRQ_SOURCE_VUPDATE1]=
;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c_irq_params-&gt;adev=
 =3D adev;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c_irq_params-&gt;irq_=
src =3D int_params.irq_source;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_dm_irq_re=
gister_interrupt(adev, &amp;int_params,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dm_dcn_crtc_high_irq, c_irq_params);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dm_vupdate_high_irq, c_irq_params);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Use GRPH_PFLIP interrupt */<br>
&gt; @@ -4544,10 +4521,6 @@ static inline int dm_set_vupdate_irq(struct drm=
_crtc *crtc, bool enable)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_device *adev =3D crtc-&gt;dev-=
&gt;dev_private;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int rc;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0/* Do not set vupdate for DCN hardware */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (adev-&gt;family &gt; AMDGPU_FAMILY_AI)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0irq_source =3D IRQ_TYPE_VUPDATE + acrtc-&gt;=
otg_inst;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D dc_interrupt_set(adev-&gt;dm.dc, irq_=
source, enable) ? 0 : -EBUSY;<br>
&gt; <br>
</blockquote></div>

--000000000000d1231005a511cbbd--

--===============0423196247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0423196247==--
