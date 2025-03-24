Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB96C36002
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 19:26:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00B1710E4CD;
	Mon, 24 Mar 2025 19:26:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="alFSqBNP";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D36C10E4CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 19:26:31 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-301b4f97cc1so1492808a91.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 12:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742844391; x=1743449191; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dDzwAWRTvaIAULT1Vt7MU+jvGB8qpxsc3IYDzPQVucg=;
 b=alFSqBNP2zSCd83cGArmJfmzmcb9cV0lmFxRpN3OvspIp0/PPffTk6jFOuQf4Je3bQ
 JqnRNRSIzv8MhHzJ2ahckqwNJxb9d4Bdy+mpUR47rXkUkEf35jtmMKw+2MGiT51FdOpY
 rVLlpu0X40ZbbAFxjgairV0accwJf+2+I7ZCuQcAdgFmxfMEnGeCGsAhtthOxidBlrFp
 qHKoJgf5x4HySaCY6kK1VSbwyBA9LTUs6S0m6ppjj11UVb7CphyGiB8A7yLIqY4rarlm
 5lgEgfkv+liBjuBpdFVGkAF8bp6q0qXKRBPhSIYLa6WCGvMuSUDVJRp5pBRzo4MeAYU1
 tDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742844391; x=1743449191;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dDzwAWRTvaIAULT1Vt7MU+jvGB8qpxsc3IYDzPQVucg=;
 b=TonozFSWcmA3JK3lCdkwHDo0seeUwQs7nHThHsuIg2x2uK1pkAhw/OTn1Z3rzzzzO4
 fZllp92oEvkHEHiE8PWbTwqTGnFnn07eytChaM1eQmM7BPcD7chEY17scV0VOim8IUnP
 xtM56UXWooGkn7kHHx1NSwtFeKCx/ljM86+IIz9dOvwqbT3U5fEC3awfYBIZISMZOVFY
 2TQO38uM7DBqglkFA8Kwz3gW+hCE5MDuDb4UgVTCBW2KgWfrMPQKgVwk6MNhCckbgL4X
 Gu9lGJcD45E0Ew8lQ7J/JFSMs7kIXfAJg1T5x1mzLYrCvP7VQ/U8kqYHxQY5FCtDlC9D
 iQlg==
X-Gm-Message-State: AOJu0YxO8kiPg5QkfLhPXHWRmIl4MHLLBDoaKn/xs4yBSrUfXnKbe4FP
 7qr+0j3zH3KiZTl8reKUgbb9OFNjyUFxcXY4u9am6AGxZkpZOOsRKXBzhGB3SC3QAONxfulLjCl
 eH7xBn8XjGijtzuPDVbXtDM24Cus=
X-Gm-Gg: ASbGncsGcD4KlcN72epMhQxwxjd6mFhZXymF87d7VQR4Q/dl+D3cdu+3HxYTwjWFUWl
 v2CKn0P9Xv1JaSlXNdgqKI8V2ko2vHiogVJlf0gIzMNJQ63Ob91CddTG7FyU37AJl8h/GablGQD
 MDASIJ0SL++1VR18yxyvSiSzlCsw==
X-Google-Smtp-Source: AGHT+IFoAEl0poXfFYtuFB5nYS2AbtwmGEQ6ZpqYkNkncDtgXA5WaWp71HV0gpsdMqGNZR0V0v4PHPCsViCJ8ZZqsOA=
X-Received: by 2002:a17:90b:4a89:b0:2ee:acea:9ec4 with SMTP id
 98e67ed59e1d1-3030fee30e6mr7602242a91.3.1742844390994; Mon, 24 Mar 2025
 12:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250322014700.62356-1-alexandre.f.demers@gmail.com>
