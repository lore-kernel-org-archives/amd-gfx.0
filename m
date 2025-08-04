Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA39C87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 15:49:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5691010E5CE;
	Mon,  4 Aug 2025 15:49:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JxIeDNSk";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A15E10E5CE
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 15:49:22 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-b350c85cf4eso516941a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 08:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754322562; x=1754927362; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aT5wB/k9jBizux6kZ0fKN9/+yqAlbpim0JWK8EXYXwQ=;
 b=JxIeDNSk+Me+b4jNJBeaQI/xjEIB9hpdbC+95X/dgYd2Q7l9zMqiRVpXtSw1ytzQKK
 i4kFSDCzUTsNh3N6Ezl0Yi+ZwfHo5EW/xPbhqcjOQ/Jflo1jPTMDXVNB0eNlDtkWgjoT
 1sB84YOaaf8ZfYm/6T5L+U6tYZgPo4NbQ3kpVgCu4Zr6ee8bwZFXbWdlAQfo1RME85PO
 sZxX3eIdXYlBqiiq2QCuwi1LbbPPSNEQcy7MTkDtFCEawu6khYxGYRocTR/XORIdQaYC
 wcC7JtbUDv7bkz777EN2NXncIkvefipBFzOtgMXnwp0IZgHuasJvchQxgR+B9yOF5Gox
 8AGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754322562; x=1754927362;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aT5wB/k9jBizux6kZ0fKN9/+yqAlbpim0JWK8EXYXwQ=;
 b=dUKsDWux7TKDH9z44IkAksygBkxSvnQruY5Um1XhT7y6bijF/1kai39vgEZj06A3NP
 DcKv0/DNYCfCwux9XjkSEr4qXZ1p4pxjGyTc7M00MQ5Y2OvVvK1HpOQ0+KwU/SXswQnn
 2NNTab7YoDNXieHLVyBCIWKVGv0srX1GaPLRwOhmpdQCeuJhcbUI3DtQjbnBlS5mlCLR
 Nx9eDPoDJIVNSG1HjlfYOm4NFkM060bBxk8jfGsHmh5vR23IR+Ut+dAWOiPDFcWY5VTX
 3Ak4sMMgOzD9XSv35NlfXkFM/C5xteAeFVhTqICf9qcAwhq6SNGUkoLX+0+vUlku4N4a
 H8vQ==
X-Gm-Message-State: AOJu0YxH2j8s2qNSgS3jhU+Q4UZb/uM5OHPKmNO9Toj48x6M5HFOt9z3
 8M9sncK4KqegX8sHYQEnGdM8MCgIBzzWEgNzjipsWfoo5vT9AKvVSa0W0zTKj2J/GKCTZn/p0fV
 /DR6LADCmQuR8o6mtMesrdACh5uUTPuQ=
X-Gm-Gg: ASbGncvwv+vM+aQpsmumRrbo/OdIIC9C+1sXKhUjFlhDxLFiFcQO/EBW9CWRk7MNNxm
 nzt4J43SQRRhklw6k9qlIk53oo+yhY+wsrT77Yv0i8MRv2Utd5FodL5/ZRH5ACC0Y+mVYDA4guV
 dfQwfWTAfsnZcXe/WnE01pyNzGcJX9WCafXisgWe1MuqiEdtREkBpolO6PID2mUNAIwDkWDUqia
 nnfGQK2
X-Google-Smtp-Source: AGHT+IFBE0kKX8yUZ1AdiL1OG/FlXksJuce8ERTwrCccvffaK3JT8AXS+g20nLSMe1U2gtHyAKu+vuoxGEokP+UnFkQ=
X-Received: by 2002:a17:90a:d08:b0:321:3e03:e39f with SMTP id
 98e67ed59e1d1-3213e03e4a2mr1542136a91.6.1754322561828; Mon, 04 Aug 2025
 08:49:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250802155153.6432-1-timur.kristof@gmail.com>
