Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFE7C77B7F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 May 2023 13:20:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A409710E6B2;
	Fri, 12 May 2023 13:20:24 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77B6310E6B2
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 May 2023 13:20:23 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-38bed577755so3403985b6e.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 May 2023 06:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1683897622; x=1686489622;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6uDu9yaNjeK/D0ZQhRfgM1lDhChoWiW8HtuODBwA3OY=;
 b=rkPne4CZY1NOxCV7UxzR2HbP7cjVRk2CSQAfjBowkBMLB2upzPgwHSunuGDkBGPUss
 Qjc4IeRFC9pmlWG74JW9DRutk6XsZw01litVSitG6aCcUqV2gmPlrF0Rn2zGG9156HjL
 Lvhp2EPrJ9Ao6wSeQ/W7BrygeD6bRnpMO/qd6hO9pzeGC4eLORH6sDcoN+GaZ27Jrb5l
 VyswMimFMKL+rg5pUegH7vi/YHlLVWzuo/X9Rzf8z8p8F4moIo/pVYTKtmd9sXZt4a3Z
 H/f2Zg0DaEcFaE7tYDRqDr865/n/PkWe1TO5ixi0/0Ymo2DS86KRM5e2tdTzyFZN3K2Z
 CR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683897622; x=1686489622;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6uDu9yaNjeK/D0ZQhRfgM1lDhChoWiW8HtuODBwA3OY=;
 b=Ne25j9nLEwPIh+Xiv+/PCqKnilU0LhnL6UZ6B5yVYm2OMSyM0yO6rrzxaJYPwI4y61
 dZowhGwkJ3wnw1bSYp3CgE9AsCy3SdPSZEfnxvNrMug3W572Kf98FfGYm1k3Z8kg0WSk
 CPzFEh/UyypFVfaQTPpBLGj0n7aiY9EtIx99qCESnND7BTh7F/jJuixs/ZOObjZTUunI
 Jda3+N3M1cWbWv74mqwDq9RXDhxiTvAVHeYh/oVa+o+5/dOW0/9uvjpkAPEiDaQYxKhF
 //oZZNa1DLHTCyzHwww/CgV8Emh172PmUjDmVX9rukz6Kv/ICiqzdVusYXjV5UjheQCp
 i09A==
X-Gm-Message-State: AC+VfDz5TsNQjk5b/YbG68AWK/9zulb5SXH2IcpRt5U1Ol5oH37u5AjB
 ZUeTnl2xiN5dW4msriCqsylaYUJmSwSG2QVOhHBXEy3P
X-Google-Smtp-Source: ACHHUZ6qbHSQI9vSawLH1gW/PLKUGMyZqBISyfIba/E5ahrSIgJvuDxXMj0eljMNaqo2kF+O+qm87Ith5gpZXWmepfw=
X-Received: by 2002:aca:2808:0:b0:392:18e1:7c65 with SMTP id
 8-20020aca2808000000b0039218e17c65mr5707827oix.17.1683897621937; Fri, 12 May
 2023 06:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <DM4PR12MB5152E2B7372CFB31CAA0F546E3759@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5152E2B7372CFB31CAA0F546E3759@DM4PR12MB5152.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 12 May 2023 09:20:10 -0400
Message-ID: <CADnq5_Ms90FrkmLT=_boDybxoNwq2DDJtQ8JKYNOVoM84oUkvg@mail.gmail.com>
Subject: Re: drm/amdgpu: Differentiate between Raven2 and Raven/Picasso
 according to revision id.
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wang,
 Chester" <shansheng.wang@amd.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, May 11, 2023 at 9:20=E2=80=AFPM Zhang, Jesse(Jie) <Jesse.Zhang@amd.=
com> wrote:
>
> [AMD Official Use Only - General]
>
>
> drm/amdgpu: Differentiate between Raven2 and Raven/Picasso according to r=
evision id.
>
>
>
>     Due to the raven2 and raven/picasso maybe have the same GC_HWIP versi=
on.
>
>     So differentiate them by revision id.
>
>
>
>     Signed-off-by: shanshengwang <shansheng.wang@amd.com>
>
>     Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
>
>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
>
> index e093e83ae739..1f4edfb96636 100644
>
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>
> @@ -4000,30 +4000,27 @@ static uint64_t gfx_v9_0_get_gpu_clock_counter(st=
ruct amdgpu_device *adev)
>
>                 clock =3D clock_lo | (clock_hi << 32ULL);
>
>                 break;
>
>         case IP_VERSION(9, 1, 0):
>
> +       case IP_VERSION(9, 2, 2):
>
>                 preempt_disable();
>
> -               clock_hi =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COU=
NT_UPPER_Raven);
>
> -               clock_lo =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COU=
NT_LOWER_Raven);
>
> -               hi_check =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COU=
NT_UPPER_Raven);
>
> -               /* The PWR TSC clock frequency is 100MHz, which sets 32-b=
it carry over
>
> -                * roughly every 42 seconds.
>
> -                */
>
> -               if (hi_check !=3D clock_hi) {
>
> +               if (adev->rev_id >=3D 0x8)
>
> +               {
>
> +                       clock_hi =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN=
_TSC_COUNT_UPPER_Raven2);
>
> +                       clock_lo =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN=
_TSC_COUNT_LOWER_Raven2);
>
> +                       hi_check =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN=
_TSC_COUNT_UPPER_Raven2);
>
> +               }else{
>
> +                       clock_hi =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN=
_TSC_COUNT_UPPER_Raven);
>
>                         clock_lo =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN=
_TSC_COUNT_LOWER_Raven);
>
> -                       clock_hi =3D hi_check;
>
> +                       hi_check =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN=
_TSC_COUNT_UPPER_Raven);
>
>                 }
>
> -               preempt_enable();
>
> -               clock =3D clock_lo | (clock_hi << 32ULL);
>
> -               break;
>
> -       case IP_VERSION(9, 2, 2):
>
> -               preempt_disable();
>
> -               clock_hi =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COU=
NT_UPPER_Raven2);
>
> -               clock_lo =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COU=
NT_LOWER_Raven2);
>
> -               hi_check =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN_TSC_COU=
NT_UPPER_Raven2);
>
>                 /* The PWR TSC clock frequency is 100MHz, which sets 32-b=
it carry over
>
> -                * roughly every 42 seconds.
>
> -                */
>
> +               * roughly every 42 seconds.
>
> +               */
>
>                 if (hi_check !=3D clock_hi) {
>
> -                       clock_lo =3D RREG32_SOC15_NO_KIQ(PWR, 0, mmGOLDEN=
_TSC_COUNT_LOWER_Raven2);
>
> +                       if (adev->rev_id >=3D 0x8) {
>
> +                               clock_lo =3D RREG32_SOC15_NO_KIQ(PWR, 0, =
mmGOLDEN_TSC_COUNT_LOWER_Raven2);
>
> +                       }else{
>
> +                               clock_lo =3D RREG32_SOC15_NO_KIQ(PWR, 0, =
mmGOLDEN_TSC_COUNT_LOWER_Raven);
>
> +                       }
>
>                         clock_hi =3D hi_check;
>
>                 }
>
>                 preempt_enable();
>
>
