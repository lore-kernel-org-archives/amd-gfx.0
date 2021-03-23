Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F64C433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 14:26:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3040F619B1
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 14:26:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3040F619B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B62506E110;
	Tue, 23 Mar 2021 14:26:16 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D09036E110
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 14:26:14 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 l23-20020a05683004b7b02901b529d1a2fdso19601232otd.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 07:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=j/5uLl6PoFLSS6wk4I2AliD71zDQ4LnHkug5NciNRD0=;
 b=jKEx2zoLV4wJEIpML7DqNfXJu3ss5gHpsczdfq9B/qtetlYKt5wsia2HmAKswWoqMX
 0z1VXdG7BMZO49e2cgEl9Ox5sGphQwC5j3yvS1iK1McgSN1/V7B6UMiZzHZwcEROWvvj
 gV1wGQz7pCkwylU8FSTZpGnt1JW/1bquDGa6Vhymd9Xx46pizI4q1Nd2S5t8ogCLS7tN
 e6e4JvFtndq6oFHUYxgLZO7A7Z9/3Pb9jUsilPg/RApFB3dQUNqeuvnvGXRu/vdbTxtM
 /3taFaCrFWI09r9Wje3imqvmZ8CFjK+cDVZtpWhRge78t+jcdB7vSD2FRcBa0/acrYqo
 9wpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j/5uLl6PoFLSS6wk4I2AliD71zDQ4LnHkug5NciNRD0=;
 b=YakgEhkKhEVAJXjVohLvseMH7CHbXPBHm5hrBxm72hqY82HtlmERkipoOiNXZFHyoR
 NF3u6MToQytBOL7aficqU66qTCZtLLM+IR+xTsF6R9JFjhER00fc1pZQEfFNq4vZtuix
 o3CUUZQft+9fR5Pi5P2+8wblWXe4wTq+qXdcpnJdAE1atMmXDyFpNbnAPgDIlNRUGeiF
 0di+Ty1cDgsAMaxRPFyV+KLpaEQ7XNnEH81gj2XmihYOKwK++qCcjVlhNlHU2q5MsVo7
 fxxMiDCzM67bCZXnYC95yBrThQoEpnDpV630r+H9BLdm7er0LEY1W8vwTzAUvEZOAkg/
 BTDQ==
X-Gm-Message-State: AOAM530d3xlIZEZ46S4aStEPRlsGsYqDhR/iizWCVaRlhkSHHbtk9sR2
 RguxuZEHkL5Z92/aEjfZbOv1QD0aKIUOj5hJEgQ=
X-Google-Smtp-Source: ABdhPJwlxVpvheRwgVrzRhsToIk2N3YUSl1vxppDB/lp47ANNIMTOQgM+OfLZsVzRyBioyzvl8CEIxtr0fWvAW8JBgk=
X-Received: by 2002:a9d:750e:: with SMTP id r14mr4691291otk.311.1616509573997; 
 Tue, 23 Mar 2021 07:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210323003121.7897-1-luben.tuikov@amd.com>
In-Reply-To: <20210323003121.7897-1-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 Mar 2021 10:26:03 -0400
Message-ID: <CADnq5_OrcLoBH7d1n1aL9eCQSqaajgYaU5ypXwzgm+-DPaahpw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Use DRM_DEBUG_DP
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <Harry.Wentland@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 22, 2021 at 8:31 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Convert IRQ-based prints from DRM_DEBUG_DRIVER to
> DRM_DEBUG_DP, as the latter is not used in drm/amd
> prior to this patch and since IRQ-based prints
> drown out the rest of the driver's
> DRM_DEBUG_DRIVER messages.
>
> Cc: Harry Wentland <Harry.Wentland@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 67 +++++++++----------
>  1 file changed, 33 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index f455fc3aa561..aabaa652f6dc 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -449,9 +449,9 @@ static void dm_pflip_high_irq(void *interrupt_params)
>         amdgpu_crtc->pflip_status = AMDGPU_FLIP_NONE;
>         spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
>
> -       DRM_DEBUG_DRIVER("crtc:%d[%p], pflip_stat:AMDGPU_FLIP_NONE, vrr[%d]-fp %d\n",
> -                        amdgpu_crtc->crtc_id, amdgpu_crtc,
> -                        vrr_active, (int) !e);
> +       DRM_DEBUG_DP("crtc:%d[%p], pflip_stat:AMDGPU_FLIP_NONE, vrr[%d]-fp %d\n",

Should probably be _KMS or _ATOMIC since this is not displayport specific.

> +                    amdgpu_crtc->crtc_id, amdgpu_crtc,
> +                    vrr_active, (int) !e);
>  }
>
>  static void dm_vupdate_high_irq(void *interrupt_params)
> @@ -993,8 +993,7 @@ static void event_mall_stutter(struct work_struct *work)
>         dc_allow_idle_optimizations(
>                 dm->dc, dm->active_vblank_irq_count == 0);
>
> -       DRM_DEBUG_DRIVER("Allow idle optimizations (MALL): %d\n", dm->active_vblank_irq_count == 0);
> -
> +       DRM_DEBUG_DP("Allow idle optimizations (MALL): %d\n", dm->active_vblank_irq_count == 0);

