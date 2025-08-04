Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4360C87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 16:35:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D3CA10E104;
	Mon,  4 Aug 2025 16:35:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jj66OfQ4";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36C6F10E104
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 16:35:07 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-3b78315ff04so3701281f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 09:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754325306; x=1754930106; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=lPnORv0E1AfXM0R2bHKMlJzT6mWCnwEup9cEtwyEQvI=;
 b=Jj66OfQ4F/7VkCprA/Bue6r87EE2ljtgg7lmEPqNB7dKKCnsyE2hoUFJXBsW2D6qhp
 CxFfHmYlTsFaU/5fuR6+SAh7fecP1lkvvB3m5pVOVHgM0eLudh2W+D/ZMC7jSaCfgUMH
 ciH7Gudi4AG0KxZWesFPYWTVdV0jzenzWWEtHOCHOiaIsECcnv1pshENi0PSF7lnNiQf
 MSmzQRGXkDNS5FgfZBj/PBDBEIKFTPrqrL8nG43aB/o7smyP7yhjcb3NUXgyFbQ+JKr1
 nbdUgVxGknmwQgJoNzEQkvNhp+Sh06tQ9Q6XaqZke9g8+gaR94ylKJzsausdPEyRM2Kx
 x7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754325306; x=1754930106;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lPnORv0E1AfXM0R2bHKMlJzT6mWCnwEup9cEtwyEQvI=;
 b=TsGRejHIEO9nHgb5qijlB5sZ6ktlr5aonQKPYcpdsDRuzL+Fsq4KCTxKG0KSQswvnG
 F6jm7/LhnaJRTwRYK1UsFw+nEK0JcCQXw7YD2hkWJa3StDLsi1YbKFN2ZHSxYH/ZTp1E
 K6i3ph1u1PGkb4GQehhE4Bg+7YF7TikyUjK4qUkWYV3n06ZAaw1S1xx8Yrkh9xUiODdM
 efMdxPWTflTwwP4QRcLmxwetQ1TKUeCciwzYTLsVgIcFHA/c/VQ072PnK0NCik1aLV4P
 Y89iJjnc8Zi86f8iRma/Rc/RJ3KyEJSgt253NCLR3jVw+HwVUiEIrgORdB0Q8kZ4SJzo
 nl0A==
X-Gm-Message-State: AOJu0YzBDp/6XKwYliGubUVFjIbcEqZc0gP4zpVcpAWXqbnR0PLrO98Q
 0WN7cEMdxATc1rOhqDEmFD16QvOQrYS3IXjLJuasOKzwrBIJYBkgVaQD
X-Gm-Gg: ASbGncu+2XbCCyvqoNQdLWlvf81XzYZE0SpuUACjdSeo4ZkHe9wX3nqF9CHZlAU3Yny
 yu01PJauPtGsuL6YFP9/eX0qw/eNhLgETQ6ev7bPzDO5u50voygEuzuWBhvR35xbRK7Or+XnXUT
 qirEi0USpVUvFPIULOO/VLFpr8X8lf2733Cf7HCPZqwU2opoun81z0qLIcdxDCOnFPJL+kzoscw
 xHlT2fDpBFCoWffGFiNe/k5PxjnB6EGuOj7hzKna4T8lcZZXekNN+Q4/XUm7XzmS1DMPB3RMEhJ
 75gEkylXQt2WzgqChPGQHFsoBwf9oNE1rEWxeqq/XKHj7+4xQhrEf5ZHmYSgkTeYXExU5SjYzVM
 O+iv6XW4hpyYlDIHyWIKFO3px7UZLP4UZWFI6tUYaRes8rZR3IFTBX293rL5iKwlQ0xu2kXozES
 HBZJzktk6p/vnzFy1U8kjZfM9sKvGYf0BtdDEvUe4prGzyWn4pUm9fGrBDauVnxg==
