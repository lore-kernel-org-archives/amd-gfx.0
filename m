Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9CCC25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 30 May 2024 16:35:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA9FB11B956;
	Thu, 30 May 2024 16:35:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CAtxkWYi";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE38511B6E9
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 16:35:22 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-1f44b5b9de6so643985ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 May 2024 09:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717086922; x=1717691722; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z808VwFKm938mcRwo6gMBBo0JtqizuzIjGkgKY74db0=;
 b=CAtxkWYiJapi9tgHyb89R/U0NMtDNf/35IjNjPE2nQz0jZz1OHepvqTDOV3Tc8J7d8
 /r2FsVFDoB52ur7krSL9dUNH44TNIlAirm7TXB4GBcG0/IwB7gnBBoRi2397eJdZIwNe
 l7klNqHRPkXA2/u1KomXk2BuxcVmMYpMo1SBwDYVX6J0H7aSmcxUBiC1mP9ht4LVP5jX
 kRMSSQfU7cFpjGnVb2cgpYR7paM57XfGFmBRqLbOjwjf5KapTAs60deji4ElMv5XeQNK
 OkeY3piiRBjreTkP8vB4wnYpB19HV5Zgxy5YVD4BvqvGf9Vglwu4ubTyRNNevpMoGGIN
 UK9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717086922; x=1717691722;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z808VwFKm938mcRwo6gMBBo0JtqizuzIjGkgKY74db0=;
 b=nKqJY2fCOrVs/5f62X473jaGdSlgjRuetawhyOuGduq/VPK+Hu7koD6OgXlAZRHNG/
 BT5uynvEv9AhSpgitvcune6lebvm7uJYUMOtthijTV8mJttP9EQ3UYll3Bmjek8520i+
 vqsRceMSyAByp1bNdAhmo/qpyVObyd1CquwBWRmucUGlaJyXIjWP3f8hjfZ1erTXA1pP
 kymNU37yaqQi74ICgyS+6fQb+33TX1uiQMRz1WrAqjFCBfXgRkzIphnOUis3Au12xukl
 05OjjEo5VrctHkdohwwOw+LfsltUC27FsG0YYMC3sXYr6xCO28334ZwfpacHD2yJPOXx
 cdbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwqqAFLTfQzbM0CET+6Aogfoe1JdvrBjwdx5JGZtK44+J0rP147MYfF+zKB8+RlQNKQCZrfE2LMhn1aR8W2BmQSPjcTfQRW7XdJfKJdw==
X-Gm-Message-State: AOJu0YyqiMn1CxZ9VqlwrWxuzW37Td0Ksz9w/y2AuVg8ZVRu4iyVcVzS
 iZuaSLpOgpo070c9RS5EuHJNb/YytUsAvpFT/7k4JnsMIeFSDf2JijB93idV4q+S9NvD1d3MNi8
 iw/lLKc+ZR/CnXRScX0dCYGQqBHA=
X-Google-Smtp-Source: AGHT+IHei3VfuiaH2I2jAMPh1Y7IIJKpqx+LKEr0Uo507xucpJ36z3VEToEH+fzihtGnqewcFYDlq9sFLFios7hM7NY=
X-Received: by 2002:a17:902:e74f:b0:1f3:53c:32be with SMTP id
 d9443c01a7336-1f6192ed4eemr29678565ad.2.1717086922045; Thu, 30 May 2024
 09:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240525021041.1780050-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240525021041.1780050-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 May 2024 12:35:10 -0400
Message-ID: <CADnq5_MG+0xxVYc13syRVfM22_pWUO0VpEDYyC46XQprd0PDpQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix type mismatch in amdgpu_gfx_kiq_init_ring
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 kernel test robot <lkp@intel.com>, Lijo Lazar <lijo.lazar@amd.com>
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

On Sat, May 25, 2024 at 1:47=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> This commit fixes a type mismatch in the amdgpu_gfx_kiq_init_ring
> function triggered by the snprintf function expecting unsigned char
> arguments due to the '%hhu' format specifier, but receiving int and u32
> arguments.
>
> The issue occurred because the arguments xcc_id, ring->me, ring->pipe,
> and ring->queue were of type int and u32, not unsigned char. This led to
> a type mismatch when these arguments were passed to snprintf.
>
> To resolve this, the snprintf line was modified to cast these arguments
> to unsigned char. This ensures that the arguments are of the correct
> type for the '%hhu' format specifier and resolves the warning.
>
> Fixes the below:
> >> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:333:4: warning: format
> >> specifies type 'unsigned char' but the argument has type 'int'
> >> [-Wformat]
>                     xcc_id, ring->me, ring->pipe, ring->queue);
>                     ^~~~~~
> >> drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:333:12: warning: format
> >> specifies type 'unsigned char' but the argument has type 'u32' (aka
> >> 'unsigned int') [-Wformat]
>                     xcc_id, ring->me, ring->pipe, ring->queue);
>                             ^~~~~~~~
>    drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:333:22: warning: format specif=
ies type 'unsigned char' but the argument has type 'u32' (aka 'unsigned int=
') [-Wformat]
>                     xcc_id, ring->me, ring->pipe, ring->queue);
>                                       ^~~~~~~~~~
>    drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:333:34: warning: format specif=
ies type 'unsigned char' but the argument has type 'u32' (aka 'unsigned int=
') [-Wformat]
>                     xcc_id, ring->me, ring->pipe, ring->queue);
>                                                   ^~~~~~~~~~~
>    4 warnings generated.
>
> Fixes: 0eb430076172 ("drm/amdgpu: Fix snprintf usage in amdgpu_gfx_kiq_in=
it_ring")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202405250446.XeaWe66u-lkp@i=
ntel.com/
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 68505eaa92f9..19b1817b55d7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -330,7 +330,8 @@ int amdgpu_gfx_kiq_init_ring(struct amdgpu_device *ad=
ev, int xcc_id)
>         ring->eop_gpu_addr =3D kiq->eop_gpu_addr;
>         ring->no_scheduler =3D true;
>         snprintf(ring->name, sizeof(ring->name), "kiq_%hhu.%hhu.%hhu.%hhu=
",
> -                xcc_id, ring->me, ring->pipe, ring->queue);
> +                (unsigned char)xcc_id, (unsigned char)ring->me,
> +                (unsigned char)ring->pipe, (unsigned char)ring->queue);
>         r =3D amdgpu_ring_init(adev, ring, 1024, irq, AMDGPU_CP_KIQ_IRQ_D=
RIVER0,
>                              AMDGPU_RING_PRIO_DEFAULT, NULL);
>         if (r)
> --
> 2.34.1
>