Maybe _VBL or _KMS or _ATOMIC?

>
>         mutex_unlock(&dm->dc_lock);
>  }
> @@ -1810,8 +1809,8 @@ static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
>                 if (acrtc && state->stream_status[i].plane_count != 0) {
>                         irq_source = IRQ_TYPE_PFLIP + acrtc->otg_inst;
>                         rc = dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EBUSY;
> -                       DRM_DEBUG("crtc %d - vupdate irq %sabling: r=%d\n",
> -                                 acrtc->crtc_id, enable ? "en" : "dis", rc);
> +                       DRM_DEBUG_DP("crtc %d - vupdate irq %sabling: r=%d\n",
> +                                    acrtc->crtc_id, enable ? "en" : "dis", rc);

I think this should be _VBL.

>                         if (rc)
>                                 DRM_WARN("Failed to %s pflip interrupts\n",
>                                          enable ? "enable" : "disable");
> @@ -4966,8 +4965,8 @@ static void update_stream_scaling_settings(const struct drm_display_mode *mode,
>         stream->src = src;
>         stream->dst = dst;
>
> -       DRM_DEBUG_DRIVER("Destination Rectangle x:%d  y:%d  width:%d  height:%d\n",
> -                       dst.x, dst.y, dst.width, dst.height);
> +       DRM_DEBUG_DP("Destination Rectangle x:%d  y:%d  width:%d  height:%d\n",
> +                    dst.x, dst.y, dst.width, dst.height);

Should probably be _KMS or _ATOMIC since this is not displayport specific.

>
>  }
>
> @@ -5710,8 +5709,8 @@ static inline int dm_set_vupdate_irq(struct drm_crtc *crtc, bool enable)
>
>         rc = dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EBUSY;
>
> -       DRM_DEBUG_DRIVER("crtc %d - vupdate irq %sabling: r=%d\n",
> -                        acrtc->crtc_id, enable ? "en" : "dis", rc);
> +       DRM_DEBUG_DP("crtc %d - vupdate irq %sabling: r=%d\n",
> +                    acrtc->crtc_id, enable ? "en" : "dis", rc);

Should probably be _VBL.

>         return rc;
>  }
>
> @@ -6664,7 +6663,7 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
>         int r;
>
>         if (!new_state->fb) {
> -               DRM_DEBUG_DRIVER("No FB bound\n");
> +               DRM_DEBUG_DP("No FB bound\n");

Should probably be _KMS or _ATOMIC since this is not displayport specific.

>                 return 0;
>         }
>
> @@ -7896,11 +7895,11 @@ static void handle_cursor_update(struct drm_plane *plane,
>         if (!plane->state->fb && !old_plane_state->fb)
>                 return;
>
> -       DRM_DEBUG_DRIVER("%s: crtc_id=%d with size %d to %d\n",
> -                        __func__,
> -                        amdgpu_crtc->crtc_id,
> -                        plane->state->crtc_w,
> -                        plane->state->crtc_h);
> +       DRM_DEBUG_DP("%s: crtc_id=%d with size %d to %d\n",
> +                    __func__,
> +                    amdgpu_crtc->crtc_id,
> +                    plane->state->crtc_w,
> +                    plane->state->crtc_h);

Should probably be _KMS or _ATOMIC since this is not displayport specific.

>
>         ret = get_cursor_position(plane, crtc, &position);
>         if (ret)
> @@ -7958,8 +7957,8 @@ static void prepare_flip_isr(struct amdgpu_crtc *acrtc)
>         /* Mark this event as consumed */
>         acrtc->base.state->event = NULL;
>
> -       DRM_DEBUG_DRIVER("crtc:%d, pflip_stat:AMDGPU_FLIP_SUBMITTED\n",
> -                                                acrtc->crtc_id);
> +       DRM_DEBUG_DP("crtc:%d, pflip_stat:AMDGPU_FLIP_SUBMITTED\n",
> +                    acrtc->crtc_id);

Should probably be _KMS or _ATOMIC since this is not displayport specific.

>  }
>
>  static void update_freesync_state_on_stream(
> @@ -8265,9 +8264,9 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>                         &bundle->flip_addrs[planes_count].address,
>                         afb->tmz_surface, false);
>
> -               DRM_DEBUG_DRIVER("plane: id=%d dcc_en=%d\n",
> -                                new_plane_state->plane->index,
> -                                bundle->plane_infos[planes_count].dcc.enable);
> +               DRM_DEBUG_DP("plane: id=%d dcc_en=%d\n",
> +                            new_plane_state->plane->index,
> +                            bundle->plane_infos[planes_count].dcc.enable);

