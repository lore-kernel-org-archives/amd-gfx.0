Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA88AC48BF8
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Feb 2024 17:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C9BD10E35E;
	Thu, 22 Feb 2024 17:03:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RUaR/CAO";
	dkim-atps=neutral
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DB0E10E35E
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Feb 2024 17:03:09 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-5d8b276979aso6179360a12.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Feb 2024 09:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708621388; x=1709226188; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NLdmiB88Eyr1Azvi2AkgBpCiW0WeloY4bFAiWMh8d3k=;
 b=RUaR/CAO3Na606E8y/M+dLkvZg4seDRIMUYPJKqaOCoJjZr89XfUwdTWg2835YafV0
 pilV17to8rLfPJsqnr7C1zSZMFZqZcujz+yKxbDgKMk0Cz98RESpYzQp0fiFScuKJstW
 YZEwzzcIU9CiiKjBfrlTI5filJNr9n1eT9ofHDD0/gh3uQ+Io/s20+B3g+dhtk2UJacO
 3/sNNyKk2lqU7Jh8AthA85ngb2waB2hAqBEjnuALwKM23YSEenXp4OyikN1iv4Xfr5vj
 qr2Yb00xCCQGvjOU79PtXBxt3R9jnm5K0C/4Aj4MBqgcdvd9z6lhYoMbXgsyz7jN0xHf
 fZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708621388; x=1709226188;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NLdmiB88Eyr1Azvi2AkgBpCiW0WeloY4bFAiWMh8d3k=;
 b=hgmOtWr01N/dkr7DKYrby6HhI2c1kD449253EsXKMmZHvVEPbRiL68tH49FMARyqe6
 hakMDvX7tgVIo7MTM/wYEqHfhcnI8/evdbLUy1zV1FnnApUXVwxNWQZZj2EDM5AcIVEM
 7ah5cZfNMq790DXghh1hoGvXzS5wR17LwbRjhf1iiHUON7gUiKEVK9RR5KuShVHkDUzA
 5cZsz+B7LKCOMuYkwfHydKqOjAQmRL3eMtutJz4i49YuYdYBdLpn/sKc2/626yUu1LtI
 E73WwH+3SLEYKtdPNaW8B5la6OPS0/3j3RD2IpNUwuOji+FX3XzLVpr6evtPRDCwyBgU
 gKGw==
X-Gm-Message-State: AOJu0Yy1zhcXhdTkROluTY9ZSddjMqu96f6wN5OUbxAlL25iOJpU6wYR
 VSroRbQcDMUFodJIzyta7znXGt6rOQZ7Fjc2QnLDAvkWdSn/7TRLSG3of+cNVZlNSCrUcd4Ybw+
 RwXKK0N3te27A3rGJNz5yixoJWjk=
X-Google-Smtp-Source: AGHT+IFmWHKzOxwpaZ7P+WqwvGqKT8Q+OH9Ih47bkcJY9ZRtLoImqagtu0DgdK9P/hhSxd9CcWb3CFyt+NbfJHBxzDI=
X-Received: by 2002:a17:90a:cc07:b0:299:32d6:aa76 with SMTP id
 b7-20020a17090acc0700b0029932d6aa76mr14871121pju.43.1708621388209; Thu, 22
 Feb 2024 09:03:08 -0800 (PST)
MIME-Version: 1.0
References: <20240222134126.1111837-1-Prike.Liang@amd.com>
In-Reply-To: <20240222134126.1111837-1-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 Feb 2024 12:02:55 -0500
Message-ID: <CADnq5_PGjdSAaDB-XYodMMxhCJkRLmCLPvs5iF8KKabresgE8A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Enable gpu reset for S3 abort cases on Raven
 series
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com
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

On Thu, Feb 22, 2024 at 8:41=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> Currently, GPU resets can now be performed successfully on the Raven
> series. While GPU reset is required for the S3 suspend abort case.
> So now can enable gpu reset for S3 abort cases on the Raven series.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 45 +++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amd=
gpu/soc15.c
> index e4012f53632b..f68ef0863cb0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -574,11 +574,34 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
>                 return AMD_RESET_METHOD_MODE1;
>  }
>
> +static bool soc15_need_reset_on_resume(struct amdgpu_device *adev)
> +{
> +       u32 sol_reg;
> +
> +       sol_reg =3D RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
> +
> +       /* Will reset for the following suspend abort cases.
> +        * 1) Only reset limit on APU side, dGPU hasn't checked yet.
> +        * 2) S3 suspend abort and TOS already launched.
> +        */
> +       if (adev->flags & AMD_IS_APU && adev->in_s3 &&
> +                       !adev->suspend_complete &&
> +                       sol_reg)
> +               return true;
> +
> +       return false;
> +}
> +
>  static int soc15_asic_reset(struct amdgpu_device *adev)
>  {
>         /* original raven doesn't have full asic reset */
> -       if ((adev->apu_flags & AMD_APU_IS_RAVEN) ||
> -           (adev->apu_flags & AMD_APU_IS_RAVEN2))
> +       /* On the latest Raven, the GPU reset can be performed
> +        * successfully. So now, temporarily enable it for the
> +        * S3 suspend abort case.
> +        */
> +       if (!soc15_need_reset_on_resume(adev) &&
> +                       ((adev->apu_flags & AMD_APU_IS_RAVEN) ||
> +           (adev->apu_flags & AMD_APU_IS_RAVEN2)))

Maybe check the apu flags first to avoid the MMIO read on chips where
we don't need it.

Alex

>                 return 0;
>
>         switch (soc15_asic_reset_method(adev)) {
> @@ -1298,24 +1321,6 @@ static int soc15_common_suspend(void *handle)
>         return soc15_common_hw_fini(adev);
>  }
>
> -static bool soc15_need_reset_on_resume(struct amdgpu_device *adev)
> -{
> -       u32 sol_reg;
> -
> -       sol_reg =3D RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_81);
> -
> -       /* Will reset for the following suspend abort cases.
> -        * 1) Only reset limit on APU side, dGPU hasn't checked yet.
> -        * 2) S3 suspend abort and TOS already launched.
> -        */
> -       if (adev->flags & AMD_IS_APU && adev->in_s3 &&
> -                       !adev->suspend_complete &&
> -                       sol_reg)
> -               return true;
> -
> -       return false;
> -}
> -
>  static int soc15_common_resume(void *handle)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> --
> 2.34.1
>
