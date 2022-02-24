Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DEDC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Feb 2022 22:21:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFFAF10E16B;
	Thu, 24 Feb 2022 22:21:24 +0000 (UTC)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A836210E16B
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Feb 2022 22:21:23 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 l20-20020a0568302b1400b005af8c95bbe4so2387728otv.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Feb 2022 14:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5AZDk+RwC6jN1E8TMI+84ml8kiIqx6tpCLvRzkZvZlQ=;
 b=e4Y8qk7dEzAcyBMWCzFY/CZBwr00qVLKmI6pHS7JeTZ2yQgzbBKzvvXsQsliZdItbr
 AHyj8L3MWqRXYC+CO9/Z25gI0XPYe9X6VxPCfH9vSf32aZXJH2b9kIF0JJc3XvZXTMcI
 oS3NbijiA0cOjfsFoVJtc2/o7dGhoi5ivPpIna6vFtwPN+xQjHG6bP4HagGB2g5nDvRt
 qJW4+ejrA1j9m4A5gVvBj2WCtPKwnZz8gE1gUoZTOTLe1WEUV114NciQ2jLKLQdmf3/F
 jkhnep9HxtY35wk2LbdVjK7wLvQPUAMlTx++dn8TK4wZDpg0g+wV3UKqLTk7lVZ21lN3
 10cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5AZDk+RwC6jN1E8TMI+84ml8kiIqx6tpCLvRzkZvZlQ=;
 b=RJw3v6azZmPPfZNGklHlWsJcCXowi66XRAYZ4cgaZqJK+xEqYg7Cy8WAYtO4+NPtFL
 nwawzpjQ2yCMWegrxKfDor0VmXQQvruKF+bltcPEwivOLEf4+tBjruGjEBkw50HUek6x
 MFDwD9aeKumef2lVSJOttWJ0oA1njzU0gLyQfxfTXRR0+uL0MFUAERLpV7RnVQpu0Ao+
 cXndEyxR0WdQgLPGyvGYN2OxkPpr79Yiei4B1A2a8uXfE1mKcAQQHy174zuXdE6ru1Wo
 NOTCkbAph7es6QdSY9Dor/QAga1oQXN1ntrCmwPMblOmTELKbOdhKCAPU2Vq8WYwmT99
 Dk0w==
X-Gm-Message-State: AOAM531lFPG97r1a2WpktMRh4Q+eC42GhUfq8dfG1tUI+CCxOP3B7FUj
 7E4DabTglCI2Hb+Qo/rwwsvE0W3tYVI8sRbg/z0=
X-Google-Smtp-Source: ABdhPJyicIiyWUCTWF8MEw1KoAsrS/j6wwK1ys0JNY5qK2VHyKdOtXOkcx5Kl5DGiS01OHM7htGxJdnp7jUyUWjRpMg=
X-Received: by 2002:a4a:1b43:0:b0:31b:aa93:dd7d with SMTP id
 64-20020a4a1b43000000b0031baa93dd7dmr1757668oop.68.1645741282910; Thu, 24 Feb
 2022 14:21:22 -0800 (PST)
MIME-Version: 1.0
References: <20220224214531.6397-1-luben.tuikov@amd.com>
In-Reply-To: <20220224214531.6397-1-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 24 Feb 2022 17:21:11 -0500
Message-ID: <CADnq5_MvPWnrOnNb4Ggm-jUgyg7zq69WAthfZ2bZgTXAYzEG2Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Don't fill up the logs
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Felix Kuehling <felix.kuehling@amd.com>, Roman Li <Roman.Li@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Daniel Wheeler <daniel.wheeler@amd.com>, Hersen Wu <hersenwu@amd.com>,
 Alex Deucher <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 24, 2022 at 4:46 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Don't fill up the logs with:
>
> [253557.859575] [drm:amdgpu_dm_atomic_check [amdgpu]] DSC precompute is not needed.
> [253557.892966] [drm:amdgpu_dm_atomic_check [amdgpu]] DSC precompute is not needed.
> [253557.926070] [drm:amdgpu_dm_atomic_check [amdgpu]] DSC precompute is not needed.
> [253557.959344] [drm:amdgpu_dm_atomic_check [amdgpu]] DSC precompute is not needed.
>
> which prints many times a second, when the kernel is run with
> drm.debug=2.
>
> Instead of DRM_DEBUG_DRIVER(), make it DRM_INFO_ONCE().

Maybe convert to DRM_DEBUG_KMS() for consistency with the rest of the
display code?

Alex

>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Roman Li <Roman.Li@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Hersen Wu <hersenwu@amd.com>
> Cc: Daniel Wheeler <daniel.wheeler@amd.com>
> Fixes: 5898243ba7acdb ("drm/amd/display: Add dsc pre-validation in atomic check")
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c   | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 05573f073b21f7..0542034530b1b0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -1198,11 +1198,11 @@ void pre_validate_dsc(struct drm_atomic_state *state,
>         struct dc_state *local_dc_state = NULL;
>
>         if (!is_dsc_precompute_needed(state)) {
> -               DRM_DEBUG_DRIVER("DSC precompute is not needed.\n");
> +               DRM_INFO_ONCE("DSC precompute is not needed.\n");
>                 return;
>         }
>         if (dm_atomic_get_state(state, dm_state_ptr)) {
> -               DRM_DEBUG_DRIVER("dm_atomic_get_state() failed\n");
> +               DRM_INFO_ONCE("dm_atomic_get_state() failed\n");
>                 return;
>         }
>         dm_state = *dm_state_ptr;
> @@ -1245,7 +1245,7 @@ void pre_validate_dsc(struct drm_atomic_state *state,
>         }
>
>         if (!pre_compute_mst_dsc_configs_for_state(state, local_dc_state, vars)) {
> -               DRM_DEBUG_DRIVER("pre_compute_mst_dsc_configs_for_state() failed\n");
> +               DRM_INFO_ONCE("pre_compute_mst_dsc_configs_for_state() failed\n");
>                 goto clean_exit;
>         }
>
> @@ -1258,7 +1258,7 @@ void pre_validate_dsc(struct drm_atomic_state *state,
>
>                 if (local_dc_state->streams[i] &&
>                     is_timing_changed(stream, local_dc_state->streams[i])) {
> -                       DRM_DEBUG_DRIVER("crtc[%d] needs mode_changed\n", i);
> +                       DRM_INFO_ONCE("crtc[%d] needs mode_changed\n", i);
>                 } else {
>                         int ind = find_crtc_index_in_state_by_stream(state, stream);
>
>
> base-commit: bff980c7632ef3b0099ba230cf7d5c864db3e1a3
> --
> 2.35.1.129.gb80121027d
>
