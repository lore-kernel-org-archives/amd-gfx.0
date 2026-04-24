Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECA5FED3F0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2026 16:28:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A017110E402;
	Fri, 24 Apr 2026 16:28:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A50wq11k";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC12C10E402
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 16:28:53 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso83878545e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 09:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777048132; x=1777652932; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8O6I+hq683VBQwlRSKnFzEs1zN65e2/VVYAazZL5GNk=;
 b=A50wq11k3AffLypQvPXxcQY9jmOaEJsWgJtM0cWq/QOCAXElW86psGDCrwimPdoOGq
 jctArgNMfy+7xi6D2domOxc1XP7yfbbDt7KyTk8wupDBYyMi8pDt1PL7VLr38myZTKfn
 PeklOMKG+vZ6JK3LSHpiLOrvTXAwSKZV0iNC7+OoldQat2ephemgU4Cxpo7DxpumMkse
 nUVb5LfSGOVHrJlysorACm/djHX4B/mC5mZWHCtr6IiHlmSve1fr7jpno8Cn+ObeJMHs
 aI8sYdGX3uQzxAc8c/Acx7yaQ9tTNpjOUILjbIUVAMrm9eUbOLFWPM+Ghi8lKdqMercs
 Debw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777048132; x=1777652932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8O6I+hq683VBQwlRSKnFzEs1zN65e2/VVYAazZL5GNk=;
 b=EuI20HvJNYq8g95aiwfREB8tn9n62wvUBPa6udj5eBnaeY8uFsJ5OcwEFoZRRuezjN
 avQbbime4S/CO+m83dV8EFwVIvB0DNOXdKPkROtdP+ivhl77EDqnarAYkXUM5kk1p6/o
 QcDENA8gjXMWeTgYevgBpaIqwVi8Sue9mL+xq9AHKTuOiZeC4k13CdIQtPH8OxdTR4ki
 lDPFqCevK9CzEBFsWURy0i142aRFOa+9RnwaUQae3y6xGVp3wPUOW5PvmIaWys9GyHUo
 s9IAWRRq+44GGu5ikNCgpE//HiFAICVt7nKtbGTgGyPJD2BgcsnlOUHijWNPmBxGl7PV
 gkAg==
X-Gm-Message-State: AOJu0Yw2zdAoCyhDkXMOXWevNP4eeLZtapKwqUKO0vs/49WB58oqbUgX
 VGBkhlc6EWQWkWyX+qEMqhLza3COUXJYIp9zqnBeE2F38wSdOjZKRbbaP05uQ1IF
X-Gm-Gg: AeBDietJAtoJXwTJYRtsjzSVQz/j+G/IFnsdYGc1nptbJyRU5ljFXul6RMOOEjlRpb6
 TSHh6E2rECpvrmHb5qgOBEOOVVmiaiQGd5hm4OSa5a9Q66I0X+eF19IaHOI8h2CbGK7OWe+4EVO
 kqoGYiw28Y5L+RFFXeUiRP36aNo9xYvbuVYZVijmyQQMqDbhshMSsBMwQZAi8lG21rkdxF8l/Se
 ozeORbsfzIE410ezlSv/TZJrMqOeuEoiIy/czDNQJ4JbjifTsBkWHBnfeqHIbbFV1ORsXlvfV1I
 7yeBZP4jbIcYKHGYIwlu2nfG9dkhdQlCsS7ApjWkKGHW5Hk/Ez85Nm04qHkPj2RrEUObAc61sHt
 bs6rX274IabjdHtmLKTGMupCaDBega2QFU14vBdjaA6BJjziy2/WNVexWX9IOmhNbdOGJgxJgyL
 ZIzUHd0G+nwJgeVjUKROsnWWpM/3vDdwRxbi1NOmeBBRXF7HqsJjYGL6w3BdWW8zzoo0iLNbe0J
 lyNtsfVwA==
X-Received: by 2002:a05:600c:3483:b0:488:af7f:775f with SMTP id
 5b1f17b1804b1-488fb77d343mr448046555e9.18.1777048132201; 
 Fri, 24 Apr 2026 09:28:52 -0700 (PDT)
