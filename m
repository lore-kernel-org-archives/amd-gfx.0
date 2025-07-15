Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E13DC83F21
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 13:45:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B21B10E5CD;
	Tue, 15 Jul 2025 13:45:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mJFq9Q56";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B72C10E5CD
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 13:45:18 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-234b122f2feso4927585ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 06:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752587118; x=1753191918; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ea6zILJUKfjDh01VcKvBGMfYV1+itb5o+BZpMbWPDvY=;
 b=mJFq9Q56L8RL5M/xXN5qbl7yJF8IIgkOdSKbBQjrFxF3wFqMRSr0UI5/UzyyeL1Emf
 TF5bJ8iweLaJ6BJolAJUXDWHexgVyykPQpFCEsEy7QjpeiagFqydYp1gt2OnQbCCr1Up
 Xf5dToGL7kyN1vxgKMkhDVbuVBIPx9F7Q/6qQ9UmzFMlLmwuBwr7ON37mMvWE1vrl1WS
 f7EAR/7dl1CF2JJjyvM6qM7jp7oy7z6VZe3W8pD36b1C9sIC2igq2reaWQcbnTz6IP52
 YVzqltevkbH3y/1HR2JgN6ExikxNZG/qLUYSI76Bgra503ia+4aMqwM1o3djrWYSNS7z
 sx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752587118; x=1753191918;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ea6zILJUKfjDh01VcKvBGMfYV1+itb5o+BZpMbWPDvY=;
 b=MQirnqiThVkg7f4rfnUQ2I6y6TDf9lYlVQdl8pCrOLkhUa0hQckEsWiodHRi9PDnbH
 ylLUevI4plHiLrbNYu+IRQgZMim3r43pIkSf6RbmZSYS9RIHsPeJJBhEOJLGpV4px7Bd
 evZFLwEEeHL03UPpi0LDihm7UeJ895dUxV1BqRIbyLOMgYVhm3/4fC2oxSn22d9S9mtJ
 5mrOP1MPe5WtWlL8RlRNvhgO3rIEvaMhzzcCpI6ewneBnl+NQxNINr310lwg6a10Pf3v
 JMupCLrWSIn0MrPMX43Xej1sMzGMYuSWpc5bGqRKxKwPktpkQ58sKeVvSVPEQFbJ5I+4
 lQmw==
X-Gm-Message-State: AOJu0YyNGlDgwweumbnvfBJFJUYQ2FIm8A6ZAvd9hhHdIo4TwpSSb7Ug
 DPG3M0JIZui2IKYKoudXN7TimW0ODSgLupxPK1WdOPgxY42TaExXSZxqJLamX8OjjQGCEdmAPZf
 HSQK04MgVsHsYSQgM807hOdv1aTA2dwGwpQ==
X-Gm-Gg: ASbGncvAPAuyP01Qf339mOpRz++cNivAd8xNfwRW5voQeKZr8LAeVZpl2xZNDnb2LIG
 77ZXU5UwiccK4Mlkagp5DWdjjcBjpRaJfx4ZR2AyvlTEnh0QjITU7C4oOlXuWZqWUQqdbdiDvPE
 id02BoHgg3vb14wIQvHfKiVmwKPFkAheCNbHq8g7tDBelC1sp5GCkjaSVu5rlLKpMJ3fpZ8d9LM
 KaFFxAV
X-Google-Smtp-Source: AGHT+IFQhl6C/gSB/Pf0rIqNKVC8noXjdYQInDRMR5RBEgot2ZYG6zjohh39EfBm9PmKjNUcBmDBdbsLGHfPJkqa8ZI=
X-Received: by 2002:a17:902:f682:b0:234:f1b5:6e9b with SMTP id
 d9443c01a7336-23e1e912dcbmr9350355ad.1.1752587117509; Tue, 15 Jul 2025
 06:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250625023220.8417-1-alexander.deucher@amd.com>
