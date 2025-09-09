Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC79BCA0FED
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 15:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A02F310E260;
	Tue,  9 Sep 2025 15:27:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Blkp0zFF";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F0E910E260
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 15:27:43 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-24b150fb800so14479485ad.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Sep 2025 08:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757431663; x=1758036463; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VUlyZaeyq5uuIoynfk7wo1qVs63WTQDaLWhnaR/Bxf0=;
 b=Blkp0zFFb/5R1/YVNk/j4au7MVt1ldakv/2FyOLaLuuqwbNbTXxKaGjo2+HpFwAdhg
 Un/2Mb2B/e6lE9h2NeVzGCpptcx5Mt69X7PAE6r59vo8ujLMBqLlAmTcXbn6t1Rr2p81
 TRlYgKPKigdM0+iaRUY9i4Fej8cyhUWZtnhH6vXpXoEtsFk+tkgT5PdnFI/rYBCCG8MW
 /L7WeiyZERUT4Vu2Z+cJrk+nnVvFyNeUve7k8N6xE0ogaDJoTnVc966Sacnl62xv8x9p
 +DU52XQzZ5Ruwju2Rfougwy1gGgFO5jGAlzMTDfG3D0ewboRYgA9htbS5yeE/lpdgDC4
 M8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757431663; x=1758036463;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VUlyZaeyq5uuIoynfk7wo1qVs63WTQDaLWhnaR/Bxf0=;
 b=G2WOmksHEKBkFzfiI5ynUM4KlHI6qZqAR64V2A7lxpBZWwh9qIDR5CYXd4k3WEtcH9
 OoTFVO7seITUtGPKJfFcrYRlF2kEeQ0Y0BLibl+GmK2QXv3dXPn4Xba60wPmLo5LLn8e
 gj/0hWDl0ksX/e0pNSsa17bpnHALd6ZSnA89jyoXFGZKVYWVYD351qYLnR4imb6qLsKf
 AvPij2UqtOL7fs/aSfMsPLJqOZQxJ+NvOiAure3OXWYCgdstYcZrcRd1ix9NCgruYYzD
 UtfoBkcwKsTy7jyMyHhQCUTC8jaVvuG3jc6juHFGfu1PzoYLC7KhnAb8Hy11W1Cigvbc
 XShg==
X-Gm-Message-State: AOJu0YzI4KxzqjmQrCaN1tzSfZWedsueRayUDeTN7Z7lwZvs6NOythsZ
 mVg0fPmBbaMyhBcL23HH07WMRAwSpfiy67fzkTfUR7ZF9F1BZldQGAaQva7WDt4Y+wbji6l2GnU
 l9+HrmXUFutpJsyJeZctk30+SQV33+1A=
X-Gm-Gg: ASbGnctuD0JdZ+DGvZwSrN7+k2pxqVPoAw6oXA9prLRVSw5nk39RwSIbiE7r3WPzJ8S
 ZGpRJGANuIvpXkfJ+hOuCnBxw7Gs8fcHyenU9yOUEmiRO1UHK1Og1JOJZtnjRCvvr2FfIWCLnWc
 4IqESso6rKiUj8dbzNI1BocDr5rkBI6XJXloMGs5oKbILqhxDcK1ON12rjGjL0Dk3gBWjYhGkyd
 YpNGXn1E26zn3b8LA==
X-Google-Smtp-Source: AGHT+IESC26tX4kJLPI5f5GlHcbG3mlNyh46COhxC+MSST/zqpz9sEWfS8kM1bjnmjVuf3gh5zulGtojpW0d2ZarjyE=
X-Received: by 2002:a17:903:18c:b0:24c:cc2c:9da5 with SMTP id
 d9443c01a7336-25173ea24a3mr90213125ad.6.1757431662878; Tue, 09 Sep 2025
 08:27:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250909141752.9517-1-timur.kristof@gmail.com>
 <20250909141752.9517-3-timur.kristof@gmail.com>
