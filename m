Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A11E4CA0EFA
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 14:27:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5012710E670;
	Tue, 26 Aug 2025 14:27:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UP7cgZ1/";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB95710E671
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 14:26:58 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2488be81066so227585ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 07:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756218418; x=1756823218; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W+RdNl7ggf2ORMIqg1GxzKj0JUmCbcWrTymmWQ2vfGs=;
 b=UP7cgZ1/3JGiCiyEDruxabUpPMzE/lb/+3x2TOojF9QtCEl3s5nSUiGxQ4yKPz/nR5
 glQok/b1iHeNcU2kD/mJNGpvX7gT1y04QZEovB4KGwrALq7Hdu/4Ww1Rhl+KhJkuo0PJ
 l69lzaMuzOuekdjqv4YBBKon7UGrHklBjXfK02kddVlpbNZ+4pyvowH3+50iollAImhP
 HG80Z6d5ySzuTWvGx3vjFvtWrzeSjdffjDGZeYVmO5Wp1WYwLcQ8tfUav6lvDQKYIdzb
 ED40kP1dhLBtgrwEy7NYB0y6x3i7gUFNItTdFsw4aM4RIK9CVG7mz1pykDJI+jAqTxPw
 EGrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756218418; x=1756823218;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W+RdNl7ggf2ORMIqg1GxzKj0JUmCbcWrTymmWQ2vfGs=;
 b=SYc9MuKSlDJnHLF/+DYI3c/WKUzHmU3gC/ktFqzm+CEXmnIvMd57AZ6yE5eDbRb39J
 se9DJ2oTTdQjxhDbboiQku735OFLSZSyYfTnGDyfiP0/sBnjAdybtTGeL423tcelZzgm
 cAlrOYv6kHWuoskebmOdHC7tAXGnSOTdTzQQAaH4GcLXd1piqUFnKdY84GzRog9ElhJZ
 wjL8byK0elRA1xBK4ilc33Vozc/41MOy83raszVaQevZt1r27GEUXYGBNccN78JIhPMr
 RZ9Io7YH3fuFVhD0V31zzRjSLTeKlb7W7ZCi1MXdJZdVaKOCtczaIw89JwbgHbJWRVmo
 3NmA==
X-Gm-Message-State: AOJu0Yw38r1xUYNIvHtcOJB3TOiQbO6HZDyuYRlFu/7M9F5cMb7lPzCa
 dMy2AQe33I15l1H25bvheXcLTLUjTkCEZLa08ZS0F6VxpmjY7RTIx+TEV4rHD524sHuQWDOnNJ1
 lITh9zBAnvXER0i53xSfnYM1FXNsalHo=
X-Gm-Gg: ASbGncv2jW72+x9EEojyT8YiOu4ANkwF1MzhdBOBDyr+9mcmYSdyJc+kKdQ2iBs+0OP
 VjIX3zPKd8Fo/L/YyKejM6FkwiRZyPL3GN5hK8TrnC9drTfXmoX1YC1MhqO2oaw/KQzHFINm68K
 vl8Ba8jQ/cVqavTezRpkJhcqwvveCpZNhs1TY95P2ZZq8CqdW0iSj96xIjwaZH8qsiS5PYRsX7O
 J0VfwT4YGoFBq088Zf0JlZJK1kO
X-Google-Smtp-Source: AGHT+IFze+HSjAuXG6tvVTc/gBUpvL6yRHNyKlkj27ysIlwP0xY2alIssyBKcusSTxwYsqcDB++SXAzzQ3xQxyKk1io=
X-Received: by 2002:a17:902:f689:b0:246:b3cc:f854 with SMTP id
 d9443c01a7336-246b3cd0030mr60706525ad.2.1756218418369; Tue, 26 Aug 2025
 07:26:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250825220732.636810-1-timur.kristof@gmail.com>
 <20250825220732.636810-2-timur.kristof@gmail.com>
