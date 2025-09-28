Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5AECAC5BB
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Sep 2025 23:33:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8A5910E17E;
	Sun, 28 Sep 2025 23:33:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eowd/Uv9";
	dkim-atps=neutral
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0312410E17E
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Sep 2025 23:33:17 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-631787faf35so8064225a12.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Sep 2025 16:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759102396; x=1759707196; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3tRVP+EyruaYCh6fdavZ2Wms8cp5pX0ZJFnNU25WGX8=;
 b=eowd/Uv9cwznqGMThjLNwIHd8S+Pes9W4vlufP+BkGejdBkRLL+EM4DBdmzfl2GXyL
 4Tr7XkKiabM+2OJlFUHjGnC4qMj7oSl8tQA7R4PHnMvt9jML3Z0331IiY2VHohQbssa7
 dLo4Z6nscqeipV2gXl47H14VA71kVRgZNum/TmIWMxzcfllApKI1LjHZR/JHE3vaed0B
 QjXoD7ZYylHhno9yQLf8+9UhFKGVJpVkK5q0X5CpcD0ywS9f2wMXUihLgK2AanzUL2dk
 eatk+eM0XGZBPzJHpKofJ8HJfbw9abRq1+dduS6XMLFN3M4cbFuSenGbImTJj+5psOFZ
 tKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759102396; x=1759707196;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3tRVP+EyruaYCh6fdavZ2Wms8cp5pX0ZJFnNU25WGX8=;
 b=cAdSOiXWlI4N9ftpTZN8o9KTdEQeBuSa+pzByC1c0MPT98z4zcPrOQfZhThCYE42GR
 5kzGWKXaxJmU0auSA+y7llMykKfYywYfrBMCoJEat1pabdL1YbdZx4xFQ6zBMzkn8LnZ
 5x4nalOsRqQWsGocbT96QHUb25uWA3GNqqGZOfnPNkdDfHXe5krm0cfgSY6W4MkPYE2j
 fPlEeaKY95cATASKwJ+CJy64W4YtTVIDYqFi+wU2/8Wn8wZJ8uQmxb1z+vmmRmq7Cp7/
 I1qbmJHDtoV8sxzBqyp20f3M1POONtgAAGqEIufhTOrLJU71dRKcG0CGc+LjxYy+vLF0
 qeFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGtVAtZavAUeoHEbVALN9wvUMuPpY4PL99uYePOxATLqI4Vu0IhwvJLY8TngusYhkqxgyAAUI0@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz49K3FyWhQApZiiSc1gon7sV9SdXGY/4lwKUqAKki4oMZTBrV1
 EPo4GEWLVg6Ld5deI10nG5P8tzK8BiDyYO2sRZ7G7oW6KphFV3NOw2Te
X-Gm-Gg: ASbGncuIXL6MGAU0ntV5nzzvoiIo7SpoQ+87Yyhypu1aIj8+NtrxTE0GJfdiEcA5YbO
 IOt60dFE708z0v0AZn2M4AXI6iOAJYFAa1Bv3sV3zd+ptewKFc5pS51M5ACVVXFDFs5kShPNsTH
 fZt+zLpJ0ZTcQt6XYNEX52+L5zHHejslkXY1rG+OPKg7wah9WNn/YR8dj0u42eL8/GvYJLeMT5B
 eMel9TLTt++nadvwuZdiHLtvG7YuwfB5FDmStDIYeve0nREuQlB36WFKxFOqc0pRHIYTodywYrY
 HQvT9thoJFO+JIbX3UYgU9oSfU5ljLHznKsend9eray6zyY0ROK25Osk4DQsEJJVpCbPg+A+b6d
 CREPo1lg3CqkYH4Mbh0W31on/seuY
X-Google-Smtp-Source: AGHT+IEdYvAGwT3NwwKLTcqe8SAsDHKX93YGm8kKOBxgFt6q2YAkvlHoZ96I69X29p8n8+i8X2zztQ==
X-Received: by 2002:a17:907:9815:b0:b32:3d0:db27 with SMTP id
 a640c23a62f3a-b34b7dc9e46mr1700455666b.19.1759102396217; 
 Sun, 28 Sep 2025 16:33:16 -0700 (PDT)
Received: from [10.93.20.36] ([83.229.109.3]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3cedacd973sm208561366b.49.2025.09.28.16.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Sep 2025 16:33:15 -0700 (PDT)
Message-ID: <3b1e453fd8595afb0b4c98855a7a06ba940925a4.camel@gmail.com>
Subject: Re: [PATCH 3/3] drm/amd/display: Set stricter clock dividers on DCE
 6-10
From: timur.kristof@gmail.com
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com, 
 siqueira@igalia.com
Date: Mon, 29 Sep 2025 01:33:14 +0200
In-Reply-To: <221fd37b-e2a4-419c-9ac7-bb9eea0b4f78@amd.com>
References: <20250926182614.26629-1-timur.kristof@gmail.com>
 <20250926182614.26629-4-timur.kristof@gmail.com>
 <221fd37b-e2a4-419c-9ac7-bb9eea0b4f78@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
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

On Sun, 2025-09-28 at 16:14 +0200, Christian K=C3=B6nig wrote:
>=20
>=20
> On 26.09.25 20:26, Timur Krist=C3=B3f wrote:
> > Set stricter dividers to stabilize the PLL's feedback loop.
> > In practice, the actual output isn't exactly the target
> > clock, but slowly oscillates around it. This makes it
> > more stable.
> >=20
> > The values here are taken from the non-DC code.
>=20
> There are also a bunch of other restrictions which need to be kept in
> mind.
>=20
> For example what is the minimum feedback divider value the DC code
> uses?

As far as I see DC doesn't have minimum / maximum limits for the
feedback divider right now, though I can add that in a future patch if
necessary.

>=20
> We once had a longer discussion with the PLL HW engineers to get this
> working because at least the display code we used as reference back
> then got it wrong.

After this series is reviewed, I can look through the other
restrictions in the amdgpu_atombios_get_clock_info function and write
another patch series to add those restrictions to DC.

>=20
> > ---
> > =C2=A0drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c | 7 +++++++
> > =C2=A01 file changed, 7 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> > b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> > index b4f5b4a6331a..00f25e2ee081 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> > @@ -1700,6 +1700,13 @@ bool dce110_clk_src_construct(
> > =C2=A0			clk_src->cs_mask->PLL_POST_DIV_PIXCLK;
> > =C2=A0	calc_pll_cs_init_data.min_pll_ref_divider =3D	1;
> > =C2=A0	calc_pll_cs_init_data.max_pll_ref_divider =3D	clk_src-
> > >cs_mask->PLL_REF_DIV;
> > +
> > +	if (ctx->dce_version <=3D DCE_VERSION_10_0) {
> > +		/* Set stricter dividers to stabilize the PLL's
> > feedback loop on old HW. */
> > +		calc_pll_cs_init_data.min_pix_clk_pll_post_divider
> > =3D 2;
> > +		calc_pll_cs_init_data.min_pll_ref_divider =3D 2;
> > +	}
> > +
> > =C2=A0	/* when 0 use minInputPxlClkPLLFrequencyInKHz from
> > firmwareInfo*/
> > =C2=A0	calc_pll_cs_init_data.min_override_input_pxl_clk_pll_freq_
> > khz =3D	0;
> > =C2=A0	/* when 0 use maxInputPxlClkPLLFrequencyInKHz from
> > firmwareInfo*/
