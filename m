Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89C6CCD184
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 14:57:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EF5110EA81;
	Thu,  9 Oct 2025 14:57:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GTxsc8LB";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 024E310EA81
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 14:57:38 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-32eb8144fecso212924a91.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Oct 2025 07:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760021858; x=1760626658; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R6XdlmW98KtilytItO4ixKc8ZfXZSoJOArSFuikw+5k=;
 b=GTxsc8LBVIs+SSoT7tCxD5Nc7xPRveKfDMkVsaxVn6AQu/qdVaRkg/Wl6XK2Zh75Rx
 Pos7ybBPegJVVCSpD56qNXLG0f4f+i0O4aoNHGiHxElIDOJgVem776o18TD7qxRDDZ8g
 nUJ7M1K7n/eennuV3KgXxHXFoUdo8LxPAE4gqb/zTvHASqdQa4oNMz6HB1/rKq++xu+4
 9Pn91etjNCLgCkExxL13d/5OfnwY50WgFg9wiUGre9Q2hYi6fVdo3ZlWd95Ejc295h78
 rivDD74ITJuNm19e604ux831lThs3fK8M5zHE7O5o8IrAtG+EhDIbp2GbCnjhtGHFBwD
 /6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760021858; x=1760626658;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R6XdlmW98KtilytItO4ixKc8ZfXZSoJOArSFuikw+5k=;
 b=v6Hs40xZ9hLbZB0xy4TDXyNtVf74J5ei1iC/QJEYVrACao7jn62oQUA4swlYIOTV3V
 rjqZrAbMe6LdtEiQ5oYytfJatkqpwJUUml2/Jpz8erYCpKkI7mSLK7qTqL5HcYxkpgPU
 qbhQiIYX5Sk+W5ugaHHktXFDSHnPSQnsnwxckExLAUOeT3q9k864u8MPusil4kgf0fdk
 Q5aR6zbW0gx8lnAzbWFNeK7R1VyHijXSYZkCYIYDcnFQ+jw2EPY+FxC2AXKkbX7iLsci
 1UhfwF6lk72Qy9fObO2UEQ6MSJQdY6/q0H7EtwQzOt6TeaWc3plTBvwWl7RRBWQbK4g5
 qgPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2DInjiXhPWDpBCkpowLRB32fdavsW+EXd89FgxL1CWgE62C26RCUb4I7pqfu4WD2lxqMhio3+@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxsaXtZ4vS46rttiSJDHX5SzZ5XC7pXz+ivk0Dso+sW9l8t+n9A
 idryR5k4cYAAyyc8q52+yw/HvDS8FARg17pZo9BWz0hJch2z2b2YE6oJ/5zwpJncoe8zQsk4f2U
 IKfoSp/Y+MTaMl0YyrvwKudSSn6cUhR8=
X-Gm-Gg: ASbGncu5GGIpqH1EshIWZRTAaetHmWAtZmgr7e+3z84Nn++Im3C63RdNi9PaDhzTqbS
 j7FaS4QjWijJTZ4cweCFwZlP2N884HrvnTSe0BM8DjDIExxaKXSpANlB9dgvMDeVK6B2O7hqE1d
 hpR3elXWhgMFsANUauB4dXIwXYjR/qDj+uYbFHR8LjTKZbpCbLuFC5JXlAjKi8Zul7nCpWzex8J
 1Rp2DcSsiZa5VlZlUf+3BqMZxKZr/MtcO+3Dp5RNA==
X-Google-Smtp-Source: AGHT+IF5nY+/zS7XE+U3ljAWwxUkr3ItMRcUh2ZrRrJhs5g+6GaXHyt+rQpZjkZPESw2KD1IdoLsSC3inYtQoPTKMPA=
X-Received: by 2002:a17:902:f54b:b0:274:506d:7fe5 with SMTP id
 d9443c01a7336-290273e1e23mr53282705ad.4.1760021858358; Thu, 09 Oct 2025
 07:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20251009121900.12777-1-matthew.schwartz@linux.dev>
In-Reply-To: <20251009121900.12777-1-matthew.schwartz@linux.dev>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Oct 2025 10:57:27 -0400
X-Gm-Features: AS18NWCqAqPtByWTZAk7O2nj3raD72Gwfu7-I05PFv7BPT8i-MRFM-Zyva2YcIA
Message-ID: <CADnq5_NauQ3YSngQ4mtx=L1t5yuxWZYHLRn-Je8rL3yYhYOqMA@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "drm/amd/display: Only restore backlight after
 amdgpu_dm_init or dm_resume"
