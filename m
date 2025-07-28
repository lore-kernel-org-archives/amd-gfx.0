Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94255C83F26
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 18:16:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F377A10E56F;
	Mon, 28 Jul 2025 18:16:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FvOWQX4G";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7C6010E56D
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 18:16:17 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-31ebeb3882cso90019a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 11:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753726577; x=1754331377; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u3soBJPkZLZYCKkc3oDW7JQtTqI+od2koapW6qw8t1U=;
 b=FvOWQX4GAEkJc09VSjSbHIo1r5G60y2hqaYdEv95MeO+ZbBnSPJIfpwsP7tIYbp+Rv
 Ddun9+OkNeEMrL6n0x5CqQlTYXTZ67VN2mdnHp1wm8F8nLiqGHr+8zU3HIrxEYz652AO
 agjjbAWMIOccfnZhCgkyKxVJnLrHrp5/W+vpOel8BumFYVxZMw1roSslr2khhV7XMlXC
 +7lX4vnnhLRR+ifixJ5xX5A2iwfR/b/sp4BrZk44MPj+hTRttMjVfOPy8gp2XBzcWuJl
 +hhg/HIzYqC6UARjhorLWLhgC/95YILwmXO1so/PLliJl/4oncbmJz5IkQBhi0ZSNUoC
 pXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753726577; x=1754331377;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u3soBJPkZLZYCKkc3oDW7JQtTqI+od2koapW6qw8t1U=;
 b=CueCOFq8IVQ3xnyMujXIsgTfIjq2p8Bmgu+1UAyOYJJvSlI9/mAJm9VN38ocmwXVsY
 lLvwFHReL5ZGup0ybAmOWRPyGrUZsrdtgZ/GuVBF4K5KwmHmx9wjqWY5Md3VzJ61f4qP
 MLg6jNgzYiNuxOQvS40vFXoObNQemTgX0kuKOZ1iQUCeB3vr0PzEBIgIlvL6VJsc9o3d
 9nC+6KIu/cYMheTHCXV6GjtbFuGg8Ux1pekr3NDvqC7a4uous3taebXcqV0ufwh9uYmU
 V/TZ4pCTMqrA7dnCZfK4Fhwmm0Z0zTujFFfSu2Fuf6Xg5gEXr/yRvWXy3F+J8KP3oIBM
 wzPw==
X-Gm-Message-State: AOJu0YxchUDklb5kYJ0FFcD/SgQXEgWmN2TT7h6lXlmfhqxnDvh4TL9x
 vTL7Wab0Gv5bonOKHOhzgKhaarN9wdLnuNmaUAvSB5anqXEsEhnzi+dCdPjG0UQr71Y54oFyDWE
 VjGrJIjCXbTeCKYzkDWq8vtbnbLO1dxdyvg==
X-Gm-Gg: ASbGnctLCEeGqUhJc1xXYelOQnx4XCteqeOVGqrtL4YeTSBeKASxoi94lfn5+SIoXwX
 GgTWPeBFtUKTT5qLfh5UOFEp8gSqUr86Pdpng/Iw2HFV0O4per3Fl6vcQLDB2UV2R4XZO/ypOj3
 tIBvDRAoK8KulzDL/TTgBg1VEgFqHMcIOoi8R9zwJ9DgDxj7xn5bv9LrNMvzGhuw7/PcUnGmiR2
 j6WLbsw
X-Google-Smtp-Source: AGHT+IGJU5WYpTSLgOoAfIwyjK056Kon59+cUC2ARXZ9sJ7ojMYxiD2MGN5I0leZpxEbr9qN6vSBi6aE2Fnn3sA9dlU=
X-Received: by 2002:a17:90b:3a81:b0:312:e9d:3fff with SMTP id
 98e67ed59e1d1-31e778451b4mr6981447a91.1.1753726577109; Mon, 28 Jul 2025
 11:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250722155830.67401-1-timur.kristof@gmail.com>
 <20250722155830.67401-4-timur.kristof@gmail.com>
In-Reply-To: <20250722155830.67401-4-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Jul 2025 14:16:05 -0400
X-Gm-Features: Ac12FXwszss18KgOy_zmLIykcq1fiErYN-b5eK7pTDhLR4HrBu4klR25JSby7J0
Message-ID: <CADnq5_PVBr8oo4hoYQ7sC+NmBCNMeapX7a52_no-YoTohDqZBg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amd/display: Fix DCE 6.0 and 6.4 PLL programming.
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