In-Reply-To: <20250802155153.6432-1-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 11:49:10 -0400
X-Gm-Features: Ac12FXw7vin4XiFZ6SMUNikezuOlLak7w1Vuw-1fdEx2llJ4m15DBZDvaOBG4qM
Message-ID: <CADnq5_PGreVkq75ph1VwTwWt+VydCUnc6ZLB8pcii4pZL489sg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix DP audio DTO1 clock source on DCE 6.
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Leo (Sunpeng) Li" <Sunpeng.Li@amd.com>
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

On Sat, Aug 2, 2025 at 11:58=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> On DCE 6, DP audio was not working. However, it worked when an
> HDMI monitor was also plugged in.
>
> Looking at dce_aud_wall_dto_setup it seems that the main
> difference is that we use DTO1 when only DP is plugged in.
>
> When programming DTO1, it uses audio_dto_source_clock_in_khz
> which is set from get_dp_ref_freq_khz
>
> The dce60_get_dp_ref_freq_khz implementation looks incorrect,
> because DENTIST_DISPCLK_CNTL seems to be always zero on DCE 6,
> so it isn't usable.
> I compared dce60_get_dp_ref_freq_khz to the legacy display code,
> specifically dce_v6_0_audio_set_dto, and it turns out that in
> case of DCE 6, it needs to use the display clock. With that,
> DP audio started working on Pitcairn, Oland and Cape Verde.
>
> However, it still didn't work on Tahiti. Despite having the
> same DCE version, Tahiti seems to have a different audio device.
> After some trial and error I realized that it works with the
> default display clock as reported by the VBIOS, not the current
> display clock.
>

This looks good to me, but it would be good to get an ack from Harry or Leo=
.
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> The patch was tested on all four SI GPUs:
>
> * Pitcairn (DCE 6.0)
> * Oland (DCE 6.4)
> * Cape Verde (DCE 6.0)
> * Tahiti (DCE 6.0 but different)
>
> The testing was done on Samsung Odyssey G7 LS28BG700EPXEN on
> each of the above GPUs, at the following settings:
>
> * 4K 60 Hz
> * 1080p 60 Hz
> * 1080p 144 Hz
>
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> ---
>  .../display/dc/clk_mgr/dce60/dce60_clk_mgr.c  | 21 ++++++-------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c=
 b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> index 0267644717b2..883591706db9 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> @@ -83,22 +83,13 @@ static const struct state_dependent_clocks dce60_max_=
clks_by_state[] =3D {
>  static int dce60_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
>  {
>         struct clk_mgr_internal *clk_mgr =3D TO_CLK_MGR_INTERNAL(clk_mgr_=
base);
> -       int dprefclk_wdivider;
> -       int dp_ref_clk_khz;
> -       int target_div;
> +       struct dc_context *ctx =3D clk_mgr_base->ctx;
> +       int dp_ref_clk_khz =3D 0;
>
> -       /* DCE6 has no DPREFCLK_CNTL to read DP Reference Clock source */
> -
> -       /* Read the mmDENTIST_DISPCLK_CNTL to get the currently
> -        * programmed DID DENTIST_DPREFCLK_WDIVIDER*/
> -       REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DPREFCLK_WDIVIDER, &dprefcl=
k_wdivider);
> -
> -       /* Convert DENTIST_DPREFCLK_WDIVIDERto actual divider*/
> -       target_div =3D dentist_get_divider_from_did(dprefclk_wdivider);
> -
> -       /* Calculate the current DFS clock, in kHz.*/
> -       dp_ref_clk_khz =3D (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
> -               * clk_mgr->base.dentist_vco_freq_khz) / target_div;
> +       if (ASIC_REV_IS_TAHITI_P(ctx->asic_id.hw_internal_rev))
> +               dp_ref_clk_khz =3D ctx->dc_bios->fw_info.default_display_=
engine_pll_frequency;
> +       else
> +               dp_ref_clk_khz =3D clk_mgr_base->clks.dispclk_khz;
>
>         return dce_adjust_dp_ref_freq_for_ss(clk_mgr, dp_ref_clk_khz);
>  }
> --
> 2.50.1
>
