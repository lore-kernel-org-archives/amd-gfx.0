Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E40CF9C6F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Sep 2024 15:45:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01F9310E06A;
	Tue, 24 Sep 2024 15:45:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CgL9tIVw";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6462B10E06A
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 15:45:05 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2055548469aso2291745ad.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Sep 2024 08:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727192705; x=1727797505; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TvlCNBilCotHK3Lbb5u3TJU74Z7YKedVvFvrd9pu5oU=;
 b=CgL9tIVwy+843nk3hiOFioO9SQFQh/QoC9AEUQ2/84Xdx3Py4tGRASFNgCfEPJX4eJ
 eF1C+rOLIbp9Dk4QVsDLcVaqC5C1v4Mn/wR2nEjKzAIYoeB1uRe0RiDkjv4irkm0LXEd
 ME+VXkSCpvVXVnqbcrTa9I2nKQdQ7dN7H5Ai1wnEVqnOTdyuEZISquAXsuZ+jUK+HjHJ
 i4vAIuI11eu/fLL1fO2jFc4ijXGuXdWORdgNxaL9ADQ6N1RHG65+bz1J+y7ssrEMUN06
 C1sqNwGinIlV0kG7oyxFfKxUdyQtfwRk+dPvwVp70V6U+ZKSgpk5ufkdeT1HxUmh1D2G
 U6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727192705; x=1727797505;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TvlCNBilCotHK3Lbb5u3TJU74Z7YKedVvFvrd9pu5oU=;
 b=hOM5qm0baOJcZI/ZlzDXIIwnkdI/2AzX05nFvh+8NmZHLhjIMkfiW+fxDprzOvAUz2
 nhRqdD7TE/v9JTzDvGAkjjz+Sf9rM7ExjiK1qBpGCVgf8/jqCq4oGeOGTCC8noptbzWO
 +XDsTnFn7+gKoMVVKZ1D+AVPZS/GDh785so3wE6eYlFyZQWIexvOqYjFuAeqJ4ht/nsF
 tSq6lACP/IogxfrBGoUi4IXjCkJ8lKgzm8DL1rf41E+Hv1qSzz3mhv0B0lFmt+jrObNP
 0IYWL3p2SkXRPxMulSY5ZNjc55lH+eEBLo9UR5ZgBr44GrLvTbQMm1bD1APi1S9EbyCM
 cSaQ==
X-Gm-Message-State: AOJu0YxFsNbQbtu4tk0yxysVcREjtZRzfSjea2b2xQZ6w8T6/7qQaqrT
 NOj+2XKJuTCVyewjWJbQ0wOq1hc+BvVNg4GhLGCu1rytu09nojcLYZ4QXRP92zsubN3SXEx45EC
 DFXOpf7VhGDa71XHwUCCmhylKkJs=
X-Google-Smtp-Source: AGHT+IFph1JhregwJCmK2s6h6iVZGGSu6eW/my4gqh8P4YAvp8MYmEMb4vNZwG+o4QBwgTZs2p4EzDy0WhQbBJs81uc=
X-Received: by 2002:a17:902:f2c9:b0:207:d98:52ea with SMTP id
 d9443c01a7336-20aefee581amr17485495ad.12.1727192704851; Tue, 24 Sep 2024
 08:45:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240920111304.436478-1-kenneth.feng@amd.com>
In-Reply-To: <20240920111304.436478-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Sep 2024 11:44:53 -0400
Message-ID: <CADnq5_M8sb-j7=TwZfA5SSLtwjOH69TNA0F1W5V0K7a+OShFcQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: update workload mask after the setting
To: Kenneth Feng <kenneth.feng@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
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

On Fri, Sep 20, 2024 at 7:13=E2=80=AFAM Kenneth Feng <kenneth.feng@amd.com>=
 wrote:
>
> update workload mask after the setting, to fix:
> https://gitlab.freedesktop.org/drm/amd/-/issues/3625
>

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3625

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 6 +++++-
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 3 +++
>  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 6 +++++-
>  3 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index a887ab945dfa..1d024b122b0c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2569,10 +2569,14 @@ static int smu_v13_0_0_set_power_profile_mode(str=
uct smu_context *smu,
>                 }
>         }
>
> -       return smu_cmn_send_smc_msg_with_param(smu,
> +       ret =3D smu_cmn_send_smc_msg_with_param(smu,
>                                                SMU_MSG_SetWorkloadMask,
>                                                workload_mask,
>                                                NULL);
> +       if (!ret)
> +               smu->workload_mask =3D workload_mask;
> +
> +       return ret;
>  }
>
>  static bool smu_v13_0_0_is_mode1_reset_supported(struct smu_context *smu=
)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 7bc95c404377..b891a5e0a396 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -2501,8 +2501,11 @@ static int smu_v13_0_7_set_power_profile_mode(stru=
ct smu_context *smu, long *inp
>                 return -EINVAL;
>         ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetWorkloadM=
ask,
>                                     1 << workload_type, NULL);
> +
>         if (ret)
>                 dev_err(smu->adev->dev, "[%s] Failed to set work load mas=
k!", __func__);
> +       else
> +               smu->workload_mask =3D (1 << workload_type);
>
>         return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index 43820d7d2c54..5899d01fa73d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -1861,10 +1861,14 @@ static int smu_v14_0_2_set_power_profile_mode(str=
uct smu_context *smu,
>         if (workload_type < 0)
>                 return -EINVAL;
>
> -       return smu_cmn_send_smc_msg_with_param(smu,
> +       ret =3D smu_cmn_send_smc_msg_with_param(smu,
>                                                SMU_MSG_SetWorkloadMask,
>                                                1 << workload_type,
>                                                NULL);
> +       if (!ret)
> +               smu->workload_mask =3D 1 << workload_type;
> +
> +       return ret;
>  }
>
>  static int smu_v14_0_2_baco_enter(struct smu_context *smu)
> --
> 2.34.1
>