In-Reply-To: <20250625023220.8417-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Jul 2025 09:45:05 -0400
X-Gm-Features: Ac12FXwaQ0YWEOERcy_UpJANmQoELeOOLUMKB4wI2i7MAvcPyv42fs-_tzlotDA
Message-ID: <CADnq5_P24tVYNh0oegDsC5R8gCS3_+aWvAf2yswgqd5k6JnrHQ@mail.gmail.com>
Subject: Re: [PATCH V2] drm/amdgpu: make compute timeouts consistent
To: Alex Deucher <alexander.deucher@amd.com>
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

Ping?

On Tue, Jun 24, 2025 at 10:32=E2=80=AFPM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> For kernel compute queues, align the timeout with
> other kernel queues (10 sec).  This had previously
> been set higher for OpenCL when it used kernel
> queues, but now OpenCL uses KFD user queues which
> don't have a timeout limitation. This also aligns
> with SR-IOV which already used a shorter timeout.
>
> Additionally the longer timeout negatively impacts
> the user experience with kernel queues for interactive
> applications.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>
> V2: fix documentation as well
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 10 +++++-----
>  2 files changed, 7 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index c8a6b3689deae..58a0ee99eb2f8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4171,18 +4171,10 @@ static int amdgpu_device_get_job_timeout_settings=
(struct amdgpu_device *adev)
>         int ret =3D 0;
>
>         /*
> -        * By default timeout for non compute jobs is 10000
> -        * and 60000 for compute jobs.
> -        * In SR-IOV or passthrough mode, timeout for compute
> -        * jobs are 60000 by default.
> +        * By default timeout for jobs is 10 sec
>          */
> -       adev->gfx_timeout =3D msecs_to_jiffies(10000);
> +       adev->compute_timeout =3D adev->gfx_timeout =3D msecs_to_jiffies(=
10000);
>         adev->sdma_timeout =3D adev->video_timeout =3D adev->gfx_timeout;
> -       if (amdgpu_sriov_vf(adev))
> -               adev->compute_timeout =3D amdgpu_sriov_is_pp_one_vf(adev)=
 ?
> -                                       msecs_to_jiffies(60000) : msecs_t=
o_jiffies(10000);
> -       else
> -               adev->compute_timeout =3D  msecs_to_jiffies(60000);
>
>         if (strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)) {
>                 while ((timeout_setting =3D strsep(&input, ",")) &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 7e3fa76227033..7bc326d0b4000 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -362,12 +362,12 @@ module_param_named(svm_default_granularity, amdgpu_=
svm_default_granularity, uint
>   *   The second one is for Compute. The third and fourth ones are
>   *   for SDMA and Video.
>   *
> - * By default(with no lockup_timeout settings), the timeout for all non-=
compute(GFX, SDMA and Video)
> - * jobs is 10000. The timeout for compute is 60000.
> + * By default(with no lockup_timeout settings), the timeout for all jobs=
 is 10000.
>   */
> -MODULE_PARM_DESC(lockup_timeout, "GPU lockup timeout in ms (default: for=
 bare metal 10000 for non-compute jobs and 60000 for compute jobs; "
> -               "for passthrough or sriov, 10000 for all jobs. 0: keep de=
fault value. negative: infinity timeout), format: for bare metal [Non-Compu=
te] or [GFX,Compute,SDMA,Video]; "
> -               "for passthrough or sriov [all jobs] or [GFX,Compute,SDMA=
,Video].");
> +MODULE_PARM_DESC(lockup_timeout,
> +                "GPU lockup timeout in ms (default: 10000 for all jobs. =
"
> +                "0: keep default value. negative: infinity timeout), for=
mat: for bare metal [Non-Compute] or [GFX,Compute,SDMA,Video]; "
> +                "for passthrough or sriov [all jobs] or [GFX,Compute,SDM=
A,Video].");
>  module_param_string(lockup_timeout, amdgpu_lockup_timeout, sizeof(amdgpu=
_lockup_timeout), 0444);
>
>  /**
> --
> 2.49.0
>
