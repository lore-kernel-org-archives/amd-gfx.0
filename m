Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5E3F94CA7
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 19:25:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E8FA88EBA;
	Tue, 21 Apr 2026 19:25:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DJPLwfNY";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 529B688EBA
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 19:25:47 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so75373115e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 12:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776799546; x=1777404346; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pVskJ/wl1mJcDrGKJKbCd70fMkqfhxhokutmn18jL1o=;
 b=DJPLwfNYUcBS6Xg+1tngawZGUTtIS2igZNLfvLB4yRsuN2MsMnxm9ewuwVs53RA8QA
 OUlCCxm3R1gMRRloamROzSOH5r6Rj5LgbBu9PZ9T5HeFuJdKg5L/K1KdI/wqYzuVrKCz
 r8pKDbjJGeefYkoGgWBm8VsKcmiSPsBFRng7GTDFGPmMQuIwywtTNvZOoN0p8k02RdGe
 u+nDDYA3aAzVekg8XA5grZIQp9EjTz2yRp0PGBCtApPF9BYR7b2oH9Zvm6lF2UKvJpvf
 GVvqSGKlwIZQRdRUJBnEjEObuG4nruEFs8xU+yhKJV/NqQaED2XG6QWSGmHhFBA+FmG2
 tx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776799546; x=1777404346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pVskJ/wl1mJcDrGKJKbCd70fMkqfhxhokutmn18jL1o=;
 b=D+diBHKUKYfkbI423gI3d3pJvzfsPGcwPlw5MJbsXDlLrZh8a/h1x5h/RJOYW0d+Dt
 Br9/fQb4DKyysKgk1fuf4Ure+/PXMJCEg7L5lxKRE3DGOR0iJPFQLJfYEiCkRIklCtaR
 hYIHYDJ0+pmoqXX1FY4cEfnfU92QZfuz8C2h5w4eB0wqAng9G7BNMqQAMQulWJ3IiMkB
 bB1ekx64kzCqY+YkX4WPeM7BQNni3n+AWiNylmN6sopwqI9pasfVV2Kvo8mFJmMxn2rC
 91En3DxK+3Ho0sV5RqM+1Gy/Vr0L0lBg3d7PAiv1RGfGM17DFSTa9TdpiT4nn/XMsRhE
 qHhw==
X-Gm-Message-State: AOJu0YxpCBaayk/6iGzyc7VD9/lxKe2wiCt39sf5E/rXpwi8xceICdYk
 2KppcpiMtr+z2mPdu/em5e56COi9kHizsgLiFKC8k74imx5G79Nf2uH96JUFkQ==
X-Gm-Gg: AeBDieujkmyso/gz0cwaZF8sPb3mdCvOsgTICUvlPpGry8mw1NBRQsNJk+wj7LXCryG
 I/eV1hJUg4UMVqCjNnosICKeEfRQmQB9ant1mAl/dNI428DJ7vJ+cgI5XfIUtgzpVLnBvohfb+B
 PI2M9vf9HTr41Xwv3rjMshqMghoYHtMbGPAHKay96RQPF7c7cBdYMCfBM7no77wHSGQGIejervx
 +3ViPZCo3dOGtdlESyArOWSHdnEmnKn/V9slA0BUQ6aF8gtlKqWflKR4ZySMsxqwn3QxcKL00F1
 vZVBonsx7xCVcltRgE9ae0m/BZ51VuOtNeIIXj4eUOxw1PQc2V8yeOQERpwamumfNQv9p09JLOH
 2J8WHs3GHHkZN/ZJItwZZNknb90017GkeK+SDbLJEWUSMdNJYXNIHPFDlR/o63UxIgb1Sr1KxUI
 iooI6LTLWvjcFKlKlPmeFpgRklV5U+v8vd6NiJYHPiI9/z0dJ4Qvt2pL2FOQlqhXdZSuLn8F9hg
 SWAWeG5q8VticZhcXjuUajitbXdkUQazoaaEDN2
X-Received: by 2002:a05:600c:620d:b0:489:1d23:4524 with SMTP id
 5b1f17b1804b1-4891d23468bmr137455385e9.5.1776799545603; 
 Tue, 21 Apr 2026 12:25:45 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24EFEC0033EDEB5C97A7ED1D.dsl.pool.telekom.hu.
 [2001:4c4e:24ef:ec00:33ed:eb5c:97a7:ed1d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891f98728dsm48407145e9.23.2026.04.21.12.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 12:25:45 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Li, Roman" <Roman.Li@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Hung, Alex" <Alex.Hung@amd.com>
Subject: Re: [PATCH v3] drm/amd/display: Restore analog connector support
Date: Tue, 21 Apr 2026 21:25:43 +0200
Message-ID: <5053236.OV4Wx5bFTl@timur-max>
In-Reply-To: <CY8PR12MB81939EDD14C03CE06C32C07D892C2@CY8PR12MB8193.namprd12.prod.outlook.com>
References: <20260418003539.1862136-1-Roman.Li@amd.com>
 <CY8PR12MB81939EDD14C03CE06C32C07D892C2@CY8PR12MB8193.namprd12.prod.outlook.com>
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

On 2026. =C3=A1prilis 21., kedd 20:08:21 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=C3=
=A1ri id=C5=91 Li, Roman wrote:
> [Public]
>=20
> Hi Timur,
>=20
> Did you get a chance to test V3?
>=20
> Thanks,
> Roman

Hi Roman,

Yes I tested it, it works fine also on Kaveri (with DP bridge encoder) and=
=20
other GPUs with a DAC encoder. Nice work, thank you!
V3 of the patch is:
Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
Tested-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

I noticed that there is still an issue with an Oland GPU that has a VGA=20
connector, that hits an ASSERT(0) thanks to a recent HPD refactor:
https://gitlab.freedesktop.org/agd5f/linux/-/blob/
a1404287ad4cc349ce3f5d94ac81903db9e0351f/drivers/gpu/drm/amd/display/dc/lin=
k/
link_factory.c#L608

At the moment I'm not sure if we should just remove the assertion or maybe=
=20
other changes are also necessary? What do you think?

Thanks & best regards,
Timur



