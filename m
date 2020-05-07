Return-Path: <SRS0=+Cdj=6V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F08DC38A24
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 13:50:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F00E2073A
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2020 13:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6hPCypV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F00E2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E695C6E071;
	Thu,  7 May 2020 13:50:47 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF68C6E071
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 May 2020 13:50:46 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id s8so6497576wrt.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 May 2020 06:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RVNaJWoqkg6yH1w5U4ZDmo+smHUKVmU4pCTzrrnlmaM=;
 b=T6hPCypVmRCqCE5UZ1AXQ5Ha6EJub8Sae160of6dS7FE8fuLMsTWzi7IYZwMxY1f11
 ZWihnU2J/NkC9m1P+f8GCa3RVrNXARBOY01Ejl2+2BLSGqcauqxgKDA8tv3oyktFZLRf
 T7G6VxZyKXY9z0aQ1vu5HtblIM8gsttOeJ3JUuY6nnZEL/eoXI58ClD5HCfXl9Y/Nplx
 6O06o2IG3x1E8VSX3wo7IjbsSGLRZLIUssqOjvQCe3W3a8BOwoWlyrl9Z0z57ltJEgO2
 pLRib5JV8eRWS+WOHvs7cIpILEcwaJYz0GD1NVsRGag5reOCfDMUnZxLikUXso8M5UEs
 mLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RVNaJWoqkg6yH1w5U4ZDmo+smHUKVmU4pCTzrrnlmaM=;
 b=Tu5EO5pwdp2auMU+VEWByJDQta/Bj+71bRk1bVwVSPJ9aIZoKq6pOOn1NISoYQQgch
 z0h5gVOrHDM4Hi9SSUP4JkYiar2rAuYi/S+FjZ+Zv1bz5AKU565JKIfc6i8wwDNlkIyV
 4S5CYVRv7o+66J/hQG2ktoYOh+eMDxsp6+/pM53YX8yh25niVEbbCyzIWdifySwBEZZ9
 eJEJaBRU47hiaUT5iHACDYcSdL/xVdbHSHe/70sNzLRC/yjI0/jruQoO+E2LatW3qyXO
 fKFYzTbbeFrlyhC20KC5QXzqRg55iULYUWs8eN/K2oiRYqHb9JEz9ONLKRcOFER6bhHg
 lQ/w==
X-Gm-Message-State: AGi0PuZJi/Bw22dLv+ecKFwg1kWq9j4nyN2rMUGsIGbSJSJeKE/ddARV
 GBQHhDFlJYC6TSQYaHcsf4NjodrfdGSjIcj0OfS7+Q==
X-Google-Smtp-Source: APiQypL6R3Jin85AU4KufeX5eoWXfgl/JyP1IkOlD+DgGcdKR/QzT2nfb9nslU6ZaJUu9ALRUR5p1UImM+6NKsonTGY=
X-Received: by 2002:a5d:4389:: with SMTP id i9mr16440355wrq.374.1588859445316; 
 Thu, 07 May 2020 06:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200506194754.10780-1-nicholas.kazlauskas@amd.com>
In-Reply-To: <20200506194754.10780-1-nicholas.kazlauskas@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 7 May 2020 09:50:34 -0400
Message-ID: <CADnq5_NB7GnrYcehN3dY1L9eM7og3w_jD6DGZsd5E3UXSi3YrQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix vblank and pageflip event handling
 for FreeSync
