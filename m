Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB333CAC599
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 13:17:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FEE810E09F;
	Tue, 16 Sep 2025 13:17:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lzihGXQd";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF0DF10E09F
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 13:17:57 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-267f15eb5d3so287565ad.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 06:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758028677; x=1758633477; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EL8rdeeyZRCJLWAuSItxERxV75snwUDozJkW0ed9By8=;
 b=lzihGXQdFg0iOH+sJzBkRWW8W0AvIFkkyCPtVGrljBP8LN21tsYZir04Azz2C1o563
 i6W6Zc/RjDiG/UgAwZnfglVHsLKMI7ixa2/BAYKiPBbLMn6AFr78f2bwj+FhqtJFSQ0e
 sNQv3Ry4jQo+MrvHcF3csnJvpHztG4jjyjWSOpa4m27O5BxxKF/MovXEcb7+D1DOdLMq
 0nXoUU2a4G24S2/OyZ9C1eRRT+NJiKvmqwMoKfIJj6xdNyw1ILOOmzt21HwIqX/RZ8wo
 ob9zUhQ0jCXO1iD7b3j9Iy/AO/p/brLP5AwEeLYWwwMWD+tK26CBvcDCq/QLMLHNZBX0
 aYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758028677; x=1758633477;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EL8rdeeyZRCJLWAuSItxERxV75snwUDozJkW0ed9By8=;
 b=dv1+7/abpRd0BZdI8RREjP0n8XrF8ebiQb4EcisNXBSNKBwPKgioLbV5uSxTkvcy3x
 gWxhdecJTGS/6Q78UfeCybg6rVDseD8H9O03vNFFzimWuuzWS+lxL0u53BvASdyhmPh2
 PGbalGemC89OFGea2+SGmTws3pLR/aqtWaT2vj4bYZHqMAjzmlDiQl6AUqM6IF9iRDMU
 78v6qi6bg1LvOitepWWDDjE63RlGz+RteYjlAXkUMqgtox7IX04ULWxqj6BZYuQcTuYd
 K5gpsW4ybT1V5R4JFSSWC0GspBH1p0Ln9rQbSN/ULgLqeeevfBHcofTQLVRmGhUfr1uh
 V+Kg==
X-Gm-Message-State: AOJu0YxHB/Tezsz9UUXG02inmEuM/5K3w6K6Zjb5mNfDb3Vkm9xBlHa5
 w9WlFotRDeWqZRPk7GTo5Wj22W7ZrChTtovQwX8PEpCCReK1t1e9ZvmOdmsj3/u9PXaazMfoogM
 CgdCUEqjzj1rjHNe5FV/AJgudHIf+AZQ=
X-Gm-Gg: ASbGncvupUfNk9DbUAFywH+dkeMQB7kKrvXQm2PUbnCo3/vE1XMg8r75h3Q4DQ3kAw6
 58lyVTA/ZHxGM1PeFEZqMKCuIvQ/UHrCmGx/RM5tpD2ZwhOD2oplnEJryJdqWqMcIe96uMxJd9M
 W4LGheouk/UKPtFhUzl8s4eNkIMGatRRf2qpcajNb4MeFMK/X9zuu5TuqVVcKv6Bt6DHS2OLE/c
 v1RJoY=
X-Google-Smtp-Source: AGHT+IEWOKNZlpigqVqMynJ9DZyeKUBqPRWLtd91PAWWKCLFctKlaa268jD+blO0AOC6qstSHkGyUuZW7QsroQ8WBXs=
X-Received: by 2002:a17:903:41c1:b0:260:7a59:a177 with SMTP id
 d9443c01a7336-2607a59a2d9mr91723455ad.7.1758028677254; Tue, 16 Sep 2025
 06:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250916012033.76549-1-mario.limonciello@amd.com>
In-Reply-To: <20250916012033.76549-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Sep 2025 09:17:45 -0400
X-Gm-Features: AS18NWChsoNjWoOcWhWFQGhnyn30oQmKFLwsoZYYhRgpVlN9uTRdZpIO26jPG_4
Message-ID: <CADnq5_OQXtMY-vm7d+k6ieWeBgB4H5b6+u7nSfTnYqnOpB=CvQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Run KFD suspend and resume routines for s0ix
To: Mario Limonciello <mario.limonciello@amd.com>
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

On Mon, Sep 15, 2025 at 9:20=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> KFD suspend and resume routines have been disabled since commit
> 5d3a2d95224da ("drm/amdgpu: skip kfd suspend/resume for S0ix") which
> made sense at that time.  However there is a problem that if there is
> any compute work running there may still be active fences.  Running
> suspend without draining them can cause the system to hang.
>
> So run KFD suspend/resume routines even in s0ix.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 0fdfde3dcb9f..59688f8ae919 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5220,10 +5220,9 @@ int amdgpu_device_suspend(struct drm_device *dev, =
bool notify_clients)
>
>         amdgpu_device_ip_suspend_phase1(adev);
>
> -       if (!adev->in_s0ix) {
> -               amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_vf(adev) && !ad=
ev->in_runpm);
> +       amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_vf(adev) && !adev->in_r=
unpm);
> +       if (!adev->in_s0ix)
>                 amdgpu_userq_suspend(adev);

KGD user queues have the same requirements as KFD user queues so this
should be called as well.

> -       }
>
>         r =3D amdgpu_device_evict_resources(adev);
>         if (r)
> @@ -5318,11 +5317,11 @@ int amdgpu_device_resume(struct drm_device *dev, =
bool notify_clients)
>                 goto exit;
>         }
>
> -       if (!adev->in_s0ix) {
> -               r =3D amdgpu_amdkfd_resume(adev, !amdgpu_sriov_vf(adev) &=
& !adev->in_runpm);
> -               if (r)
> -                       goto exit;
> +       r =3D amdgpu_amdkfd_resume(adev, !amdgpu_sriov_vf(adev) && !adev-=
>in_runpm);
> +       if (r)
> +               goto exit;
>
> +       if (!adev->in_s0ix) {
>                 r =3D amdgpu_userq_resume(adev);

Same here.

Alex

>                 if (r)
>                         goto exit;
> --
> 2.50.1
>