Received: from timur-hyperion.localnet (5401DFC2.dsl.pool.telekom.hu.
 [84.1.223.194]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f82bbsm1025761145e9.3.2026.04.24.09.28.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 09:28:51 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Melissa Wen <mwen@igalia.com>
Subject: Re: [PATCH 03/14] drm/amd/display: Remove min/max clock levels from
 clk_mgr
Date: Fri, 24 Apr 2026 18:28:50 +0200
Message-ID: <3592022.LZWGnKmheA@timur-hyperion>
In-Reply-To: <5132be76-3565-4b4d-8703-8fa49e652ea0@igalia.com>
References: <20260423191519.73127-1-timur.kristof@gmail.com>
 <20260423191519.73127-4-timur.kristof@gmail.com>
 <5132be76-3565-4b4d-8703-8fa49e652ea0@igalia.com>
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

On Friday, April 24, 2026 4:21:54=E2=80=AFPM Central European Summer Time M=
elissa Wen=20
wrote:
> On 23/04/2026 16:15, Timur Krist=C3=B3f wrote:
> > These fields are not used by anything anymore.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f<timur.kristof@gmail.com>
> > ---
> >=20
> >   .../amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c   | 14 --------------
> >   .../display/dc/clk_mgr/dce112/dce112_clk_mgr.c    | 15 ---------------
> >   .../drm/amd/display/dc/inc/hw/clk_mgr_internal.h  |  2 --
> >   3 files changed, 31 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> > b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c index
> > 988eb6f841f54..2ba341df7fffd 100644
> > --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> > +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> > @@ -257,11 +257,6 @@ int dce_set_clock(
> >=20
> >   		actual_clock =3D=20
pxl_clk_params.dfs_bypass_display_clock;
> >   =09
> >   	}
> >=20
> > -	/* from power down, we need mark the clock state as=20
ClocksStateNominal
> > -	 * from HWReset, so when resume we will call pplib voltage=20
regulator.*/
> > -	if (requested_clk_khz =3D=3D 0)
> > -		clk_mgr_dce->cur_min_clks_state =3D=20
DM_PP_CLOCKS_STATE_NOMINAL;
> > -
> >=20
> >   	if (dmcu && dmcu->funcs->is_dmcu_initialized(dmcu))
> >   =09
> >   		dmcu->funcs->set_psr_wait_loop(dmcu, actual_clock /=20
1000 / 7);
> >=20
> > @@ -425,7 +420,6 @@ void dce_clk_mgr_construct(
> >=20
> >   		struct clk_mgr_internal *clk_mgr)
> >  =20
> >   {
> >  =20
> >   	struct clk_mgr *base =3D &clk_mgr->base;
> >=20
> > -	struct dm_pp_static_clock_info static_clk_info =3D {0};
> >=20
> >   	if (ctx->dce_version <=3D DCE_VERSION_6_4)
> >   =09
> >   		memcpy(clk_mgr->max_clks_by_state,
> >=20
> > @@ -451,14 +445,6 @@ void dce_clk_mgr_construct(
> >=20
> >   	clk_mgr->dprefclk_ss_divider =3D 1000;
> >   	clk_mgr->ss_on_dprefclk =3D false;
> >=20
> > -	if (ctx->dce_version >=3D DCE_VERSION_8_0) {
> > -		if (dm_pp_get_static_clocks(ctx, &static_clk_info))
>=20
> and `dm_pp_get_static_clocks` becomes unused, right?

Looks like nothing else is using dm_pp_get_static_clocks() so that can be=20
deleted as well. I can do that in a follow-up series if that's OK.

>=20
> > -			clk_mgr->max_clks_state =3D=20
static_clk_info.max_clocks_state;
> > -		else
> > -			clk_mgr->max_clks_state =3D=20
DM_PP_CLOCKS_STATE_NOMINAL;
> > -		clk_mgr->cur_min_clks_state =3D=20
DM_PP_CLOCKS_STATE_INVALID;
> > -	}
> > -
> >=20
> >   	base->clks.max_supported_dispclk_khz =3D
> >   =09
> >   		clk_mgr-
>max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk
> >   		_khz;
> >=20
> > diff --git
> > a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
> > b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c index
> > 48393c69735b6..0f3f8df4df96a 100644
> > --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
> > +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
> > @@ -89,13 +89,6 @@ int dce112_set_clock(struct clk_mgr *clk_mgr_base, i=
nt
> > requested_clk_khz)>=20
> >   	bp->funcs->set_dce_clock(bp, &dce_clk_params);
> >   	actual_clock =3D dce_clk_params.target_clock_frequency;
> >=20
> > -	/*
> > -	 * from power down, we need mark the clock state as=20
ClocksStateNominal
> > -	 * from HWReset, so when resume we will call pplib voltage=20
regulator.
> > -	 */
> > -	if (requested_clk_khz =3D=3D 0)
> > -		clk_mgr_dce->cur_min_clks_state =3D=20
DM_PP_CLOCKS_STATE_NOMINAL;
> > -
> >=20
> >   	/*Program DP ref Clock*/
> >   	/*VBIOS will determine DPREFCLK frequency, so we don't set it*/
> >   	dce_clk_params.target_clock_frequency =3D 0;
> >=20
> > @@ -143,14 +136,6 @@ int dce112_set_dispclk(struct clk_mgr_internal
> > *clk_mgr, int requested_clk_khz)>=20
> >   	bp->funcs->set_dce_clock(bp, &dce_clk_params);
> >   	actual_clock =3D dce_clk_params.target_clock_frequency;
> >=20
> > -	/*
> > -	 * from power down, we need mark the clock state as=20
ClocksStateNominal
> > -	 * from HWReset, so when resume we will call pplib voltage=20
regulator.
> > -	 */
> > -	if (requested_clk_khz =3D=3D 0)
> > -		clk_mgr->cur_min_clks_state =3D=20
DM_PP_CLOCKS_STATE_NOMINAL;
> > -
> > -
> >=20
> >   	if (dmcu && dmcu->funcs->is_dmcu_initialized(dmcu)) {
> >   =09
> >   		if (clk_mgr->dfs_bypass_disp_clk !=3D actual_clock)
> >   	=09
> >   			dmcu->funcs->set_psr_wait_loop(dmcu,
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
> > b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h index
> > c69ccfcebeb5a..e01bf6bd7f3f4 100644
> > --- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
> > +++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
> > @@ -477,8 +477,6 @@ struct clk_mgr_internal {
> >=20
> >   	 */
> >   =09
> >   	int dprefclk_ss_divider;
> >=20
> > -	enum dm_pp_clocks_state max_clks_state;
> > -	enum dm_pp_clocks_state cur_min_clks_state;
> >=20
> >   	bool periodic_retraining_disabled;
> >   =09
> >   	unsigned int cur_phyclk_req_table[MAX_LINKS];