In-Reply-To: <20250322014700.62356-1-alexandre.f.demers@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Mar 2025 15:26:18 -0400
X-Gm-Features: AQ5f1JrJzQFJoBVVvmvakSzDpy2O8dHZ_hD1dtGHDGb4FNjxnjsXAygXimCIyrk
Message-ID: <CADnq5_Nj=5h+skoxE488zYZujQPG4t88n8mX9LRCMuE76fxYEQ@mail.gmail.com>
Subject: Re: [PATCH 00/18] Properly wire defines,
 shifts and masks in SI and cleanup
To: Alexandre Demers <alexandre.f.demers@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Fri, Mar 21, 2025 at 9:58=E2=80=AFPM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> The following series is intented to remove duplicated defines, shifts and=
 masks or
> to classify them where they belong. si_enums.h has been used as a garbage=
 can
> for anything and everything when moving SI code from radeon to amdgpu.
>
> Where needed, the defines found under sid.h and si_enums.h were ported to=
 DCE6,
> GFX6 and GMC6 defines, shifts and masks. There location was based on CIK =
and
> later.
>
> However, most of them were already available, but not used where they cou=
ld be.
>
> This series is running on my PITCAIRN setup without any visible drawbacks=
.

Applied 1-9, 12, 14, 16-18 with some minor fixes.  See my comments on
patch 10.  The remaining patches depend on patch 10.

Thanks,

Alex

>
> V2: Drop unneeded comments.
> Remove "ix" prefix on some defines, since they are not indexes.
> Make sure each patch has a description.
>
> Alexandre Demers (18):
>   drm/amdgpu: move GFX6 defines into gfx_v6_0.c
>   drm/amdgpu: wire up defines, shifts and masks through SI code
>   drm/amdgpu: use proper defines, shifts and masks in DCE6 code
>   drm/amdgpu: remove PACKET3 duplicated defines from si_enums.h
>   drm/admgpu: move si_ih.c away from sid.h defines
>   drm/amdgpu: use GRPH_SECONDARY_SURFACE_ADDRESS_MASK with
>     GRPH_SECONDARY_SURFACE_ADDRESS in DCE6
>   drm/amdgpu: move DCE6 away from sid.h and si_enums.h defines
>   drm/amdgpu: add missing DMA defines, shifts and masks
>   drm/amdgpu: add missing GFX6 defines
>   drm/amdgpu: add missing SMU6 defines, shifts and masks
>   drm/pm/legacy-dpm: move SI away from sid.h and si_enums.h
>   drm/amdgpu: fix GFX6 variables for sid.h cleanup
>   drm/amdgpu: move si.c away from sid.h
>   drm/amdgpu: move si_dma.c away from sid.h and si_enums.h
>   drm/amdgpu: huge sid.h cleanup, drop substituted defines.
>   drm/amdgpu: keep removing sid.h dependency from si_dma.c
>   drm/amdgpu: cleanup DCE6 a bit more
>   drm/amdgpu: continue cleaning up sid.h and si_enums.h
>
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |  176 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |   15 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |    2 +-
>  drivers/gpu/drm/amd/amdgpu/si.c               |  387 +++--
>  drivers/gpu/drm/amd/amdgpu/si_dma.c           |  116 +-
>  drivers/gpu/drm/amd/amdgpu/si_enums.h         |  234 +--
>  drivers/gpu/drm/amd/amdgpu/si_ih.c            |   17 +-
>  drivers/gpu/drm/amd/amdgpu/sid.h              | 1546 ++---------------
>  .../include/asic_reg/dce/dce_6_0_sh_mask.h    |    4 +-
>  .../drm/amd/include/asic_reg/gca/gfx_6_0_d.h  |    2 +
>  .../drm/amd/include/asic_reg/oss/oss_1_0_d.h  |   23 +-
>  .../include/asic_reg/oss/oss_1_0_sh_mask.h    |   43 +
>  .../drm/amd/include/asic_reg/smu/smu_6_0_d.h  |   44 +
>  .../include/asic_reg/smu/smu_6_0_sh_mask.h    |  190 +-
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |  358 ++--
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c    |   42 +-
>  16 files changed, 1001 insertions(+), 2198 deletions(-)
>
> --
> 2.48.1
>
