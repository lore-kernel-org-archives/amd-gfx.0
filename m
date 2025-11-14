Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C78BCE7B13
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 14:39:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C571B10EA9B;
	Fri, 14 Nov 2025 14:38:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KrYd0ffU";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D78F810EA89
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 14:38:58 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-297ea4c2933so1590605ad.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 06:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763131138; x=1763735938; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lFDIf42a/8NBacaxtL3s+d+JqPGha0uXxGnBIHEXnJI=;
 b=KrYd0ffUbkQ9qfSTeCKkxDMIWEMDHtRBDtvUPRHx6x3zdGRlvZ6pTJ0JkHunw4hC4t
 BkbdMzO8aX8+/2t/RZFrP3cFYOThlVKS4TArRIEMHKDx6lQ61UdAiSBeR7u8UBGbO9BQ
 gUFviX2f6PDz98EWYvKGYjVjH31WMMg1pCASVcnkNRIvNaJWxbDqZ5M1MoNKmAGXCCev
 /ZGTKj9nxODcc73sa0vLNbkV0O1WvGi8c2M7FYaKHC3/dkX8yLZMpjhPCtm0bsIEiIzz
 MSzn6YA5Sgl562f6wB54n0UJjkTmpX1V2Tgb4gl3hTYtaXNQ8IrP+h/E/+wiob7NLmuc
 UhEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763131138; x=1763735938;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lFDIf42a/8NBacaxtL3s+d+JqPGha0uXxGnBIHEXnJI=;
 b=ijgloB1niT9cMGv7ioD7nWc84J3QZOCRXVHnDCtS4ANLYC/9HKqpFg1R6JQbBlsdR7
 oWCVhepY4tnIWOMxDa/jmbodJpcaa1tCkrCWQKj5cCp+2E53eYU9bsK7aZdN7SZSEsxg
 Avi1sO3KQsljS2PPYYYw1zqmsmehIA8naC+gQfmhD7EQyrtEk+UrdT2ZNuubX7iS6WX3
 A9Xw4cILcEgvo/DH4CvZ+TRwskptUJiT+q83Wop8/z+/D+8mUrn8B/ZPy3C0IbouzTjZ
 Wr8G9NwGYaZgdIrquBYNbwt1F2S5VeRb24AQ2MBkbELbSCNYyOy8p6WgwJOyZc9Qk8qb
 BGhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4XmhIfUr0NHXjfIKfqWBv/vcUpox5zIwK7tFmjD008tngRi3RRI/LirSeHElG2ELMa64CtuXp@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxzlwv27xYBDFizedajqbD/mWpS28FtuNzeTE5X0fDNyNj4N/Z4
 9k1Ee9qiCWL3w7q2PIVndSZOxpCr/nVXSeINAf7l/jUcJnYnhCu4JBHxOSaRGf4tb2ljTEJ3Xf2
 c6pRTxcdT9BwWjPiJMS7Kz/20Uj2AyeE=
X-Gm-Gg: ASbGncst1KqZ5cghkUjJHZ2MpR7YVIXPoYrKAIQ5Q5g5qATjqDXdW0pvEZvI5kR7ZTv
 AV36DvicXm0QxIBVXsEGrClp80VAy5XgI82ZahoGQfqooEvY+EMEgD53EB4qLej4SYm3PsaPp+I
 Cg5uivKy6e9n3sof8QETidwxHih2uT7hi2VflRsg4PsPeKFUrBGIvmW4XjvZK+20W7dbEwZX09a
 71GsRe7l7822r7jDch3e4yGSoT0Kui/MVufmpf8W/u0KuUm3BkQ2XMqkeyu3wECd/vcbFs=
X-Google-Smtp-Source: AGHT+IFbV0Np/yLCd4fTi6ctrklHcYlF9brP4D0Vu55UU7PFwm+x6Y++pesBXtj2kNjrZTHPoVJ/92AwQHaAHl//EO8=
X-Received: by 2002:a05:7022:411:b0:11a:5cb2:24a0 with SMTP id
 a92af1059eb24-11b40f87c55mr1135410c88.1.1763131138120; Fri, 14 Nov 2025
 06:38:58 -0800 (PST)
MIME-Version: 1.0
References: <20251114120736.31310-1-timur.kristof@gmail.com>
 <72c36b2f-4996-48f0-bcfe-87faf4ffba29@amd.com>
