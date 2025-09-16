Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FF9CAC599
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Sep 2025 13:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47A1F10E7F3;
	Tue, 16 Sep 2025 13:43:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="avWtyY++";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F4DD10E7E3
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 13:43:45 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-24602f6d8b6so9832085ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Sep 2025 06:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758030224; x=1758635024; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y4CyUbLFK7H2CrcBCMNBEphwCpJRTgO2AxEDcPoIJ2k=;
 b=avWtyY++x08qpehQ2PUIVvqWBSbBGCe53jhp0ohey5NYnDJX0lZOy7P3XJYZudEU+T
 EgUtITrQbgN4u1dnriFgwPxohz4lzXt9Bev3y7PyLHN6Ed1Y4ju30c9mTPKj6dMN0HGs
 kVxp7rZP1E8BW0J1ZnxbnXTbRuSDPNuG+2ps26UwxbHTFX6QAZwLtazo7ZMIhXEMKuQD
 7uombM11vScFAFkdRbh1bUSMbIL+dgneIDOX1GjxlWr12aAHq0lp+VmZSiRYo2mt0jNP
 Q57UTVsGEhcCcZcKH1lm8K2ySZdV50JLFNlMzpQTtokapEpRV6BSNtpTU4Vt55DnVH8i
 XxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758030224; x=1758635024;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y4CyUbLFK7H2CrcBCMNBEphwCpJRTgO2AxEDcPoIJ2k=;
 b=pkriVK9OcDicwW84JgCl+nUzTHs/do6gCZU9QeOuwn49HZ4u95Eq2NStROvQGoietE
 2ETrmJYOOkFWIVN6Fz40YoR075r3RN/ogZJBv8umqWsOzIDWs2jG9oAD3FozAW2TN+Mm
 zaDu+kwJAxtkYoio5+Dr3Jbz/HMnkrfXBepy/Eh2veoS3YUj+4UsjAmNv4MaB2UCn64U
 2m7WQjReHMFmk2JinA8Zz919gCBN18drUPo15Iz8cBj/GMY5S9z7wgW92zUiU0Bqu3vv
 22h5RgPm5idNzgq6W5qWCqZT3O4DJNno6W4IqxV5H2DwTWjFdA2ZWTKfFzYvULbNYigM
 aqww==
X-Gm-Message-State: AOJu0YyvKMmHEw8hS6+rmMR6uyT4AeoUZyY8d62gYYMgqUC8lCoBOOJq
 ruId8y3y9UXH6/o3Pc2UJu/keiJ0616PidOj4wlWQujd/HxqsEl43bGhPCSdEY70d/0CXFTufBk
 3Zj8Hv5osUrxyu6zPhEUZIL36e9Fy0KOsIA==
X-Gm-Gg: ASbGncuYgn10NT3UChYtZYPpknk5dslPfULct1RH0BgSrzLCU2NBcKumIPGsboAYG/5
 HqIcnYmaq0JTH7uSz5ygvzzYX/mA2ICXR8JUVE1mNgXlvgl/LNH656f3ZgnezPmgl72s1aUmU80
 DExOG7WPvY3FzxAo9lKdqEQhXhBBjG8yRAxCyxvScHVb3vsWiFCDAdL6h8Mit95+YIwvYH+FeWc
 Cz6N3ttfD9KLr92RA==
X-Google-Smtp-Source: AGHT+IGVbZOhA+naVJ9+P8IuF63O9G7eoVrdj2jK+htF2C8w+EJiRWbTCszEjHX1IdI4XWO/BfmHZ+h2v2YYV2aFRJ4=
X-Received: by 2002:a17:902:db08:b0:264:41bd:bd1a with SMTP id
 d9443c01a7336-26441bdbeddmr62242485ad.3.1758030224472; Tue, 16 Sep 2025
 06:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250916132211.93617-1-mario.limonciello@amd.com>
In-Reply-To: <20250916132211.93617-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Sep 2025 09:43:33 -0400
X-Gm-Features: AS18NWDstQ1MqZDfQ3gfDghhKhU86jlynnpQXMP_I3eU3xxHblc9s3_bzngvRPk
Message-ID: <CADnq5_MF_q2pS-Obu1CePcxgQrtEN59qfSEzMhwBn_Yr7H3VCw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd: Run KFD/userq suspend and resume routines for
 s0ix
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Yifan Zhang <yifan1.zhang@amd.com>
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

On Tue, Sep 16, 2025 at 9:39=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> KFD suspend and resume routines have been disabled since commit
> 5d3a2d95224da ("drm/amdgpu: skip kfd suspend/resume for S0ix") which
> made sense at that time.  However there is a problem that if there is
> any compute work running there may still be active fences.  Running
> suspend without draining them can cause the system to hang.
>
> The same problem can also occur with user queues too.
>
> So run KFD and user queue suspend/resume routines even in s0ix.
>
> Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v2:
>  * handle user queues as well (Alex)
>  * Add tag (Yifan)
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 0fdfde3dcb9f..85b58e5edc7d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5220,10 +5220,8 @@ int amdgpu_device_suspend(struct drm_device *dev, =
bool notify_clients)
>
>         amdgpu_device_ip_suspend_phase1(adev);
>
> -       if (!adev->in_s0ix) {
> -               amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_vf(adev) && !ad=
ev->in_runpm);
> -               amdgpu_userq_suspend(adev);
> -       }
> +       amdgpu_amdkfd_suspend(adev, !amdgpu_sriov_vf(adev) && !adev->in_r=
unpm);
> +       amdgpu_userq_suspend(adev);
>
>         r =3D amdgpu_device_evict_resources(adev);
>         if (r)
> @@ -5318,15 +5316,13 @@ int amdgpu_device_resume(struct drm_device *dev, =
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
> -               r =3D amdgpu_userq_resume(adev);
> -               if (r)
> -                       goto exit;
> -       }
> +       r =3D amdgpu_userq_resume(adev);
> +       if (r)
> +               goto exit;
>
>         r =3D amdgpu_device_ip_late_init(adev);
>         if (r)
> --
> 2.50.1
>
