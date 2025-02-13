Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5575BC021A0
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 18:19:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D82FD10E080;
	Thu, 13 Feb 2025 18:19:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ExK12AhM";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D74510E080
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 18:19:24 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2fc0ab102e2so264993a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 10:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739470764; x=1740075564; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9sJisWDE+3uJxdfXSALpmo3QJWaZ7S64wkeGYqgQAM4=;
 b=ExK12AhMX/gy2NI0kCJhyzDeTKXwDDZ+BWHnM1IsFkzuYdOdnjOqYcVCPGgQtiJFkC
 cKu0TEdhCKDT/IblrCbnExQAEisF5uuP1VbdRTc32837FG8F8qHPobqmT+ry8kjZd0bF
 RCpijjuwvEyjwGHs82VJjUGBXyc+JLsAKRqoCmIyB5/w/jKcJl4U2jh/q8KOkoiCa3na
 sE+azde5sKe9IixYZ25eVZoJLxz2+E0EEFuu57Z9/LWJTnjdWfm5NUi/ceP3agh0y/9k
 lhaZofD+dxnIVvrVL8A/3P4iI9WX1GwPFy7z5QvDD/sRtkdJUaslAnBA4kpiNMskm6gH
 rleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739470764; x=1740075564;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9sJisWDE+3uJxdfXSALpmo3QJWaZ7S64wkeGYqgQAM4=;
 b=glD2buGBDaN4Mc/vGmQ0kPp5EXHuB0hrr63ZyOoa8cSTQOCZ9gsZyDAaLAql5H7NlK
 U+aiacMK+GkeTuqqCrzaxEIdBLFdOdYvRYtg4OjeTrm1eHsnBu2+vS3zkG+ZcsrEOCEk
 EJ9WvZM/STGTzoC8kEon9tP4tMq+wJ6VeEO0lf/ESIBfF7k94ls0RxiAmeKbf6hcNtQS
 /uHH5wiCo7fynf5h9gnbhqFFl5VseToBVYtmbCxic0qTIBcWU+RC5P8GI4HmGHRD7cvR
 L39+P3w40UdTkUSDthk81QjYGwq1OZ0F77eLv9mjJR2jLqBRbNjsWKdLR0JFm3Ptz8g1
 eZWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhhQtx8i1cxbKMwWwX4AaN2na8zF+UJr4bmDtceInFaWkClLAYbQUI4EElkD/kCHbWd4kIrHNY@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwXUwVcJqMfdfb29SsGcywyl4k0/dyoGtjxrmYqEI1EFWpvie4J
 ET74u5KoE8FmfqPrHoUbMj9ZhvzQGQnD+mIwfVwMtQoAbE9RrpH0Qqza78B6oHSQSd9HbVar/VT
 Vmoezi+RNZarS/NYgzcPuwKh+mHGsnQ==
X-Gm-Gg: ASbGncu835wWxzarBQoLS0oQWQwnBXO5ve08/oUAy1L6zbErZMg47lJ1BPtrcRGMHVX
 0LjrabvFnXd07g89Z01zdldFYAsO0UqHo6xjYsNFqgBrkzbC2yoNNnpbf3VgrLuxn78S3U5uG
X-Google-Smtp-Source: AGHT+IH9R3wEJQS3ptklgR0vCnoTy45/+1L3AbBBV7eNWVV13iTKVVlJI8Mz9+/yHB1ZvGEXGs2/KGSPyFDTZ3QOYtg=
X-Received: by 2002:a17:90b:4a10:b0:2f2:f6e5:d28e with SMTP id
 98e67ed59e1d1-2fbf5c57a6cmr4605251a91.3.1739470763973; Thu, 13 Feb 2025
 10:19:23 -0800 (PST)
MIME-Version: 1.0
References: <20250213175012.588986-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250213175012.588986-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Feb 2025 13:19:12 -0500
X-Gm-Features: AWEUYZkz8vxloXBRBT8kYTqjBhFZXI1y77Z8OdS9JfF0hGFIig0z1OWt9m9uHAQ
Message-ID: <CADnq5_NGZOE_UMf6idOh2NcoJ-osojDxrW0fzRfiMGspenEPDQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix crashes in enforce_isolation sysfs
 handling on non-supported systems
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Thu, Feb 13, 2025 at 12:57=E2=80=AFPM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> By adding these NULL pointer checks and improving error handling, we can
> prevent crashes when the enforce_isolation sysfs file is accessed on
> non-supported systems.

Can you clarify what the issue is?  The code seems correct as is.
With this change the driver will start logging errors for all parts
that don't support enforce isolation yet which is misleading.

Alex

>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 27f5318c3a26..bf0bf6382b65 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1777,20 +1777,27 @@ static int amdgpu_gfx_sysfs_isolation_shader_init=
(struct amdgpu_device *adev)
>  {
>         int r;
>
> +       if (!adev->gfx.enable_cleaner_shader)
> +               return -EINVAL;
> +
>         r =3D device_create_file(adev->dev, &dev_attr_enforce_isolation);
>         if (r)
>                 return r;
> -       if (adev->gfx.enable_cleaner_shader)
> -               r =3D device_create_file(adev->dev, &dev_attr_run_cleaner=
_shader);
>
> -       return r;
> +       r =3D device_create_file(adev->dev, &dev_attr_run_cleaner_shader)=
;
> +       if (r)
> +               return r;
> +
> +       return 0;
>  }
>
>  static void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device =
*adev)
>  {
> +       if (!adev->gfx.enable_cleaner_shader)
> +               return;
> +
>         device_remove_file(adev->dev, &dev_attr_enforce_isolation);
> -       if (adev->gfx.enable_cleaner_shader)
> -               device_remove_file(adev->dev, &dev_attr_run_cleaner_shade=
r);
> +       device_remove_file(adev->dev, &dev_attr_run_cleaner_shader);
>  }
>
>  static int amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev)
> --
> 2.34.1
>