X-Google-Smtp-Source: AGHT+IEggRBx2z5F6NzdxhD56nvOI713i2hcxSBZm+nXGhhDBuiD+kv+4x4lQRHPuvc9wD5b4DWFMw==
X-Received: by 2002:a05:6000:26d0:b0:3b6:c6b:e4e6 with SMTP id
 ffacd0b85a97d-3b8d946ac74mr8136847f8f.11.1754325305508; 
 Mon, 04 Aug 2025 09:35:05 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24da:bd00:a473:4c1d:2078:832b?
 (20014C4E24DABD00A4734C1D2078832B.dsl.pool.telekom.hu.
 [2001:4c4e:24da:bd00:a473:4c1d:2078:832b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953eaeeesm228889715e9.25.2025.08.04.09.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 09:35:05 -0700 (PDT)
Message-ID: <7c144d14fb8726b812091719a69192c9bc655762.camel@gmail.com>
Subject: Re: [PATCH 2/7] drm/amd/display: Adjust DCE 8-10 clock, don't
 overclock by 15%
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Date: Mon, 04 Aug 2025 18:35:04 +0200
In-Reply-To: <CADnq5_OAOrZETWPBzUjGJigJxXRsK=nBPjY+-j3ZE+skXr4vfw@mail.gmail.com>
References: <20250731094352.29528-1-timur.kristof@gmail.com>
 <20250731094352.29528-3-timur.kristof@gmail.com>
 <CADnq5_OAOrZETWPBzUjGJigJxXRsK=nBPjY+-j3ZE+skXr4vfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
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

On Mon, 2025-08-04 at 11:56 -0400, Alex Deucher wrote:
> On Thu, Jul 31, 2025 at 5:58=E2=80=AFAM Timur Krist=C3=B3f
> <timur.kristof@gmail.com> wrote:
> >=20
> > Adjust the nominal (and performance) clocks for DCE 8-10,
> > and set them to 625 MHz, which is the value used by the legacy
> > display code in amdgpu_atombios_get_clock_info.
> >=20
> > This was tested with Hawaii, Tonga and Fiji.
> > These GPUs can output 4K 60Hz (10-bit depth) at 625 MHz.
> >=20
> > The extra 15% clock was added as a workaround for a Polaris issue
> > which uses DCE 11, and should not have been used on DCE 8-10 which
> > are already hardcoded to the highest possible display clock.
> > Unfortunately, the extra 15% was mistakenly copied and kept
> > even on code paths which don't affect Polaris.
> >=20
> > This commit fixes that and also adds a check to make sure
> > not to exceed the maximum DCE 8-10 display clock.
> >=20
> > Fixes: 8cd61c313d8b ("drm/amd/display: Raise dispclk value for
> > Polaris")
> > Fixes: dc88b4a684d2 ("drm/amd/display: make clk mgr soc specific")
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> >=20
> > x
>=20
> Stray x here.=C2=A0 with that fixed:
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Thanks!
Sorry about that, that's a typo that I made during a rebase.

Maybe a silly question but what is the right way to deal with it?
Should I send the entire series or just the patch with the typo fixed?
Or can you just delete the typo when you are applying it to your tree?

Timur

>=20
> > ---
> > =C2=A0.../drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c=C2=A0 | 12 ++=
+++---
> > ----
> > =C2=A01 file changed, 5 insertions(+), 7 deletions(-)
> >=20
> > diff --git
> > a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> > b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> > index 26feefbb8990..69e9540f553b 100644
> > --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> > +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> > @@ -72,9 +72,9 @@ static const struct state_dependent_clocks
> > dce80_max_clks_by_state[] =3D {
> > =C2=A0/* ClocksStateLow */
> > =C2=A0{ .display_clk_khz =3D 352000, .pixel_clk_khz =3D 330000},
> > =C2=A0/* ClocksStateNominal */
> > -{ .display_clk_khz =3D 600000, .pixel_clk_khz =3D 400000 },
> > +{ .display_clk_khz =3D 625000, .pixel_clk_khz =3D 400000 },
> > =C2=A0/* ClocksStatePerformance */
> > -{ .display_clk_khz =3D 600000, .pixel_clk_khz =3D 400000 } };
> > +{ .display_clk_khz =3D 625000, .pixel_clk_khz =3D 400000 } };
> >=20
> > =C2=A0int dentist_get_divider_from_did(int did)
> > =C2=A0{
> > @@ -400,11 +400,9 @@ static void dce_update_clocks(struct clk_mgr
> > *clk_mgr_base,
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct clk_mgr_internal *clk=
_mgr_dce =3D
> > TO_CLK_MGR_INTERNAL(clk_mgr_base);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct dm_pp_power_level_cha=
nge_request level_change_req;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int patched_disp_clk =3D context-=
>bw_ctx.bw.dce.dispclk_khz;
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*TODO: W/A for dal3 linux, inves=
tigate why this works */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!clk_mgr_dce->dfs_bypass_acti=
ve)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 patched_disp_clk =3D patched_disp_clk * 115 / 100;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const int max_disp_clk =3D
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 clk_mgr_dce-
> > >max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int patched_disp_clk =3D MIN(max_=
disp_clk, context-
> > >bw_ctx.bw.dce.dispclk_khz);
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 level_change_req.power_level=
 =3D
> > dce_get_required_clocks_state(clk_mgr_base, context);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* get max clock state from =
PPLIB */
> > --
> > 2.50.1
> >=20
