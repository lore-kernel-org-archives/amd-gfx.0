Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499F6C88E75
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 17:23:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCC0010E109;
	Tue, 15 Sep 2026 17:23:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NdAD9SYc";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E59E510E109
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 17:23:10 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c2940ef15c1so13118866b.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 10:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789492989; x=1790097789; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=drXxK3Ob4F1sjELs/THgN0WFq+7nK1SJBnzarpIaRqY=;
 b=NdAD9SYcbl6/9YPA+/YCuY1Jm2TgI+wnJoqLKN4ulXyoVhKDWS26ign5FBkerpYx5/
 2Ykxf9cSi/IlcSCf07Lidqz/whORjsJvwrSaceCd27e/zuQPKIlnrQuKx5rJJMW/pxlo
 eMfGNpf6//1nnDeHi4WraOKdFLzJ6L08BjC3uHS18i8+3wRC2jErrjDycetpLavvgKfA
 RbBdbbg9Mgkznxv9mhU9Dmd9OPBR2lGP4Cz17xL8Qa6WuQN/NJbnbEfzgKcshRhxECnb
 E3iJMDbZJ1PoPQse22D1dyDd6cnBfw5Epv66Iz6dcP0XME7inoIAadH0IGoI/cMiWshO
 bvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789492989; x=1790097789;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=drXxK3Ob4F1sjELs/THgN0WFq+7nK1SJBnzarpIaRqY=;
 b=PayiLrqdYAoed06jX46wBrxvKnPxsVqUGHLWBOkazatJHCrw2QkLrEIifXjoMmzEqJ
 H908i5dYID8cGgO/DOyn+QZq41dFzK3DxGov1bMylCIiOictNUZpKxp6vSq2DzorGji0
 hpSWqjJs7CncMbi4YtDEGvCMnjXy84qeYHRYexVioqEoYxS5Y82CH98r6urx5I5fdbSN
 QJxN+NKWrBzjBRSZKLLbBp9Psxzmr2LW+l090ttOAUnU9PAEHANxyKfkyrkQBdHKgemT
 xQUOFwRBZ/jOeBonSvij22RBmn77465/Fh25FMnI4ETo1sVG1xFZWvgDuH+wEDBXC4r2
 AsnQ==
X-Gm-Message-State: AFuF++mwvVghYHUGhMTMsPhzE2BAIbFqzplbZq25FvLno2csAJwylzWs
 3sjURx/sX/w5I8kXJ/uvp6+Sfmk6ITfmc069U33g4moljOmgGsZ22+aV
X-Gm-Gg: AYBFou2Y0xnHoQhLLCVnTmyMGq9RDz906OhbJcbW3DuBVOLKuxxNVn3iWCvlyavFFjE
 RdTsFNIprTZuaZnE8c6nY9UgAxUmwBeNVzGhJD8YdtSQogFx8/n4PSvRiMdW7Gf5sQAQCn/nPd4
 Riv/ydLfX3kv0kL/sPGGndIg192B0GyrfMIV7hbJ2dLYVqPxuWMu1gIh/TaA0jlIy30flwpufIk
 FJMZjp5G2ySqFcrUi8p9TiPfd2P3qH5NplyjxZbdPeMYrXD5P+IH+vXH0qDPckvfp3S5jQ/ittF
 kBgMTjh1KCYpTvSGNcNey4qsEya4wmFj0uVq/nWkzWp0nk3s/HOvg+L50jCYGbiaBDroZ42764L
 iAxkZ/HzcAJjDgP34ZstKvIVY6mHiDB4bNd48uEA+PZr+DxcNhS3NAQ7jw5c32rDo9ugmgl1bmh
 09QYiW+XHAfiVUvTEZaaDbnRiOwjzj5OCCCVPbuFoDRnKDPRwkBlbU46MxvuPgiEOCI+5q1cuDd
 s/EMQ8UfZWKaY5gWImeFlOM7sT4f4tOMtCshR31GH4Gdt52tUz2nC9/
X-Received: by 2002:a17:907:3cc2:b0:c29:5d41:dfe8 with SMTP id
 a640c23a62f3a-c29d79b9fcfmr164712266b.43.1789492989039; 
 Tue, 15 Sep 2026 10:23:09 -0700 (PDT)
