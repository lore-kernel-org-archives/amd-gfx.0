Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E976C77B73
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 18:13:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FD6310E462;
	Thu, 20 Apr 2023 18:13:11 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CC9C10ECBD
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 18:13:10 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-187ef4d7863so473667fac.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 11:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682014388; x=1684606388;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T2sqr50fZEpRfJXsqpHMULXLYdRtPilWvWHDCFFoQY4=;
 b=p7W3wz9+XO7uEeJ2cVBjAdlnt70YU1yrLcJ7zQz95tA6zHvE56E1mRwOmEVDk8yhXs
 ojNyG24URHQkvuW6+g9JWDHekbUe0QNQUvuttUCIsVe74yDm4dFHHM0hy3APtUD7VU5C
 O3HwXHq8Sr2C0JTNc/RvkA9nGjYaEhOPYmjx+A6LNqpN8i7LLVerx84KDXDQZe3t5lQj
 OOGdAgUijfxuV2w1ygmY0AZ1GEsg6sz3hAsBtV5AFayQK5Yaxkp/4J4/APTR66EO93kQ
 ymj8P9bvjurbsgTP4p1rnm+ZD+izvs/N+T97vmnc8nAeKdoqzfBvV5pC94u6mxABLSFs
 Lg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682014388; x=1684606388;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T2sqr50fZEpRfJXsqpHMULXLYdRtPilWvWHDCFFoQY4=;
 b=clfncugGip3d5dRGY4aLgZFDJ00Jc1mPNf12HIXjHTYBwI5iiTgYJ9cdn0TnZ0HrbA
 1nGRBaagU+Nzdj9MWjeL6I6x6eTVYN7/b4XVwBmw5LX0sje5TI8JwvKqxi8YVTaq9Nhi
 MvMk3aaby5hui7jtte2+LA9pYFxkf+g27hpLG7tZu1yNWvOSxY1F6I/x4/+Sz08OJMN2
 JP63HUZ9UoNwfhAywueJCSx+JPfNakdwPUonNk0lZjNQzDC3ERYn7Yo1tnnQFrdu5w1q
 gC/K4Q7MCAsqb9i/H1URhoUgTJBjeVtG0B84Vk14H5YkG4u+n0pOVQMmu6SM7k3oTAkC
 nRWA==
X-Gm-Message-State: AAQBX9eBxXuiohLG1uOm4qgjGE5RRsg9jgw9Fgx8ew71lwghvIzvD4yA
 iahcRZtHa2ZC+c2LlIj47UBEa2aTupTyQqaxYqi/uzot
X-Google-Smtp-Source: AKy350YC1Kt7JR/nM/O4DiE1K/inoVUbq0dy/cBQgE2xyxiPRDXtjELz1T2BYgOjE7QjNwtG4D9OBvSLhH/BJq6w3Ac=
X-Received: by 2002:a05:6870:d109:b0:184:21db:bf36 with SMTP id
 e9-20020a056870d10900b0018421dbbf36mr1687396oac.2.1682014388628; Thu, 20 Apr
 2023 11:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230411211422.871350-1-alexander.deucher@amd.com>
In-Reply-To: <20230411211422.871350-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Apr 2023 14:12:57 -0400
Message-ID: <CADnq5_Mr3OWJixj=QL1rf=jJ6AWti_WyNmXOMxyF+4sxgVKjOg@mail.gmail.com>
Subject: Re: [PATCH V2] drm/amdgpu/gfx11: update gpu_clock_counter logic
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Tue, Apr 11, 2023 at 5:14=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> This code was written prior to previous updates to this
> logic for other chips.  The RSC registers are part of
> SMUIO which is an always on block so there is no need
> to disable gfxoff.  Additionally add the carryover and
> preemption checks.
>
> v2: rebase
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v11_0.c
> index 107c487c0c37..00a06d353abd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4673,24 +4673,27 @@ static uint64_t gfx_v11_0_get_gpu_clock_counter(s=
truct amdgpu_device *adev)
>         uint64_t clock;
>         uint64_t clock_counter_lo, clock_counter_hi_pre, clock_counter_hi=
_after;
>
> -       amdgpu_gfx_off_ctrl(adev, false);
> -       mutex_lock(&adev->gfx.gpu_clock_mutex);
>         if (amdgpu_sriov_vf(adev)) {
> +               amdgpu_gfx_off_ctrl(adev, false);
> +               mutex_lock(&adev->gfx.gpu_clock_mutex);
>                 clock_counter_hi_pre =3D (uint64_t)RREG32_SOC15(GC, 0, re=
gCP_MES_MTIME_HI);
>                 clock_counter_lo =3D (uint64_t)RREG32_SOC15(GC, 0, regCP_=
MES_MTIME_LO);
>                 clock_counter_hi_after =3D (uint64_t)RREG32_SOC15(GC, 0, =
regCP_MES_MTIME_HI);
>                 if (clock_counter_hi_pre !=3D clock_counter_hi_after)
>                         clock_counter_lo =3D (uint64_t)RREG32_SOC15(GC, 0=
, regCP_MES_MTIME_LO);
> +               mutex_unlock(&adev->gfx.gpu_clock_mutex);
> +               amdgpu_gfx_off_ctrl(adev, true);
>         } else {
> +               preempt_disable();
>                 clock_counter_hi_pre =3D (uint64_t)RREG32_SOC15(SMUIO, 0,=
 regGOLDEN_TSC_COUNT_UPPER);
>                 clock_counter_lo =3D (uint64_t)RREG32_SOC15(SMUIO, 0, reg=
GOLDEN_TSC_COUNT_LOWER);
>                 clock_counter_hi_after =3D (uint64_t)RREG32_SOC15(SMUIO, =
0, regGOLDEN_TSC_COUNT_UPPER);
>                 if (clock_counter_hi_pre !=3D clock_counter_hi_after)
>                         clock_counter_lo =3D (uint64_t)RREG32_SOC15(SMUIO=
, 0, regGOLDEN_TSC_COUNT_LOWER);
> +               preempt_enable();
>         }
>         clock =3D clock_counter_lo | (clock_counter_hi_after << 32ULL);
> -       mutex_unlock(&adev->gfx.gpu_clock_mutex);
> -       amdgpu_gfx_off_ctrl(adev, true);
> +
>         return clock;
>  }
>
> --
> 2.39.2
>