To: Matthew Schwartz <matthew.schwartz@linux.dev>
Cc: harry.wentland@amd.com, christian.koenig@amd.com, sunpeng.li@amd.com, 
 airlied@gmail.com, simona@ffwll.ch, alexander.deucher@amd.com, 
 linux-kernel@vger.kernel.org, mario.limonciello@amd.com, 
 amd-gfx@lists.freedesktop.org, regressions@lists.linux.dev, 
 stable@vger.kernel.org
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks.

Alex

On Thu, Oct 9, 2025 at 8:51=E2=80=AFAM Matthew Schwartz
<matthew.schwartz@linux.dev> wrote:
>
> This fix regressed the original issue that commit d83c747a1225
> ("drm/amd/display: Fix brightness level not retained over reboot") solved=
,
> so revert it until a different approach to solve the regression that
> it caused with AMD_PRIVATE_COLOR is found.
>
> Fixes: a490c8d77d50 ("drm/amd/display: Only restore backlight after amdgp=
u_dm_init or dm_resume")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4620
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> ---
> v1 -> v2:
> - Fix missing stable tag
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++--------
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  7 -------
>  2 files changed, 4 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 8e1622bf7a42..21281e684b84 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -2081,8 +2081,6 @@ static int amdgpu_dm_init(struct amdgpu_device *ade=
v)
>
>         dc_hardware_init(adev->dm.dc);
>
> -       adev->dm.restore_backlight =3D true;
> -
>         adev->dm.hpd_rx_offload_wq =3D hpd_rx_irq_create_workqueue(adev);
>         if (!adev->dm.hpd_rx_offload_wq) {
>                 drm_err(adev_to_drm(adev), "failed to create hpd rx offlo=
ad workqueue.\n");
> @@ -3438,7 +3436,6 @@ static int dm_resume(struct amdgpu_ip_block *ip_blo=
ck)
>                 dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
>
>                 dc_resume(dm->dc);
> -               adev->dm.restore_backlight =3D true;
>
>                 amdgpu_dm_irq_resume_early(adev);
>
> @@ -9965,6 +9962,7 @@ static void amdgpu_dm_commit_streams(struct drm_ato=
mic_state *state,
>         bool mode_set_reset_required =3D false;
>         u32 i;
>         struct dc_commit_streams_params params =3D {dc_state->streams, dc=
_state->stream_count};
> +       bool set_backlight_level =3D false;
>
>         /* Disable writeback */
>         for_each_old_connector_in_state(state, connector, old_con_state, =
i) {
> @@ -10084,6 +10082,7 @@ static void amdgpu_dm_commit_streams(struct drm_a=
tomic_state *state,
>                         acrtc->hw_mode =3D new_crtc_state->mode;
>                         crtc->hwmode =3D new_crtc_state->mode;
>                         mode_set_reset_required =3D true;
> +                       set_backlight_level =3D true;
>                 } else if (modereset_required(new_crtc_state)) {
>                         drm_dbg_atomic(dev,
>                                        "Atomic commit: RESET. crtc id %d:=
[%p]\n",
> @@ -10140,16 +10139,13 @@ static void amdgpu_dm_commit_streams(struct drm=
_atomic_state *state,
>          * to fix a flicker issue.
>          * It will cause the dm->actual_brightness is not the current pan=
el brightness
>          * level. (the dm->brightness is the correct panel level)
> -        * So we set the backlight level with dm->brightness value after =
initial
> -        * set mode. Use restore_backlight flag to avoid setting backligh=
t level
> -        * for every subsequent mode set.
> +        * So we set the backlight level with dm->brightness value after =
set mode
>          */
> -       if (dm->restore_backlight) {
> +       if (set_backlight_level) {
>                 for (i =3D 0; i < dm->num_of_edps; i++) {
>                         if (dm->backlight_dev[i])
>                                 amdgpu_dm_backlight_set_level(dm, i, dm->=
brightness[i]);
>                 }
> -               dm->restore_backlight =3D false;
>         }
>  }
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 009f206226f0..db75e991ac7b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -630,13 +630,6 @@ struct amdgpu_display_manager {
>          */
>         u32 actual_brightness[AMDGPU_DM_MAX_NUM_EDP];
>
> -       /**
> -        * @restore_backlight:
> -        *
> -        * Flag to indicate whether to restore backlight after modeset.
> -        */
> -       bool restore_backlight;
> -
>         /**
>          * @aux_hpd_discon_quirk:
>          *
> --
> 2.51.0
>
