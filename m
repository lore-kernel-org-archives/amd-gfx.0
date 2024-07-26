Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940CDC3DA49
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 15:26:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A2F010E9CE;
	Fri, 26 Jul 2024 15:26:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MXoKm/vA";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C48110E9CE
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 15:26:07 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-79b530ba612so787798a12.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 08:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722007567; x=1722612367; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gUvHM94ZZ0bz/yGUiaXjrFmhlnZUx3WNoEG45gLUt2I=;
 b=MXoKm/vAkR8sRAba2Y45k80iyG+Rqwt9Augn+Uem49JusGVisSg0HhhXs6NtTNZcEX
 6dX0Jl2C5OMwsHZsAaxA/dJSXWKvBk5dbS8IJSzDLtq8mtFHaKKK0wIuzbnJ3Gcsacvw
 zNRW1No5293yuFfm5CItVj3KftlYlabC+uBEGt23ve69TvKCzp7Z0s2mwEkzn6MsjHne
 ovLK7pw39LFmF/OxUH58EpfTIeBKP3MeyhISsdKF9dwbaJ9oE2omEJPZ7y5k6/9xSuRG
 hplzfkMIGlhkVlY4n9578yDev+UxA7IXvv2JAC2/L1PL8GDQKlXwLRRSeild5eCBLtze
 7Y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722007567; x=1722612367;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gUvHM94ZZ0bz/yGUiaXjrFmhlnZUx3WNoEG45gLUt2I=;
 b=I2y2WY8O9yFC3yQRdFO+ctdKHnxL20d0aduAHfEsxJFHMzxsWsHES7PsZnL4EiKfYd
 L4e8mvekIZmwzliPIS8363GegUAlBUmdblVBS4SDeEk9CrAypMhRBX9qJY/4/AO5nqMG
 AKwvcKypfmhMR/J1KuCXgOrg4SNEbxyW8Yjp7HDHtcxrF14RHLYzWnfhcuXjgPALdNpq
 reyKt/fNbI+KYo1eDsgEpIVOCQjJ6PSoYuUTH+gFHG7lm8qnvReqMk8jMQzdQATRi+bW
 x47SFYZQC6DoDLloug6bv+kYojJaoVETKLrKN5bvJ86TgoJx7zdoKZ9gm6NqrIRrF03b
 lbYw==
X-Gm-Message-State: AOJu0Yyq+YyyIL97MyYKjSpzRLSfRQQzR8937KXcW2ptws2Gwnbkn7Sn
 QLkp1Rt8jtTRiZofUaeDOOfKj6RqoMqC/Qh45svOZ+YCH808YKKhVlAhcq6Vb72HeO/pwtb85cg
 ahPfa8Mw8GjuPiSaPlOM3VttGJR0=
X-Google-Smtp-Source: AGHT+IFDr+KgMtonwKDW4Jhrct12ZC08eflOwxlYv0zxyERuO8X8jdhcC77N1LNagBpdDpj95RADAZlP1u+BUkvg76M=
X-Received: by 2002:a17:90b:1b51:b0:2cb:511f:35f with SMTP id
 98e67ed59e1d1-2cf2e9dc8f5mr5600876a91.15.1722007566889; Fri, 26 Jul 2024
 08:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240726134115.36802-1-alexander.deucher@amd.com>
In-Reply-To: <20240726134115.36802-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 26 Jul 2024 11:25:54 -0400
Message-ID: <CADnq5_PGaR=0bqmXckwY8HpgCj5MxCJ4Qc1JP=QR9Lnb7AES6w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: always allocate cleared VRAM for GEM
 allocations
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

On Fri, Jul 26, 2024 at 9:50=E2=80=AFAM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> This adds allocation latency, but aligns better with user
> expectations.  The latency should improve with the drm buddy
> clearing patches that Arun has been working on.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index ebb3f87ef4f6..768840e8937d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -347,6 +347,10 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, =
void *data,
>                 return -EINVAL;
>         }
>
> +       /* always clear VRAM */
> +       if (args->in.domains & AMDGPU_GEM_DOMAIN_VRAM)
> +               flags |=3D AMDGPU_GEM_CREATE_VRAM_CLEARED;

Alternatively, we can set AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE here,
although for cases like reboots, we probably want clear on create.

Alex


> +
>         /* create a gem object to contain this object in */
>         if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
>             AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {
> --
> 2.45.2
>
