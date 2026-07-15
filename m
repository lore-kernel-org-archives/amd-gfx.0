Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CD2C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 22:52:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B32610E247;
	Wed, 15 Jul 2026 22:52:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GfpCvBHy";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD13510E247
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 22:52:02 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47d70879764so4157355f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 15:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784155921; x=1784760721; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6aBuWvd4jPDPONcxOqIGGTxip/syZyM9G94JPQhCOjg=;
 b=GfpCvBHyEOBuEM9MrXUtNvy1MFuvv7ZVrufzBkJXobN9BtyLTdCZNCFeY72h7kbYab
 Hn0yJnxNOV3zv6tC79MIM5TgOzs3SZ9wDyK/D2zIx+vAMi8NAPVStlEVPwzcek+ZI8zj
 wsseptTQ9+NF+g7YwAkn2rCrcV49zdVBCjz1lU2xswCyjEh7RFi29fjdzfj4nV8xC92k
 Ue3OB0uBVD4RA0d5GKh2QpXdAN6zGAIZmX1DhMZG+8+sJcwMyU46kG5timUPnMW0movC
 +Xp1A7MlVwmrMK4TgUr/hfR9NQxoKGuEhajP2nrXdeVl352G6kAyZkWdeo3BLlNsIQfa
 vsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784155921; x=1784760721;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6aBuWvd4jPDPONcxOqIGGTxip/syZyM9G94JPQhCOjg=;
 b=gtodIaTZbew9L8V55rbShm8Oht128VZDQS3Ullu1vcp/tOSwncTqp7O3cbMhcbc2pt
 3HVSsNfIlLcgLs1wdsAsGyQ0W8UFS5vUxKWNFoUSLsDm7iMnK4Gn9qd947twhOkKuQH5
 oNU8yy+QLhYtUINU/NpRmwE9Z0k5au4ol9B2SYebfz8+KMqxYXndgsVTxzZjK9FvO9Gf
 Meke2TjrXPouMZOx3Y9ShE2knynuG50ozZ8//MsCzqLUVyuYlvrwR29dDwC143HU0lR2
 llKz0ETZHkrZFWp5wnSa7CZHZ1v5DIOV1TJ85cZ7uisGHNisxoIeELaHGHzUYlA3lbfn
 P8aw==
X-Gm-Message-State: AOJu0YwZBghQ/q/uWwwTGMnJdEaZixAceKBPWFFlLp/qOxaFkr3KR0p3
 vG27HHKtRB/Hm9/OBu3hbGjNuy725alpP7pupXGlWuhl3FICY3AaIMMqvJCcD50W
X-Gm-Gg: AfdE7ck8dqM80vnK3rGJlVMhSIcsiyo8cX6Phw5Nll/u6OP7rcSwCh/LtX6fvEyX6Il
 r5ztpzZ6785OBWFAsRyafvQ+2W8sMN/aA+3vEiy+88QiBrGaOeZBBBX3krauURM522pnQMTfIO7
 XoTucY0KJHKRTQqU1ibhF9qoMPm+T7Z04LZWIghIBhsjyOOQ4BuSGn6byR5tzvHoUNMrbt4nlrw
 OeF1uyIumB23Pf4+y4t02CA7NdVgMg5WknlXkgXtPzDRq3mUp1q5GDz3cjVAidmCC2wnoqSRMWz
 wUU3X0T6+aECjLxPmV3l93iZ6aU4wknNau64kieDESeYKEPNIiSCRefS/LnLgQVw68CwxaPiiHc
 +CeJKrrHNkyeSOlKyAKaS/mKDuCZHiBuNxeTllssOkgnBnm7m/9olCfe2xqQycV3wkpKea7YzUj
 knVr3T+gvu+Wp7yK5PAxj2PlOoSxu7f3HC2JLjdaBrcj6vvaaL
