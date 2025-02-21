Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68756C021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:34:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1769D10E236;
	Fri, 21 Feb 2025 15:34:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lwwfQgyJ";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A895810E236
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:34:28 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-2f9b8ef4261so515206a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 07:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740152068; x=1740756868; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SYcbkC0BxUbXU+M+aGGXHQrwgHDxzDD6WPbsYPxW6a0=;
 b=lwwfQgyJXTyuAKK6QHaWqpwlj4IGBE9AAOUmBbA2g2ARBEIqgSqNwOjdUDPIA6iQXg
 7Jh0wj93pjy0sGq6WcpWzzG1fpN4WkIKc5udQVu+vhE6SK3NKS/mreUpIBJCE1GCIQqk
 +bWMMpZ2gkaeC7lgKxpPk+78hKE25Ml5v0u58C+1y8/oV4N4H3u1Rt6WadRMgI4p2L8Y
 pG4cCdLx84OEM8Qx8Off626QeLVePBcdFi8PiQxAFz1dX1RFzmzDwIShIG3qHPWMyjsJ
 eH/kNkKGX61oU+S5SFXb2MsJs3fsONH7HnBE2GAwgbnkbDCZzz0/PADOVF1TFtG4mzVh
 F8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740152068; x=1740756868;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SYcbkC0BxUbXU+M+aGGXHQrwgHDxzDD6WPbsYPxW6a0=;
 b=CMDl0BO3E+Q7Cay3z2+mt5Bd2XCs+JgpunneZFClsHeh+WMpwNbkhAve346zmM+4CP
 Y9tqKgdxn1HFX3UddBqjdcSjul1zcMx9TaeRztnVBUsjUXzlfTLJtVcwvsRRhc1BWzil
 XxD69t05raFxAVV/QYLYeGbJ1Cj0U0786L63OGvEBYVCRDta/GyS6dulByt0L+BRZdhg
 VyG8Wsh9+E5B/EGMiuD/FZSC1B6fZGElfWlrvw/nHKOahIs8cTa46jfi7ktfaR5wfelK
 Si3EprTeGLKlktAGB2iah/iIjKEWN3PA0HwDp3JhPxcdb1mn9bwVliUji/Iu11jdFUhA
 cjAw==
X-Gm-Message-State: AOJu0YxlNOqC5dncYw+OgGZa5d9bNpchIPcS+LG1JYOyZdXB0ZNTIh09
 GMeRWWgYFDVBbK4g0jOWyghybDpinkcuLYpEEUy+m92oCRU2+9DBVrjulC8njOz5jSP5KLv1HUS
 PTg6ahC01W3JYI7Ls0u6C2RO6Wcy6FQ==
X-Gm-Gg: ASbGnctmYwVvsBuWA0m+RD0bBVviWloQwmWAMXZRgYAhUK9pQTZnTSWTN9oAbCMNQ+5
 tyGmRJX8SsYTZVXZh4OYH0OGp0kQoUSBBxBKrs53NNrRgtquBdVC4iocH7kzmyH3/u3m3Xt0HwC
 vxZiUxqAY=
X-Google-Smtp-Source: AGHT+IED/qz1AqvoV5u8K+MOYWcitmWVQh+FhJSgWwpAUm5imXXaN7ktYnxasGlWifUC5NEYLQK7KpkQ+1NVRGXYYKw=
X-Received: by 2002:a17:90b:4c04:b0:2ee:f59a:94d3 with SMTP id
 98e67ed59e1d1-2fce75eed74mr2378451a91.0.1740152066905; Fri, 21 Feb 2025
 07:34:26 -0800 (PST)
MIME-Version: 1.0
References: <20250221153247.3499295-1-alexander.deucher@amd.com>
In-Reply-To: <20250221153247.3499295-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Feb 2025 10:34:14 -0500
X-Gm-Features: AWEUYZnyDprOqFpEoRhFICwcBEKrFrd9H_F5kCE3ayYOVxP__3DDvgCBKBGHbJQ
Message-ID: <CADnq5_OvSDMOmvKK2NvAyMnBwUt_USkesWKnhjGhO85efOgO_A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/job: move fix is_guilty logic change
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Jesse Zhang <jesse.zhang@amd.com>
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

typo in the title fixed up locally.

Alex

On Fri, Feb 21, 2025 at 10:33=E2=80=AFAM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> Incrementing the gpu_reset counter needs to be
> in the is_guilty block.
>
> Fixes: f447ba2bbd48 ("drm/amdgpu: Update amdgpu_job_timedout to check if =
the ring is guilty")
> Cc: Jesse Zhang <jesse.zhang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.c
> index efba509e2b5d1..a82119b551dc3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -155,8 +155,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(st=
ruct drm_sched_job *s_job)
>                 if (!r) {
>                         if (amdgpu_ring_sched_ready(ring))
>                                 drm_sched_stop(&ring->sched, s_job);
> -                       atomic_inc(&ring->adev->gpu_reset_counter);
>                         if (is_guilty) {
> +                               atomic_inc(&ring->adev->gpu_reset_counter=
);
>                                 amdgpu_fence_driver_force_completion(ring=
);
>                                 dma_fence_set_error(&s_job->s_fence->fini=
shed, -ETIME);
>                         }
> --
> 2.48.1
>
