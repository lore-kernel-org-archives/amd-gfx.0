Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77BC5C19F4F
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Apr 2024 13:12:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EABA010E772;
	Thu, 25 Apr 2024 13:12:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tv6HJmg5";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03B2310E772
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 13:12:42 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-53fa455cd94so722884a12.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Apr 2024 06:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714050762; x=1714655562; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y1ni7hNQy4DvsjvqfsC6GN+Vy6CL1a8sD+2ouB8J+mM=;
 b=Tv6HJmg5MgEiWoylVjSZmLGEd9ahUIqnz+Vko39WVvrSe90JczB0bcy5hn77oTm1es
 BgpeRa5ubufMSrrpJLLhLFDI31458pa6DFipzsZKb+DC/y2KEspPCmSjNHCYT4hkklOp
 xbwLNEkOSgAa/T8JWJ2bZgGjCZqMij+z+kERAyTmgBiaA3Lg8rtFvu73VfwLG+4xb6jQ
 SbNOfWTcYGe0TYRIX4jdmjmA6M912ybsbXiPHBbUGSDcOYpK+SEdvFv+HJ8AgJpxc7W+
 nCcGzSk2QYhWSzEy7m7MyoEoeJtLJ2DvFA3nlKq5SCDHLJ2PfcZL1ZAhWytOH/PHS37r
 rHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714050762; x=1714655562;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y1ni7hNQy4DvsjvqfsC6GN+Vy6CL1a8sD+2ouB8J+mM=;
 b=uDGgvODYx7xGceg/Fj8E7rnZ2KCSrS5FXakhrfVyBT0XqFCXbDtARuReNoE7kiqa3d
 kqiHV7Af8m6T9b2fWfksT7XRU9ErSaq6rxRTlHl7ZzRGymAIhIjjwOlRFYDo8LV1D/SN
 P9da+eCXElFobCm/ocUvAUMMM/tqmwrmz+D4bqbfV0jo7gVvIHiVF+t0WmqKaJaq2o61
 L169fAFycz2MzQBpWmcMXhdEaY0/MfmmtaDHHqTlhyOKjmNScoAYEUSIHDDXdqOiY51d
 jkCf8z5NLb/PmwH4zJX8+sOHwLlQZbpjOTnEfXVh7USXwgvRqVRYpSFjy/nJXeQmgnTM
 t60g==
X-Gm-Message-State: AOJu0YwYQUfELXnrxmH431QDncxsBkBFniI5pHoMNcFtImNjhNeobrak
 ST/CwhLQi4+Vs870EQcp2hwec+5oAXpMnQRsrUzv5Z4doJhkF7qQ0/KCreVkTPd7hSyH6pATSdG
 QuOp06FcFfvuA6RAelEkFYTfsXyo=
X-Google-Smtp-Source: AGHT+IEapLlkUsHG8yVkMeY8yaYSZdC+mrd69GEGfaMlyg95vNlKe7ibjj+Jdl/8KnO16d3LBj15F0TaBaMiZ4FSNTs=
X-Received: by 2002:a17:90a:ac2:b0:29d:dd93:5865 with SMTP id
 r2-20020a17090a0ac200b0029ddd935865mr4765365pje.46.1714050762084; Thu, 25 Apr
 2024 06:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240425100027.637016-1-Jun.Ma2@amd.com>
 <20240425100027.637016-3-Jun.Ma2@amd.com>
In-Reply-To: <20240425100027.637016-3-Jun.Ma2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Apr 2024 09:12:29 -0400
Message-ID: <CADnq5_PQ+kBcwG5kKKUhKpd6Xmv5njij5oj1EK_uC4zJQ=upcQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Fix the uninitialized variable warning
To: Ma Jun <Jun.Ma2@amd.com>
Cc: amd-gfx@lists.freedesktop.org, christian.koenig@amd.com, 
 Alexander.Deucher@amd.com
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

On Thu, Apr 25, 2024 at 6:17=E2=80=AFAM Ma Jun <Jun.Ma2@amd.com> wrote:
>
> Initialize the phy_id to 0 to fix the warning of
> "Using uninitialized value phy_id"
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> index 8ed0e073656f..53d85fafd8ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_securedisplay.c
> @@ -95,7 +95,7 @@ static ssize_t amdgpu_securedisplay_debugfs_write(struc=
t file *f, const char __u
>         struct psp_context *psp =3D &adev->psp;
>         struct ta_securedisplay_cmd *securedisplay_cmd;
>         struct drm_device *dev =3D adev_to_drm(adev);
> -       uint32_t phy_id;
> +       uint32_t phy_id =3D 0;

You can drop this hunk now that you added the check below.

Alex

>         uint32_t op;
>         char str[64];
>         int ret;
> @@ -135,6 +135,10 @@ static ssize_t amdgpu_securedisplay_debugfs_write(st=
ruct file *f, const char __u
>                 mutex_unlock(&psp->securedisplay_context.mutex);
>                 break;
>         case 2:
> +               if (size < 3) {
> +                       dev_err(adev->dev, "Invalid input: %s\n", str);
> +                       return -EINVAL;
> +               }
>                 mutex_lock(&psp->securedisplay_context.mutex);
>                 psp_prep_securedisplay_cmd_buf(psp, &securedisplay_cmd,
>                         TA_SECUREDISPLAY_COMMAND__SEND_ROI_CRC);
> --
> 2.34.1
>