Received: from timur-hyperion.localnet (54001FD5.dsl.pool.telekom.hu.
 [84.0.31.213]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c29de48755asm6606766b.24.2026.09.15.10.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 10:23:08 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org,
 Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <nat@pixelcluster.dev>, Lijo Lazar <lijo.lazar@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Subject: Re: [PATCH 00/12] RFC: drm/amdgpu/sdma: Refactor SDMA v4 and older
 functions to be per-instance
Date: Tue, 15 Sep 2026 19:23:07 +0200
Message-ID: <CBgaIVTsRE2O7KG28C_9bw@gmail.com>
In-Reply-To: <CADnq5_P_cVmHqd5sB6vwGqYA6jSY_fY6EWQp+WofptCgC8nRLw@mail.gmail.com>
References: <20260907203316.159103-1-timur.kristof@gmail.com>
 <CADnq5_P_cVmHqd5sB6vwGqYA6jSY_fY6EWQp+WofptCgC8nRLw@mail.gmail.com>
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

On Friday, September 11, 2026 9:00:07=E2=80=AFPM Central European Summer Ti=
me Alex=20
Deucher wrote:
> On Mon, Sep 7, 2026 at 4:40=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@=
gmail.com>=20
wrote:
> > This series applies on top of my previous series:
> > "Improve existing SDMA queue resets" (currently under review)
> >=20
> > Prepare the code for implementing recovery for
> > SDMA v4 and all older SDMA (and SI DMA) versions.
> > Reorganize the SDMA 4.0 code so that the functions that are
> > responsible for managing the SDMA engines take an instance ID
> > as an argument.
> >=20
> > This makes it possible to manage the SDMA instances
> > independently of each other, which will enable us to
> > also use these functions to implement resetting and
> > recovering them independently. (The actual recovery
> > implementation will be in a follow-up patch series
> > which I will submit after this one is accepted.)
>=20
> This series looks fine to me, although I think I would prefer to apply
> it along with the relevant soft reset changes to avoid churning the
> code until each family is ready.  E.g., apply the cik_sdma refactor
> along with the CIK soft reset support, etc.  Unless you have something
> else in mind.

Thank you Alex.

My plan is the following:

1. I would like to first refactor the functions for every SDMA IP block ver=
sion=20
to be per-instance.
2. Then, I'd like to improve the soft reset code, more specifically the mul=
ti-
ring reset helpers and amdgpu_device_ip_soft_reset() to make them aware of =
IP=20
block instances and change SDMA v4.4.2, v5.0 and v5.2 over to use that code.
3. With all of that out of the way, it will be pretty easy to hook up the s=
ame=20
soft reset mechanism for SI, CIK, VI as well.
4. At that point, we should also consider if we want soft reset for SDMA v6=
=20
and v7. Technically these versions support proper queue reset through the M=
ES,=20
but in practice I've seen the MES fail so often that I wouldn't consider it=
=20
stable.

This RFC is basically a prototype for step (1) and only takes care of SDMA =
v4=20
and older just to show how I imagine doing the refactor. If you like this=20
direction, I would like to do the same for all IP versions before moving=20
forward with soft reset changes and other refactors. I prefer to do this fi=
rst=20
for all IP versions because I think it's important to have consistency with=
in=20
the code base regarding how the SDMA is programmed.

What do you think, would that be OK for you?
I understand this causes code churn, sorry about that.

Thanks & best regards,
Timur

>=20
> > Timur Krist=C3=B3f (12):
> >   drm/amdgpu/sdma: Refactor SI DMA functions to be per instance
> >   drm/amdgpu/sdma: Refactor SI DMA clock gating functions to be
> >  =20
> >     per-instance
> >  =20
> >   drm/amdgpu/sdma: Refactor CIK SDMA functions to be per instance
> >   drm/amdgpu/sdma: Refactor CIK SDMA clock gating functions to be
> >  =20
> >     per-instance
> >  =20
> >   drm/amdgpu/sdma: Refactor SDMA v2.4 functions to be per instance
> >   drm/amdgpu/sdma: Refactor SDMA v2.4 golden registers to be
> >  =20
> >     per-instance
> >  =20
> >   drm/amdgpu/sdma: Refactor SDMA v3.0 functions to be per instance
> >   drm/amdgpu/sdma: Refactor SDMA v3.0 clock gating functions to be
> >  =20
> >     per-instance
> >  =20
> >   drm/amdgpu/sdma: Refactor SDMA v3.0 golden registers to be
> >  =20
> >     per-instance
> >  =20
> >   drm/amdgpu/sdma: Refactor SDMA v4.0 functions to be per instance
> >   drm/amdgpu/sdma: Refactor SDMA v4.0 clock gating functions to be
> >  =20
> >     per-instance
> >  =20
> >   drm/amdgpu/sdma: Refactor SDMA v4.0 golden registers to be
> >  =20
> >     per-instance
> > =20
> >  drivers/gpu/drm/amd/amdgpu/cik_sdma.c  | 322 +++++++-------
> >  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c | 232 +++++-----
> >  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 561 ++++++++++++++----------
> >  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 577 +++++++++++++++----------
> >  drivers/gpu/drm/amd/amdgpu/si_dma.c    | 160 ++++---
> >  5 files changed, 1043 insertions(+), 809 deletions(-)
> >=20
> > --
> > 2.55.0




