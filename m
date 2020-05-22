Return-Path: <SRS0=+s4F=7E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1ACC433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 14:45:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AC072054F
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2020 14:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9cy+YSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC072054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB0116E9F9;
	Fri, 22 May 2020 14:45:55 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48D2F6E9F9
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 14:45:55 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id y17so2023117wrn.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2020 07:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8fOD4YsmP+d6q6HmNcCmQPCejW2saeT7AodhwkNxpuQ=;
 b=B9cy+YSHt5j+P9EA1hBuyrVafYAZUJvfpJguLLQZs/3QZ1+V3AbJ4xhBzBNuk6qjqS
 Hpmb+VmbI8CgUOWJNkLFOgkPMxSKq1HRT4Y3THd3MWviOdCXMOJpMyanOzJGiFrGmaUi
 LfNqTXezbJmhnUgMbhe8fQV52+M8zu/OwLBjDIu2Y34Ax3zGUCXFV9ejsc577fr8riEq
 UMnWa8P6cwEkxTaitfuvZ45RkQwuR+3JCUHm8tIZE8qMPyk8NkUMjGnDkiUMJtE6sX8Y
 yDLDqw3yQ7/C75sHXfiuZQMCReIybPPw8dMYmNTURYrys2usL2wPvXXLuZwUbA5VybmO
 NAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8fOD4YsmP+d6q6HmNcCmQPCejW2saeT7AodhwkNxpuQ=;
 b=LayyFutsM7eQW8qDx0MspJQU14x/EU20epaAdmPGe+YdIdz4QqnPrAIHH059esV6cj
 9PMzDS/YXTCXJ5NTaZJpSqPEErOn0uQo4XL6sIOgGdbUT149qyMqlS66jtB9kX4GMt0a
 gwDv+/ULJSsnNPhE7YzxtelmDTTFKpXq0PLuojWr9PHdN6TQLqPSGwaeCWKWRwwMIQvu
 jO4EwcTUVXDG/OVh9zo1qjhceR6QQJIgde/glI41uHmY6I7EN00br9ADjz5aYn0a1pxh
 IeL+e0nvN1e0RVQBPL9PqAFiXwV8UuS1VCc+worFSMnWcENL6th7U+A2kHzc3KRBofPw
 vMFw==
X-Gm-Message-State: AOAM531YpsSIRXzlWL+jF/ATp0U/LUvWLJqJzhYFgueWNlss/+AaI1vt
 RtxqtlAtg7chATy0ro3MmFBRHbtKHzTn1VCrYyY=
X-Google-Smtp-Source: ABdhPJzATrqUJaKTXi/rbzkicFkhz56MxrGFP+RvxnsDxgE8pgAD7bJOOyrxKQLZ20P0bwjTvCnJr49OJmzbnj9gl/I=
X-Received: by 2002:a5d:400f:: with SMTP id n15mr3912202wrp.419.1590158753850; 
 Fri, 22 May 2020 07:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200521213933.5252-1-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20200521213933.5252-1-Bhawanpreet.Lakha@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 May 2020 10:45:42 -0400
