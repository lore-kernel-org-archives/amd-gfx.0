Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D3BC25B10
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 20:59:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98E6810E481;
	Thu,  9 May 2024 20:59:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O8KbcQW4";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E62D10E481
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 20:59:26 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-2b3c711dfd3so1120686a91.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 May 2024 13:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715288365; x=1715893165; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ECwtnY2Vno6jGhOlyqjp6pCx0bJoxA/Dcv1Et+/e/fI=;
 b=O8KbcQW4NaKnKvdwrEdEG/ftMpzaF1MVANIjC5Bx9+sqxv+/L+M6DrexVuigTD7jKQ
 5aE9FCCsIwP2NbykKkf4OlwVWJgKZFCew2Un0S8fbSpz18AMPgOsmwbQDnYxl8GJR4Fh
 IgUjoDEph8V1x3/iDKGeSbJ6RTTbYrdHfBXtOJjgtkc7t8OhssqfJcXbVnANBrxXeUiz
 hzHIVPbuMGPA/832ibk/UsljY9TQFXkGJSV0raYJOq0UaMT00/Kkl6co7TWxVCwMHy1m
 MI4+PFsZOKZo+Y0Z/ztBkr89AIsKnXVChpkRCvdGbc//x9dvcIzpUSBCZP0ihQ6p3R3N
 qPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715288365; x=1715893165;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ECwtnY2Vno6jGhOlyqjp6pCx0bJoxA/Dcv1Et+/e/fI=;
 b=jztLZmD8uzt+Xw1izPZ9fYBB8m1rrW2eVUx2U2e34vei997ekQt8EaKphzag5NR3w4
 2UhzGAAbSMllq4TpEmACJ2tDGAVkPkNGyJ7REYfYklhYOnq96Nv9KWqSTT+YBC3bYoo/
 qGaf3amz9qtFI67X4RjL9XNjxbCNTh850QVyuOQiPiT3wP11S8TL6o6O//A+d5jhtmGX
 rrFgMMayZb+MvAL0XkwgmIFMywQvd3ks6oPK3cmz5/cun75TEC2CY3y66EsvLcR6u518
 AFoLz8ynw6I6/qaeaT/s9LEnKCNxQR0Y8wabzN115sVf3CGS8ldirQGBWzRGQJbwIKCP
 nZcQ==
X-Gm-Message-State: AOJu0YxDV/EkwESb85vvgX2WA9gfN8mZJ/mf84ljOF/CqiMKI0I0O3nn
 K8SZGVrqVnvmrtnvao6UJ9968zNVQ4XB5FS489J0NItTq9K/2kbKc5Ed/eeqrcqesSBPnsrGWCz
 lQdZHjMhGChztZkH6wFqXXh9I1nE=
X-Google-Smtp-Source: AGHT+IGRU+CEs51u/rhtr6HfuxGlQkYkt6PZJWaC9MARylqFqzDQKmQdiG4FE8zDf+HA4WtU6zcNvOU8qu4DBO3QsOc=
X-Received: by 2002:a17:90a:c697:b0:2af:8959:2cc with SMTP id
 98e67ed59e1d1-2b6cc3428b1mr723454a91.9.1715288365531; Thu, 09 May 2024
 13:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240509204631.1489565-1-David.Wu3@amd.com>
In-Reply-To: <20240509204631.1489565-1-David.Wu3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 May 2024 16:59:13 -0400
Message-ID: <CADnq5_MMDTkoAnj+174wu_X762FvUc27_7RkzU+KDLrCrO55pw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/jpeg: keep drm kernel message consistent
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 Christian.Koenig@amd.com, leo.liu@amd.com, sonny.jiang@amd.com
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

On Thu, May 9, 2024 at 4:57=E2=80=AFPM David (Ming Qiang) Wu <David.Wu3@amd=
.com> wrote:
>
> amdgpu jpeg kernel message is different than others such as vcn:
>   [drm:jpeg_v5_0_0_hw_init [amdgpu]] JPEG decode initialized successfully=
.
>
> This patch is to make them consistent.
>
> The message after the change is:
>   [drm] JPEG decode initialized successfully.

Please convert the others to DRM_DEV_INFO instead.  Otherwise we can't
tell which GPUs these messages refer to on multi-GPU systems.

Alex

>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/a=
md/amdgpu/jpeg_v5_0_0.c
> index 64c856bfe0cb..4be0668ab97d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
> @@ -145,7 +145,7 @@ static int jpeg_v5_0_0_hw_init(void *handle)
>         if (r)
>                 return r;
>
> -       DRM_DEV_INFO(adev->dev, "JPEG decode initialized successfully.\n"=
);
> +       DRM_INFO("JPEG decode initialized successfully.\n");
>
>         return 0;
>  }
> @@ -549,7 +549,7 @@ static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec=
_ring_vm_funcs =3D {
>  static void jpeg_v5_0_0_set_dec_ring_funcs(struct amdgpu_device *adev)
>  {
>         adev->jpeg.inst->ring_dec->funcs =3D &jpeg_v5_0_0_dec_ring_vm_fun=
cs;
> -       DRM_DEV_INFO(adev->dev, "JPEG decode is enabled in VM mode\n");
> +       DRM_INFO("JPEG decode is enabled in VM mode\n");
>  }
>
>  static const struct amdgpu_irq_src_funcs jpeg_v5_0_0_irq_funcs =3D {
> --
> 2.34.1
>
