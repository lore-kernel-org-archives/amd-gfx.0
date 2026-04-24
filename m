Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F741FED3F0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2026 16:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96C2310E3FA;
	Fri, 24 Apr 2026 16:27:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bLBzMWAd";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BC6B10E3FA
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 16:27:11 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-48374014a77so104800095e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 09:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777048029; x=1777652829; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yR+mtEfyzliPLJndrPOIrm/+S1aiF9OJ+x6n/cx4IZs=;
 b=bLBzMWAdAqc1qxdpgyn279yZmb/FKCx7hkBFFmmZv3nrqi4ncGMACq+dWtYky2bCUv
 shLXUOUumoA1Nj1uPSSYrrL4b0u9RTldrMB5XxeCeYuOBG7TqmtyKpZkt/sS2veeM9QM
 pOUs9FVGwNxtfJCCa7exY9/NRRzWqxSFGrCNserWcgETs4f8QPgAHIRz8nkzMV3dfwB6
 7c3CgnOmChLRt6N+9Zh8ZpfFK0yzMp+kqzZG+8Cv3aIxDui+FY1VXEFAoJVJ29VMv444
 /5Y5nEh6qnu3MVueRaj7k0JfJDMkrUND9Mu6JzK08M8AliPT3Pz2U3/vaji+uJlzzrM5
 grsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777048029; x=1777652829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yR+mtEfyzliPLJndrPOIrm/+S1aiF9OJ+x6n/cx4IZs=;
 b=ssSe+csb713zmWjnGeAhKGZEJK+zIoWK8EdLd/InHfwNhkIty6CBzGZ9LWVdxKtlJt
 ZUNlewIguHhV4vQb2L922iInTP4pZQnWNCtyOW2fTB+cVSI/SveaJbNUIm40eWKt2NBF
 8wlVom2XKA7y5aNkuQwFVy6TQSFp5q/pSXNzEj11FW7e1cFRZAjNHs+xXzEv584oE7LW
 saCTTqes2QjJHtDUfvZtV1s40xOBIxeQCIwWlyAC450RWbCnOUioLN57KD4cltJSuxu9
 DL7XtY3MMsITwSwZqjhmPpx9WYMSx1wJSNQJkqFbZixnj4nZrxy7IH6MHIES4PALozoE
 5AFA==
X-Gm-Message-State: AOJu0Yz19zTRvGC82iTdlkEAhfnX3QcAs3tnE69ZR6nJ95uWkMcvshwM
 vlk5+ecFzNrRLG6ochJpJVB7FZETr+BjoE7v4YQOtWRDzG6Bm8aredQyOeCrhPFW
X-Gm-Gg: AeBDievQztKPVKAaS5VsXMy0vC1GiAUQoJPDGM5ngcPRKfRjO0lQvluSXH4RIRVeS74
 CbuiuHBy4otVugpcw1peL9u0gCR2sHJxB/0qHZ5d9PrvmRQC/NFqfyGnje8g/5EyKVpua8h3yq0
 VWt3XwuNnXXsJrUU58EKoWtxNds5h2Ee8DwC5C4den/ix+wxxLJGWmDpqE0OpHWZhF06UPTMYwK
 MF0p2bhjkYY8SfG7xsMHSiAHP8gt6bNgMmmZfGG/SVrcEJDILR/dkLIfo6r3Zhvliqsi+QEyo8r
 C+Y8nnHo3NPVxqRvM90e63YpnNhigF9k/3th4v4Y77fbf8tzzOYIPP9KtIZgU3HrvmcDu74ulRy
 lyDP3z+W4VLnCO5K0pUPXHo9LhDU44rz8abrNUC4F1D3gU4ZBZ/awOhAKzxiOgNyfC8bCn+wzLc
 80sbB/ssPXRkjavs3gIK6dV6lzud9kFxWMnH62Ttxu4aLXO4o/n078HxdqSvRbNiNq96oxnBJZM
 FNguPZ+Hw==
X-Received: by 2002:a05:600c:4687:b0:485:40db:d40c with SMTP id
 5b1f17b1804b1-488fb73d7e9mr451210695e9.3.1777048029336; 
 Fri, 24 Apr 2026 09:27:09 -0700 (PDT)