To: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
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
Cc: Leo Li <sunpeng.li@amd.com>, Mario Kleiner <mario.kleiner.de@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, May 6, 2020 at 3:48 PM Nicholas Kazlauskas
<nicholas.kazlauskas@amd.com> wrote:
>
> [Why]
> We're the drm vblank event a frame too early in the case where the
> pageflip happens close to VUPDATE and ends up blocking the signal.
>
> The implementation in DM was previously correct *before* we started
> sending vblank events from VSTARTUP unconditionally to handle cases
> where HUBP was off, OTG was ON and userspace was still requesting some
> DRM planes enabled. As part of that patch series we dropped VUPDATE
> since it was deemed close enough to VSTARTUP, but there's a key
> difference betweeen VSTARTUP and VUPDATE - the VUPDATE signal can be
> blocked if we're holding the pipe lock.
>
> There was a fix recently to revert the unconditional behavior for the
> DCN VSTARTUP vblank event since it was sending the pageflip event on
> the wrong frame - once again, due to blocking VUPDATE and having the
> address start scanning out two frames later.
>
> The problem with this fix is it didn't update the logic that calls
> drm_crtc_handle_vblank(), so the timestamps are totally bogus now.
>
> [How]
> Essentially reverts most of the original VSTARTUP series but retains
> the behavior to send back events when active planes == 0.
>
> Some refactoring/cleanup was done to not have duplicated code in both
> the handlers.
>
> Fixes: 16f17eda8bad ("drm/amd/display: Send vblank and user events at vsartup for DCN")
> Fixes: 3a2ce8d66a4b ("drm/amd/display: Disable VUpdate interrupt for DCN hardware")
> Fixes: 2b5aed9ac3f7 ("drm/amd/display: Fix pageflip event race condition for DCN.")
>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Mario Kleiner <mario.kleiner.de@gmail.com>
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 137 +++++++-----------
>  1 file changed, 55 insertions(+), 82 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 59f1d4a94f12..30ce28f7c444 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -441,7 +441,7 @@ static void dm_vupdate_high_irq(void *interrupt_params)
>
>  /**
>   * dm_crtc_high_irq() - Handles CRTC interrupt
> - * @interrupt_params: ignored
> + * @interrupt_params: used for determining the CRTC instance
>   *
>   * Handles the CRTC/VSYNC interrupt by notfying DRM's VBLANK
>   * event handler.
> @@ -455,70 +455,6 @@ static void dm_crtc_high_irq(void *interrupt_params)
>         unsigned long flags;
>
>         acrtc = get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_VBLANK);
> -
> -       if (acrtc) {
> -               acrtc_state = to_dm_crtc_state(acrtc->base.state);
> -
> -               DRM_DEBUG_VBL("crtc:%d, vupdate-vrr:%d\n",
> -                             acrtc->crtc_id,
> -                             amdgpu_dm_vrr_active(acrtc_state));
> -
> -               /* Core vblank handling at start of front-porch is only possible
> -                * in non-vrr mode, as only there vblank timestamping will give
> -                * valid results while done in front-porch. Otherwise defer it
> -                * to dm_vupdate_high_irq after end of front-porch.
> -                */
> -               if (!amdgpu_dm_vrr_active(acrtc_state))
> -                       drm_crtc_handle_vblank(&acrtc->base);
> -
> -               /* Following stuff must happen at start of vblank, for crc
> -                * computation and below-the-range btr support in vrr mode.
> -                */
> -               amdgpu_dm_crtc_handle_crc_irq(&acrtc->base);
> -
> -               if (acrtc_state->stream && adev->family >= AMDGPU_FAMILY_AI &&
> -                   acrtc_state->vrr_params.supported &&
> -                   acrtc_state->freesync_config.state == VRR_STATE_ACTIVE_VARIABLE) {
> -                       spin_lock_irqsave(&adev->ddev->event_lock, flags);
> -                       mod_freesync_handle_v_update(
> -                               adev->dm.freesync_module,
> -                               acrtc_state->stream,
> -                               &acrtc_state->vrr_params);
> -
> -                       dc_stream_adjust_vmin_vmax(
> -                               adev->dm.dc,
> -                               acrtc_state->stream,
> -                               &acrtc_state->vrr_params.adjust);
> -                       spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
> -               }
> -       }
> -}
> -
> -#if defined(CONFIG_DRM_AMD_DC_DCN)
> -/**
> - * dm_dcn_crtc_high_irq() - Handles VStartup interrupt for DCN generation ASICs
> - * @interrupt params - interrupt parameters
> - *
> - * Notify DRM's vblank event handler at VSTARTUP
> - *
> - * Unlike DCE hardware, we trigger the handler at VSTARTUP. at which:
> - * * We are close enough to VUPDATE - the point of no return for hw
> - * * We are in the fixed portion of variable front porch when vrr is enabled
> - * * We are before VUPDATE, where double-buffered vrr registers are swapped
> - *
> - * It is therefore the correct place to signal vblank, send user flip events,
> - * and update VRR.
> - */
> -static void dm_dcn_crtc_high_irq(void *interrupt_params)
> -{
> -       struct common_irq_params *irq_params = interrupt_params;
> -       struct amdgpu_device *adev = irq_params->adev;
> -       struct amdgpu_crtc *acrtc;
> -       struct dm_crtc_state *acrtc_state;
> -       unsigned long flags;
> -
> -       acrtc = get_crtc_by_otg_inst(adev, irq_params->irq_src - IRQ_TYPE_VBLANK);
> -
>         if (!acrtc)
>                 return;
>
> @@ -528,22 +464,35 @@ static void dm_dcn_crtc_high_irq(void *interrupt_params)
>                          amdgpu_dm_vrr_active(acrtc_state),
>                          acrtc_state->active_planes);
>
> +       /**
> +        * Core vblank handling at start of front-porch is only possible
> +        * in non-vrr mode, as only there vblank timestamping will give
> +        * valid results while done in front-porch. Otherwise defer it
> +        * to dm_vupdate_high_irq after end of front-porch.
> +        */
> +       if (!amdgpu_dm_vrr_active(acrtc_state))
> +               drm_crtc_handle_vblank(&acrtc->base);
> +
> +       /**
> +        * Following stuff must happen at start of vblank, for crc
> +        * computation and below-the-range btr support in vrr mode.
> +        */
>         amdgpu_dm_crtc_handle_crc_irq(&acrtc->base);
> -       drm_crtc_handle_vblank(&acrtc->base);
> +
> +       /* BTR updates need to happen before VUPDATE on Vega and above. */
> +       if (adev->family < AMDGPU_FAMILY_AI)
> +               return;
>
>         spin_lock_irqsave(&adev->ddev->event_lock, flags);
>
> -       if (acrtc_state->vrr_params.supported &&
> +       if (acrtc_state->stream && acrtc_state->vrr_params.supported &&
>             acrtc_state->freesync_config.state == VRR_STATE_ACTIVE_VARIABLE) {
> -               mod_freesync_handle_v_update(
> -               adev->dm.freesync_module,
> -               acrtc_state->stream,
> -               &acrtc_state->vrr_params);
> +               mod_freesync_handle_v_update(adev->dm.freesync_module,
> +                                            acrtc_state->stream,
> +                                            &acrtc_state->vrr_params);
>
> -               dc_stream_adjust_vmin_vmax(
> -                       adev->dm.dc,
> -                       acrtc_state->stream,
> -                       &acrtc_state->vrr_params.adjust);
> +               dc_stream_adjust_vmin_vmax(adev->dm.dc, acrtc_state->stream,
> +                                          &acrtc_state->vrr_params.adjust);
>         }
>
>         /*
> @@ -556,7 +505,8 @@ static void dm_dcn_crtc_high_irq(void *interrupt_params)
>          * avoid race conditions between flip programming and completion,
>          * which could cause too early flip completion events.
>          */
> -       if (acrtc->pflip_status == AMDGPU_FLIP_SUBMITTED &&
> +       if (adev->family >= AMDGPU_FAMILY_RV &&
> +           acrtc->pflip_status == AMDGPU_FLIP_SUBMITTED &&
>             acrtc_state->active_planes == 0) {
>                 if (acrtc->event) {
>                         drm_crtc_send_vblank_event(&acrtc->base, acrtc->event);
> @@ -568,7 +518,6 @@ static void dm_dcn_crtc_high_irq(void *interrupt_params)
>
>         spin_unlock_irqrestore(&adev->ddev->event_lock, flags);
>  }
> -#endif
>
>  static int dm_set_clockgating_state(void *handle,
>                   enum amd_clockgating_state state)
> @@ -2454,8 +2403,36 @@ static int dcn10_register_irq_handlers(struct amdgpu_device *adev)
>                 c_irq_params->adev = adev;
>                 c_irq_params->irq_src = int_params.irq_source;
>
> +               amdgpu_dm_irq_register_interrupt(
> +                       adev, &int_params, dm_crtc_high_irq, c_irq_params);
> +       }
> +
> +       /* Use VUPDATE_NO_LOCK interrupt on DCN, which seems to correspond to
> +        * the regular VUPDATE interrupt on DCE. We want DC_IRQ_SOURCE_VUPDATEx
> +        * to trigger at end of each vblank, regardless of state of the lock,
> +        * matching DCE behaviour.
> +        */
> +       for (i = DCN_1_0__SRCID__OTG0_IHC_V_UPDATE_NO_LOCK_INTERRUPT;
> +            i <= DCN_1_0__SRCID__OTG0_IHC_V_UPDATE_NO_LOCK_INTERRUPT + adev->mode_info.num_crtc - 1;
> +            i++) {
> +               r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_DCE, i, &adev->vupdate_irq);
> +
> +               if (r) {
> +                       DRM_ERROR("Failed to add vupdate irq id!\n");
> +                       return r;
> +               }
> +
> +               int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
> +               int_params.irq_source =
> +                       dc_interrupt_to_irq_source(dc, i, 0);
> +
> +               c_irq_params = &adev->dm.vupdate_params[int_params.irq_source - DC_IRQ_SOURCE_VUPDATE1];
> +
> +               c_irq_params->adev = adev;
> +               c_irq_params->irq_src = int_params.irq_source;
> +
>                 amdgpu_dm_irq_register_interrupt(adev, &int_params,
> -                               dm_dcn_crtc_high_irq, c_irq_params);
> +                               dm_vupdate_high_irq, c_irq_params);
>         }
>
>         /* Use GRPH_PFLIP interrupt */
> @@ -4544,10 +4521,6 @@ static inline int dm_set_vupdate_irq(struct drm_crtc *crtc, bool enable)
>         struct amdgpu_device *adev = crtc->dev->dev_private;
>         int rc;
>
> -       /* Do not set vupdate for DCN hardware */
> -       if (adev->family > AMDGPU_FAMILY_AI)
> -               return 0;
> -
>         irq_source = IRQ_TYPE_VUPDATE + acrtc->otg_inst;
>
>         rc = dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EBUSY;
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
