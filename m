Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7935DE94615
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 22:11:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 158BB10E485;
	Mon,  9 Feb 2026 22:11:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="e4PDM93O";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C37310E485
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 22:11:52 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso50177915e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Feb 2026 14:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770675111; x=1771279911; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4I9fREdne0NN3epoOUO+X++5woIMrln6VeUOryULEhE=;
 b=e4PDM93OvT17fhof2owTNZiIyo/FKs1NwlI1wlIge7f+FE7FQU2SgujrFcrVGiYQnE
 dv0H49OFsI2mt7BOXBaECN6+UiPQRhxdb0gbhCAdgx1VwEHVCe/K/zuiay50nrmW38nF
 0s/tZ66g03tlU0nISBsDK6DFNKZs32GQysVveRi2c7tC4wo5/WSjIPH7KsLGyKY0qc0p
 R2eocV4KVG6OhczoejkPd9ilKrzJrh40lqmZ9n8VToyCh8hYXm2ygB5akCZfIeI93giy
 ZxU3S6wUg4Ku6Jy43pQ9fPmvkd9trt0E/RE5bvRRAd5+Sawgpzyeb1+nR/qGj4MzAdhR
 nz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770675111; x=1771279911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4I9fREdne0NN3epoOUO+X++5woIMrln6VeUOryULEhE=;
 b=aERxj+WLLmalOwof9ueR2vo8udIMLCWv6m6aguRdMMrF8eTXwA+e4ZOpZRKSw8l/XT
 ni+I5QWM6vdd1rKIyE2Q3lIiil/hITycuwjQR6bRk5vnzadQvkLKMFbgp8l5EVTv4EBm
 fNr8p9znB9JLmUeNcbj4+yF0AuIOK+SmAzjxXotKPb8lPwUgFY77Ux7lpJU3VsiNzEjl
 z9eVLv1z+lmgdhANek36M5Cv+HeS7h3QsImFITLM1vZIRD9ppADUlQYn8V+8k/XRCakM
 fbQ2GNcAGk/4476ykbuw4kR0TS6KGboReztYZBKJgEDdQ2QwLyNBoI2maFBb0Q/9u62V
 Jpsw==
X-Gm-Message-State: AOJu0Yze4VNg3mH6YknotRBetK30Y+iwmk6I6/ewGQZ7dIq3h8/z4PoP
 5Cmt1tS49Muj7+2IpYVf53sUJ+QH9XD+Vqx/dNoHxoI+AgsQuSAZ33jhNZ6JPA==
X-Gm-Gg: AZuq6aIJzJrJvFkfNtV959jNftRYRE3oFJYsNRen+eY4V/e8ZGsQvuV1rVCw1uymptp
 o9BqC+q8yK8N3B0q7v8KkCxgj75+Dzu5EK595W56GaFwS2Js8ebqQyt37kGwrqs7ST/Oz03XeXR
 LjdMKB8qSn9W8AjgMlb7GYCAx/jL5Kr2dEnAkMCH2O98mz5KP8bzCIS1koZNpeghlMkb+zEuRMQ
 2e/fE143C3yy8CQfXxFRWjWgE4qOXikBplp3Cp7PnFJ5tMrDILYRg03gQ9CH3HyHWJQMXAD9V8h
 Mt+zg7erg0aGzp1AiN6fLKds8lXoHMFP5H75MNiWmpfF6BHJhNa9zeWVHZQEmNDcL8sOBhchEKo
 ev2rabe3U+Pldm8EdyKNBaMSreuiWLrxUm9EiAo2TwrDZ23h/xQ2nwWf36BD3PO1klVyPdvpfUq
 PMoon57FJJUH8eoRymOPD3v+DdK2KkdJtNBFWnbltPHk8MU292vccrZSdGiklr
X-Received: by 2002:a05:600c:3f12:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-483502291f5mr2555685e9.3.1770675110562; 
 Mon, 09 Feb 2026 14:11:50 -0800 (PST)