Message-ID: <CADnq5_OaLsk6T-+R2n0ozB2c_dGWKukoKL-UYX-N6kr1k4-3SA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Handle GPU reset for DC block
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 21, 2020 at 5:39 PM Bhawanpreet Lakha
<Bhawanpreet.Lakha@amd.com> wrote:
>
> [Why]
> Previously we used the s3 codepath for gpu reset. This can lead to issues in
> certain case where we end of waiting for fences which will never come (because
> parts of the hw are off due to gpu reset) and we end up waiting forever causing
> a deadlock.
>
> [How]
> Handle GPU reset separately from normal s3 case. We essentially need to redo
> everything we do in s3, but avoid any drm calls.
>
> For GPU reset case
>
> suspend:
>         -Acquire DC lock
>         -Cache current dc_state
>         -Commit 0 stream/planes to dc (this puts dc into a state where it can be
>          powered off)
>         -Disable interrupts
> resume
>         -Edit cached state to force full update
>         -Commit cached state from suspend
>         -Build stream and plane updates from the cached state
>         -Commit stream/plane updates
>         -Enable interrupts
>         -Release DC lock
>
> v2:
> -Formatting
> -Release dc_state
>
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 182 +++++++++++++++++-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
>  2 files changed, 182 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 60fe64aef11b..4110ff8580b7 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1521,10 +1521,114 @@ static int dm_hw_fini(void *handle)
>         return 0;
>  }
>
> +
> +static int dm_enable_vblank(struct drm_crtc *crtc);
> +static void dm_disable_vblank(struct drm_crtc *crtc);
> +
> +static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
> +                                struct dc_state *state, bool enable)
> +{
> +       enum dc_irq_source irq_source;
> +       struct amdgpu_crtc *acrtc;
> +       int rc = -EBUSY;
> +       int i = 0;
> +
> +       for (i = 0; i < state->stream_count; i++) {
> +               acrtc = get_crtc_by_otg_inst(
> +                               adev, state->stream_status[i].primary_otg_inst);
> +
> +               if (acrtc && state->stream_status[i].plane_count != 0) {
> +                       irq_source = IRQ_TYPE_PFLIP + acrtc->otg_inst;
> +                       rc = dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EBUSY;
> +                       DRM_DEBUG("crtc %d - vupdate irq %sabling: r=%d\n",
> +                                 acrtc->crtc_id, enable ? "en" : "dis", rc);
> +                       if (rc)
> +                               DRM_WARN("Failed to %s pflip interrupts\n",
> +                                        enable ? "enable" : "disable");
> +
> +                       if (enable) {
> +                               rc = dm_enable_vblank(&acrtc->base);
> +                               if (rc)
> +                                       DRM_WARN("Failed to enable vblank interrupts\n");
> +                       } else {
> +                               dm_disable_vblank(&acrtc->base);
> +                       }
> +
> +               }
> +       }
> +
> +}
> +
> +enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc)
> +{
> +       struct dc_state *context = NULL;
> +       enum dc_status res = DC_ERROR_UNEXPECTED;
> +       int i;
> +       struct dc_stream_state *del_streams[MAX_PIPES];
> +       int del_streams_count = 0;
> +
> +       memset(del_streams, 0, sizeof(del_streams));
> +
> +       context = dc_create_state(dc);
> +       if (context == NULL)
> +               goto context_alloc_fail;
> +
> +       dc_resource_state_copy_construct_current(dc, context);
> +
> +       /* First remove from context all streams */
> +       for (i = 0; i < context->stream_count; i++) {
> +               struct dc_stream_state *stream = context->streams[i];
> +
> +               del_streams[del_streams_count++] = stream;
> +       }
> +
> +       /* Remove all planes for removed streams and then remove the streams */
> +       for (i = 0; i < del_streams_count; i++) {
> +               if (!dc_rem_all_planes_for_stream(dc, del_streams[i], context)) {
> +                       res = DC_FAIL_DETACH_SURFACES;
> +                       goto fail;
> +               }
> +
> +               res = dc_remove_stream_from_ctx(dc, context, del_streams[i]);
> +               if (res != DC_OK)
> +                       goto fail;
> +       }
> +
> +
> +       res = dc_validate_global_state(dc, context, false);
> +
> +       if (res != DC_OK) {
> +               DRM_ERROR("%s:resource validation failed, dc_status:%d\n", __func__, res);
> +               goto fail;
> +       }
> +
> +       res = dc_commit_state(dc, context);
> +
> +fail:
> +       dc_release_state(context);
> +
> +context_alloc_fail:
> +       return res;
> +}
> +
>  static int dm_suspend(void *handle)
>  {
>         struct amdgpu_device *adev = handle;
>         struct amdgpu_display_manager *dm = &adev->dm;
> +       int ret = 0;
> +
> +       if (adev->in_gpu_reset) {
> +               mutex_lock(&dm->dc_lock);
> +               dm->cached_dc_state = dc_copy_state(dm->dc->current_state);
> +
> +               dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, false);
> +
> +               amdgpu_dm_commit_zero_streams(dm->dc);
> +
> +               amdgpu_dm_irq_suspend(adev);
> +
> +               return ret;
> +       }
>
>         WARN_ON(adev->dm.cached_state);
>         adev->dm.cached_state = drm_atomic_helper_suspend(adev->ddev);
> @@ -1640,6 +1744,46 @@ static void emulated_link_detect(struct dc_link *link)
>
>  }
>
> +static void dm_gpureset_commit_state(struct dc_state *dc_state,
> +                                    struct amdgpu_display_manager *dm)
> +{
> +       struct {
> +               struct dc_surface_update surface_updates[MAX_SURFACES];
> +               struct dc_plane_info plane_infos[MAX_SURFACES];
> +               struct dc_scaling_info scaling_infos[MAX_SURFACES];
> +               struct dc_flip_addrs flip_addrs[MAX_SURFACES];
> +               struct dc_stream_update stream_update;
> +       } * bundle;
> +       int k, m;
> +
> +       bundle = kzalloc(sizeof(*bundle), GFP_KERNEL);
> +
> +       if (!bundle) {
> +               dm_error("Failed to allocate update bundle\n");
> +               goto cleanup;
> +       }
> +
> +       for (k = 0; k < dc_state->stream_count; k++) {
> +               bundle->stream_update.stream = dc_state->streams[k];
> +
> +               for (m = 0; m < dc_state->stream_status->plane_count; m++) {
> +                       bundle->surface_updates[m].surface =
> +                               dc_state->stream_status->plane_states[m];
> +                       bundle->surface_updates[m].surface->force_full_update =
> +                               true;
> +               }
> +               dc_commit_updates_for_stream(
> +                       dm->dc, bundle->surface_updates,
> +                       dc_state->stream_status->plane_count,
> +                       dc_state->streams[k], &bundle->stream_update, dc_state);
> +       }
> +
> +cleanup:
> +       kfree(bundle);
> +
> +       return;
> +}
> +
>  static int dm_resume(void *handle)
>  {
>         struct amdgpu_device *adev = handle;
> @@ -1656,8 +1800,44 @@ static int dm_resume(void *handle)
>         struct dm_plane_state *dm_new_plane_state;
>         struct dm_atomic_state *dm_state = to_dm_atomic_state(dm->atomic_obj.state);
>         enum dc_connection_type new_connection_type = dc_connection_none;
> -       int i, r;
> +       struct dc_state *dc_state;
> +       int i, r, j;
> +
> +       if (adev->in_gpu_reset) {
> +               dc_state = dm->cached_dc_state;
>
> +               r = dm_dmub_hw_init(adev);
> +               if (r)
> +                       DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
> +
> +               dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
> +               dc_resume(dm->dc);
> +
> +               amdgpu_dm_irq_resume_early(adev);
> +
> +               for (i = 0; i < dc_state->stream_count; i++) {
> +                       dc_state->streams[i]->mode_changed = true;
> +                       for (j = 0; j < dc_state->stream_status->plane_count; j++) {
> +                               dc_state->stream_status->plane_states[j]->update_flags.raw
> +                                       = 0xffffffff;
> +                       }
> +               }
> +
> +               WARN_ON(!dc_commit_state(dm->dc, dc_state));
> +
> +               dm_gpureset_commit_state(dm->cached_dc_state, dm);
> +
> +               dm_gpureset_toggle_interrupts(adev, dm->cached_dc_state, true);
> +
> +               dc_release_state(dm->cached_dc_state);
> +               dm->cached_dc_state = NULL;
> +
> +               amdgpu_dm_irq_resume_late(adev);
> +
> +               mutex_unlock(&dm->dc_lock);
> +
> +               return 0;
> +       }
>         /* Recreate dc_state - DC invalidates it when setting power state to S3. */
>         dc_release_state(dm_state->context);
>         dm_state->context = dc_create_state(dm->dc);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 3f0c6298b588..40c912e0bf0c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -315,6 +315,7 @@ struct amdgpu_display_manager {
>  #endif
>
>         struct drm_atomic_state *cached_state;
> +       struct dc_state *cached_dc_state;
>
>         struct dm_comressor_info compressor;
>
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
