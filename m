Return-Path: <SRS0=J69/=N2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3165C433EF
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Sep 2021 14:36:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4A1160F42
	for <amd-gfx@archiver.kernel.org>; Sat,  4 Sep 2021 14:36:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D4A1160F42
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AE7D88130;
	Sat,  4 Sep 2021 14:36:25 +0000 (UTC)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3406C6E528
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Sep 2021 14:36:24 +0000 (UTC)
Received: by mail-qk1-x730.google.com with SMTP id t4so2114823qkb.9
 for <amd-gfx@lists.freedesktop.org>; Sat, 04 Sep 2021 07:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8BNGZbPw6Eow0Wr1m7Fq0CjI68AECtOaluScpJY3Zqg=;
 b=Awkd/5EnZ5WTf+HXhoXaMbVCleom/zuWq25CtFBSictVLymO3ZMgAPgKE5oAT1Usca
 VUwGr4UqQAJzmra5QWnKCBjErwzlfmVTdguU8VtDJ29+9uqQmmtSGT559WlGW3ljlrnj
 CipcSO8nXAiUpScuEPMqtiO3u2WOgEvwjV5vOIDctt4sXrAciocDNX+rQZHefHk+Mfod
 oAYZe7LBtz7nITP/0cmUd8R5ftWn9QYrh9lp8PVgwlKFNhoTMwAOT9anV2BAgqcfgv/Y
 sYyQ/q93WT5u5AKAIejtlBG2Psz15LZk7QLYskQHxyYavtowjZJhR9nzmzJFQgF3dN/N
 7gRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8BNGZbPw6Eow0Wr1m7Fq0CjI68AECtOaluScpJY3Zqg=;
 b=nBu5po62cWwMqY5Xs1tfIROroKgprUB9nqUxlWCOiuobdQc/cH/sbR5HNst2x1mdft
 HvyRP54WySqL0Ah4NJPZtn/U+TJ+iBsaJg4quzZ0tcpKBUWYwjrlKe6F1pFJ1uEo6+1b
 KhU2qQkhCkbn/WXSLzscL3oHw9H5HDMUNTzCdQ/e6eHyLoILooIBw61xJq69KaWnZNW2
 2PVwdOuPY01FceaXYkl8IrnsDsACeejDyVMaBWvyqjCmmphT5J2ZddpkKBR46/hSkXpm
 7TJ4P0+dKLkDOzoG7qYfkvqGZpqWXpgijaXjn8RtYbaOujAfJ9JvpyfHaGSi49WDBLP8
 u2mg==
X-Gm-Message-State: AOAM532c+4qcMHI6/vuumuZkyufafAzz203vKFsrwTQDitGLvRcOtBEm
 vP7EKYUnINP7R9Xs/8+mpZFlBu8uFgVvUYRPtvYrbQ==
X-Google-Smtp-Source: ABdhPJz9tW9zJgpiKT9MhTSHMtyAnH0+Jfv0tKqysa/sElt4EpFvNDlWROTjO1toyp48ffFyMYS0Q5tbxg+SIfwgiTM=
X-Received: by 2002:a37:c09:: with SMTP id 9mr3543056qkm.73.1630766182799;
 Sat, 04 Sep 2021 07:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210813063502.3106309-1-Wayne.Lin@amd.com>
 <20210813063502.3106309-4-Wayne.Lin@amd.com>
In-Reply-To: <20210813063502.3106309-4-Wayne.Lin@amd.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Sat, 4 Sep 2021 15:36:11 +0100
Message-ID: <CAHbf0-GfTL7k64io_2ORFYfT717MX2WJqs7DHY7ODwWDcx-6LA@mail.gmail.com>
Subject: Re: [PATCH 3/7] drm/amd/display: Use vblank control events for PSR
 enable/disable
To: Wayne Lin <Wayne.Lin@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Harry Wentland <Harry.Wentland@amd.com>, 
 Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Rodrigo.Siqueira@amd.com, 
 Aurabindo.Pillai@amd.com, Qingqing.Zhuo@amd.com, bindu.r@amd.com, 
 Anson.Jacob@amd.com, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, 
 Roman Li <Roman.Li@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi

This patch is causing issues on my PRIME system

I've opened https://gitlab.freedesktop.org/drm/amd/-/issues/1700 to track

Cheers

Mike


