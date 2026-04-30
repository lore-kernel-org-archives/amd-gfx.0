Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7681FF8873
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 13:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3192410F316;
	Thu, 30 Apr 2026 13:19:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YMXZ6YB6";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF7B910F315
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 13:19:40 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso10100145e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 06:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777555179; x=1778159979; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=c/9Gsw7aEDLJz813g8vd3M59fwoYkF+qi6k8FuOTT3Q=;
 b=YMXZ6YB6ZVlOr1G2KmjV8LnRdkj1I1KOGxfX5EfnHjpDLBXJYRu+x2bK9lSPL4A6WG
 uq5cHwYefgPlxnfOJMKpOdOFPKH584PDHcyjs/HnhtCHVB+z/L8KYT4sZvydS0994wbM
 w9XSWMMWC8KClsAwqTXK1PiBT0HSG73nTxT4GHIV//KsQUAZDaFtF6lJrUBDAZ+ujXvI
 3xjESnt1sFq+pt3Kh+3hFqCwjQjoEiEq4RXjjMWjCkPXAA3CZEiPsK7Sy6RUTDkjrzbn
 QexGalCAWchv38Y50/W4kBVKI3HjJTdGCHQ8Os6GEyiPYxPwc2ioiid/PYO9WBEHsmxv
 d/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777555179; x=1778159979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=c/9Gsw7aEDLJz813g8vd3M59fwoYkF+qi6k8FuOTT3Q=;
 b=IzHmLofjR/5+1mOqhY0L/hY8J3vvT2l7rG6zqCt8a5aEnKyKafSbPvpAGceyf8GjPn
 bLXUKRlsRMxHySjZMate26cH6QkqOFbeRL+xtxDFNwj1Rc7wCFmAl8OLCRVkxUvSHqIC
 wCVxxyoPSzKz6xjdoYp9W3O2EqwjS9QDpJkA7ifEUdDhDy/ljH5BZ0pVbbZ7yFfZFz5H
 M41mCQgNdNaGbGgVX8aqs5z+ZtyMYmWi0XDMIKw+6k4oiyG5mDkH13k58BE9COV+IAWw
 vf9ytGeYQPLqSVM/p3QTK5vR+0zJHsL3OHyClMU5gtsUYbKQ6p7u5DQfUR0UO8+NJ421
 iozQ==
X-Gm-Message-State: AOJu0YxoEMAE1x9Fl5Wo4PXeScmiVka3v98f8AkwakSliRtUcPd/2nam
 VWmN9YF+WIPLveZ3eHchuMAAGiyPbf9NObziegsLUKI/kiUJSWyosMQB5KtYuv5R
X-Gm-Gg: AeBDiesCdcNm5Cr9NAav9F7DvGVQCqbXWSAzvyWTwR9D4iCUzieWlz2uA/DnUv8g/JR
 bUpK//gXEI6aDLFbFUGMDhx1MtplTbREvfMNRHlujDpQA2I0mJbWCAL7nApNt7fxGAS9REWlgkq
 JRB3ts0x7V/oYl3k5Qr3xt5uz4yG932xNw2VlGTAJJ/5LEfTlsbUY/N9PhrJqYuPPdA6G9TGBCV
 JpZ1GgGYi7czG5V5aJpP4PpN9fTRfEqoyo9CQ06ZckeHgygvWEuS0L0lCaK93e6UGzLAX1Zi4mS
 JlDf6V7+4zkiJgOYZadTVrKLluDvLlzKARwLRaRnGRq/XyBgw4ztNXWL7rn1HW+turcIqml9v9L
 MmcVJS1U8X9Pg/o8dcB+P/nekW8VYvjsDBJPDg16X5C9S0H2yaLlcwqKrCUXyKAc8vnPqYnDeeI
 WZnzchJc4gCtOcdC61OzXLvE8ev4p7tEQm8H51nHnSc7qGU9nGcDKFZpogFnn7T2UfkvgjMTKcC
 6Uw5p9tem/MQY4wRPk5j/0WCw==
X-Received: by 2002:a05:600c:4f44:b0:487:2439:b7be with SMTP id
 5b1f17b1804b1-48a842566a4mr52159325e9.6.1777555179238; 
 Thu, 30 Apr 2026 06:19:39 -0700 (PDT)
