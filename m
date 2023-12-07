Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F51BC4167B
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 17:39:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CA6810E201;
	Thu,  7 Dec 2023 17:39:16 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2C6210E201
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 17:39:14 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-1f5bd86ceb3so756844fac.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 07 Dec 2023 09:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701970754; x=1702575554; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jGOgdlUjnFtZRdWXISZJ7WNUwZyI3gcTa/9KCldnxFs=;
 b=IgPjwXXcWAkw94vuQppjeJ3w14cxC5zwOQ5F9h4Jm9OFkdXkwXYdT/6i1IY1BRWy96
 Tyb3irICIKYH/HbBCrv9o0p8zLfmVmk31AKf7uOIU06xTyQ5dFmRsCTFsnn9ERKEmBqj
 mJOGN8PXqxRNowAqDkBT8KqcMCC7zQ/sjfJpKgba0KD1MjNoZVaF6Hc1fbuZqaB4qStM
 u2BPm1TWuSv0HB1BjtT0oGKk+uZqB8JcpL9ucKaNlOYnoRKDcsw7KstzSTywJ0Ped+qM
 lXY2VCE6LMyFN3Ra2iAEQvicqHDlB2mpX3rpSy6HzC8bNYOKqamBazPHtJIenYF36hL1
 hAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701970754; x=1702575554;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jGOgdlUjnFtZRdWXISZJ7WNUwZyI3gcTa/9KCldnxFs=;
 b=KiRlmDo79N4o4mF61xS4GODzGWL9TgAkc101EEgCQysdQAfdC1+MDSKn4avV7iiUGQ
 SExeMcLvaaPe8InQBsnLpuye3YrqxU9u9ljBxi4AjrsnaEJ0nF8qunq7epbzWV4dST7M
 yZOmm8nw4VI+uQsTVYpzcNnEuPNL+Prhp2MyiuedRaRBFcYmp7lQp4EQw2K6gZvOe/pv
 Og5UxzwSu18iO3M62WEUurdRV5tBDGln2CzN0/v7REUzUGju6yiVybS+maHkBcsRrspN
 CJHh76JIVrDOxSm+MD1B714cnmgVoHPXWKaJXbO3SlpnhNW9PmDdJVWGBudhWncqbuiz
 ER+A==
X-Gm-Message-State: AOJu0Yw+PdU7FgTl+u44edOACFRP1Ac/7p7dPhsGUjnnldw0kUD6fK2W
 K9JwDoDnL0wR98t3MOux7+b4dg6BTrwb8BQodB04giJG
X-Google-Smtp-Source: AGHT+IGmFszx53xyJSJCdH+ll1VYqlH61uqBncQpNGQc1TtC0REk0K0N6iZqra9AgJR2i4ELstlBhKmgV+aB+Z4KFoo=
X-Received: by 2002:a05:6870:80d1:b0:1fb:412:c32c with SMTP id
 r17-20020a05687080d100b001fb0412c32cmr3140933oab.32.1701970754129; Thu, 07
 Dec 2023 09:39:14 -0800 (PST)
MIME-Version: 1.0
References: <20231127223234.891204-1-alexander.deucher@amd.com>
In-Reply-To: <20231127223234.891204-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 7 Dec 2023 12:39:03 -0500
Message-ID: <CADnq5_OpHe527RoVPzgyj_TOw+RT=dZnfmfB7TGWD=8Zzt10cQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/debugfs: fix error code when smc register
 accessors are NULL
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping on this series?

Alex

On Mon, Nov 27, 2023 at 5:52=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Should be -EOPNOTSUPP.
>
> Fixes: 5104fdf50d32 ("drm/amdgpu: Fix a null pointer access when the smc_=
rreg pointer is NULL")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_debugfs.c
> index 0e61ebdb3f3e..8d4a3ff65c18 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -755,7 +755,7 @@ static ssize_t amdgpu_debugfs_regs_smc_read(struct fi=
le *f, char __user *buf,
>         int r;
>
>         if (!adev->smc_rreg)
> -               return -EPERM;
> +               return -EOPNOTSUPP;
>
>         if (size & 0x3 || *pos & 0x3)
>                 return -EINVAL;
> @@ -814,7 +814,7 @@ static ssize_t amdgpu_debugfs_regs_smc_write(struct f=
ile *f, const char __user *
>         int r;
>
>         if (!adev->smc_wreg)
> -               return -EPERM;
> +               return -EOPNOTSUPP;
>
>         if (size & 0x3 || *pos & 0x3)
>                 return -EINVAL;
> --
> 2.42.0
>
