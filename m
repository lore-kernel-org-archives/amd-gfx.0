Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1D0C4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Dec 2022 21:13:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EDBC10E154;
	Wed, 21 Dec 2022 21:13:57 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5148E88CBF
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Dec 2022 21:13:54 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-142b72a728fso270204fac.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Dec 2022 13:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zp5C1FpylgQp/NreKkgXLSu0SsgmZpzgIsbCArAqtXw=;
 b=fMNseHZHcCliVBltomhCuwrO3LaELsdwnN0LYTsixch9nJ+MaPq/bbrpXiJqnAoXjk
 M0y2RmoyGu8je/+FcPjK3e3LF2ZbZtYQhyppYpqWHvfvIBx+j5BrM2klUs+sZDEjm7yW
 Mnnfx6y8gcv+Uytbuvyw8Mm8IocKZx/lDSfYm0/iKLONuto52knop2wBr0uUnQrifmsb
 7h0eLX+e5Ava0O09hBL4b3ykDZZ+00v8F9gG7Ql6QE8ipP4owI5D6kQvnAvXT+SGEMyX
 XAFqmbatD1FeXfLH5Ki/rdlEk6JG7AftnMU7gzc1WsNEoO+CmO2zT67k/M8Ek5oinjKW
 d3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zp5C1FpylgQp/NreKkgXLSu0SsgmZpzgIsbCArAqtXw=;
 b=wFgjXzk6ySv8oyE6es6q1H7U+zqwwTFUvf56dsKwU6gch85hPAjWvzbmUAJdN5Ji+G
 /O60L0g6qkkG+r9N1Utn3O9uxW2rFTx/t85Ht2Zl36E1mFqpLivqG98oaYaW+Q+N1gEA
 lkrxyBCL5C820v8cvnZCNHn1hcq7hs/FPaL+m1EJDRO5HK89MoGEE1v/M1pYi20WZsq1
 a1NSPa4teKyrXKQ7q21wmGA4H9tD8Y6w1YpMJutbROjxFwNWGHDhH6XNKmEU6dc3ejBE
 y7PAPYjEpXIUdVikfb3HMpQ+sWhTvD/NK7HCu4NZBCxSiMXFw10yvI7ZKmqKKqagrtJ/
 BSPg==
X-Gm-Message-State: AFqh2kqP9fe1sIx/vV7OLpceLUanf3QAuDUQq/xGC7Q2akCc++DB2L91
 kI1CrQTHl2JlXVqB3dFOtZWiphzPBUTLvqZPe00ricZ0
X-Google-Smtp-Source: AMrXdXv+v3CkNWXR4Wqfp2CWdSO06rVpcGMoqljuMkEEdxjGSROjglDXZm6H3BMlV/AKy0MaOpk96K/J5hJwyXwz4Sc=
X-Received: by 2002:a05:6871:4410:b0:14c:6b59:b014 with SMTP id
 nd16-20020a056871441000b0014c6b59b014mr256710oab.96.1671657233732; Wed, 21
 Dec 2022 13:13:53 -0800 (PST)
