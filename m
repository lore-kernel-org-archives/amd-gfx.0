Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A44CC87FDA
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 15:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDD1410E5AB;
	Mon,  4 Aug 2025 15:56:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IvSV0dv7";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9580D10E59D
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 15:56:12 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2400145aa5aso5654115ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 08:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754322972; x=1754927772; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xUeY7TMt0SIlktdPFySbmCJ9yggMND+vUXM/tjsc9BI=;
 b=IvSV0dv7UhBYyJngWJ3oB+xcXk9lQafoYMRKgHkKgfpSbOV1LwjsoGXW5NPesXLIim
 CaNmx0b2FA6u89sPYYrqWMYD83qVJEyMKkCGLkl9vFOnzS0EhYy9AFmqHIJ7kXMTRm6e
 YXmUSEJT1+0DzJl2b9inlOQ45FemHZieaOwXENJ6Uo4KeMs9JQzZCcF7Ow7QGlFp2LP8
 7NQAY8JpLRvMsQnubM79HYHqKOiJnieJ4rIlESR9s9GweCSeTwpWGnerVvXaBF67HxdJ
 6LqmxyuNwlXxIUBvK6mNjghdj2po1VaS7qjW2ysTE5nDqDvaaFLLSNCJ13I9k+aKmwOi
 qusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754322972; x=1754927772;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xUeY7TMt0SIlktdPFySbmCJ9yggMND+vUXM/tjsc9BI=;
 b=BhLi5Tcv4QDIkFPW1Zm9cnREH/SHPm5vz2hlo+QbH2hhASxaHAc24GfbD1ydOILdtv
 xSs6qJ2Y09h7H2ZcUhcTh1IrLLTjOphPKR0tmeb7ghrMPijB3Ad8pD3Mmiq2FZ9MLI05
 eYTYFjkxqAyT5Il5GdmW8iTjIk15W9ue0aLdPCnezWgCuM6LO82puGFib3VCHeGqQ8mw
 jaVLGtkzZ0JBcdL3T0yyI20Wek+p5leEECGVEBxZSaYiNNsHpYgZgUz72jm3GjzCDfvU
 0e99FpaDU22TizYPI+7/a2RjSAgNaU8Ic4Bv9lc7oRO85XdDFs1e5MtICZqj2lVZ8Zb/
 vNYQ==
X-Gm-Message-State: AOJu0Yy0JZJheGdYqNHZ97LM1ujMJui6JijNjiI2KrxPrwl55PQffkQq
 YPOHFqBvOAUFc5/Xs7AvVmyyZ43Uvq0Ty3eO43Q3pxraQGjYGmrQhPk8T9UuZ3uzy7hZxrk7vqw
 wMBO0KHQGHaKOeHSz5C5QYC78kuABZ6DqpUNq
X-Gm-Gg: ASbGncvV00JQ8IJtGeMIEjuiXP8enTdv4GcZrtY9eJfr6MjpD93fVqCNfuPo9H+9DaL
 7r+0Q1zQCJ0XrMmkCvBug3dKTJ5hmuEHl8sgELMvhKvb4qamaGknkFDfUt2Yn7Wp/clz7fnts5w
 QaqASNRuLGEQQVuJniSPNqKvL2WoJEwnGRfNKvYybZrYhJmQxHU/ahlbrETI77LXNKH+Bt60Nsr
 qu7MRPg
X-Google-Smtp-Source: AGHT+IFqfa60i6cT3g+Lb4Z/hQxafBKXpvEwiGc6xLdarZewCrN71ss41+Hd2buT1PxpqXgXYwzLW5ADchuragcRdgw=
X-Received: by 2002:a17:902:e543:b0:240:9ab5:4cae with SMTP id
 d9443c01a7336-24246f2cbc1mr58966715ad.1.1754322971923; Mon, 04 Aug 2025
 08:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250731094352.29528-1-timur.kristof@gmail.com>
 <20250731094352.29528-3-timur.kristof@gmail.com>
In-Reply-To: <20250731094352.29528-3-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 11:56:00 -0400
X-Gm-Features: Ac12FXydnVUXBYQZ7qdB3WH4uncLkLgqo3Rre_YpFpwWnKceh5IyIXDTOvrvHHg
Message-ID: <CADnq5_OAOrZETWPBzUjGJigJxXRsK=nBPjY+-j3ZE+skXr4vfw@mail.gmail.com>
Subject: Re: [PATCH 2/7] drm/amd/display: Adjust DCE 8-10 clock, don't
 overclock by 15%
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

On Thu, Jul 31, 2025 at 5:58=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> Adjust the nominal (and performance) clocks for DCE 8-10,
> and set them to 625 MHz, which is the value used by the legacy
> display code in amdgpu_atombios_get_clock_info.
>
> This was tested with Hawaii, Tonga and Fiji.
> These GPUs can output 4K 60Hz (10-bit depth) at 625 MHz.
>
> The extra 15% clock was added as a workaround for a Polaris issue
> which uses DCE 11, and should not have been used on DCE 8-10 which
> are already hardcoded to the highest possible display clock.
> Unfortunately, the extra 15% was mistakenly copied and kept
> even on code paths which don't affect Polaris.
>
> This commit fixes that and also adds a check to make sure
> not to exceed the maximum DCE 8-10 display clock.
>
> Fixes: 8cd61c313d8b ("drm/amd/display: Raise dispclk value for Polaris")
> Fixes: dc88b4a684d2 ("drm/amd/display: make clk mgr soc specific")
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
>
> x

Stray x here.  with that fixed:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c  | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c =
b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> index 26feefbb8990..69e9540f553b 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> @@ -72,9 +72,9 @@ static const struct state_dependent_clocks dce80_max_cl=
ks_by_state[] =3D {
>  /* ClocksStateLow */
>  { .display_clk_khz =3D 352000, .pixel_clk_khz =3D 330000},
>  /* ClocksStateNominal */
> -{ .display_clk_khz =3D 600000, .pixel_clk_khz =3D 400000 },
> +{ .display_clk_khz =3D 625000, .pixel_clk_khz =3D 400000 },
>  /* ClocksStatePerformance */
> -{ .display_clk_khz =3D 600000, .pixel_clk_khz =3D 400000 } };
> +{ .display_clk_khz =3D 625000, .pixel_clk_khz =3D 400000 } };
>
>  int dentist_get_divider_from_did(int did)
>  {
> @@ -400,11 +400,9 @@ static void dce_update_clocks(struct clk_mgr *clk_mg=
r_base,
>  {
>         struct clk_mgr_internal *clk_mgr_dce =3D TO_CLK_MGR_INTERNAL(clk_=
mgr_base);
>         struct dm_pp_power_level_change_request level_change_req;
> -       int patched_disp_clk =3D context->bw_ctx.bw.dce.dispclk_khz;
> -
> -       /*TODO: W/A for dal3 linux, investigate why this works */
> -       if (!clk_mgr_dce->dfs_bypass_active)
> -               patched_disp_clk =3D patched_disp_clk * 115 / 100;
> +       const int max_disp_clk =3D
> +               clk_mgr_dce->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORM=
ANCE].display_clk_khz;
> +       int patched_disp_clk =3D MIN(max_disp_clk, context->bw_ctx.bw.dce=
.dispclk_khz);
>
>         level_change_req.power_level =3D dce_get_required_clocks_state(cl=
k_mgr_base, context);
>         /* get max clock state from PPLIB */
> --
> 2.50.1
>
