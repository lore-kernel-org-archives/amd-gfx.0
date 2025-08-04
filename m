Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BF5C87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 15:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0278E10E5BB;
	Mon,  4 Aug 2025 15:58:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KxYh290d";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 968AA10E5AE
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 15:58:23 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-312a806f002so775895a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 08:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754323103; x=1754927903; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F/5tNMcW1T+Zopu6lk/4HohrXw52V/G/u7CsUzdl8XE=;
 b=KxYh290dnI7yQ7swk5dD2I2UDuX0hw64qZkjcVOphu+EfH6ZmSzPlDBecJ6ZixmeVk
 JtwKeveSkd+NcE8K7+27tf01qOaFbtpMtztLy/7FLmEZDJrENF6cVdtR2nOz8Y1Yjmse
 gh/cwN+Infgf+NHVkDQjLP2mL51dEERrx0X0MApfP4tAu2nykj7bp5bnr00urmbq7xwc
 Op8R9hWCW5zmqmox6N1u43VGp1N8p4D9oVJtK0fDNVPihqSVzqItyxAlumtyq/XFteKD
 vNz/ap6mxdBIQ4Zsp3+kZ0qPF/DC0ASnt0335Yx/oBCBIykjFY1sM+KmV/e6cH+dHl8T
 /P4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754323103; x=1754927903;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F/5tNMcW1T+Zopu6lk/4HohrXw52V/G/u7CsUzdl8XE=;
 b=nTNdUueHNA12XvcplciwCozOgjLF4uG+Hzkz0bg/02OoDCYzQiPKndYBRqR/xcp6tA
 GZDK5JnZ28nAvdNJRY2k8DbGjcH7tMwOdr9/5koREnA/RG6BkR64kCKJ6kXPMM3MjikH
 ZQTCsenb07fv43Ww28b2MT378ZKMpWCJwRAUW84xQ7K2eltOdvRkJplCfCZkif6agQdE
 Ul8+KrxlrWv5UwYRC1YrEC2RlerX2w0w7W7rGzAommFcv928NCKtFekqTRO3OkEYZ1Qc
 C5CoBiHdzsW5WRj0w4npdeQdU0m1bMZAVIguoK+8xD/+WMYf79M11t8KbWoL9F0QvhoH
 CsOw==
X-Gm-Message-State: AOJu0Yz8qwxOSJd+wR42U0Mp5u75fYgnzYrbo0L/7J2gSbmxVvPi1poW
 bNqoqUy2ovTrXJMmFp9OxqjYTqowKCXhY3LopitAxsX/NQtRasaBNVmzrhmvu1cMA5NP4zb8eWD
 pKQ7/UztXPRSejppmGZtjvHacVsE7QamTLCvd
X-Gm-Gg: ASbGnctR+Pi+6fctyoobAB7eMjgtkVUQrHvsWIPTib7oxWZX2kxnawxSheDygN4x+4Y
 YC6JpmXd7vChrcLGi+5gECwNq7UKK0CxBaJrAeziCHSeYoiYz27cCw5yLEIQuzHQax5brhWJb3f
 HDNbLQYrPXUtnbSIVGP48conYGNoe4VnGo7rcYrjW0GrnHRviUc/0x4/D6VN0O6hlaf5Se2u3A4
 Kjiq89KQ+PKw6oLj+k=
X-Google-Smtp-Source: AGHT+IGM997l86FPy5p9h+ZJbyVe2bkRQpsSJeHz31iT8vQbvA4OEmokWiOXXReRskP1jzmyyNpskfyAPURzcHSQ/Js=
X-Received: by 2002:a17:90a:d08:b0:321:3e03:e39f with SMTP id
 98e67ed59e1d1-3213e03e4a2mr1554383a91.6.1754323102845; Mon, 04 Aug 2025
 08:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250731094352.29528-1-timur.kristof@gmail.com>
 <20250731094352.29528-5-timur.kristof@gmail.com>
In-Reply-To: <20250731094352.29528-5-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 11:58:11 -0400
X-Gm-Features: Ac12FXzMUrA3PVYfInqg0GD8lnzSeYThLhQsdoKqPRvDSEVakVOq92WpCQ8J6GI
Message-ID: <CADnq5_OEogbpQnBM=agZymGNvN-RztkEG8mZ9XMTfD_x778YGw@mail.gmail.com>
Subject: Re: [PATCH 4/7] drm/amd/display: Fill display clock and vblank time
 in dce110_fill_display_configs
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Thu, Jul 31, 2025 at 5:53=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> Also needed by DCE 6.
> This way the code that gathers this info can be shared between
> different DCE versions and doesn't have to be repeated.
>
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c    |  2 --
>  .../drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c | 10 +++-------
>  .../drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c   |  2 --
>  3 files changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c =
b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> index 69e9540f553b..17a8b46b0818 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> @@ -386,8 +386,6 @@ static void dce_pplib_apply_display_requirements(
>  {
>         struct dm_pp_display_configuration *pp_display_cfg =3D &context->=
pp_display_cfg;
>
> -       pp_display_cfg->avail_mclk_switch_time_us =3D dce110_get_min_vbla=
nk_time_us(context);
> -
>         dce110_fill_display_configs(context, pp_display_cfg);
>
>         if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, si=
zeof(*pp_display_cfg)) !=3D  0)
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr=
.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
> index baeac8f1c04f..13cf415e38e5 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
> @@ -124,6 +124,9 @@ void dce110_fill_display_configs(
>         int j;
>         int num_cfgs =3D 0;
>
> +       pp_display_cfg->avail_mclk_switch_time_us =3D dce110_get_min_vbla=
nk_time_us(context);
> +       pp_display_cfg->disp_clk_khz =3D dc->clk_mgr->clks.dispclk_khz;
> +       pp_display_cfg->avail_mclk_switch_time_in_disp_active_us =3D 0;
>         pp_display_cfg->crtc_index =3D dc->res_pool->res_cap->num_timing_=
generator;
>
>         for (j =3D 0; j < context->stream_count; j++) {
> @@ -243,13 +246,6 @@ void dce11_pplib_apply_display_requirements(
>         pp_display_cfg->min_engine_clock_deep_sleep_khz
>                         =3D context->bw_ctx.bw.dce.sclk_deep_sleep_khz;
>
> -       pp_display_cfg->avail_mclk_switch_time_us =3D
> -                                               dce110_get_min_vblank_tim=
e_us(context);
> -       /* TODO: dce11.2*/
> -       pp_display_cfg->avail_mclk_switch_time_in_disp_active_us =3D 0;
> -
> -       pp_display_cfg->disp_clk_khz =3D dc->clk_mgr->clks.dispclk_khz;
> -
>         dce110_fill_display_configs(context, pp_display_cfg);
>
>         if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, si=
zeof(*pp_display_cfg)) !=3D  0)
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c=
 b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> index cfd7309f2c6a..7044b437fe9d 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> @@ -109,8 +109,6 @@ static void dce60_pplib_apply_display_requirements(
>  {
>         struct dm_pp_display_configuration *pp_display_cfg =3D &context->=
pp_display_cfg;
>
> -       pp_display_cfg->avail_mclk_switch_time_us =3D dce110_get_min_vbla=
nk_time_us(context);
> -
>         dce110_fill_display_configs(context, pp_display_cfg);
>
>         if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, si=
zeof(*pp_display_cfg)) !=3D  0)
> --
> 2.50.1
>