On Tue, Jul 22, 2025 at 12:23=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@=
gmail.com> wrote:
>
> Apparently, both DCE 6.0 and 6.4 have 3 PLLs, but PLL0 can only
> be used for DP. Make sure to initialize the correct amount of PLLs
> in DC for these DCE versions and use PLL0 only for DP.
>
> Also, on DCE 6.0 and 6.4, the PLL0 needs to be powered on at
> initialization as opposed to DCE 6.1 and 7.x which use a different
> clock source for DFS.
>
> The following functions were used as reference from the old
> radeon driver implementation of DCE 6.x:
> - radeon_atom_pick_pll
> - atombios_crtc_set_disp_eng_pll
>
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |  5 +++
>  .../dc/resource/dce60/dce60_resource.c        | 34 +++++++++++--------
>  2 files changed, 25 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c =
b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> index 26feefbb8990..f5ad0a177038 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> @@ -245,6 +245,11 @@ int dce_set_clock(
>         pxl_clk_params.target_pixel_clock_100hz =3D requested_clk_khz * 1=
0;
>         pxl_clk_params.pll_id =3D CLOCK_SOURCE_ID_DFS;
>
> +       /* DCE 6.0, DCE 6.4: engine clock is the same as PLL0 */
> +       if (clk_mgr_base->ctx->dce_version =3D=3D DCE_VERSION_6_0 ||
> +           clk_mgr_base->ctx->dce_version =3D=3D DCE_VERSION_6_4)
> +               pxl_clk_params.pll_id =3D CLOCK_SOURCE_ID_PLL0;
> +
>         if (clk_mgr_dce->dfs_bypass_active)
>                 pxl_clk_params.flags.SET_DISPCLK_DFS_BYPASS =3D true;
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> index 58b59d52dc9d..53b60044653f 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> @@ -373,7 +373,7 @@ static const struct resource_caps res_cap =3D {
>                 .num_timing_generator =3D 6,
>                 .num_audio =3D 6,
>                 .num_stream_encoder =3D 6,
> -               .num_pll =3D 2,
> +               .num_pll =3D 3,
>                 .num_ddc =3D 6,
>  };
>
> @@ -389,7 +389,7 @@ static const struct resource_caps res_cap_64 =3D {
>                 .num_timing_generator =3D 2,
>                 .num_audio =3D 2,
>                 .num_stream_encoder =3D 2,
> -               .num_pll =3D 2,
> +               .num_pll =3D 3,
>                 .num_ddc =3D 2,
>  };
>
> @@ -973,21 +973,24 @@ static bool dce60_construct(
>
>         if (bp->fw_info_valid && bp->fw_info.external_clock_source_freque=
ncy_for_dp !=3D 0) {
>                 pool->base.dp_clock_source =3D
> -                               dce60_clock_source_create(ctx, bp, CLOCK_=
SOURCE_ID_EXTERNAL, NULL, true);
> +                       dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_I=
D_EXTERNAL, NULL, true);
>
> +               /* DCE 6.0 and 6.4: PLL0 can only be used with DP. Don't =
initialize it here. */
>                 pool->base.clock_sources[0] =3D
> -                               dce60_clock_source_create(ctx, bp, CLOCK_=
SOURCE_ID_PLL0, &clk_src_regs[0], false);
> +                       dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_I=
D_PLL1, &clk_src_regs[1], false);
>                 pool->base.clock_sources[1] =3D
> -                               dce60_clock_source_create(ctx, bp, CLOCK_=
SOURCE_ID_PLL1, &clk_src_regs[1], false);
> +                       dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_I=
D_PLL2, &clk_src_regs[2], false);
>                 pool->base.clk_src_count =3D 2;
>
>         } else {
>                 pool->base.dp_clock_source =3D
> -                               dce60_clock_source_create(ctx, bp, CLOCK_=
SOURCE_ID_PLL0, &clk_src_regs[0], true);
> +                       dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_I=
D_PLL0, &clk_src_regs[0], true);
>
>                 pool->base.clock_sources[0] =3D
> -                               dce60_clock_source_create(ctx, bp, CLOCK_=
SOURCE_ID_PLL1, &clk_src_regs[1], false);
> -               pool->base.clk_src_count =3D 1;
> +                       dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_I=
D_PLL1, &clk_src_regs[1], false);
> +               pool->base.clock_sources[1] =3D
> +                       dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_I=
D_PLL2, &clk_src_regs[2], false);
> +               pool->base.clk_src_count =3D 2;
>         }
>
>         if (pool->base.dp_clock_source =3D=3D NULL) {
> @@ -1365,21 +1368,24 @@ static bool dce64_construct(
>
>         if (bp->fw_info_valid && bp->fw_info.external_clock_source_freque=
ncy_for_dp !=3D 0) {
>                 pool->base.dp_clock_source =3D
> -                               dce60_clock_source_create(ctx, bp, CLOCK_=
SOURCE_ID_EXTERNAL, NULL, true);
> +                       dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_I=
D_EXTERNAL, NULL, true);
>
> +               /* DCE 6.0 and 6.4: PLL0 can only be used with DP. Don't =
initialize it here. */
>                 pool->base.clock_sources[0] =3D
> -                               dce60_clock_source_create(ctx, bp, CLOCK_=
SOURCE_ID_PLL1, &clk_src_regs[0], false);
> +                       dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_I=
D_PLL1, &clk_src_regs[1], false);
>                 pool->base.clock_sources[1] =3D
> -                               dce60_clock_source_create(ctx, bp, CLOCK_=
SOURCE_ID_PLL2, &clk_src_regs[1], false);
> +                       dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_I=
D_PLL2, &clk_src_regs[2], false);
>                 pool->base.clk_src_count =3D 2;
>
>         } else {
>                 pool->base.dp_clock_source =3D
> -                               dce60_clock_source_create(ctx, bp, CLOCK_=
SOURCE_ID_PLL1, &clk_src_regs[0], true);
> +                       dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_I=
D_PLL0, &clk_src_regs[0], true);
>
>                 pool->base.clock_sources[0] =3D
> -                               dce60_clock_source_create(ctx, bp, CLOCK_=
SOURCE_ID_PLL2, &clk_src_regs[1], false);
> -               pool->base.clk_src_count =3D 1;
> +                       dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_I=
D_PLL1, &clk_src_regs[1], false);
> +               pool->base.clock_sources[1] =3D
> +                       dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_I=
D_PLL2, &clk_src_regs[2], false);
> +               pool->base.clk_src_count =3D 2;
>         }
>
>         if (pool->base.dp_clock_source =3D=3D NULL) {
> --
> 2.50.1
>