Received: from timur-hyperion.localnet (5E1BC3D9.dsl.pool.telekom.hu.
 [94.27.195.217]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5d8ebfsm28862545e9.2.2026.02.09.14.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 14:11:50 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Leo Li <sunpeng.li@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: Re: [PATCH 4/5] drm/amd/display: Handle DCE 6 in dce_clk_mgr.c
Date: Mon, 09 Feb 2026 23:11:49 +0100
Message-ID: <2869796.vuYhMxLoTh@timur-hyperion>
In-Reply-To: <a6038bb6-d180-49e2-b063-6a0135f13648@amd.com>
References: <20260118173150.19790-1-timur.kristof@gmail.com>
 <20260118173150.19790-5-timur.kristof@gmail.com>
 <a6038bb6-d180-49e2-b063-6a0135f13648@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Monday, February 9, 2026 6:21:38=E2=80=AFPM Central European Standard Ti=
me Alex=20
Hung wrote:
> Hi Timur,
>=20
> I just found this patch won't build unless that CONFIG_DRM_AMD_DC_SI is
> not set, or with the following change to Makefile. Can you check?

Hi Alex,

I didn't see any problem when I submitted the patch, but it's possible that=
 I=20
overlooked something. I will fix it in the second version.

Thanks,
Timur

>=20
> diff --git drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
> drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
> index 60021671b386..57d492b90986 100644
> --- drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
> +++ drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
> @@ -30,17 +30,6 @@ AMD_DAL_CLK_MGR =3D $(addprefix
> $(AMDDALPATH)/dc/clk_mgr/,$(CLK_MGR))
>   AMD_DISPLAY_FILES +=3D $(AMD_DAL_CLK_MGR)
>=20
>=20
> -ifdef CONFIG_DRM_AMD_DC_SI
> -########################################################################=
###
> #### -# DCE 60
> -########################################################################=
###
> #### -CLK_MGR_DCE60 =3D dce60_clk_mgr.o
> -
> -AMD_DAL_CLK_MGR_DCE60 =3D $(addprefix
> $(AMDDALPATH)/dc/clk_mgr/dce60/,$(CLK_MGR_DCE60))
> -
> -AMD_DISPLAY_FILES +=3D $(AMD_DAL_CLK_MGR_DCE60)
> -endif
> -
> =20
> #########################################################################=
##
> #### # DCE 100 and DCE8x
> =20
> #########################################################################=
##
> ####
> On 1/18/26 10:31, Timur Krist=C3=B3f wrote:
> > dce60_clk_mgr was basically identical to dce_clk_mgr other than
> > a few minor details. They can be all handled in the same file,
> > reducing duplicated code and easing the maintenance burden for
> > old DCE versions.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >   .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  12 +-
> >   .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |  64 ++++++--
> >   .../display/dc/clk_mgr/dce60/dce60_clk_mgr.c  | 142 ------------------
> >   .../display/dc/clk_mgr/dce60/dce60_clk_mgr.h  |  36 -----
> >   4 files changed, 52 insertions(+), 202 deletions(-)
> >   delete mode 100644
> >   drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c delete
> >   mode 100644
> >   drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.h>=20
> > diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> > b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c index
> > 15cf13ec5302..9206eb8b0365 100644
> > --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> > +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
> > @@ -34,7 +34,6 @@
> >=20
> >   #include "dce110/dce110_clk_mgr.h"
> >   #include "dce112/dce112_clk_mgr.h"
> >   #include "dce120/dce120_clk_mgr.h"
> >=20
> > -#include "dce60/dce60_clk_mgr.h"
> >=20
> >   #include "dcn10/rv1_clk_mgr.h"
> >   #include "dcn10/rv2_clk_mgr.h"
> >   #include "dcn20/dcn20_clk_mgr.h"
> >=20
> > @@ -150,16 +149,7 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context
> > *ctx, struct pp_smu_funcs *p>=20
> >   	switch (asic_id.chip_family) {
> >  =20
> >   #if defined(CONFIG_DRM_AMD_DC_SI)
> >=20
> > -	case FAMILY_SI: {
> > -		struct clk_mgr_internal *clk_mgr =3D=20
kzalloc(sizeof(*clk_mgr),
> > GFP_KERNEL); -
> > -		if (clk_mgr =3D=3D NULL) {
> > -			BREAK_TO_DEBUGGER();
> > -			return NULL;
> > -		}
> > -		dce60_clk_mgr_construct(ctx, clk_mgr);
> > -		return &clk_mgr->base;
> > -	}
> >=20
> > +	case FAMILY_SI:
> >   #endif
> >  =20
> >   	case FAMILY_CI:
> >   	case FAMILY_KV: {
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> > b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c index
> > 6131ede2db7a..d02d03c154b3 100644
> > --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> > +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> > @@ -62,6 +62,18 @@ static const struct clk_mgr_mask disp_clk_mask =3D {
> >=20
> >   		CLK_COMMON_MASK_SH_LIST_DCE_COMMON_BASE(_MASK)
> >  =20
> >   };
> >=20
> > +/* Max clock values for each state indexed by "enum clocks_state": */
> > +static const struct state_dependent_clocks dce60_max_clks_by_state[] =
=3D {
> > +/* ClocksStateInvalid - should not be used */
> > +{ .display_clk_khz =3D 0, .pixel_clk_khz =3D 0 },
> > +/* ClocksStateUltraLow - not expected to be used for DCE 6.0 */
> > +{ .display_clk_khz =3D 0, .pixel_clk_khz =3D 0 },
> > +/* ClocksStateLow */
> > +{ .display_clk_khz =3D 352000, .pixel_clk_khz =3D 330000},
> > +/* ClocksStateNominal */
> > +{ .display_clk_khz =3D 600000, .pixel_clk_khz =3D 400000 },
> > +/* ClocksStatePerformance */
> > +{ .display_clk_khz =3D 600000, .pixel_clk_khz =3D 400000 } };
> >=20
> >   /* Max clock values for each state indexed by "enum clocks_state": */
> >   static const struct state_dependent_clocks dce80_max_clks_by_state[] =
=3D {
> >=20
> > @@ -126,8 +138,25 @@ int dce_adjust_dp_ref_freq_for_ss(struct
> > clk_mgr_internal *clk_mgr_dce, int dp_r>=20
> >   	return dp_ref_clk_khz;
> >  =20
> >   }
> >=20
> > +static int dce60_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
> > +{
> > +	struct clk_mgr_internal *clk_mgr =3D=20
TO_CLK_MGR_INTERNAL(clk_mgr_base);
> > +	struct dc_context *ctx =3D clk_mgr_base->ctx;
> > +	int dp_ref_clk_khz =3D 0;
> > +
> > +	if (ASIC_REV_IS_TAHITI_P(ctx->asic_id.hw_internal_rev))
> > +		dp_ref_clk_khz =3D
> > ctx->dc_bios->fw_info.default_display_engine_pll_frequency; +	else
> > +		dp_ref_clk_khz =3D clk_mgr_base->clks.dispclk_khz;
> > +
> > +	return dce_adjust_dp_ref_freq_for_ss(clk_mgr, dp_ref_clk_khz);
> > +}
> > +
> >=20
> >   int dce_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
> >   {
> >=20
> > +	if (clk_mgr_base->ctx->dce_version <=3D DCE_VERSION_6_4)
> > +		return dce60_get_dp_ref_freq_khz(clk_mgr_base);
> > +
> >=20
> >   	struct clk_mgr_internal *clk_mgr =3D=20
TO_CLK_MGR_INTERNAL(clk_mgr_base);
> >   	int dprefclk_wdivider;
> >   	int dprefclk_src_sel;
> >=20
> > @@ -441,27 +470,37 @@ void dce_clk_mgr_construct(
> >=20
> >   	struct clk_mgr *base =3D &clk_mgr->base;
> >   	struct dm_pp_static_clock_info static_clk_info =3D {0};
> >=20
> > -	memcpy(clk_mgr->max_clks_by_state,
> > -		dce80_max_clks_by_state,
> > -		sizeof(dce80_max_clks_by_state));
> > +	if (ctx->dce_version <=3D DCE_VERSION_6_4)
> > +		memcpy(clk_mgr->max_clks_by_state,
> > +			dce60_max_clks_by_state,
> > +			sizeof(dce60_max_clks_by_state));
> > +	else
> > +		memcpy(clk_mgr->max_clks_by_state,
> > +			dce80_max_clks_by_state,
> > +			sizeof(dce80_max_clks_by_state));
> > +
> >=20
> >   	base->ctx =3D ctx;
> >   	base->funcs =3D &dce_funcs;
> >=20
> > -	clk_mgr->regs =3D &disp_clk_regs;
> > -	clk_mgr->clk_mgr_shift =3D &disp_clk_shift;
> > -	clk_mgr->clk_mgr_mask =3D &disp_clk_mask;
> > -	clk_mgr->dfs_bypass_disp_clk =3D 0;
> > +	if (ctx->dce_version >=3D DCE_VERSION_8_0) {
> > +		clk_mgr->regs =3D &disp_clk_regs;
> > +		clk_mgr->clk_mgr_shift =3D &disp_clk_shift;
> > +		clk_mgr->clk_mgr_mask =3D &disp_clk_mask;
> > +	}
> >=20
> > +	clk_mgr->dfs_bypass_disp_clk =3D 0;
> >=20
> >   	clk_mgr->dprefclk_ss_percentage =3D 0;
> >   	clk_mgr->dprefclk_ss_divider =3D 1000;
> >   	clk_mgr->ss_on_dprefclk =3D false;
> >=20
> > -	if (dm_pp_get_static_clocks(ctx, &static_clk_info))
> > -		clk_mgr->max_clks_state =3D=20
static_clk_info.max_clocks_state;
> > -	else
> > -		clk_mgr->max_clks_state =3D DM_PP_CLOCKS_STATE_NOMINAL;
> > -	clk_mgr->cur_min_clks_state =3D DM_PP_CLOCKS_STATE_INVALID;
> > +	if (ctx->dce_version >=3D DCE_VERSION_8_0) {
> > +		if (dm_pp_get_static_clocks(ctx, &static_clk_info))
> > +			clk_mgr->max_clks_state =3D=20
static_clk_info.max_clocks_state;
> > +		else
> > +			clk_mgr->max_clks_state =3D=20
DM_PP_CLOCKS_STATE_NOMINAL;
> > +		clk_mgr->cur_min_clks_state =3D=20
DM_PP_CLOCKS_STATE_INVALID;
> > +	}
> >=20
> >   	base->clks.max_supported_dispclk_khz =3D
> >   =09
> >   		clk_mgr-
>max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk
> >   		_khz;
> >=20
> > @@ -469,4 +508,3 @@ void dce_clk_mgr_construct(
> >=20
> >   	dce_clock_read_integrated_info(clk_mgr);
> >   	dce_clock_read_ss_info(clk_mgr);
> >  =20
> >   }
> >=20
> > -
> > diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr=
=2Ec
> > b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c deleted
> > file mode 100644
> > index 1fdf344efe1a..000000000000
> > --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
> > +++ /dev/null
> > @@ -1,142 +0,0 @@
> > -/*
> > - * Copyright 2020 Mauro Rossi <issor.oruam@gmail.com>
> > - *
> > - * Permission is hereby granted, free of charge, to any person obtaini=
ng
> > a
> > - * copy of this software and associated documentation files (the
> > "Software"), - * to deal in the Software without restriction, including
> > without limitation - * the rights to use, copy, modify, merge, publish,
> > distribute, sublicense, - * and/or sell copies of the Software, and to
> > permit persons to whom the - * Software is furnished to do so, subject =
to
> > the following conditions: - *
> > - * The above copyright notice and this permission notice shall be
> > included in - * all copies or substantial portions of the Software.
> > - *
> > - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > EXPRESS OR - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > MERCHANTABILITY, - * FITNESS FOR A PARTICULAR PURPOSE AND
> > NONINFRINGEMENT.  IN NO EVENT SHALL - * THE COPYRIGHT HOLDER(S) OR
> > AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR - * OTHER LIABILITY,
> > WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, - * ARISING FROM,
> > OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR - * OTHER
> > DEALINGS IN THE SOFTWARE.
> > - *
> > - * Authors: AMD
> > - *
> > - */
> > -
> > -
> > -#include "dccg.h"
> > -#include "clk_mgr_internal.h"
> > -#include "dce100/dce_clk_mgr.h"
> > -#include "dce110/dce110_clk_mgr.h"
> > -#include "dce60_clk_mgr.h"
> > -#include "reg_helper.h"
> > -#include "dmcu.h"
> > -#include "core_types.h"
> > -#include "dal_asic_id.h"
> > -
> > -/*
> > - * Currently the register shifts and masks in this file are used for
> > dce60
> > - * which has no DPREFCLK_CNTL register
> > - * TODO: remove this when DENTIST_DISPCLK_CNTL
> > - * is moved to dccg, where it belongs
> > - */
> > -#include "dce/dce_6_0_d.h"
> > -#include "dce/dce_6_0_sh_mask.h"
> > -
> > -/* Max clock values for each state indexed by "enum clocks_state": */
> > -static const struct state_dependent_clocks dce60_max_clks_by_state[] =
=3D {
> > -/* ClocksStateInvalid - should not be used */
> > -{ .display_clk_khz =3D 0, .pixel_clk_khz =3D 0 },
> > -/* ClocksStateUltraLow - not expected to be used for DCE 6.0 */
> > -{ .display_clk_khz =3D 0, .pixel_clk_khz =3D 0 },
> > -/* ClocksStateLow */
> > -{ .display_clk_khz =3D 352000, .pixel_clk_khz =3D 330000},
> > -/* ClocksStateNominal */
> > -{ .display_clk_khz =3D 600000, .pixel_clk_khz =3D 400000 },
> > -/* ClocksStatePerformance */
> > -{ .display_clk_khz =3D 600000, .pixel_clk_khz =3D 400000 } };
> > -
> > -static int dce60_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
> > -{
> > -	struct clk_mgr_internal *clk_mgr =3D=20
TO_CLK_MGR_INTERNAL(clk_mgr_base);
> > -	struct dc_context *ctx =3D clk_mgr_base->ctx;
> > -	int dp_ref_clk_khz =3D 0;
> > -
> > -	if (ASIC_REV_IS_TAHITI_P(ctx->asic_id.hw_internal_rev))
> > -		dp_ref_clk_khz =3D
> > ctx->dc_bios->fw_info.default_display_engine_pll_frequency; -	else
> > -		dp_ref_clk_khz =3D clk_mgr_base->clks.dispclk_khz;
> > -
> > -	return dce_adjust_dp_ref_freq_for_ss(clk_mgr, dp_ref_clk_khz);
> > -}
> > -
> > -static void dce60_pplib_apply_display_requirements(
> > -	struct dc *dc,
> > -	struct dc_state *context)
> > -{
> > -	struct dm_pp_display_configuration *pp_display_cfg =3D
> > &context->pp_display_cfg; -
> > -	dce110_fill_display_configs(context, pp_display_cfg);
> > -
> > -	if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg,
> > sizeof(*pp_display_cfg)) !=3D  0)
> > -		dm_pp_apply_display_requirements(dc->ctx,=20
pp_display_cfg);
> > -}
> > -
> > -static void dce60_update_clocks(struct clk_mgr *clk_mgr_base,
> > -			struct dc_state *context,
> > -			bool safe_to_lower)
> > -{
> > -	struct clk_mgr_internal *clk_mgr_dce =3D
> > TO_CLK_MGR_INTERNAL(clk_mgr_base);
> > -	struct dm_pp_power_level_change_request level_change_req;
> > -	const int max_disp_clk =3D
> > -		clk_mgr_dce-
>max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_
> > clk_khz; -	int patched_disp_clk =3D MIN(max_disp_clk,
> > context->bw_ctx.bw.dce.dispclk_khz); -
> > -	level_change_req.power_level =3D
> > dce_get_required_clocks_state(clk_mgr_base, context); -	/* get max=20
clock
> > state from PPLIB */
> > -	if ((level_change_req.power_level < clk_mgr_dce-
>cur_min_clks_state &&
> > safe_to_lower) -			||=20
level_change_req.power_level >
> > clk_mgr_dce->cur_min_clks_state) { -		if
> > (dm_pp_apply_power_level_change_request(clk_mgr_base->ctx,
> > &level_change_req)) -			clk_mgr_dce-
>cur_min_clks_state =3D
> > level_change_req.power_level; -	}
> > -
> > -	if (should_set_clock(safe_to_lower, patched_disp_clk,
> > clk_mgr_base->clks.dispclk_khz)) { -		patched_disp_clk =3D
> > dce_set_clock(clk_mgr_base, patched_disp_clk);
> > -		clk_mgr_base->clks.dispclk_khz =3D patched_disp_clk;
> > -	}
> > -	dce60_pplib_apply_display_requirements(clk_mgr_base->ctx->dc,=20
context);
> > -}
> > -
> > -
> > -
> > -
> > -
> > -
> > -
> > -
> > -static struct clk_mgr_funcs dce60_funcs =3D {
> > -	.get_dp_ref_clk_frequency =3D dce60_get_dp_ref_freq_khz,
> > -	.update_clocks =3D dce60_update_clocks
> > -};
> > -
> > -void dce60_clk_mgr_construct(
> > -		struct dc_context *ctx,
> > -		struct clk_mgr_internal *clk_mgr)
> > -{
> > -	struct clk_mgr *base =3D &clk_mgr->base;
> > -
> > -	dce_clk_mgr_construct(ctx, clk_mgr);
> > -
> > -	memcpy(clk_mgr->max_clks_by_state,
> > -		dce60_max_clks_by_state,
> > -		sizeof(dce60_max_clks_by_state));
> > -
> > -	clk_mgr->regs =3D NULL;
> > -	clk_mgr->clk_mgr_shift =3D NULL;
> > -	clk_mgr->clk_mgr_mask =3D NULL;
> > -	clk_mgr->base.funcs =3D &dce60_funcs;
> > -
> > -	base->clks.max_supported_dispclk_khz =3D
> > -		clk_mgr-
>max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_
> > khz; -}
> > -
> > diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr=
=2Eh
> > b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.h deleted
> > file mode 100644
> > index eca3e5168089..000000000000
> > --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.h
> > +++ /dev/null
> > @@ -1,36 +0,0 @@
> > -/*
> > - * Copyright 2020 Mauro Rossi <issor.oruam@gmail.com>
> > - *
> > - * Permission is hereby granted, free of charge, to any person obtaini=
ng
> > a
> > - * copy of this software and associated documentation files (the
> > "Software"), - * to deal in the Software without restriction, including
> > without limitation - * the rights to use, copy, modify, merge, publish,
> > distribute, sublicense, - * and/or sell copies of the Software, and to
> > permit persons to whom the - * Software is furnished to do so, subject =
to
> > the following conditions: - *
> > - * The above copyright notice and this permission notice shall be
> > included in - * all copies or substantial portions of the Software.
> > - *
> > - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > EXPRESS OR - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > MERCHANTABILITY, - * FITNESS FOR A PARTICULAR PURPOSE AND
> > NONINFRINGEMENT.  IN NO EVENT SHALL - * THE COPYRIGHT HOLDER(S) OR
> > AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR - * OTHER LIABILITY,
> > WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, - * ARISING FROM,
> > OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR - * OTHER
> > DEALINGS IN THE SOFTWARE.
> > - *
> > - * Authors: AMD
> > - *
> > - */
> > -
> > -
> > -#ifndef DAL_DC_DCE_DCE60_CLK_MGR_H_
> > -#define DAL_DC_DCE_DCE60_CLK_MGR_H_
> > -
> > -#include "dc.h"
> > -
> > -void dce60_clk_mgr_construct(
> > -		struct dc_context *ctx,
> > -		struct clk_mgr_internal *clk_mgr_dce);
> > -
> > -#endif /* DAL_DC_DCE_DCE60_CLK_MGR_H_ */




