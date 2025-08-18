Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3935FCA0EE4
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 17:03:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5A7610E07F;
	Mon, 18 Aug 2025 17:03:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bz5Wl1aF";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEC3A10E4B5
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 17:03:47 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2445806ca1aso7107315ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 10:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755536627; x=1756141427; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uq7qo8m+W0ZQtDwMZa0yDOP8bQXZsO2zrdLgXBGQay4=;
 b=bz5Wl1aF9BliPgJg453Pm1A+YNRyNJe5AUHl+mzx19mPBvQR5oIMnZrVjWjCjlQVjk
 8BArREfgfU8dHJ5TpStFxprNIQyNUFRfRo6c5e5cFKKs/1sOixZ89xuwA3ev9w9dcszI
 eUtvWvVu3mv/hUzo0AWJvt0THRHg53kjhHlNz5CDDiLv9K2A2xlEU/c+XykF5xX78r5K
 fcWEIPByw+Ie6HU7NFFmaPvuJ4uyJln+plE2SWZrqzFUfcWdMysXgwvbfQI++YLNJ3Ft
 Xaj2hTuV1HULpz87ayFuRNQZuJqcQZkFE1rNfcPS0szbn3EqxFZer2cqZnp8W6I5MwKT
 yTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755536627; x=1756141427;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uq7qo8m+W0ZQtDwMZa0yDOP8bQXZsO2zrdLgXBGQay4=;
 b=VxGxi3wrShUKh9paietcg69A42aph/wdSd729NizJP/LdRonl5eTN/7hRSRAIjx3Po
 apd5B1YuNwDsyaxftO9C0erD6Bs8F8mEFHYXH3N/8QTOXJu4sfUXC7ATrc+qfwg3XgSw
 N3qdmWG1m4R6gaHjdD9Wt9K3hLKXZYb844LgCKHMdWb9DfIGJTJ5+KkmO7gFvdSjs4N2
 5ooMl1JQGDFNykGGK9LppT4lPpQ5w6OU2bqf05g2NY519SRJF0kaZBbFHvWpcy+Piv6T
 ninWvPTNq/Cwx/13AqXZm9g9OnPSmj3P+DG/qgJcVuHZt+zAzpZpawWTsndDQmCnP97U
 g3VQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW91wFxIfSkfS8s+9G+y8QjiuDRH/dQUIasfyb6kMDnYarqIglh6acs98lZ1SorMleYcFspESDt@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwFNfNG4CwTg/MwAijxsdNIomKlzzQNNZ4hVEcdbK/znAEgkKWz
 R6yXSr77eyWkH14Uj5WG56Fha1v2r+8nS1JQVN+SE+UKHdZrThXvtdyjQMv6yOGaidYUNm8bleD
 jQxsp5NWAFL+EATS8twe0xbopHRZreYw=
X-Gm-Gg: ASbGncsmSScSMQejVWTUHUkuhwYbNtZ7ul3NtihqOWIkt/W+vYRH3sARBkXhYp7LxqD
 dol0Od2OFShRmV4d8ePxbxktZZP1Eri+Ey7SoMZRm4H3QPpCrF3mjfEDgME95lwO9YFSCuSfe7/
 z8HLe2U+OK6CjnHb46OYGnGA9TsjLwAODp3XdDJoTE6Ne9YzIfYJIKm6h//1eNg05Z6wxy3Wk7r
 C3iK5Y=
X-Google-Smtp-Source: AGHT+IFd1dTGkpwQFywttmCvY8s0S1t5REKtFG1FGr6CxTY76oh9k1VN/H0Ww/ZfLGHodDDpy21m3hxg7dS51kp5A5U=
X-Received: by 2002:a17:902:f541:b0:240:9ab5:4cae with SMTP id
 d9443c01a7336-2446d5d6193mr77515045ad.1.1755536627159; Mon, 18 Aug 2025
 10:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250802160602.12698-1-timur.kristof@gmail.com>
 <5c44a7c2-1f2e-4020-bfd5-a86955e7191f@amd.com>
In-Reply-To: <5c44a7c2-1f2e-4020-bfd5-a86955e7191f@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Aug 2025 13:03:35 -0400
X-Gm-Features: Ac12FXwEbMzj1NX2yNLgUc98wzAkTFn-KEfzOJgK9uyFmk9qsABClrQT17G75T4
Message-ID: <CADnq5_Ok7hrAErkxT0osa=8B8X=9VONyi4gpH3jCKTN16WR-xQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] DC: Fix page flip timeouts on DCE 6
To: Alex Hung <alex.hung@amd.com>
Cc: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org
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

@Alex Hung
 can you pick these up as well?

Thanks,

Alex

On Mon, Aug 18, 2025 at 12:23=E2=80=AFAM Alex Hung <alex.hung@amd.com> wrot=
e:
>
> The series is Reviewed-by: Alex Hung <alex.hung@amd.com>
>
> The patch series is also tested in promotion test and CI without regressi=
on.
>
> On 8/2/25 10:05, Timur Krist=C3=B3f wrote:
> > Currently when using DC on DCE 6, it produces a page flip timeout
> > after a suspend/resume.
> >
> > After some investigation, it turns out that the issue is because
> > DC uses different interrupts between DCE 6 and newer HW versions,
> > and it assumes that the VUPDATE interrupt is always present, when
> > in fact it's not. It also assumes that the HW is capable of VRR
> > when a VRR capable monitor is plugged in, when in fact this is
> > not the case.
> >
> > This series marks VRR as unsupported on DCE 6 even when a VRR
> > capable monitor is plugged in. Furthermore, it fixes the code
> > trying to access the unregistered VUPDATE interrupt.
> >
> > As a side note, I also attempted to actually use the same
> > interrupts as newer DCE versions, but this didn't work.
> > Apparently DCE 6 was not advertised with VRR support anyway.
> >
> > Finally, there is also a patch to disable fast boot mode
> > on DCE 6. The rationale is that this already didn't work
> > on DCE 8, and even if it did I have no means to test it.
> >
> > Timur Krist=C3=B3f (3):
> >    drm/amd/display: Disable fastboot on DCE 6 too.
> >    drm/amd/display: Disable VRR on DCE 6
> >    drm/amd/display: Don't use non-registered VUPDATE on DCE 6
> >
> >   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 26 ++++++++++++------=
-
> >   .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 16 +++++++-----
> >   drivers/gpu/drm/amd/display/dc/dc_helper.c    |  5 ++++
> >   drivers/gpu/drm/amd/display/dc/dm_services.h  |  2 ++
> >   .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  6 ++---
> >   5 files changed, 35 insertions(+), 20 deletions(-)
> >
>