MIME-Version: 1.0
References: <20221221152413.883409-1-michel@daenzer.net>
In-Reply-To: <20221221152413.883409-1-michel@daenzer.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 21 Dec 2022 16:13:42 -0500
Message-ID: <CADnq5_PyXw8XvmBLkXNZiNts6PY1qsdytasO1HuSGvNyvKoorw@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/display: Enable Freesync Video Mode by
 default"
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx@lists.freedesktop.org, Solomon Chiu <solomon.chiu@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Wed, Dec 21, 2022 at 10:24 AM Michel D=C3=A4nzer <michel@daenzer.net> wr=
ote:
>
> From: Michel D=C3=A4nzer <mdaenzer@redhat.com>
>
> This reverts commit de05abe6b9d0fe08f65d744f7f75a4cba4df27ad.
>
> The bug referenced below was bisected to this commit. There has been no
> activity toward fixing it in 3 months, so let's revert for now.
>
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2162
> Signed-off-by: Michel D=C3=A4nzer <mdaenzer@redhat.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 27 +++++++++++++++++++
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +++++----
>  3 files changed, 35 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 6b74df446694..e3e2e6e3b485 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -195,6 +195,7 @@ extern int amdgpu_emu_mode;
>  extern uint amdgpu_smu_memory_pool_size;
>  extern int amdgpu_smu_pptable_id;
>  extern uint amdgpu_dc_feature_mask;
> +extern uint amdgpu_freesync_vid_mode;
>  extern uint amdgpu_dc_debug_mask;
>  extern uint amdgpu_dc_visual_confirm;
>  extern uint amdgpu_dm_abm_level;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index b4f2d61ea0d5..1353ffd08988 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -181,6 +181,7 @@ int amdgpu_mes_kiq;
>  int amdgpu_noretry =3D -1;
>  int amdgpu_force_asic_type =3D -1;
>  int amdgpu_tmz =3D -1; /* auto */
> +uint amdgpu_freesync_vid_mode;
>  int amdgpu_reset_method =3D -1; /* auto */
>  int amdgpu_num_kcq =3D -1;
>  int amdgpu_smartshift_bias;
> @@ -879,6 +880,32 @@ module_param_named(backlight, amdgpu_backlight, bint=
, 0444);
>  MODULE_PARM_DESC(tmz, "Enable TMZ feature (-1 =3D auto (default), 0 =3D =
off, 1 =3D on)");
>  module_param_named(tmz, amdgpu_tmz, int, 0444);
>
> +/**
> + * DOC: freesync_video (uint)
> + * Enable the optimization to adjust front porch timing to achieve seaml=
ess
> + * mode change experience when setting a freesync supported mode for whi=
ch full
> + * modeset is not needed.
> + *
> + * The Display Core will add a set of modes derived from the base FreeSy=
nc
> + * video mode into the corresponding connector's mode list based on comm=
only
> + * used refresh rates and VRR range of the connected display, when users=
 enable
> + * this feature. From the userspace perspective, they can see a seamless=
 mode
> + * change experience when the change between different refresh rates und=
er the
> + * same resolution. Additionally, userspace applications such as Video p=
layback
> + * can read this modeset list and change the refresh rate based on the v=
ideo
> + * frame rate. Finally, the userspace can also derive an appropriate mod=
e for a
> + * particular refresh rate based on the FreeSync Mode and add it to the
> + * connector's mode list.
> + *
> + * Note: This is an experimental feature.
> + *
> + * The default value: 0 (off).
> + */
> +MODULE_PARM_DESC(
> +       freesync_video,
> +       "Enable freesync modesetting optimization feature (0 =3D off (def=
ault), 1 =3D on)");
> +module_param_named(freesync_video, amdgpu_freesync_vid_mode, uint, 0444)=
;
> +
>  /**
>   * DOC: reset_method (int)
>   * GPU reset method (-1 =3D auto (default), 0 =3D legacy, 1 =3D mode0, 2=
 =3D mode1, 3 =3D mode2, 4 =3D baco)
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 50c783e19f5a..c9dff07127d9 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5831,7 +5831,8 @@ create_stream_for_sink(struct amdgpu_dm_connector *=
aconnector,
>                  */
>                 DRM_DEBUG_DRIVER("No preferred mode found\n");
>         } else {
> -               recalculate_timing =3D is_freesync_video_mode(&mode, acon=
nector);
> +               recalculate_timing =3D amdgpu_freesync_vid_mode &&
> +                                is_freesync_video_mode(&mode, aconnector=
);
>                 if (recalculate_timing) {
>                         freesync_mode =3D get_highest_refresh_rate_mode(a=
connector, false);
>                         drm_mode_copy(&saved_mode, &mode);
> @@ -6982,7 +6983,7 @@ static void amdgpu_dm_connector_add_freesync_modes(=
struct drm_connector *connect
>         struct amdgpu_dm_connector *amdgpu_dm_connector =3D
>                 to_amdgpu_dm_connector(connector);
>
> -       if (!edid)
> +       if (!(amdgpu_freesync_vid_mode && edid))
>                 return;
>
>         if (amdgpu_dm_connector->max_vfreq - amdgpu_dm_connector->min_vfr=
eq > 10)
> @@ -8846,7 +8847,8 @@ static int dm_update_crtc_state(struct amdgpu_displ=
ay_manager *dm,
>                  * TODO: Refactor this function to allow this check to wo=
rk
>                  * in all conditions.
>                  */
> -               if (dm_new_crtc_state->stream &&
> +               if (amdgpu_freesync_vid_mode &&
> +                   dm_new_crtc_state->stream &&
>                     is_timing_unchanged_for_freesync(new_crtc_state, old_=
crtc_state))
>                         goto skip_modeset;
>
> @@ -8881,7 +8883,7 @@ static int dm_update_crtc_state(struct amdgpu_displ=
ay_manager *dm,
>                 if (!dm_old_crtc_state->stream)
>                         goto skip_modeset;
>
> -               if (dm_new_crtc_state->stream &&
> +               if (amdgpu_freesync_vid_mode && dm_new_crtc_state->stream=
 &&
>                     is_timing_unchanged_for_freesync(new_crtc_state,
>                                                      old_crtc_state)) {
>                         new_crtc_state->mode_changed =3D false;
> @@ -8893,7 +8895,7 @@ static int dm_update_crtc_state(struct amdgpu_displ=
ay_manager *dm,
>                         set_freesync_fixed_config(dm_new_crtc_state);
>
>                         goto skip_modeset;
> -               } else if (aconnector &&
> +               } else if (amdgpu_freesync_vid_mode && aconnector &&
>                            is_freesync_video_mode(&new_crtc_state->mode,
>                                                   aconnector)) {
>                         struct drm_display_mode *high_mode;
> --
> 2.38.1
>
