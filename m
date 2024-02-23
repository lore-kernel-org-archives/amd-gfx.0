Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF449C5478C
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Feb 2024 16:25:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35F1110EC58;
	Fri, 23 Feb 2024 16:25:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zqx6MqMA";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0B9810EC58
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Feb 2024 16:25:31 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2998950e951so771921a91.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Feb 2024 08:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708705531; x=1709310331; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8D6PfT1VyGBOWIy+fzcEW21SWEyUhNMcVIQPNsRShU0=;
 b=Zqx6MqMAVgAcOm1VDREn/uxplXL+rxBa08GX00QlT4V3WKz73WhRTiEnc+M/1d4eOA
 8kqtskbHASEMLUAAPKhHonsZScw0Nt+1uINiG/UDP5A0ejK5yPzZl1B0s64zUDud5Q56
 6TkHqvChgJnQ3wan3iUYDgKPskilenAjs60DPwFsGGkEw9CtmfzClcvLQau3Ubv64z3m
 vJYyIa/L3SRBFRJSjLK5sVnMHWwNigi/5o8LORWlIL82iUOJQ0k7ogSMPuRejnH94isi
 KF3vHhdGpPoh8zL86/wJdJr3rrp5bdJlz5fTOzVQAjtcr+4gQF0wFm/LNEBKh1P1yXYP
 /aGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708705531; x=1709310331;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8D6PfT1VyGBOWIy+fzcEW21SWEyUhNMcVIQPNsRShU0=;
 b=HDE+8bgiVLiYVfe3kCscuo9Yi0N2pirWLUdhlXQw5kPv02KtWIg1qK7T39gUbbEWf5
 QzkIdmrqRloccaH9j3NH31EdchN3vHl1GWj0BiEoJ1DblDz5tUa4PhWi+mmsn53x+idM
 n3Ut8mFQWyOjf8UUPh6iQsiv+YcxQzUqkkz5vJrlI0fDyhSuCqhW1ZEECirSwaJl68kh
 3/VQTsdXFEnoJFLJ3KhKzEN5aQPBvLjQ96h5VjfntuxZJM2Vf/7SXpMrlv5mIDxuQsm+
 5IV6C/BBQM3W/xef7WuJ5ldLpGA6uDvEd9dtKT/9OrAChm1RYN07Z7A/QFaABKFmJIa3
 oYzw==
X-Gm-Message-State: AOJu0Yw3n9tvkCSX3wpjsxyynbC7k57Tmu7TLddBmX3UXK4/PvAn1GgB
 ut6Ji9NT5IpwgESfKtGWwVfUU4gAofwJ8IU6mMqoLpZNfBQUd27nLrmW/2LQVvjY9pxRf2nCsrL
 TcEhUEQeLG+I98vFn6t2xJE5eagw=
X-Google-Smtp-Source: AGHT+IHqfmD90xDwIQ79cCp+c9uJXfOizAClef7oHtz8vZ9ZUeU322b9C70bekVoba9ecqOE7/o9fwmI1drrfFxjYiM=
X-Received: by 2002:a17:90a:a112:b0:299:4f5a:62d5 with SMTP id
 s18-20020a17090aa11200b002994f5a62d5mr329079pjp.18.1708705531137; Fri, 23 Feb
 2024 08:25:31 -0800 (PST)
MIME-Version: 1.0
References: <20240223023921.1115688-1-Prike.Liang@amd.com>
In-Reply-To: <20240223023921.1115688-1-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 Feb 2024 11:25:19 -0500
Message-ID: <CADnq5_OqqC7UFf==DCeFcn49_d4_uSM=MM3munQjEqiyh=AKfA@mail.gmail.com>
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

On Thu, Feb 22, 2024 at 9:48=E2=80=AFPM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> Currently, GPU resets can now be performed successfully on the Raven
> series. While GPU reset is required for the S3 suspend abort case.
> So now can enable gpu reset for S3 abort cases on the Raven series.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 45 +++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amd=
gpu/soc15.c
> index e4012f53632b..dec81ccf6240 100644
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
> +       if (((adev->apu_flags & AMD_APU_IS_RAVEN) ||
> +           (adev->apu_flags & AMD_APU_IS_RAVEN2)) &&
> +               !soc15_need_reset_on_resume(adev))
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
