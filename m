Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D41CA0EE0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 20:56:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 562CC10E7C3;
	Wed, 13 Aug 2025 20:56:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AvXW3t6c";
	dkim-atps=neutral
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com
 [209.85.160.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF67F10E7C3
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 20:56:44 +0000 (UTC)
Received: by mail-oa1-f54.google.com with SMTP id
 586e51a60fabf-30cce5be7d0so170664fac.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 13:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755118604; x=1755723404; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZsDO9IHoXJmIHbJNxBPgqYjdMyp3yu++D/pfLfNrBy0=;
 b=AvXW3t6cYMokCLk5ey2PQmBYmWOUwFeoMnrku/QH6B4xK1XiDVTyI3ZMY8KG2SEXei
 7q81s+ER/AyXcEov1oG1fTuj+rKMF1V+ExRzOMZdWO7AnX982mJVeoPTqqUhd0UEO3Ke
 wQeTvAlcj9nXIkil8H0EK8oTxs6IDBOR1LfYmex8UiK2kllGmsyefmctTHKXw0teHObj
 cC+d0xttoGZHJsgeaXaTkFjpj+TJeLGVqZVyCDqlsUNcdPIWQUBR430vxBv35FOaEjtb
 EeVxi09ozJ2cgcJyhLWJGfXz6TaC98mFOGPSXQYb2NAR7ZiHUfGLaO0l8yW0GGc5jw/S
 FUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755118604; x=1755723404;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZsDO9IHoXJmIHbJNxBPgqYjdMyp3yu++D/pfLfNrBy0=;
 b=Pg1119zAZOPjpxW0sOV5FP2BN54sbq224Hwn8cN5vFNwILw2MMWg4jQqMhZdZKtbFj
 fQ3d6t71hpyeuMYX1d3M7GVvY41yLnCNty0x1Wq3rGHWYZuJL63MYAY+x9FMLFv4+rUy
 S4lNdx0oJ/DzcUPZm4e8DrBbpvCTSYKytn7qob5p1JkbQJhkb7JKJoB9MKEakfJ1x6Bz
 YJnr43+MwJ0lMaM5rh8wAKTeqcioMM9T/imZQqNKRmLfBAYXw3G5LvT8LLym+lPrv18J
 1rLEaI9ujaYvc7DnKpEx8jKSoLv35+2cdFJs2yATDuRL82ruPerONjCvVjvSKN/oGiLK
 thRg==
X-Gm-Message-State: AOJu0Yy7M8YpBY5iDkiXJyHCk/7vqxOC39mv87OTyLty1JHjaBq+F6vE
 0rWdfkps1OWdHznatkefUqBbzwHbKqCA7pOkVcPUP3IsTSlzCOjAKeRpX2sTs4/w9rK8J+LQe8e
 L9uaMbyvf+tkMi8XwrCYuRNU1gn+/I0g=
X-Gm-Gg: ASbGncvgnSQPFBOjOYSaauqSUP2qpoi//6K4kefgqa5yyjYpEifGJTSrovIXzzXoRu2
 dV3NzYmyU2ziETjQkrV6NcTzXSK3ghOM92a1ERJBWmTZuowqhilr50WWjJo2z3n0yecFJVVaBYh
 8cfjgVVGMRrSkQoPgqpRw978U22lZ1OOJsV28cVKF+cfBAprkKkq962Oiz9z/Z6ZWFDLK7BECAJ
 A0ccBH6
X-Google-Smtp-Source: AGHT+IFDZRNCqYOV+yRJXpEilYrxICK/ibWpeAc96ZHTvUVwqki25rMccggJlo8C0z+DheOvufBdbe9l0LgbZ3Y22GU=
X-Received: by 2002:a05:6870:d04:b0:30b:8066:bf03 with SMTP id
 586e51a60fabf-30cd12ec099mr446891fac.20.1755118603845; Wed, 13 Aug 2025
 13:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250813000141.105508-1-alexandre.f.demers@gmail.com>
 <CADnq5_M8gjwe8q1ZZABOSz42RDCzDPjQGQQdQ0OxLV2BB8y38A@mail.gmail.com>
In-Reply-To: <CADnq5_M8gjwe8q1ZZABOSz42RDCzDPjQGQQdQ0OxLV2BB8y38A@mail.gmail.com>
From: Alexandre Demers <alexandre.f.demers@gmail.com>
Date: Wed, 13 Aug 2025 16:56:32 -0400
X-Gm-Features: Ac12FXwRA1pOXaPR-GD1FbbND2qr1bhCx_Ju9bU7Tt8t-3Ln28aV0gt5BuANfJw
Message-ID: <CAPEhTTGeVfHqB8ck_dvFx47LEdgOkbG2OBCHC4W3kh-vRWPThg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add and use "name" member to radeon_ring struct
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Aug 13, 2025 at 10:15=E2=80=AFAM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Tue, Aug 12, 2025 at 8:08=E2=80=AFPM Alexandre Demers
> <alexandre.f.demers@gmail.com> wrote:
> >
> > This series adds a "name" member to the radeon_ring structure and
> > uses it instead of ring indexes in logs and std outputs. This change is
> > proposed for better logs readability and ring identification as much
> > for the average user as for debugging purposes.
> >
> > It uses the same naming convention as the one used under amdgpu for
> > coherence between the two drivers.
>
> What about the other devices supported by radeon?  If you are going to
> change this, it would be good to fully convert the driver.
>
> Alex
>

Good point. I'll send a V2 for the series when I'm done.
Alexandre Demers

> >
> > Alexandre Demers (4):
> >   drm/radeon: add name member to radeon_ring structure
> >   drm/radeon: rename ring to ring_idx in
> >     radeon_fence_driver_start_ring()
> >   drm/radeon: name rings
> >   drm/radeon: switch from ring->idx to ring->name for printouts
> >
> >  drivers/gpu/drm/radeon/cik.c          | 33 +++++++++++++++------
> >  drivers/gpu/drm/radeon/cik_sdma.c     |  6 ++--
> >  drivers/gpu/drm/radeon/ni.c           | 10 +++++--
> >  drivers/gpu/drm/radeon/r600.c         |  8 ++---
> >  drivers/gpu/drm/radeon/r600_dma.c     |  8 ++---
> >  drivers/gpu/drm/radeon/radeon.h       |  1 +
> >  drivers/gpu/drm/radeon/radeon_fence.c | 42 ++++++++++++++-------------
> >  drivers/gpu/drm/radeon/radeon_ring.c  |  4 +--
> >  drivers/gpu/drm/radeon/radeon_vce.c   | 13 +++++----
> >  drivers/gpu/drm/radeon/si.c           | 36 +++++++++++++++++------
> >  drivers/gpu/drm/radeon/uvd_v1_0.c     | 14 ++++-----
> >  11 files changed, 109 insertions(+), 66 deletions(-)
> >
> > --
> > 2.50.1
> >
