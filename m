Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB11CCF9E3
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Nov 2025 14:50:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5177B10E087;
	Wed, 12 Nov 2025 14:50:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bjSshznR";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4A1710E087
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 14:50:39 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2960771ec71so1194255ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 06:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762959039; x=1763563839; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jj8byohe+fuIewVxF3HngRMgO17jHwhibAzeOOM1+Ns=;
 b=bjSshznRTAhi0Qe+Wd1Fu7gDZWESJTzvYG/a3liUP3VoCyEeawUZZj0MGXAvARpl/G
 Ie8SzI22ADFBbb4pBz8cigZpoyaQvkc2PaDqLATSYwpP9WhGX6aHfi42iJEVD30S3Ei8
 NYt41Eh6Una2rqNSHZ+xaXeWGpV7fFW8KrDOtF6TWPKD2WutrGUDN0GXU/ABptJQdvAG
 5tThZjBclib+Bkhe3TZ7mWSNpWZZFO2SjQRl13xTCUsGmlNkSPdB42Hp0ZY40+K+VxDV
 lb/vR4zIiYbml2C/ExjYvEG8Ra9NOKmVR+3M3eCXjt6fEOVsvbZdcl215VWNYLKw/R+h
 yAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762959039; x=1763563839;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jj8byohe+fuIewVxF3HngRMgO17jHwhibAzeOOM1+Ns=;
 b=Y4t8BS4SAvnGB43XVsS5vO5EIlXRuVXw8vhA0PGpqEIrzVUDfdXwmYHx5pC9MqP6oL
 TjJ+sKB3XaK1676tLZGy+1WIJGVpO3HYxU2/ftQhumRaB9jChvFUYe1Ry004FaYFWwx1
 +N9PHPEsvyYGbTeA9aYbGZSKI73rTTLgjazR4PrbkxCM/i/OdFxo0wjsXZklMbLd0/Dp
 q6PWM5uYxnKNCRDxNbCxdGZ3wjZzdO6IRPW0fay2L1nVZ6zCv3B36l/cmJ/M3a5gI01g
 jZEOGDkNaprnKphFfNeGhKMcoTevHqsw/z2KDkv55/ljvXZ8Llcf/obfturH4fmYps1E
 9tOg==
X-Gm-Message-State: AOJu0YxMclVAL0jWJrGhPZ1BT9TzDGDKgJSMDBq+avQI5tDBrN3x1R3W
 B343cpQy2ZCU18OtL9JjMcAesXZf0KF75y443hb8cnmm3M/E+XVPrVB8UPsh0Myz7MRectrfaPe
 /uRaGZy6BaVNOz6vq8pv2wxJC7QSXcpE=
X-Gm-Gg: ASbGncsWIR+ezCGZIYrgjnzhm17r/zH0H3v38t2B9zmxbUgJQQeMBOJ2fi90bQCXjOb
 mIwZTOCRsUEwLBIHuHtEwBKLkZzCLUWNIsKVeCsLIKCu7kMaNhp4KKS6pRtvJKpQXIqs0gBy6uJ
 OrRBqS8GzkFeNWDoOWxLgHw8MlA0ECG1T4xU/jh5+Fp4uD/wFggMlUJm/2sPYoZes345zBiSqKg
 91hebh35TMah4apPLCk2bgMnzzCfR+mUSnvLiEXX83cytWFwHkyVEz0tWXU
X-Google-Smtp-Source: AGHT+IHzWJMiTeI2zG0GQNWRuJTi1WaTHk0WYAHMuzAj6TFtEByDQD2f8ZMjAMebRSBFrsb60qoXJkjR20Hr68DK9gI=
X-Received: by 2002:a17:902:d486:b0:295:54cd:d2e2 with SMTP id
 d9443c01a7336-2984ec86ddfmr24829495ad.0.1762959039112; Wed, 12 Nov 2025
 06:50:39 -0800 (PST)
MIME-Version: 1.0
References: <20251109154106.43279-1-timur.kristof@gmail.com>
In-Reply-To: <20251109154106.43279-1-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Nov 2025 09:50:26 -0500
X-Gm-Features: AWmQ_blT2wNhuFp-C8VTDaIKFTWTlknW3yldgi3n_XVd6zHx2XfCIITBRhQ8y70
Message-ID: <CADnq5_OwN1mOgvi04mEw8G78u1_QXJEg54qT6Kkb25_wO8AHhA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Use amdgpu by default on CIK dGPUs
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
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

Applied the series.  Thanks!

Alex

On Sun, Nov 9, 2025 at 10:41=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> Now that analog connector support is merged in DC,
> amdgpu has reached feature parity with the old radeon
> driver on CIK dedicated GPUs.
>
> This series refactors how the default driver for SI/CIK
> is determined, adds a "-1" option for default, and makes
> it possible to determine the default depending on the
> chip. This way we can make sure to keep using radeon on
> those chips that are not at feature parity yet.
>
> As a reminder, CIK dedicated GPUs are the following:
> Hawaii (2013~2015): Radeon R9 290 and 390 series
> Bonaire (2013~2016): Radeon HD 7790/8870, R7 260/360/450,
> RX 455, FirePro W5100, etc. and their mobile variants.
>
> Why?
>
> Compared to the old radeon driver, amdgpu offers better
> performance, more display features through DC,
> as well as support for Vulkan 1.3 through RADV.
> (Note, although the hardware is 10 years old, the R9 290
> still appears in the Steam hardware survey for Linux,
> albeit at a modest 0.25%.)
>
> What can these GPUs actually do on amdgpu?
>
> Hawaii (eg. R9 390X) can even play modern games such as
> Baldur's Gate 3 or Cyberpunk 2077 and gives a decent user
> experience considering the age of the hardware.
> Bonaire can play games from its era well.
>
> Looking forward to reviews and feedback!
>
> ps. After VCE1 support is merged, I would like to also
> enable amdgpu by default on SI dGPUs.
>
> Timur Krist=C3=B3f (3):
>   drm/radeon: Refactor how SI and CIK support is determined
>   drm/amdgpu: Refactor how SI and CIK support is determined
>   drm/amdgpu: Use amdgpu by default on CIK dedicated GPUs
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 159 ++++++++++++++----------
>  drivers/gpu/drm/radeon/radeon_drv.c     |  80 +++++++-----
>  2 files changed, 144 insertions(+), 95 deletions(-)
>
> --
> 2.51.1
>
