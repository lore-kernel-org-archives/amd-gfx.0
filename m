Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24497C6FA82
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Sep 2022 20:32:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E0DB10E881;
	Wed, 21 Sep 2022 20:32:13 +0000 (UTC)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC10310E881
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 20:32:08 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1279948d93dso10819135fac.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Sep 2022 13:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date;
 bh=2FL6VzkB+I96Oy0vtW3ZaAPQUuSw2I+oB80HKKSB0P0=;
 b=qxZjmQteujb5gMUFujWzkbTxc1OxRVK8DEwCvSRgRw95+tgEAv/1jwRFDrnIDtAgvn
 gQiAX4xlnl85arGwkdzo4QzytF8YKx2rkqJLTnBYyiwIlI7T6q88Ut/fhs0ENiGTWvYP
 Y4AFbutP2p/KrgQtsqJfy0SWSqrtcMp9SQ4+mpuiqi/D+wjOP6shXqm/KvmSpbwj/dcA
 4HC4Cc+kwfNyyuSdSRhXujhbkyDRqqvwFxhiQepXp6dc9yE1Bc/d+6WepbWoL3M9axNV
 oPPr1pZtaNRSfd+2WMeJGWO+4kPM/heXhE1C0bpiNZitFUwI9C8m3QTDL7a3BE3KEBaz
 jE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=2FL6VzkB+I96Oy0vtW3ZaAPQUuSw2I+oB80HKKSB0P0=;
 b=YkNaLmtU+aBlJk5Q3ehEiLffIlhXfQv15xQS08YZm9tYA4eASrvGHKLAFHsiTCrtUs
 +NQX8Tvb7CxJYUyzre9dBbyTkxwvJsLXVpwVJ16olaO4cxib7fbF0+brb/ty8bJg1eL0
 MAqvLjr6mOWwa7swIDPl1QQqki2CQBPBArLR8+sXgsktbDnfKL9CKO/4QCmxGT69a5wO
 l4sOEZVs8zQ3UEAkjUaUuspiMQLrxyirb3kUm8sk9urBYPFrSJSSzImd6abN+dUdWYzn
 g3WhHOCp4gAgQ8jwUadMrP5QD/Y84yk6ZMftlZ0KNiDLWutDqw+BmT4mH0jxxLBPmacu
 Axmg==
X-Gm-Message-State: ACrzQf0tmsCsXfhlsN1ZUSFcHpus2cUp3nmKjZurQ6u0OL9/Sbha9cHm
 j8WWQEQUPRZ8qtdLJc6kmsKPYy1bqPGf+gksz3a7VpIIvS8=
X-Google-Smtp-Source: AMsMyM463366XGN5g3I1meTPzSdwkJF/1hB5uVmyo1F7japJs6CwnB0Flvfjnog3wKYOKTpukMrcE0FcWr5aPqgDqOo=
X-Received: by 2002:a05:6870:1783:b0:12a:f442:504d with SMTP id
 r3-20020a056870178300b0012af442504dmr6353884oae.46.1663792328210; Wed, 21 Sep
 2022 13:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220824002514.4060-1-Yunxiang.Li@amd.com>
In-Reply-To: <20220824002514.4060-1-Yunxiang.Li@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 21 Sep 2022 16:31:56 -0400
Message-ID: <CADnq5_NruU3GWb0MtOkBNZubSaa7AqmGThk7zKjej4kfPZotQg@mail.gmail.com>
Subject: Re: [PATCH v4] drm/amd/display: Fix vblank refcount in vrr transition
To: Yunxiang Li <Yunxiang.Li@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: mario.kleiner.de@gmail.com, Harry.Wentland@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Aug 23, 2022 at 8:25 PM Yunxiang Li <Yunxiang.Li@amd.com> wrote:
>
> manage_dm_interrupts disable/enable vblank using drm_crtc_vblank_off/on
> which causes drm_crtc_vblank_get in vrr_transition to fail, and later
> when drm_crtc_vblank_put is called the refcount on vblank will be messed
> up. Therefore move the call to after manage_dm_interrupts.
>

+ Rodrigo

You might want to add:
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1380

This looks logical to me, but someone from the display team should take a look.

Alex


> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
> ---
> v2: check the return code for calls that might fail and warn on them
> v3/v4: make the sequence closer to the original and remove redundant local variables
>
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 55 +++++++++----------
>  1 file changed, 26 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index bc2493a2a90e..de80b61b8d8e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7488,15 +7488,15 @@ static void amdgpu_dm_handle_vrr_transition(struct dm_crtc_state *old_state,
>                  * We also need vupdate irq for the actual core vblank handling
>                  * at end of vblank.
>                  */
> -               dm_set_vupdate_irq(new_state->base.crtc, true);
> -               drm_crtc_vblank_get(new_state->base.crtc);
> +               WARN_ON(dm_set_vupdate_irq(new_state->base.crtc, true) != 0);
> +               WARN_ON(drm_crtc_vblank_get(new_state->base.crtc) != 0);
>                 DRM_DEBUG_DRIVER("%s: crtc=%u VRR off->on: Get vblank ref\n",
>                                  __func__, new_state->base.crtc->base.id);
>         } else if (old_vrr_active && !new_vrr_active) {
>                 /* Transition VRR active -> inactive:
>                  * Allow vblank irq disable again for fixed refresh rate.
>                  */
> -               dm_set_vupdate_irq(new_state->base.crtc, false);
> +               WARN_ON(dm_set_vupdate_irq(new_state->base.crtc, false) != 0);
>                 drm_crtc_vblank_put(new_state->base.crtc);
>                 DRM_DEBUG_DRIVER("%s: crtc=%u VRR on->off: Drop vblank ref\n",
>                                  __func__, new_state->base.crtc->base.id);
> @@ -8261,23 +8261,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>                 mutex_unlock(&dm->dc_lock);
>         }
>
> -       /* Count number of newly disabled CRTCs for dropping PM refs later. */
> -       for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state,
> -                                     new_crtc_state, i) {
> -               if (old_crtc_state->active && !new_crtc_state->active)
> -                       crtc_disable_count++;
> -
> -               dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
> -               dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
> -
> -               /* For freesync config update on crtc state and params for irq */
> -               update_stream_irq_parameters(dm, dm_new_crtc_state);
> -
> -               /* Handle vrr on->off / off->on transitions */
> -               amdgpu_dm_handle_vrr_transition(dm_old_crtc_state,
> -                                               dm_new_crtc_state);
> -       }
> -
>         /**
>          * Enable interrupts for CRTCs that are newly enabled or went through
>          * a modeset. It was intentionally deferred until after the front end
> @@ -8287,16 +8270,29 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>         for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
>                 struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
>  #ifdef CONFIG_DEBUG_FS
> -               bool configure_crc = false;
>                 enum amdgpu_dm_pipe_crc_source cur_crc_src;
>  #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
> -               struct crc_rd_work *crc_rd_wrk = dm->crc_rd_wrk;
> +               struct crc_rd_work *crc_rd_wrk;
> +#endif
> +#endif
> +               /* Count number of newly disabled CRTCs for dropping PM refs later. */
> +               if (old_crtc_state->active && !new_crtc_state->active)
> +                       crtc_disable_count++;
> +
> +               dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
> +               dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
> +
> +               /* For freesync config update on crtc state and params for irq */
> +               update_stream_irq_parameters(dm, dm_new_crtc_state);
> +
> +#ifdef CONFIG_DEBUG_FS
> +#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
> +               crc_rd_wrk = dm->crc_rd_wrk;
>  #endif
>                 spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
>                 cur_crc_src = acrtc->dm_irq_params.crc_src;
>                 spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
>  #endif
> -               dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
>
>                 if (new_crtc_state->active &&
>                     (!old_crtc_state->active ||
> @@ -8304,16 +8300,19 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>                         dc_stream_retain(dm_new_crtc_state->stream);
>                         acrtc->dm_irq_params.stream = dm_new_crtc_state->stream;
>                         manage_dm_interrupts(adev, acrtc, true);
> +               }
> +               /* Handle vrr on->off / off->on transitions */
> +               amdgpu_dm_handle_vrr_transition(dm_old_crtc_state, dm_new_crtc_state);
>
>  #ifdef CONFIG_DEBUG_FS
> +               if (new_crtc_state->active &&
> +                   (!old_crtc_state->active ||
> +                    drm_atomic_crtc_needs_modeset(new_crtc_state))) {
>                         /**
>                          * Frontend may have changed so reapply the CRC capture
>                          * settings for the stream.
>                          */
> -                       dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
> -
>                         if (amdgpu_dm_is_valid_crc_source(cur_crc_src)) {
> -                               configure_crc = true;
>  #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
>                                 if (amdgpu_dm_crc_window_is_activated(crtc)) {
>                                         spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
> @@ -8325,12 +8324,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>                                         spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
>                                 }
>  #endif
> -                       }
> -
> -                       if (configure_crc)
>                                 if (amdgpu_dm_crtc_configure_crc_source(
>                                         crtc, dm_new_crtc_state, cur_crc_src))
>                                         DRM_DEBUG_DRIVER("Failed to configure crc source");
> +                       }
>  #endif
>                 }
>         }
> --
> 2.37.2
>
