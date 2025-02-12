Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34387C02198
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 19:33:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D24F910E12E;
	Wed, 12 Feb 2025 19:33:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mCUl2vcS";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 802E110E12E
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 19:33:15 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-220cd9959f6so86815ad.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 11:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739388795; x=1739993595; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LBIVuH+ppmJeihsO04eNi6ipyNZeTFfcv3lF0UfHlSs=;
 b=mCUl2vcSHSftvICiM+kmPenDhh4tX97hIQaN3KMH4gb7ehtCvuIf7s7nHVBxxw5Nh2
 ojWGjhiOKUz433ABKEHcLck9nZUwY9hK+6azNrW4teVNkbp5YO6qD9d2vPW66s1Jn9eq
 hYy9zW287v5zG2F7NJ4R9IO2bTcyMp4b1EhCNfEYXC3ZVGE57RY5ncdIPW5tfhJvXuHq
 6M6OFIVH3m+RFSQNCuXWJdJWbif0h+UONy4zbiq36UiLu1+gubLdfMD+JJuKVxsv2DkM
 85HxoeLZxpqzMN9fYFrGTiAZYi2XPRQPbXp+O3sAdPy6JDyUpTefyE02wO4CrKPk4d0V
 fhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739388795; x=1739993595;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LBIVuH+ppmJeihsO04eNi6ipyNZeTFfcv3lF0UfHlSs=;
 b=W/kUUNAs+aCZ8VL3GxyVTjyv61+GM/mdj5KZ0Wr5n7AmFPf36ocE/m8rCR8ddJZBrA
 8U69G3QBGV0tzJ778Lck2BRfrY9tMTCLn8mNgh0w3dWOOo5TM2yqB+mPuKiw/Wvm/GAd
 Kqgv83Z8t/kiSHLTgx+zoNY1SnF4cfIAi5pu3AmSDPjciryrWrmmkXcXlVkMNFmVBcc0
 X+cJQp+nCAadk3v2JojDYRglWaZV9jQFtppj02aBaqmiUQXX7OCnTCPDjyoOCrGStasB
 ms/IFAcmfnWp78RbUZjYfnsc1lo0L9vpLt3vFmHAxANfb4wruvt4vswZuj8U1i6+yTXv
 pFxQ==
X-Gm-Message-State: AOJu0YyJyESBmRDuNhNFI80RYiXNrCuZ2qfOVPQfgilGN8U4YdTnMHbL
 hMAu1TQlNwNuLvyWgU1wuFrDmQ5DtvoSnVWZhrgG+enr1DEvD2ZUMJxo1xPNaUCV8p0+aNbLQfv
 HzsbkpVFh79cnriHbHYZGAZE8ETFZbw==
X-Gm-Gg: ASbGncuyJTY7dZuDT/rpQidhYbvdXFBKNuUpQJ3mjrRBC8RcbbdB1Ych2h9tTx+Fqn8
 f6OrMjfCsciKw8PLhpmaEISKmYieoOLpZbXRmWrVNzUKBHyHNiOqtuSoiTDpI07/K2CBlYdLY
X-Google-Smtp-Source: AGHT+IHnvYAH76hJ0lZctUO0rv+Q4tHTf3fw+mzLrOzICKj9FNhNj2ASC4jSVbuZCM/GiAdfdlciuiT3/6wFC7C9G58=
X-Received: by 2002:a17:903:19c7:b0:20b:9b07:777a with SMTP id
 d9443c01a7336-220bbfe1149mr28486935ad.10.1739388794870; Wed, 12 Feb 2025
 11:33:14 -0800 (PST)
MIME-Version: 1.0
References: <20250211090203.2866457-1-jesse.zhang@amd.com>
In-Reply-To: <20250211090203.2866457-1-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Feb 2025 14:33:02 -0500
X-Gm-Features: AWEUYZmK2XfcDXqED5smmggPPGEXiOTUCWLyoEwf-GMnx65BcvALKGv9rmST5PI
Message-ID: <CADnq5_OdfQYiJoUCE_J1=Sac2vZizEYj1m35qjyC5Xxex3+zsA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Add support for page queue scheduling
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 felix.kuehling@amd.com, Jonathan Kim <Jonathan.Kim@amd.com>, 
 Jiadong Zhu <Jiadong.Zhu@amd.com>
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

On Tue, Feb 11, 2025 at 4:02=E2=80=AFAM Jesse.zhang@amd.com <jesse.zhang@am=
d.com> wrote:
>
> This patch updates the sdma engine to support scheduling for
> the page queue. The main changes include:
>
> - Introduce a new variable `page` to handle the page queue if it exists.
> - Update the scheduling logic to conditionally set the `sched.ready` flag=
 for
>   both the sdma gfx queue and the page queue based on the provided mask.
> - Ensure that the scheduling flags are updated correctly for both queues =
when
>   the mask is applied.
>
> The patch ensures that the SDMA engine can handle scheduling for both the=
 sdma gfx
> queue and the page queue,
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.c
> index 6ba785798a4a..e82ded95540c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -358,7 +358,7 @@ static int amdgpu_debugfs_sdma_sched_mask_set(void *d=
ata, u64 val)
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)data;
>         u32 i;
>         u64 mask =3D 0;
> -       struct amdgpu_ring *ring;
> +       struct amdgpu_ring *ring, *page;
>
>         if (!adev)
>                 return -ENODEV;
> @@ -369,10 +369,18 @@ static int amdgpu_debugfs_sdma_sched_mask_set(void =
*data, u64 val)
>
>         for (i =3D 0; i < adev->sdma.num_instances; ++i) {
>                 ring =3D &adev->sdma.instance[i].ring;
> -               if (val & BIT_ULL(i))
> +               if (adev->sdma.has_page_queue)
> +                       page =3D &adev->sdma.instance[i].page;
> +               if (val & BIT_ULL(i)) {
>                         ring->sched.ready =3D true;
> -               else
> +                       if (adev->sdma.has_page_queue)
> +                               page->sched.ready =3D true;
> +               } else {
>                         ring->sched.ready =3D false;
> +                       if (adev->sdma.has_page_queue)
> +                               page->sched.ready =3D false;
> +               }
> +

Not really specific to this patch, but if we disable schedulers here,
we may disable the buffer_funcs scheduler used by the driver for
memory management.

Alex

>         }
>         /* publish sched.ready flag update effective immediately across s=
mp */
>         smp_rmb();
> --
> 2.25.1
>