On Fri, 13 Aug 2021 at 07:35, Wayne Lin <Wayne.Lin@amd.com> wrote:
>
> From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
>
> [Why]
> PSR can disable the HUBP along with the OTG when PSR is active.
>
> We'll hit a pageflip timeout when the OTG is disable because we're no
> longer updating the CRTC vblank counter and the pflip high IRQ will
> not fire on the flip.
>
> In order to flip the page flip timeout occur we should modify the
> enter/exit conditions to match DRM requirements.
>
> [How]
> Use our deferred handlers for DRM vblank control to notify DMCU(B)
> when it can enable or disable PSR based on whether vblank is disabled or
> enabled respectively.
>
> We'll need to pass along the stream with the notification now because
> we want to access the CRTC state while the CRTC is locked to get the
> stream state prior to the commit.
>
> Retain a reference to the stream so it remains safe to continue to
> access and release that reference once we're done with it.
>
> Enable/disable logic follows what we were previously doing in
> update_planes.
>
> The workqueue has to be flushed before programming streams or planes
> to ensure that we exit out of idle optimizations and PSR before
> these events occur if necessary.
>
> To keep the skip count logic the same to avoid FBCON PSR enablement
> requires copying the allow condition onto the DM IRQ parameters - a
> field that we can actually access from the worker.
>
> Reviewed-by: Roman Li <Roman.Li@amd.com>
> Acked-by: Wayne Lin <wayne.lin@amd.com>
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 48 +++++++++++++++----
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +
>  .../display/amdgpu_dm/amdgpu_dm_irq_params.h  |  1 +
>  3 files changed, 43 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index f88b6c5b83cd..cebd663b6708 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1061,7 +1061,22 @@ static void vblank_control_worker(struct work_struct *work)
>
>         DRM_DEBUG_KMS("Allow idle optimizations (MALL): %d\n", dm->active_vblank_irq_count == 0);
>
> +       /* Control PSR based on vblank requirements from OS */
> +       if (vblank_work->stream && vblank_work->stream->link) {
> +               if (vblank_work->enable) {
> +                       if (vblank_work->stream->link->psr_settings.psr_allow_active)
> +                               amdgpu_dm_psr_disable(vblank_work->stream);
> +               } else if (vblank_work->stream->link->psr_settings.psr_feature_enabled &&
> +                          !vblank_work->stream->link->psr_settings.psr_allow_active &&
> +                          vblank_work->acrtc->dm_irq_params.allow_psr_entry) {
> +                       amdgpu_dm_psr_enable(vblank_work->stream);
> +               }
> +       }
> +
>         mutex_unlock(&dm->dc_lock);
> +
> +       dc_stream_release(vblank_work->stream);
> +
>         kfree(vblank_work);
>  }
>
> @@ -6018,6 +6033,11 @@ static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)
>         work->acrtc = acrtc;
>         work->enable = enable;
>
> +       if (acrtc_state->stream) {
> +               dc_stream_retain(acrtc_state->stream);
> +               work->stream = acrtc_state->stream;
> +       }
> +
>         queue_work(dm->vblank_control_workqueue, &work->work);
>  #endif
>
> @@ -8623,6 +8643,12 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>         /* Update the planes if changed or disable if we don't have any. */
>         if ((planes_count || acrtc_state->active_planes == 0) &&
>                 acrtc_state->stream) {
> +               /*
> +                * If PSR or idle optimizations are enabled then flush out
> +                * any pending work before hardware programming.
> +                */
> +               flush_workqueue(dm->vblank_control_workqueue);
> +
>                 bundle->stream_update.stream = acrtc_state->stream;
>                 if (new_pcrtc_state->mode_changed) {
>                         bundle->stream_update.src = acrtc_state->stream->src;
> @@ -8691,16 +8717,20 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
>                                 acrtc_state->stream->link->psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED &&
>                                 !acrtc_state->stream->link->psr_settings.psr_feature_enabled)
>                         amdgpu_dm_link_setup_psr(acrtc_state->stream);
> -               else if ((acrtc_state->update_type == UPDATE_TYPE_FAST) &&
> -                               acrtc_state->stream->link->psr_settings.psr_feature_enabled &&
> -                               !acrtc_state->stream->link->psr_settings.psr_allow_active) {
> -                       struct amdgpu_dm_connector *aconn = (struct amdgpu_dm_connector *)
> -                                       acrtc_state->stream->dm_stream_context;
> +
> +               /* Decrement skip count when PSR is enabled and we're doing fast updates. */
> +               if (acrtc_state->update_type == UPDATE_TYPE_FAST &&
> +                   acrtc_state->stream->link->psr_settings.psr_feature_enabled) {
> +                       struct amdgpu_dm_connector *aconn =
> +                               (struct amdgpu_dm_connector *)acrtc_state->stream->dm_stream_context;
>
>                         if (aconn->psr_skip_count > 0)
>                                 aconn->psr_skip_count--;
> -                       else
> -                               amdgpu_dm_psr_enable(acrtc_state->stream);
> +
> +                       /* Allow PSR when skip count is 0. */
> +                       acrtc_attach->dm_irq_params.allow_psr_entry = !aconn->psr_skip_count;
> +               } else {
> +                       acrtc_attach->dm_irq_params.allow_psr_entry = false;
>                 }
>
>                 mutex_unlock(&dm->dc_lock);
> @@ -8949,8 +8979,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>
>         if (dc_state) {
>                 /* if there mode set or reset, disable eDP PSR */
> -               if (mode_set_reset_required)
> +               if (mode_set_reset_required) {
> +                       flush_workqueue(dm->vblank_control_workqueue);
>                         amdgpu_dm_psr_disable_all(dm);
> +               }
>
>                 dm_enable_per_frame_crtc_master_sync(dc_state);
>                 mutex_lock(&dm->dc_lock);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index c6b8b835b08a..d1d353a7c77d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -91,12 +91,14 @@ struct dm_compressor_info {
>   * @work: Kernel work data for the work event
>   * @dm: amdgpu display manager device
>   * @acrtc: amdgpu CRTC instance for which the event has occurred
> + * @stream: DC stream for which the event has occurred
>   * @enable: true if enabling vblank
>   */
>  struct vblank_control_work {
>         struct work_struct work;
>         struct amdgpu_display_manager *dm;
>         struct amdgpu_crtc *acrtc;
> +       struct dc_stream_state *stream;
>         bool enable;
>  };
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
> index f3b93ba69a27..79b5f9999fec 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
> @@ -33,6 +33,7 @@ struct dm_irq_params {
>         struct mod_vrr_params vrr_params;
>         struct dc_stream_state *stream;
>         int active_planes;
> +       bool allow_psr_entry;
>         struct mod_freesync_config freesync_config;
>
>  #ifdef CONFIG_DEBUG_FS
> --
> 2.25.1
>
