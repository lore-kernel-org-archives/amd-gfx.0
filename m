Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF874C83F26
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jul 2025 13:50:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EBDD10E205;
	Tue, 29 Jul 2025 13:50:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nk7mtHYH";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EA0910E205
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jul 2025 13:50:30 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-31ec2ac984eso386412a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jul 2025 06:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753797030; x=1754401830; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VIrNRy6DeBW3pslqdwgiuUzHqIguwHRSzT+19GQ/fuE=;
 b=Nk7mtHYHUU8nJh5khU4OIfBE5/VLnXy1To2KvSoFNql8anhRPbXCj3OI9qi3iNChFn
 3LOvAKhIru+1z8dG05XoHdFmRC/xi8vhEAxWG+jq73Denzr43vmjReJtFYkDFrKGvKlK
 Eh8JuxSAW8CFvGxmfWzy/4Z/2arGTUwPxUfEQtHedD4nv0EqL4A0bI7y5iOeFySDVJpn
 ZNloAadIVlIbLfaMQPtG07YTraIaffxVWo0yHFXyTPFs0DgfPwz/4yfy37l6SKXH/oIN
 dFiKkBcKMHB2LyS6+Mw5vUbKgAWRwXeDA9Rqy4A1lLzCxxrq0kK7L7BqOsIella/wAky
 CMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753797030; x=1754401830;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VIrNRy6DeBW3pslqdwgiuUzHqIguwHRSzT+19GQ/fuE=;
 b=J8LvZdwr+xQvHTxbkpsh54uhVGE7HsSMwFYJkeLRvSiEtGKa0YDgYJv07rKomQIgoG
 oEXiqprlM+qovF/xBsUd+wP2uojfiy3OsX2/s1/w8x89EQMnXmMLexD3ceqXBt4rs7RK
 RKecWO0k2sATQqu4n9+xnyoleBFPzwgr2xkzy9TrOKVQ5kPEaSEQFeSpFoqpLaWTk89g
 IX7QwyiJ1soRl6j5D5IiHrCiaNDxX+Jo/nDFZKKMznty+Pck6fFUVUnpNAJ+lwcI5+Vx
 5U3xntzRkXc6bLP0x0o8s0sdn1QVtc2mBDI+lrK2AB0m0PXTQrxj5c5fA6ybGLKrsG12
 jJcg==
X-Gm-Message-State: AOJu0YxvdhhCKehD+3OkKEgztzQz21wf+HYxsL6uL5sTW7Z8w1P/ST2H
 YsXzO6U/G8FvmWAOAz9etv6Yklor1uJKBWclzW9SH2Yl0EDHpZjEftn3An8R3iBhVODKJaokhGi
 sGUCCqP8SGvwJtqB3MW9DgIbBs0CRXes=
X-Gm-Gg: ASbGnctIzNM2OYogRH1bIPwFcj1d3jEDXOYpeNyyHp2djNyEKAZjms5DoWrufsTQ03n
 EaA02bkl6oW5ey2NVOyW/i9IGoWvGexpcSpDvKu4ETtrMHRBmT1efXl2kzy5RTq79vY/IA5o/gd
 scfOi38S7oZNlAjc+vD1QBZ5kx9JyBNvNDhzEH0bWfsUjVS0llulgeBMHj1JH+ZTcnkx2cRrF4g
 o180b9K
X-Google-Smtp-Source: AGHT+IGDNy7Hl047ApT0fsCDEFC7hoLhQy5x59weXkOvDzuwisloH/xRRWvWLISqU1ptfDFGSK+REH21UCcrXnFamNQ=
X-Received: by 2002:a17:90b:1b51:b0:31f:24c2:16cb with SMTP id
 98e67ed59e1d1-31f24c21c2bmr2549533a91.6.1753797029441; Tue, 29 Jul 2025
 06:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250722155830.67401-1-timur.kristof@gmail.com>
 <20250722155830.67401-4-timur.kristof@gmail.com>
In-Reply-To: <20250722155830.67401-4-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Jul 2025 09:50:17 -0400
X-Gm-Features: Ac12FXyH3dxJqXiajde7r1T03eFSrJHKRJItyEmcxmSKqknzXXwsL5z032j7Scw
Message-ID: <CADnq5_PyD17b98yTv_2UhOyRz3pZUjP4X9BmGBq1wUcqQQ=t_Q@mail.gmail.com>
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

Applied patches 2 and 3.  Is 1 still needed with the other patch Alex menti=
oned?

Thanks!

Alex

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
