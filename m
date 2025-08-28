Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66ADCA0EED
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 17:00:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69D4410EA54;
	Thu, 28 Aug 2025 17:00:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BLaB3AGc";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53CB910EA54
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 17:00:43 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-b49c729577dso112225a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 10:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756400442; x=1757005242; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aUPzfQL9QgyMgHaV1sIv5GjFS5sHvbwXLTqDJazvm5Y=;
 b=BLaB3AGcyPyYs18PrVscXNoV4Fx3nuiIUNnYvnOgclWgBulLzigGTMzulBz6W1M2sH
 W9jOKDWPVNCpK8SxIQNuWgTi1iAnmMlqa3XOzWOY79yQZie6PqxjXCvPGbvroq/HYcjD
 VvaFXP15Okt8oUwapLBBscVD77eMvkILISiZZRrCrS+sI51Vu9QL4MoP6Bya7sFryixo
 aizfk3N0HK3zVw+axYJUAdyXszpCO7Ej+GeHjUYYR/CDQbc9cTPj7aimSe5Rc9Lq1ecn
 oYQnus75oCoC2sC572ThSz1/ko/DS3lJiR0L20GEDnA8N8w3Cp8jSqr0kbSsmbu6mcd7
 zSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756400442; x=1757005242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aUPzfQL9QgyMgHaV1sIv5GjFS5sHvbwXLTqDJazvm5Y=;
 b=Fk67Q7YD21kkU27hhuA+kl4cdjhOBJTCVxXnm/tbOn3AqDUJp+s8/f/6R5YNiuqg8G
 p3qGNUICCLeyRMkg0NsJ3kXqzGcvQY29ak+GFIuEFnOnW0brW+zFywkErSD9MRU24ocJ
 gQPaBzAWyzVR45k5hpj1JdHEyz2RYXFqg8Yd7uwOAiKQcaXNkBRtkBtH2/ba3LH98UmM
 JaUj6htjMrR+jBAzRY3AB+3K3IZeLdVXDI7YOiXMV+rFmXIYc9nGx3o6ZjN+OxDO6VFg
 Y0te8jxso+srq1tfBczObpMhHlQS6uBAB42cKHS36vEpDJhzarh/oWToRY/lVdqGFsxp
 71NQ==
X-Gm-Message-State: AOJu0YxNL1Oj0VFUq6NLJkxgTBlOvDbD1ZBjYsk5KQ9A2h+VtUsXPZYZ
 +rXoCHuMF4UG9YgKXUBC0XwJ90Vw+RC3q+wy1zXJrvMuBUzb0bGrVTEqQaNnC7QUG+bS5w2PZCC
 mnkZuX5HFzeiiIyyqHCdemdkhf3R9Iqk=
X-Gm-Gg: ASbGncuAZnCHjmgSW5QFHwmOfqcqtuSjO04nk25Auy2WitLM+DvDfmXfagu1CGOOtHZ
 wHVJ9nwu2Sj02aRHcgza5/JO8OmBFNPHHtIKxscD3kuQ+x9ScZ0Q3iEug5IfpaI6otEj2IJNMhi
 lsSpX+N63fMb3dlsKD/cv1xGlZ9csuxZGUe7SPmWR++f6RiwkWef5YFrbwclnYb3v3W1Z7Jagez
 BWOVK3VPzDOsVvOtw==
X-Google-Smtp-Source: AGHT+IEv02jn8FF4PqdmXtFCBGwWwnHujMIqQOmrBIulIevUNlTdY4LASUsvLOewqTtZCdffVC90ra0+97iUtOGoZ04=
X-Received: by 2002:a17:90b:388b:b0:327:956b:fd49 with SMTP id
 98e67ed59e1d1-327956bfee2mr3740304a91.6.1756400442426; Thu, 28 Aug 2025
 10:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250828151112.15965-1-timur.kristof@gmail.com>
In-Reply-To: <20250828151112.15965-1-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 28 Aug 2025 13:00:29 -0400
X-Gm-Features: Ac12FXz-CGU-BVpaHV88MX5uIx7iKNHR6xGoc8biA95ZmjfGb7XoU4zRaJpBP5g
Message-ID: <CADnq5_NnHKGFzUHFu=o=iu77x6=iYocQzCkpXB8gb32VJeG0HA@mail.gmail.com>
Subject: Re: [PATCH 00/10] SI power management fixes (v3)
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com
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

On Thu, Aug 28, 2025 at 11:11=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@=
gmail.com> wrote:
>
> This series fixes some power management issues on SI,
> addressing the feedback I got for the previous versions.
>
> Additionally, the following improvements were made:
>
> There is now a patch that increases the SMC timeout.
> This gets rid of some errors that happened when
> switching between power states. Apparently the SMC can
> sometimes take a long time.
>
> Also removed one of the ad-hoc fixes from si_dpm because
> it didn't actually address anything, and edited that
> patch to focus on just solving the flickering on Oland.
>
> And edited the si_upload_smc_data patch yet again to
> program the soft registers to zero when there are no
> displays connected.
>
> Timur Krist=C3=B3f (10):
>   drm/amdgpu: Power up UVD 3 for FW validation (v2)
>   drm/amd/pm: Disable ULV even if unsupported (v3)
>   drm/amd/pm: Increase SMC timeout on SI and warn (v3)
>   drm/amd/pm: Fix si_upload_smc_data (v3)
>   drm/amd/pm: Adjust si_upload_smc_data register programming (v3)
>   drm/amd/pm: Treat zero vblank time as too short in si_dpm (v3)
>   drm/amd/pm: Disable MCLK switching with non-DC at 120 Hz+ (v2)
>   drm/amd/pm: Disable SCLK switching on Oland with high pixel clocks
>     (v3)
>   drm/amd/pm: Remove wm_low and wm_high fields from amdgpu_crtc (v2)
>   drm/amd/pm: Print VCE clocks too in si_dpm (v3)

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
And applied.

Thanks!

Alex

>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h     |  2 -
>  drivers/gpu/drm/amd/amdgpu/dce_v10_0.c       |  3 +-
>  drivers/gpu/drm/amd/amdgpu/dce_v11_0.c       |  3 +-
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c        |  1 -
>  drivers/gpu/drm/amd/amdgpu/dce_v8_0.c        |  3 +-
>  drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c        | 29 +++++-
>  drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c |  7 ++
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c   | 93 ++++++++++++++------
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c   | 26 +++++-
>  9 files changed, 125 insertions(+), 42 deletions(-)
>
> --
> 2.51.0
>
