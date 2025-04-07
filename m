Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A100C36010
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 14:17:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 150E210E472;
	Mon,  7 Apr 2025 14:17:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JaN8RVMN";
	dkim-atps=neutral
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7D5D10E472
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 14:17:23 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-af9b16eca8eso304301a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Apr 2025 07:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744035443; x=1744640243; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YNhRZPtJW5TnHTezndPQB3ppyawWTf68h9PuDQZ5kF8=;
 b=JaN8RVMN3MHB7ABaL7d0GatTuTq4SrnWvuN3pZ/2FTKFrHfp13CuDxJbo0Xd3wdBhu
 h5Ys70BMYKb7dYnAXhL0MsE7hNhUUNMTACjvDsWwM6G/siEw6+HKhlJr4tc1ZEMzhNDW
 iT6SqZGx5PC9krgohHCRxYPkb+qESWTk54BRSGUHrZssA9E7Ux9bnF+SKl0CZgg2FdoM
 /3ZXbEJ1vH5n+IGZVReSYmOhmH2a002vdJCHYTl3b+VJoa6AX3CHpwwX5t58TEntYi+S
 ZUndACKFPzhCrfcEKrU8i6dbIoVu8J8PXrNu+qgOMYCPV+vrrBt0btfyGejhRcS+Pfu8
 CXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744035443; x=1744640243;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YNhRZPtJW5TnHTezndPQB3ppyawWTf68h9PuDQZ5kF8=;
 b=qvn2LOnEN4nAwu7LuL3FhiEJ4u+WEyH90eUBqQPdW2KueRaLIkiDYb3eSdNlBEBtft
 Oe3CyZgdgfBSDZ9eJOvgHv5Vqaec+9WceZWK/oD1MH/lxAU2tYWZJOaqfdxewCI4iug7
 KYaRFn4LrvW472xbBx0l2OuexIxKIuukRKv2D6Z8kFtl40zz+ixzjNTS8XjbEd2bpVk+
 kzZPvf475x7T/SUxLr4Y7uXbIFXRwF8QoseekU9XT99WZUUBRg1juW9IQAh9hhTkM1XG
 1SAyAMhrwN2pOaBaN8ebRbcfRD9UI4qSbeZEIXN9/ve2QiXuB0NEZMfV9PltbTdUb4Sy
 QtAg==
X-Gm-Message-State: AOJu0Yy+RYs0E7GbviZoC62nNcEGhdweerYXHY53DCV5y8EAu+H2Zywe
 +yxaMN84kx2KwUvI/RQaISw7ccqJtUfEvYBBUentDbmEgtyF4L0c05bdXxl9jivpiaft7sp96xt
 0YsyGJuM1yh1tM6gdwta0XKhSmV6D3Q==
X-Gm-Gg: ASbGncvMWE1vIK0ZUPYaVfkFV/CPWIWcAtuXWWO3DHzn/TVK+ft1ingQgXcyZf0nUbJ
 xsi4dr1DBQSnw2PxQF2T7DpbPTNNz2GUDsD42xh+vyTuGUl6DRWQ1hFoiMGC27gx2Ui1VPzFc6p
 yREWBoNkhWG0H8PDpnsxTCjhfGdQ==
X-Google-Smtp-Source: AGHT+IH7d3hRZEetH4CvksYL1PjbVZtJl3wrymbWdcThXnWe+6dafmNYZ2SKP7kZ6TeumLFB9oEfk7dcoVo9f27rG8g=
X-Received: by 2002:a17:90b:4b06:b0:2fe:b77a:2eba with SMTP id
 98e67ed59e1d1-306a485b36amr6813584a91.1.1744035442950; Mon, 07 Apr 2025
 07:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250328130857.4071486-1-alexander.deucher@amd.com>
 <20250328130857.4071486-2-alexander.deucher@amd.com>
In-Reply-To: <20250328130857.4071486-2-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Apr 2025 10:17:11 -0400
X-Gm-Features: ATxdqUF10fi1wFLtwCmGVGYVh2xip0eDqaQBS1ojvRc_JLIbgUwTSiAXtwwTsUs
Message-ID: <CADnq5_Maeuqh+ywWsoR0LcSOnggT3ALtE3uwL-9GHfFhc3L9+Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/mes12: optimize MES pipe FW version
 fetching
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

Alex

On Fri, Mar 28, 2025 at 9:09=E2=80=AFAM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Don't fetch it again if we already have it.  It seems the
> registers don't reliably have the value at resume in some
> cases.
>
> Fixes: 785f0f9fe742 ("drm/amdgpu: Add mes v12_0 ip block support (v4)")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index bcabebd18fe84..8892858cfd9ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -1392,17 +1392,20 @@ static int mes_v12_0_queue_init(struct amdgpu_dev=
ice *adev,
>                 mes_v12_0_queue_init_register(ring);
>         }
>
> -       /* get MES scheduler/KIQ versions */
> -       mutex_lock(&adev->srbm_mutex);
> -       soc21_grbm_select(adev, 3, pipe, 0, 0);
> +       if (((pipe =3D=3D AMDGPU_MES_SCHED_PIPE) && !adev->mes.sched_vers=
ion) ||
> +           ((pipe =3D=3D AMDGPU_MES_KIQ_PIPE) && !adev->mes.kiq_version)=
) {
> +               /* get MES scheduler/KIQ versions */
> +               mutex_lock(&adev->srbm_mutex);
> +               soc21_grbm_select(adev, 3, pipe, 0, 0);
>
> -       if (pipe =3D=3D AMDGPU_MES_SCHED_PIPE)
> -               adev->mes.sched_version =3D RREG32_SOC15(GC, 0, regCP_MES=
_GP3_LO);
> -       else if (pipe =3D=3D AMDGPU_MES_KIQ_PIPE && adev->enable_mes_kiq)
> -               adev->mes.kiq_version =3D RREG32_SOC15(GC, 0, regCP_MES_G=
P3_LO);
> +               if (pipe =3D=3D AMDGPU_MES_SCHED_PIPE)
> +                       adev->mes.sched_version =3D RREG32_SOC15(GC, 0, r=
egCP_MES_GP3_LO);
> +               else if (pipe =3D=3D AMDGPU_MES_KIQ_PIPE && adev->enable_=
mes_kiq)
> +                       adev->mes.kiq_version =3D RREG32_SOC15(GC, 0, reg=
CP_MES_GP3_LO);
>
> -       soc21_grbm_select(adev, 0, 0, 0, 0);
> -       mutex_unlock(&adev->srbm_mutex);
> +               soc21_grbm_select(adev, 0, 0, 0, 0);
> +               mutex_unlock(&adev->srbm_mutex);
> +       }
>
>         return 0;
>  }
> --
> 2.49.0
>