In-Reply-To: <72c36b2f-4996-48f0-bcfe-87faf4ffba29@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 Nov 2025 09:38:46 -0500
X-Gm-Features: AWmQ_bk2iqY-nQ50yjT9hC9rbnct7o01F_Mi99TAnqT_iWJxa0lkkbAdoyoPa_s
Message-ID: <CADnq5_PUb6_Ti=BfK++DNVD5JmDECJq-jFmQZms-T0QmB8L9qQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/amdgpu: Use amdgpu by default on SI and CIK
 dedicated GPUs (v2)
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
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

I had already applied the CIK series, so I rebased this series and
applied the documentation update and the SI patch.

Thanks,

Alex

On Fri, Nov 14, 2025 at 7:16=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 11/14/25 13:07, Timur Krist=C3=B3f wrote:
> > Changed in v2 of the patch series:
> > Updated documentation in Kconfig file.
> >
> > Now that the DC analog connector support and VCE1 support
> > landed, amdgpu is at feature parity with the old radeon
> > driver on SI and CIK dedicated GPUs.
> >
> > Let's enable amdgpu by default on SI and CIK dedicated GPUs.
> >
> > Why?
> >
> > Compared to the old radeon driver, amdgpu offers better
> > performance, more display features through DC,
> > as well as support for Vulkan 1.3 through RADV.
> > (Note, although the hardware is 10 years old, the R9 290
> > still appears in the Steam hardware survey for Linux
> > at a modest 0.25%.)
> >
> > What can these GPUs actually do on amdgpu?
> >
> > Hawaii (eg. R9 390X) can even play modern games such as
> > Baldur's Gate 3 or Cyberpunk 2077 and gives a decent user
> > experience considering the age of the hardware.
> > Tahiti and Pitcairn can play some modern games, albeit
> > at lower resolutions and lower frame rates. They are
> > mainly held back by a low amount of VRAM (2~3 GiB).
> > The other SI and CIK "gaming" GPUs are mainly useful
> > for playing games from their era (the mid-2010s)
> > or less demanding games in general.
> >
> > CIK dedicated GPUs are the following:
> >
> > Hawaii (2013~2015):
> >   Radeon R9 290 and 390 series
> > Bonaire (2013~2016):
> >   Radeon HD 7790/8870
> >   Radeon R7 260/360/450, RX 455
> >   FirePro W5100
> >   various mobile GPUs
> >
> > SI dedicated GPUs are the following:
> >
> > Tahiti (2012~2014):
> >   Radeon HD 7870 XT, 7950, 7970, 7990, 8950, 8970, 8990
> >   Radeon R9 280, 280X
> >   FirePro W8000, W9000, D500, D700, S9000, S9050, S10000
> > Pitcairn (2012~2015):
> >   Radeon HD 7850, 7870, 7970M, 8870, 8970M
> >   Radeon R9 265, 270/370 series, M290X, M390
> >   FirePro W5000, W7000, D300, R5000, S7000
> > Cape Verde (2012~2016):
> >   Radeon HD 7730, 7750, 7770, 8730, 8760
> >   Radeon R7 250E, 250X, 350, 450
> >   FirePro W600, W4100, M4000, M6000
> > Oland (2013~2019):
> >   Radeon HD 8570, 8670
> >   Radeon R5 240, 250, 330, 340, 350, 430, 520, 610
> >   FirePro W2100
> >   various mobile GPUs
> > Hainan (2013~2016):
> >   various mobile GPUs
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com> for the enti=
re series.
>
> I think Alex already merged the CIK switch, but that should be trivial to=
 resolve.
>
> Thanks,
> Christian.
>
> >
> > Timur Krist=C3=B3f (4):
> >   drm/radeon: Refactor how SI and CIK support is determined
> >   drm/amdgpu: Refactor how SI and CIK support is determined
> >   drm/amdgpu: Use amdgpu by default on CIK dedicated GPUs (v2)
> >   drm/amdgpu: Use amdgpu by default on SI dedicated GPUs (v2)
> >
> >  drivers/gpu/drm/amd/amdgpu/Kconfig      |  24 ++--
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 160 ++++++++++++++----------
> >  drivers/gpu/drm/radeon/radeon_drv.c     |  81 +++++++-----
> >  3 files changed, 162 insertions(+), 103 deletions(-)
> >
>