Received: from timur-hyperion.localnet (5401DFC2.dsl.pool.telekom.hu.
 [84.1.223.194]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f8193sm545467635e9.1.2026.04.24.09.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 09:27:08 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Melissa Wen <mwen@igalia.com>
Subject: Re: [PATCH 01/14] drm/amd/display: Delete unimplemented
 dm_pp_apply_power_level_change_request()
Date: Fri, 24 Apr 2026 18:27:07 +0200
Message-ID: <3688452.dWV9SEqChM@timur-hyperion>
In-Reply-To: <1abaa821-5477-4bfb-9731-9820f303f22f@igalia.com>
References: <20260423191519.73127-1-timur.kristof@gmail.com>
 <20260423191519.73127-2-timur.kristof@gmail.com>
 <1abaa821-5477-4bfb-9731-9820f303f22f@igalia.com>
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

On Friday, April 24, 2026 4:19:34=E2=80=AFPM Central European Summer Time M=
elissa Wen=20
wrote:
> On 23/04/2026 16:15, Timur Krist=C3=B3f wrote:
> > dm_pp_apply_power_level_change_request() was called from old
> > DCE clock manager implementations on DCE6, 8, 10, 11.2
> > but has not been implemented ever since the beginning of DC.
> >=20
> > Affected GPUs have been working fine without that implementation
> > for many years. Let's delete it now.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f<timur.kristof@gmail.com>
> > ---
> >=20
> >   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c | 8 --------
> >   .../gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c  | 9 ---------
> >   .../drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c   | 9 ---------
> >   .../drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c   | 9 ---------
> >   drivers/gpu/drm/amd/display/dc/dm_services.h             | 4 ----
> >   5 files changed, 39 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c index
> > 11b2ea6edf953..17f42201ab862 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> > @@ -417,14 +417,6 @@ bool dm_pp_notify_wm_clock_changes(
> >=20
> >   	return false;
> >  =20
> >   }
> >=20
> > -bool dm_pp_apply_power_level_change_request(
> > -	const struct dc_context *ctx,
> > -	struct dm_pp_power_level_change_request *level_change_req)
>=20
> Hi Timur,
>=20
> > -{
> > -	/* TODO: to be implemented */
>=20
> I feel a little uneasy about removing all this infrastructure with this
> series, as AFAIU, it could be avoided by implementing this TODO (?)
> Any idea if AMD has this code somewhere that could be upstreamed, or did
> it end up in the firmware?

The display power requirements are already implemented in a different way.
Here how it works:

1. We have dce_pplib_apply_display_requirements() to communicate the displa=
y=20
power requirements to the power management code.
2. In the power management code, we have display_configuration_change() and=
=20
pm_compute_clocks() that take care of the display power requirements.

Note that on DCE 6, 8, 10, currently DC always just sets the maximum possib=
le=20
clock, and it works fine. On DCE 11 and 11.2, we rely on dce_calcs so we do=
n't=20
need a DAL power level there either.

As far as I understand, the DAL power levels were a concept from the old=20
Windows driver for these GPUs and were never really implemented in Linux.
The newest affected GPU is about 10 years old by now and it has been workin=
g=20
fine on Linux all these years without dm_pp_apply_power_level_change_reques=
t().

Side note: after this cleanup series lands, I plan to improve the situation=
=20
and implement dm_pp_apply_clock_for_voltage_request() for these GPUs to mat=
ch=20
what we are doing on DCE 12.

>=20
> BTW, Looks like `struct dm_pp_power_level_change_request` also becomes
> unused with this change, right?

Yes, that's right. It is removed in a subsequent commit.

>=20
> Melissa
>=20
> > -	return false;
> > -}
> > -
> >=20
> >   bool dm_pp_apply_clock_for_voltage_request(
> >  =20
> >   	const struct dc_context *ctx,
> >   	struct dm_pp_clock_for_voltage_req *clock_for_voltage_req)
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> > b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c index
> > 6d41df52d7c9b..ffb70120362e7 100644
> > --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> > +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> > @@ -431,19 +431,10 @@ static void dce_update_clocks(struct clk_mgr
> > *clk_mgr_base,>=20
> >   			bool safe_to_lower)
> >  =20
> >   {
> >  =20
> >   	struct clk_mgr_internal *clk_mgr_dce =3D
> >   	TO_CLK_MGR_INTERNAL(clk_mgr_base);
> >=20
> > -	struct dm_pp_power_level_change_request level_change_req;
> >=20
> >   	const int max_disp_clk =3D
> >   =09
> >   		clk_mgr_dce-
>max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display
> >   		_clk_khz;>   =09
> >   	int patched_disp_clk =3D MIN(max_disp_clk,
> >   	context->bw_ctx.bw.dce.dispclk_khz);>=20
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
> >=20
> >   	if (should_set_clock(safe_to_lower, patched_disp_clk,
> >   	clk_mgr_base->clks.dispclk_khz)) {>   =09
> >   		patched_disp_clk =3D dce_set_clock(clk_mgr_base,=20
patched_disp_clk);
> >   		clk_mgr_base->clks.dispclk_khz =3D patched_disp_clk;
> >=20
> > diff --git
> > a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
> > b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c index
> > 13296c6ec08f4..ae922f1a31ff8 100644
> > --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
> > +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
> > @@ -257,21 +257,12 @@ static void dce11_update_clocks(struct clk_mgr
> > *clk_mgr_base,>=20
> >   			bool safe_to_lower)
> >  =20
> >   {
> >  =20
> >   	struct clk_mgr_internal *clk_mgr_dce =3D
> >   	TO_CLK_MGR_INTERNAL(clk_mgr_base);
> >=20
> > -	struct dm_pp_power_level_change_request level_change_req;
> >=20
> >   	int patched_disp_clk =3D context->bw_ctx.bw.dce.dispclk_khz;
> >   =09
> >   	/*TODO: W/A for dal3 linux, investigate why this works */
> >   	if (!clk_mgr_dce->dfs_bypass_active)
> >   =09
> >   		patched_disp_clk =3D patched_disp_clk * 115 / 100;
> >=20
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
> >=20
> >   	if (should_set_clock(safe_to_lower, patched_disp_clk,
> >   	clk_mgr_base->clks.dispclk_khz)) {>   =09
> >   		context->bw_ctx.bw.dce.dispclk_khz =3D=20
dce_set_clock(clk_mgr_base,
> >   		patched_disp_clk); clk_mgr_base->clks.dispclk_khz =3D=20
patched_disp_clk;
> >=20
> > diff --git
> > a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
> > b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c index
> > 1f36ad8a7de46..48393c69735b6 100644
> > --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
> > +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
> > @@ -193,21 +193,12 @@ static void dce112_update_clocks(struct clk_mgr
> > *clk_mgr_base,>=20
> >   			bool safe_to_lower)
> >  =20
> >   {
> >  =20
> >   	struct clk_mgr_internal *clk_mgr_dce =3D
> >   	TO_CLK_MGR_INTERNAL(clk_mgr_base);
> >=20
> > -	struct dm_pp_power_level_change_request level_change_req;
> >=20
> >   	int patched_disp_clk =3D context->bw_ctx.bw.dce.dispclk_khz;
> >   =09
> >   	/*TODO: W/A for dal3 linux, investigate why this works */
> >   	if (!clk_mgr_dce->dfs_bypass_active)
> >   =09
> >   		patched_disp_clk =3D patched_disp_clk * 115 / 100;
> >=20
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
> >=20
> >   	if (should_set_clock(safe_to_lower, patched_disp_clk,
> >   	clk_mgr_base->clks.dispclk_khz)) {>   =09
> >   		patched_disp_clk =3D dce112_set_clock(clk_mgr_base,=20
patched_disp_clk);
> >   		clk_mgr_base->clks.dispclk_khz =3D patched_disp_clk;
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/dc/dm_services.h
> > b/drivers/gpu/drm/amd/display/dc/dm_services.h index
> > fbbf9c757b3c3..1395d36bfabe9 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dm_services.h
> > +++ b/drivers/gpu/drm/amd/display/dc/dm_services.h
> > @@ -224,10 +224,6 @@ bool dm_pp_apply_display_requirements(
> >=20
> >   	const struct dc_context *ctx,
> >   	const struct dm_pp_display_configuration *pp_display_cfg);
> >=20
> > -bool dm_pp_apply_power_level_change_request(
> > -	const struct dc_context *ctx,
> > -	struct dm_pp_power_level_change_request *level_change_req);
> > -
> >=20
> >   bool dm_pp_apply_clock_for_voltage_request(
> >  =20
> >   	const struct dc_context *ctx,
> >   	struct dm_pp_clock_for_voltage_req *clock_for_voltage_req);