Received: from timur-max.localnet (netacc-gpn-7-154-214.pool.yettel.hu.
 [176.77.154.214]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a822bf3ffsm71712115e9.7.2026.04.30.06.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 06:19:38 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Melissa Wen <mwen@igalia.com>
Subject: Re: [PATCH 05/14] drm/amd/display: Set max supported display clock
 without max_clks_by_state
Date: Thu, 30 Apr 2026 14:28:27 +0200
Message-ID: <3591364.LZWGnKmheA@timur-max>
In-Reply-To: <a16bce0b-6d7c-49a8-85c0-77458dd4bacb@igalia.com>
References: <20260423191519.73127-1-timur.kristof@gmail.com>
 <20260423191519.73127-6-timur.kristof@gmail.com>
 <a16bce0b-6d7c-49a8-85c0-77458dd4bacb@igalia.com>
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

On 2026. =C3=A1prilis 29., szerda 22:24:38 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=
=C3=A1ri id=C5=91 Melissa Wen=20
wrote:
> On 23/04/2026 16:15, Timur Krist=C3=B3f wrote:
> > The max_clks_by_state was based on hardcoded values, which are
> > not really used anywhere, only to know the maximum clock.
> > Just hardcode the same maximum clock for each DCE version.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >   .../amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c  | 16 +++++++++++-----
> >   1 file changed, 11 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> > b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c index
> > 2ba341df7fffd..bef9a72f3382f 100644
> > --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> > +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> > @@ -391,9 +391,7 @@ static void dce_update_clocks(struct clk_mgr
> > *clk_mgr_base,>=20
> >   			struct dc_state *context,
> >   			bool safe_to_lower)
> >  =20
> >   {
> >=20
> > -	struct clk_mgr_internal *clk_mgr_dce =3D
> > TO_CLK_MGR_INTERNAL(clk_mgr_base);
> > -	const int max_disp_clk =3D
> > -		clk_mgr_dce-
>max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_
> > clk_khz; +	const int max_disp_clk =3D
> > clk_mgr_base->clks.max_supported_dispclk_khz;>=20
> >   	int patched_disp_clk =3D MIN(max_disp_clk,
> >   	context->bw_ctx.bw.dce.dispclk_khz);
> >   =09
> >   	if (should_set_clock(safe_to_lower, patched_disp_clk,
> >   	clk_mgr_base->clks.dispclk_khz)) {>=20
> > @@ -445,8 +443,16 @@ void dce_clk_mgr_construct(
> >=20
> >   	clk_mgr->dprefclk_ss_divider =3D 1000;
> >   	clk_mgr->ss_on_dprefclk =3D false;
> >=20
> > -	base->clks.max_supported_dispclk_khz =3D
> > -		clk_mgr-
>max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_
> > khz; +	if (ctx->dce_version >=3D DCE_VERSION_12_0)
> > +		base->clks.max_supported_dispclk_khz =3D 1133000;
> > +	else if (ctx->dce_version >=3D DCE_VERSION_11_2)
> > +		base->clks.max_supported_dispclk_khz =3D 1108000;
>=20
> For DCE 11.2, I see ClocksStatePerformance is 1132000 instead of
> 1108000, right?

Hi Melissa,

=46or DCE11.2, nobody really knows what the maximum supported display clock=
 is.
There are different values hardcoded in different parts of the code base.

dce112_max_clks_by_state says it's 1132 MHz
bw_calcs says it's 1108 MHz
and dce112_update_clocks() adds 15%

In this patch, I chose to go for 1108 MHz to match bw_calcs, but I can edit=
=20
that if you feel that 1132 MHz is better. What do you think?

Thanks,
Timur


>=20
> With the value fixed, this is:
>=20
> Reviewed-by: Melissa Wen <mwen@igalia.com>
>=20
> > +	else if (ctx->dce_version >=3D DCE_VERSION_11_0)
> > +		base->clks.max_supported_dispclk_khz =3D 643000;
> > +	else if (ctx->dce_version >=3D DCE_VERSION_8_0)
> > +		base->clks.max_supported_dispclk_khz =3D 625000;
> > +	else
> > +		base->clks.max_supported_dispclk_khz =3D 600000;
> >=20
> >   	dce_clock_read_integrated_info(clk_mgr);
> >   	dce_clock_read_ss_info(clk_mgr);




