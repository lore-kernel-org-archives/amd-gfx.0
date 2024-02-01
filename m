Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F68AC48291
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Feb 2024 14:17:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E25310EE6D;
	Thu,  1 Feb 2024 14:17:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="NfpvEQuL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QRKftlcT";
	dkim-atps=neutral
Received: from galois.linutronix.de (unknown [193.142.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E9C110EDBA
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Feb 2024 13:53:54 +0000 (UTC)
Date: Thu, 1 Feb 2024 14:53:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1706795623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D0G8Dha4ClhGh5Nvr9o98y/nqFzsgiWcwq3lRMSXSTY=;
 b=NfpvEQuL3VR6PNyf7jiRcN9ed3PbNVRL/9hXwgDCM1tywsV5rz0s+kW1Q1kN/LN6LGxlWi
 r6GmiksodHoEqpbai4ZbjB3JoH18f4S1DnaA5jYbS1GleJbeGDdXK+wMCfNS43Ddm/Sxoy
 DrtgPD/uJPKXHkx9SHvjvKGDqS+fMn0yDuY2uUO0fJn4gZLItRpaTPquE6wbRVz81XAZc9
 fGpuWBVU45sv3JGXFuR//3gOfU9HEuMk/W1PoPeOaA0L0Qg09x7+BAFkBKCKudF7g3/qqb
 UPSAZ3KxeisdvgBGLg2cQ5cfkhlac8i2sEItG7tUDft8UEEvBLp3w9D66CuRIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1706795623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D0G8Dha4ClhGh5Nvr9o98y/nqFzsgiWcwq3lRMSXSTY=;
 b=QRKftlcTdZWRZc7HBsspNgirWdMZ198wSl5r8Acy7E8NKRlX7xaG80WhlWh2NMib8EN7qJ
 cH/QjJzh5k7ArWBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [bug report] drm/amd/display: Simplify the per-CPU usage.
Message-ID: <20240201135342.4dhm3bWG@linutronix.de>
References: <e31dedcc-1aa8-4430-a2f5-9e37ca25410f@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e31dedcc-1aa8-4430-a2f5-9e37ca25410f@moroto.mountain>
X-Mailman-Approved-At: Thu, 01 Feb 2024 14:17:33 +0000
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

On 2024-02-01 15:18:04 [+0300], Dan Carpenter wrote:
> Hello Sebastian Andrzej Siewior,
Hi Dan,

> The patch de5e73dc6baf: "drm/amd/display: Simplify the per-CPU
> usage." from Sep 21, 2023 (linux-next), leads to the following Smatch
> static checker warning:

Did I introduce that or has it been made visible?
That change adds preempt_disable() to DC_FP_START() but this was there
already, just hidden. For x86 it is done within kernel_fpu_begin().

> drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn30/dcn30_resource.c:=
2385 dcn30_resource_construct() warn: sleeping in atomic context
> drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn32/dcn32_resource.c:=
2136 dcn32_resource_construct() warn: sleeping in atomic context
>=20
> drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn30/dcn30_resource.c
>     2263 static bool dcn30_resource_construct(
>     2264         uint8_t num_virtual_links,
>     2265         struct dc *dc,
>     2266         struct dcn30_resource_pool *pool)
>     2267 {
=E2=80=A6
>     2281=20
>     2282         DC_FP_START();
>                  ^^^^^^^^^^^^^^
> Preempt disabled here.
=E2=80=A6
>     2383         /* Clock Sources for Pixel Clock*/
>     2384         pool->base.clock_sources[DCN30_CLK_SRC_PLL0] =3D
> --> 2385                         dcn30_clock_source_create(ctx, ctx->dc_b=
ios,
>                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^
> sleeping allocation here.
>=20

Correct you are. But there is more. Later is also dccg30_create() and
dcn30_hubbub_create() and probably a few other, too.
Could we please restructure the init-phase so that the memory allocation
happen outside of DC_FP_START(). Is DC_FP_START() even needed here?

> regards,
> dan carpenter

Sebastian