In-Reply-To: <20250825220732.636810-2-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Aug 2025 10:26:46 -0400
X-Gm-Features: Ac12FXwbmi7Xbeo3LxCaWMUIh7JzFDjdTxzsbyV-mpN3AVrZjRNszLUUklcxFfQ
Message-ID: <CADnq5_PcQFh2ss9ffbnpDn=nhNbEsXRP_W5uBcyg2zKKX9Usdg@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amd/display: Add pixel_clock to
 amd_pp_display_configuration
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 harry.wentland@amd.com, alex.hung@amd.com
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

On Mon, Aug 25, 2025 at 6:07=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> This commit adds the pixel_clock field to the display config
> struct so that power management (DPM) can use it.
>
> We currently don't have a proper bandwidth calculation on old
> GPUs with DCE 6-10 because dce_calcs only supports DCE 11+.
> So the power management (DPM) on these GPUs may need to make
> ad-hoc decisions for display based on the pixel clock.
>
> Also rename sym_clock to pixel_clock in dm_pp_single_disp_config
> to avoid confusion with other code where the sym_clock refers to
> the DisplayPort symbol clock.
>
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c       | 1 +
>  drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c | 2 +-
>  drivers/gpu/drm/amd/display/dc/dm_services_types.h             | 2 +-
>  drivers/gpu/drm/amd/include/dm_pp_interface.h                  | 1 +
>  4 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> index e5771f490f2e..11b2ea6edf95 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> @@ -98,6 +98,7 @@ bool dm_pp_apply_display_requirements(
>                         const struct dm_pp_single_disp_config *dc_cfg =3D
>                                                 &pp_display_cfg->disp_con=
figs[i];
>                         adev->pm.pm_display_cfg.displays[i].controller_id=
 =3D dc_cfg->pipe_idx + 1;
> +                       adev->pm.pm_display_cfg.displays[i].pixel_clock =
=3D dc_cfg->pixel_clock;
>                 }
>
>                 amdgpu_dpm_display_configuration_change(adev, &adev->pm.p=
m_display_cfg);
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr=
.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
> index 13cf415e38e5..d50b9440210e 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
> @@ -164,7 +164,7 @@ void dce110_fill_display_configs(
>                         stream->link->cur_link_settings.link_rate;
>                 cfg->link_settings.link_spread =3D
>                         stream->link->cur_link_settings.link_spread;
> -               cfg->sym_clock =3D stream->phy_pix_clk;
> +               cfg->pixel_clock =3D stream->phy_pix_clk;
>                 /* Round v_refresh*/
>                 cfg->v_refresh =3D stream->timing.pix_clk_100hz * 100;
>                 cfg->v_refresh /=3D stream->timing.h_total;
> diff --git a/drivers/gpu/drm/amd/display/dc/dm_services_types.h b/drivers=
/gpu/drm/amd/display/dc/dm_services_types.h
> index bf63da266a18..3b093b8699ab 100644
> --- a/drivers/gpu/drm/amd/display/dc/dm_services_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/dm_services_types.h
> @@ -127,7 +127,7 @@ struct dm_pp_single_disp_config {
>         uint32_t src_height;
>         uint32_t src_width;
>         uint32_t v_refresh;
> -       uint32_t sym_clock; /* HDMI only */
> +       uint32_t pixel_clock; /* Pixel clock in KHz (for HDMI only: norma=
lized) */

This one could probably stay sym_clock to avoid the extra churn, but
either way is fine with me.  Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


>         struct dc_link_settings link_settings; /* DP only */
>  };
>
> diff --git a/drivers/gpu/drm/amd/include/dm_pp_interface.h b/drivers/gpu/=
drm/amd/include/dm_pp_interface.h
> index acd1cef61b7c..349544504c93 100644
> --- a/drivers/gpu/drm/amd/include/dm_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/dm_pp_interface.h
> @@ -65,6 +65,7 @@ struct single_display_configuration {
>         uint32_t view_resolution_cy;
>         enum amd_pp_display_config_type displayconfigtype;
>         uint32_t vertical_refresh; /* for active display */
> +       uint32_t pixel_clock; /* Pixel clock in KHz (for HDMI only: norma=
lized) */
>  };
>
>  #define MAX_NUM_DISPLAY 32
> --
> 2.50.1
>