Should probably be _ATOMIC.

>
>                 bundle->surface_updates[planes_count].plane_info =
>                         &bundle->plane_infos[planes_count];
> @@ -8299,10 +8298,10 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>                                 dc_plane,
>                                 bundle->flip_addrs[planes_count].flip_timestamp_in_us);
>
> -               DRM_DEBUG_DRIVER("%s Flipping to hi: 0x%x, low: 0x%x\n",
> -                                __func__,
> -                                bundle->flip_addrs[planes_count].address.grph.addr.high_part,
> -                                bundle->flip_addrs[planes_count].address.grph.addr.low_part);
> +               DRM_DEBUG_DP("%s Flipping to hi: 0x%x, low: 0x%x\n",
> +                            __func__,
> +                            bundle->flip_addrs[planes_count].address.grph.addr.high_part,
> +                            bundle->flip_addrs[planes_count].address.grph.addr.low_part);
>

Same here.

>                 planes_count += 1;
>
> @@ -8621,7 +8620,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>                 dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
>                 dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
>
> -               DRM_DEBUG_DRIVER(
> +               DRM_DEBUG_DP(

And here.

>                         "amdgpu_crtc id:%d crtc_state_flags: enable:%d, active:%d, "
>                         "planes_changed:%d, mode_changed:%d,active_changed:%d,"
>                         "connectors_changed:%d\n",
> @@ -8655,7 +8654,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>
>                 if (modeset_required(new_crtc_state, dm_new_crtc_state->stream, dm_old_crtc_state->stream)) {
>
> -                       DRM_DEBUG_DRIVER("Atomic commit: SET crtc id %d: [%p]\n", acrtc->crtc_id, acrtc);
> +                       DRM_DEBUG_DP("Atomic commit: SET crtc id %d: [%p]\n", acrtc->crtc_id, acrtc);
>

And here.

>                         if (!dm_new_crtc_state->stream) {
>                                 /*
> @@ -8688,7 +8687,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>                         crtc->hwmode = new_crtc_state->mode;
>                         mode_set_reset_required = true;
>                 } else if (modereset_required(new_crtc_state)) {
> -                       DRM_DEBUG_DRIVER("Atomic commit: RESET. crtc id %d:[%p]\n", acrtc->crtc_id, acrtc);
> +                       DRM_DEBUG_DP("Atomic commit: RESET. crtc id %d:[%p]\n", acrtc->crtc_id, acrtc);

And here.

>                         /* i.e. reset mode */
>                         if (dm_old_crtc_state->stream)
>                                 remove_stream(adev, acrtc, dm_old_crtc_state->stream);
> @@ -9298,7 +9297,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>         if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
>                 goto skip_modeset;
>
> -       DRM_DEBUG_DRIVER(
> +       DRM_DEBUG_DP(

Should probably be _KMS or _ATOMIC since this is not displayport specific.

>                 "amdgpu_crtc id:%d crtc_state_flags: enable:%d, active:%d, "
>                 "planes_changed:%d, mode_changed:%d,active_changed:%d,"
>                 "connectors_changed:%d\n",
> @@ -9382,8 +9381,8 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>
>                         dc_stream_retain(new_stream);
>
> -                       DRM_DEBUG_DRIVER("Enabling DRM crtc: %d\n",
> -                                               crtc->base.id);
> +                       DRM_DEBUG_DP("Enabling DRM crtc: %d\n",
> +                                    crtc->base.id);
>

Same here.

>                         if (dc_add_stream_to_ctx(
>                                         dm->dc,
> @@ -9728,8 +9727,8 @@ static int dm_update_plane_state(struct dc *dc,
>                 if (!dc_new_plane_state)
>                         return -ENOMEM;
>
> -               DRM_DEBUG_DRIVER("Enabling DRM plane: %d on DRM crtc %d\n",
> -                               plane->base.id, new_plane_crtc->base.id);
> +               DRM_DEBUG_DP("Enabling DRM plane: %d on DRM crtc %d\n",
> +                            plane->base.id, new_plane_crtc->base.id);
>

And here.

>                 ret = fill_dc_plane_attributes(
>                         drm_to_adev(new_plane_crtc->dev),
> --
> 2.31.0.rc2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