In-Reply-To: <20250909141752.9517-3-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Sep 2025 11:27:30 -0400
X-Gm-Features: Ac12FXxzfdsPxnHG9YCb-Ndw7-oGBs5YXQDrCfjS40MaHwN-DU_5i1-vaQmnZOY
Message-ID: <CADnq5_PKwMKmwE=9kbQY7ARRthLs_07k0wnVYfaaFREiu9KpqQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/amd/pm: Use pm_display_cfg in legacy DPM (v2)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com
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

Applied the series.  Thanks!

Alex

On Tue, Sep 9, 2025 at 10:18=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> This commit is necessary for DC to function well with chips
> that use the legacy power management code, ie. SI and KV.
> Communicate display information from DC to the legacy PM code.
>
> Currently DC uses pm_display_cfg to communicate power management
> requirements from the display code to the DPM code.
> However, the legacy (non-DC) code path used different fields
> and therefore could not take into account anything from DC.
>
> Change the legacy display code to fill the same pm_display_cfg
> struct as DC and use the same in the legacy DPM code.
>
> To ease review and reduce churn, this commit does not yet
> delete the now unneeded code, that is done in the next commit.
>
> v2:
> Rebase.
> Fix single_display in amdgpu_dpm_pick_power_state.
>
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c  | 67 +++++++++++++++++++
>  .../gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h  |  2 +
>  drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  4 +-
>  .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    |  5 +-
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 65 ++++++------------
>  .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 11 +--
>  6 files changed, 97 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c b/drivers/gpu/d=
rm/amd/pm/amdgpu_dpm_internal.c
> index 2d2d2d5e6763..9ef965e4a92e 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
> @@ -100,3 +100,70 @@ u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *ad=
ev)
>
>         return vrefresh;
>  }
> +
> +void amdgpu_dpm_get_display_cfg(struct amdgpu_device *adev)
> +{
> +       struct drm_device *ddev =3D adev_to_drm(adev);
> +       struct amd_pp_display_configuration *cfg =3D &adev->pm.pm_display=
_cfg;
> +       struct single_display_configuration *display_cfg;
> +       struct drm_crtc *crtc;
> +       struct amdgpu_crtc *amdgpu_crtc;
> +       struct amdgpu_connector *conn;
> +       int num_crtcs =3D 0;
> +       int vrefresh;
> +       u32 vblank_in_pixels, vblank_time_us;
> +
> +       cfg->min_vblank_time =3D 0xffffffff; /* if the displays are off, =
vblank time is max */
> +
> +       if (adev->mode_info.num_crtc && adev->mode_info.mode_config_initi=
alized) {
> +               list_for_each_entry(crtc, &ddev->mode_config.crtc_list, h=
ead) {
> +                       amdgpu_crtc =3D to_amdgpu_crtc(crtc);
> +
> +                       /* The array should only contain active displays.=
 */
> +                       if (!amdgpu_crtc->enabled)
> +                               continue;
> +
> +                       conn =3D to_amdgpu_connector(amdgpu_crtc->connect=
or);
> +                       display_cfg =3D &adev->pm.pm_display_cfg.displays=
[num_crtcs++];
> +
> +                       if (amdgpu_crtc->hw_mode.clock) {
> +                               vrefresh =3D drm_mode_vrefresh(&amdgpu_cr=
tc->hw_mode);
> +
> +                               vblank_in_pixels =3D
> +                                       amdgpu_crtc->hw_mode.crtc_htotal =
*
> +                                       (amdgpu_crtc->hw_mode.crtc_vblank=
_end -
> +                                       amdgpu_crtc->hw_mode.crtc_vdispla=
y +
> +                                       (amdgpu_crtc->v_border * 2));
> +
> +                               vblank_time_us =3D
> +                                       vblank_in_pixels * 1000 / amdgpu_=
crtc->hw_mode.clock;
> +
> +                               /* The legacy (non-DC) code has issues wi=
th mclk switching
> +                                * with refresh rates over 120 Hz. Disabl=
e mclk switching.
> +                                */
> +                               if (vrefresh > 120)
> +                                       vblank_time_us =3D 0;
> +
> +                               /* Find minimum vblank time. */
> +                               if (vblank_time_us < cfg->min_vblank_time=
)
> +                                       cfg->min_vblank_time =3D vblank_t=
ime_us;
> +
> +                               /* Find vertical refresh rate of first ac=
tive display. */
> +                               if (!cfg->vrefresh)
> +                                       cfg->vrefresh =3D vrefresh;
> +                       }
> +
> +                       if (amdgpu_crtc->crtc_id < cfg->crtc_index) {
> +                               /* Find first active CRTC and its line ti=
me. */
> +                               cfg->crtc_index =3D amdgpu_crtc->crtc_id;
> +                               cfg->line_time_in_us =3D amdgpu_crtc->lin=
e_time;
> +                       }
> +
> +                       display_cfg->controller_id =3D amdgpu_crtc->crtc_=
id;
> +                       display_cfg->pixel_clock =3D conn->pixelclock_for=
_modeset;
> +               }
> +       }
> +
> +       cfg->display_clk =3D adev->clock.default_dispclk;
> +       cfg->num_display =3D num_crtcs;
> +}
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h b/drivers/g=
pu/drm/amd/pm/inc/amdgpu_dpm_internal.h
> index 5c2a89f0d5d5..8be11510cd92 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h
> @@ -29,4 +29,6 @@ u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *ad=
ev);
>
>  u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev);
>
> +void amdgpu_dpm_get_display_cfg(struct amdgpu_device *adev);
> +
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm=
/amd/pm/legacy-dpm/kv_dpm.c
> index 307ebf7e3226..33eb85dd68e9 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
> @@ -2299,7 +2299,7 @@ static void kv_apply_state_adjust_rules(struct amdg=
pu_device *adev,
>
>                 if (pi->sys_info.nb_dpm_enable) {
>                         force_high =3D (mclk >=3D pi->sys_info.nbp_memory=
_clock[3]) ||
> -                               pi->video_start || (adev->pm.dpm.new_acti=
ve_crtc_count >=3D 3) ||
> +                               pi->video_start || (adev->pm.pm_display_c=
fg.num_display >=3D 3) ||
>                                 pi->disable_nb_ps3_in_battery;
>                         ps->dpm0_pg_nb_ps_lo =3D force_high ? 0x2 : 0x3;
>                         ps->dpm0_pg_nb_ps_hi =3D 0x2;
> @@ -2358,7 +2358,7 @@ static int kv_calculate_nbps_level_settings(struct =
amdgpu_device *adev)
>                         return 0;
>
>                 force_high =3D ((mclk >=3D pi->sys_info.nbp_memory_clock[=
3]) ||
> -                             (adev->pm.dpm.new_active_crtc_count >=3D 3)=
 || pi->video_start);
> +                             (adev->pm.pm_display_cfg.num_display >=3D 3=
) || pi->video_start);
>
>                 if (force_high) {
>                         for (i =3D pi->lowest_valid; i <=3D pi->highest_v=
alid; i++)
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu=
/drm/amd/pm/legacy-dpm/legacy_dpm.c
> index 52dbf6d0469d..6ebe3d0f5b87 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
> @@ -771,7 +771,7 @@ static struct amdgpu_ps *amdgpu_dpm_pick_power_state(=
struct amdgpu_device *adev,
>         int i;
>         struct amdgpu_ps *ps;
>         u32 ui_class;
> -       bool single_display =3D adev->pm.dpm.new_active_crtc_count < 2;
> +       bool single_display =3D adev->pm.pm_display_cfg.num_display < 2;
>
>         /* check if the vblank period is too short to adjust the mclk */
>         if (single_display && adev->powerplay.pp_funcs->vblank_too_short)=
 {
> @@ -967,7 +967,8 @@ void amdgpu_legacy_dpm_compute_clocks(void *handle)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>
> -       amdgpu_dpm_get_active_displays(adev);
> +       if (!adev->dc_enabled)
> +               amdgpu_dpm_get_display_cfg(adev);
>
>         amdgpu_dpm_change_power_state_locked(adev);
>  }
> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm=
/amd/pm/legacy-dpm/si_dpm.c
> index 6595a611ce6e..cf9932e68055 100644
> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
> @@ -3081,7 +3081,7 @@ static int si_get_vce_clock_voltage(struct amdgpu_d=
evice *adev,
>  static bool si_dpm_vblank_too_short(void *handle)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> -       u32 vblank_time =3D amdgpu_dpm_get_vblank_time(adev);
> +       u32 vblank_time =3D adev->pm.pm_display_cfg.min_vblank_time;
>         /* we never hit the non-gddr5 limit so disable it */
>         u32 switch_limit =3D adev->gmc.vram_type =3D=3D AMDGPU_VRAM_TYPE_=
GDDR5 ? 450 : 0;
>
> @@ -3447,9 +3447,10 @@ static void rv770_get_engine_memory_ss(struct amdg=
pu_device *adev)
>  static void si_apply_state_adjust_rules(struct amdgpu_device *adev,
>                                         struct amdgpu_ps *rps)
>  {
> +       const struct amd_pp_display_configuration *display_cfg =3D
> +               &adev->pm.pm_display_cfg;
>         struct  si_ps *ps =3D si_get_ps(rps);
>         struct amdgpu_clock_and_voltage_limits *max_limits;
> -       struct amdgpu_connector *conn;
>         bool disable_mclk_switching =3D false;
>         bool disable_sclk_switching =3D false;
>         u32 mclk, sclk;
> @@ -3488,14 +3489,9 @@ static void si_apply_state_adjust_rules(struct amd=
gpu_device *adev,
>          * For example, 4K 60Hz and 1080p 144Hz fall into this category.
>          * Find number of such displays connected.
>          */
> -       for (i =3D 0; i < adev->mode_info.num_crtc; i++) {
> -               if (!(adev->pm.dpm.new_active_crtcs & (1 << i)) ||
> -                       !adev->mode_info.crtcs[i]->enabled)
> -                       continue;
> -
> -               conn =3D to_amdgpu_connector(adev->mode_info.crtcs[i]->co=
nnector);
> -
> -               if (conn->pixelclock_for_modeset > 297000)
> +       for (i =3D 0; i < display_cfg->num_display; i++) {
> +               /* The array only contains active displays. */
> +               if (display_cfg->displays[i].pixel_clock > 297000)
>                         high_pixelclock_count++;
>         }
>
> @@ -3523,7 +3519,7 @@ static void si_apply_state_adjust_rules(struct amdg=
pu_device *adev,
>                 rps->ecclk =3D 0;
>         }
>
> -       if ((adev->pm.dpm.new_active_crtc_count > 1) ||
> +       if ((adev->pm.pm_display_cfg.num_display > 1) ||
>             si_dpm_vblank_too_short(adev))
>                 disable_mclk_switching =3D true;
>
> @@ -3671,7 +3667,7 @@ static void si_apply_state_adjust_rules(struct amdg=
pu_device *adev,
>                                                    ps->performance_levels=
[i].mclk,
>                                                    max_limits->vddc,  &ps=
->performance_levels[i].vddc);
>                 btc_apply_voltage_dependency_rules(&adev->pm.dpm.dyn_stat=
e.vddc_dependency_on_dispclk,
> -                                                  adev->clock.current_di=
spclk,
> +                                                  display_cfg->display_c=
lk,
>                                                    max_limits->vddc,  &ps=
->performance_levels[i].vddc);
>         }
>
> @@ -4196,16 +4192,16 @@ static void si_program_ds_registers(struct amdgpu=
_device *adev)
>
>  static void si_program_display_gap(struct amdgpu_device *adev)
>  {
> +       const struct amd_pp_display_configuration *cfg =3D &adev->pm.pm_d=
isplay_cfg;
>         u32 tmp, pipe;
> -       int i;
>
>         tmp =3D RREG32(mmCG_DISPLAY_GAP_CNTL) & ~(CG_DISPLAY_GAP_CNTL__DI=
SP1_GAP_MASK | CG_DISPLAY_GAP_CNTL__DISP2_GAP_MASK);
> -       if (adev->pm.dpm.new_active_crtc_count > 0)
> +       if (cfg->num_display > 0)
>                 tmp |=3D R600_PM_DISPLAY_GAP_VBLANK_OR_WM << CG_DISPLAY_G=
AP_CNTL__DISP1_GAP__SHIFT;
>         else
>                 tmp |=3D R600_PM_DISPLAY_GAP_IGNORE << CG_DISPLAY_GAP_CNT=
L__DISP1_GAP__SHIFT;
>
> -       if (adev->pm.dpm.new_active_crtc_count > 1)
> +       if (cfg->num_display > 1)
>                 tmp |=3D R600_PM_DISPLAY_GAP_VBLANK_OR_WM << CG_DISPLAY_G=
AP_CNTL__DISP2_GAP__SHIFT;
>         else
>                 tmp |=3D R600_PM_DISPLAY_GAP_IGNORE << CG_DISPLAY_GAP_CNT=
L__DISP2_GAP__SHIFT;
> @@ -4215,17 +4211,8 @@ static void si_program_display_gap(struct amdgpu_d=
evice *adev)
>         tmp =3D RREG32(DCCG_DISP_SLOW_SELECT_REG);
>         pipe =3D (tmp & DCCG_DISP1_SLOW_SELECT_MASK) >> DCCG_DISP1_SLOW_S=
ELECT_SHIFT;
>
> -       if ((adev->pm.dpm.new_active_crtc_count > 0) &&
> -           (!(adev->pm.dpm.new_active_crtcs & (1 << pipe)))) {
> -               /* find the first active crtc */
> -               for (i =3D 0; i < adev->mode_info.num_crtc; i++) {
> -                       if (adev->pm.dpm.new_active_crtcs & (1 << i))
> -                               break;
> -               }
> -               if (i =3D=3D adev->mode_info.num_crtc)
> -                       pipe =3D 0;
> -               else
> -                       pipe =3D i;
> +       if (cfg->num_display > 0 && pipe !=3D cfg->crtc_index) {
> +               pipe =3D cfg->crtc_index;
>
>                 tmp &=3D ~DCCG_DISP1_SLOW_SELECT_MASK;
>                 tmp |=3D DCCG_DISP1_SLOW_SELECT(pipe);
> @@ -4236,7 +4223,7 @@ static void si_program_display_gap(struct amdgpu_de=
vice *adev)
>          * This can be a problem on PowerXpress systems or if you want to=
 use the card
>          * for offscreen rendering or compute if there are no crtcs enabl=
ed.
>          */
> -       si_notify_smc_display_change(adev, adev->pm.dpm.new_active_crtc_c=
ount > 0);
> +       si_notify_smc_display_change(adev, cfg->num_display > 0);
>  }
>
>  static void si_enable_spread_spectrum(struct amdgpu_device *adev, bool e=
nable)
> @@ -5545,7 +5532,7 @@ static int si_convert_power_level_to_smc(struct amd=
gpu_device *adev,
>             (pl->mclk <=3D pi->mclk_stutter_mode_threshold) &&
>             !eg_pi->uvd_enabled &&
>             (RREG32(mmDPG_PIPE_STUTTER_CONTROL) & DPG_PIPE_STUTTER_CONTRO=
L__STUTTER_ENABLE_MASK) &&
> -           (adev->pm.dpm.new_active_crtc_count <=3D 2)) {
> +           (adev->pm.pm_display_cfg.num_display <=3D 2)) {
>                 level->mcFlags |=3D SISLANDS_SMC_MC_STUTTER_EN;
>         }
>
> @@ -5694,7 +5681,7 @@ static bool si_is_state_ulv_compatible(struct amdgp=
u_device *adev,
>         /* XXX validate against display requirements! */
>
>         for (i =3D 0; i < adev->pm.dpm.dyn_state.vddc_dependency_on_dispc=
lk.count; i++) {
> -               if (adev->clock.current_dispclk <=3D
> +               if (adev->pm.pm_display_cfg.display_clk <=3D
>                     adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.ent=
ries[i].clk) {
>                         if (ulv->pl.vddc <
>                             adev->pm.dpm.dyn_state.vddc_dependency_on_dis=
pclk.entries[i].v)
> @@ -5848,30 +5835,22 @@ static int si_upload_ulv_state(struct amdgpu_devi=
ce *adev)
>
>  static int si_upload_smc_data(struct amdgpu_device *adev)
>  {
> -       struct amdgpu_crtc *amdgpu_crtc =3D NULL;
> -       int i;
> +       const struct amd_pp_display_configuration *cfg =3D &adev->pm.pm_d=
isplay_cfg;
>         u32 crtc_index =3D 0;
>         u32 mclk_change_block_cp_min =3D 0;
>         u32 mclk_change_block_cp_max =3D 0;
>
> -       for (i =3D 0; i < adev->mode_info.num_crtc; i++) {
> -               if (adev->pm.dpm.new_active_crtcs & (1 << i)) {
> -                       amdgpu_crtc =3D adev->mode_info.crtcs[i];
> -                       break;
> -               }
> -       }
> -
>         /* When a display is plugged in, program these so that the SMC
>          * performs MCLK switching when it doesn't cause flickering.
>          * When no display is plugged in, there is no need to restrict
>          * MCLK switching, so program them to zero.
>          */
> -       if (adev->pm.dpm.new_active_crtc_count && amdgpu_crtc) {
> -               crtc_index =3D amdgpu_crtc->crtc_id;
> +       if (cfg->num_display) {
> +               crtc_index =3D cfg->crtc_index;
>
> -               if (amdgpu_crtc->line_time) {
> -                       mclk_change_block_cp_min =3D 200 / amdgpu_crtc->l=
ine_time;
> -                       mclk_change_block_cp_max =3D 100 / amdgpu_crtc->l=
ine_time;
> +               if (cfg->line_time_in_us) {
> +                       mclk_change_block_cp_min =3D 200 / cfg->line_time=
_in_us;
> +                       mclk_change_block_cp_max =3D 100 / cfg->line_time=
_in_us;
>                 }
>         }
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/g=
pu/drm/amd/pm/powerplay/amd_powerplay.c
> index b48a031cbba0..554492dfa3c0 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
> @@ -1554,16 +1554,7 @@ static void pp_pm_compute_clocks(void *handle)
>         struct amdgpu_device *adev =3D hwmgr->adev;
>
>         if (!adev->dc_enabled) {
> -               amdgpu_dpm_get_active_displays(adev);
> -               adev->pm.pm_display_cfg.num_display =3D adev->pm.dpm.new_=
active_crtc_count;
> -               adev->pm.pm_display_cfg.vrefresh =3D amdgpu_dpm_get_vrefr=
esh(adev);
> -               adev->pm.pm_display_cfg.min_vblank_time =3D amdgpu_dpm_ge=
t_vblank_time(adev);
> -               /* we have issues with mclk switching with
> -                * refresh rates over 120 hz on the non-DC code.
> -                */
> -               if (adev->pm.pm_display_cfg.vrefresh > 120)
> -                       adev->pm.pm_display_cfg.min_vblank_time =3D 0;
> -
> +               amdgpu_dpm_get_display_cfg(adev);
>                 pp_display_configuration_change(handle,
>                                                 &adev->pm.pm_display_cfg)=
;
>         }
> --
> 2.51.0
>