X-Received: by 2002:a05:6000:1889:b0:47a:1f6b:ddb8 with SMTP id
 ffacd0b85a97d-47f4fceef45mr5753768f8f.39.1784155921082; 
 Wed, 15 Jul 2026 15:52:01 -0700 (PDT)
Received: from timur-hyperion.localnet (5401D94C.dsl.pool.telekom.hu.
 [84.1.217.76]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c25b2sm19885731f8f.30.2026.07.15.15.51.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 15:51:59 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH 02/14] drm/amdgpu/gfxhub: Enable retry fault interrupts
 when needed
Date: Thu, 16 Jul 2026 00:51:57 +0200
Message-ID: <e8giIPlBQ5SK8N3AZK-a1g@gmail.com>
In-Reply-To: <d03ddb99-56fa-4b33-b2a5-61a9af4e4e6d@amd.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
 <2821958.vuYhMxLoTh@timur-max> <d03ddb99-56fa-4b33-b2a5-61a9af4e4e6d@amd.com>
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

On Thursday, July 2, 2026 2:02:50=E2=80=AFPM Central European Summer Time C=
hristian=20
K=C3=B6nig wrote:
> On 7/2/26 11:14, Timur Krist=C3=B3f wrote:
> > On 2026. j=C3=BAlius 2., cs=C3=BCt=C3=B6rt=C3=B6k 10:10:10 k=C3=B6z=C3=
=A9p-eur=C3=B3pai ny=C3=A1ri id=C5=91 Christian
> > K=C3=B6nig>=20
> > wrote:
> >> On 7/1/26 18:17, Timur Krist=C3=B3f wrote:
> >>> Enable retry fault interrupts when initializing the GFXHUB
> >>> system aperture registers according to whether retrying
> >>> page faults is enabled in amdgpu (ie. amdgpu.noretry=3D0).
> >>>=20
> >>> Needs to be done for each GFXHUB version at once,
> >>> because none of them actually enabled this interrupt.
> >>=20
> >> Thinking more about it we are clearly missing something here. The retry
> >> fault interrupt itself should be enabled all the time.
> >=20
> > Why would it be enabled all the time?
> > I haven't seen any retry faults on neither Navi 3 nor Navi 4 without
> > enabling the ENABLE_RETRY_FAULT_INTERRUPT bit.
>=20
> As far as I understand it the GCVM_L2_PROTECTION_FAULT_CNTL2 is actually a
> debug register for the fault behavior of the GC block.

After our last conversation I tested this again and I can confirm that I do=
 NOT=20
get any retry fault interrupts on Navi 3 if I remove the code that enables=
=20
this bit. That makes me think this is not enabled by default.

> According to the register spec for Navi 44 the ENABLE_RETRY_FAULT_INTERRU=
PT
> should be default 1 and always be set under normal cricumstances.

This is definitely not the case on Navi 31 and also on Strix Halo.
I haven't checked on Navi 4x but judging by the fact that the gfxhub_v12_1=
=20
code has to enable this bit explicitly, I doubt it would be enabled on Navi=
 4x=20
either.

> >> IIRC only the RETRY_PERMISSION_OR_INVALID_PAGE_FAULT bit in the
> >> VM_CONTEXT0_CNTL register should be set or cleared by the kernel driver
> >> or
> >> firmware to control if the HW retries the access or not.
> >=20
> > That is clearly not the case on GFX12.1 and I haven't seen any indicati=
on
> > that it would be different on GFX11.x and 12.0 either.
>=20
> Mhm, then either the FW or golden register settings for that register is =
not
> correct.
>=20
> That we set ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY to one is rather strange=
 as
> well since we don't use that feature in the Linux driver.
>=20
> My suggestion is to always set the ENABLE_RETRY_FAULT_INTERRUPT in
> GCVM_L2_PROTECTION_FAULT_CNTL2 no matter what the noretry flag says, but
> I'm going to ask Alex and our ROCm people about that again when I have
> time.

I don't see why we should enable this bit when we don't want to enable retr=
y=20
faults.

Thanks & best regards,
Timur




