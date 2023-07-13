Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5940DEB64DD
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jul 2023 13:21:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE5A410E6D1;
	Thu, 13 Jul 2023 13:21:14 +0000 (UTC)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AA8E10E6D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jul 2023 13:21:13 +0000 (UTC)
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1ba2e911c24so44513fac.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jul 2023 06:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689254472; x=1691846472;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WyMIxY/wc266K9J3kMz6LXmkbIEJgn4Vxex58m+Lk+0=;
 b=N10zACuFi8BmfngEDRN4lXAMlFRENcKG+GO3BnGh0VZdDb6Bo4V08zd6iZfigm2Ut9
 aQpq8HpRnBmdVoCRRcdTPbcRHkztn3v35hiAcOdR54pC6J0hZYFDj5ssGGJyqcsm6AMS
 hxJPCdBXyPAl0e6iUrdS1mZttA9aQ0S3OC2mufs63zi4STwLXOeKIj086v2qLEXfHnF3
 vg8R62wm8hQpqfYpcyrp4uw7jFnm7whXzTaCj0cShfCGZu6rnQ3viUGKug6w3oh1iCaQ
 R92S76aJ1pkg0iDvYJI2ZZ8Ou4BP+m2AaKxnDzZJ53MDjVQAM7gZIwa7HYw8Ru3wh5Tn
 rjlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689254472; x=1691846472;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WyMIxY/wc266K9J3kMz6LXmkbIEJgn4Vxex58m+Lk+0=;
 b=Hsq0tXadvZPGBa8UNt5ohzvGc4jAIlyegHBiy7yzNMU1kjJFIh+QedE8gcuUp56rlR
 8B2yefIhlw2CEvCkERmOf2CJeXa4DG2SxcJz+u0T0BxmNvZrMpe+uaGe3e0H/RpZDJYY
 UxYlaNHMVuXDSiVJlfTH3wM+1YqWj+8ZMBZy79BVGowwuPCfCKLNFlwa3sFFq+9n5AXi
 wj93TmWUpb3bvy1dSconRTG8IktNVvs5cKSs5G4UUwxuScsGazuA+Kghadxw3H0Lc+h1
 2TPjrCkq3M7hJKFMFxzeRk7dPglfMfmOM8UqZK92q98QGu6P3fTh0vH+mOjL7ZO5WKk7
 2+fQ==
X-Gm-Message-State: ABy/qLb4NWHQkhLl7tnhCq1E1zPlFtk4cypgYDHmccO5RE5YU86CGYfk
 GdYlTTg8CgxRA+p3N77gHSTZsqyeupqOzi2JyGM=
X-Google-Smtp-Source: APBJJlGzEZM/gCRm/SwP6764DNRmjnWw702kwQ6IZ/fcp93mJXiepmRZsLE4l76RsT40E9gy1EO+PCHMVF4EMGAHdHA=
X-Received: by 2002:a05:6870:ac0f:b0:19f:aec1:331c with SMTP id
 kw15-20020a056870ac0f00b0019faec1331cmr3345228oab.27.1689254471846; Thu, 13
 Jul 2023 06:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230713131937.546606-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230713131937.546606-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Jul 2023 09:21:00 -0400
Message-ID: <CADnq5_N7FuC-qkDhnCwhGpvJf_mW=Rp9cAdXf9raEf9yzpss1Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Avoid possiblity of kernel crash in
 'gmc_v8_0, gmc_v7_0_init_microcode()'
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 13, 2023 at 9:20=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> If the function 'gmc_v8_0_ or gmc_v7_0_init_microcode()' fails, the
> driver will just fail to load, hence return -EINVAL rather having BUG(),
> fixes WARNING: Do not crash the kernel unless it is absolutely
> unavoidable--use WARN_ON_ONCE() plus recovery code (if feasible) instead
> of BUG() or variants
>
> 'Fixes: 1104113b37210 ("drm/amdgpu: Fix error & warnings in gmc_v8_0.c")'
> 'Fixes: d68f1d641eba0 ("drm/amdgpu: Fix errors & warnings in gmc_ v6_0,
> v7_0.c")'
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v7_0.c
> index 0629b6808cb1..6a6929ac2748 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -150,7 +150,7 @@ static int gmc_v7_0_init_microcode(struct amdgpu_devi=
ce *adev)
>         case CHIP_MULLINS:
>                 return 0;
>         default:
> -               BUG();
> +               return -EINVAL;
>         }
>
>         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mc.bin", chip_name)=
;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v8_0.c
> index 23bfadca0fc8..5af235202513 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -252,7 +252,7 @@ static int gmc_v8_0_init_microcode(struct amdgpu_devi=
ce *adev)
>         case CHIP_VEGAM:
>                 return 0;
>         default:
> -               BUG();
> +               return -EINVAL;
>         }
>
>         snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mc.bin", chip_name)=
;
> --
> 2.25.1
>
