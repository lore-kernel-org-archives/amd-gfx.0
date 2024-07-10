Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D933C3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 13:47:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2213410E7CF;
	Wed, 10 Jul 2024 13:47:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jz85L297";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E98210E7CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 13:47:45 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-2c8517aab46so4688333a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 06:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720619265; x=1721224065; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zkeh/thtDpJ7cne/sew20LJSnXDKm9AzrtpDn/GsF44=;
 b=Jz85L297chIBRhkMQS6k+Csp5iS4Q9OZDHWbbA0V6XWCYQZsHxMZDLl9Fr88AeA8D0
 aQk/PqQIPEgTzurMTeqiXuCLN/9liIT05UVxwTiGN2QeYgZmO+/3RiqmWv8A6L2zNbY3
 UFqqHx5x3+Xf0CWv2UB6e+SCYknMKZyr9SAhvZO6FLoCmLwlVQEXsKAGKmOfAnqarl0a
 bAg5/14AVQ+ZALIFdwoltyKdcHYpOD8aqIxFySsofj2ZqdY7YDKCWMZaU8Xuyb1Mvivz
 2abXIIuLShvT7YkDRZ/nVIzPJwB3GGVH6/6lkBzemB0a7WPRBuz4hMV+EqbXZqzJ3foR
 xtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720619265; x=1721224065;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zkeh/thtDpJ7cne/sew20LJSnXDKm9AzrtpDn/GsF44=;
 b=rjqf4xGDnzT+sIxbbSYOfxjJiZoOteRm/O0o5QLeVHBfZsvU/C+Px0IB0OxsY11uWc
 8pfZrtBL4TVPcUPp4tfK3XfIni19GpnAJR0dUbhcHRVqsMDmutwa1zYL4ZRgJaB638ad
 RoqBSPSIo+gMzC4MRXTcTPHdPKIHg90ADB3dMmteAQ3ZG5Qrabufh8GY2/UHE+MwGd2V
 cUMcnOne1+3yuRZabZXdSltj4U4B9ZDK8Xx+uzkCrCX17NkNtvecx1QGunMe2hg8YkDb
 pdVaZ+n8sBODTqF28DtmIvvy9hHOgX4ywupokhmjXa8q8+PRGHBOBwv+qQaHFCEmEqsS
 QQbw==
X-Gm-Message-State: AOJu0YzYGoStIg6wLzmbPFUdWiLQAT/jdsX/k8Jzo83GpGkWCvMs9G8O
 Ss3ww7EmMNp53YU0yyWBChnmfogBYBGAZsO9mEe+BwVARLiJpqGB+OgUGqQdrcYJ/90tGHyVIOe
 0io22wOdEPwvJ1KqEs7dSYs5kuqcnvQ==
X-Google-Smtp-Source: AGHT+IH8udzWeXYbuk9499wTJAG5jF3v0eKtnB2bXFtxK1rB/PIAa2po0lVPIBzO8WVUBxs6JTzFVrV4TRVGHrnQR5o=
X-Received: by 2002:a17:90b:10b:b0:2c9:a151:44fb with SMTP id
 98e67ed59e1d1-2ca35c68956mr4573247a91.22.1720619264792; Wed, 10 Jul 2024
 06:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240710094258.1033943-1-li.ma@amd.com>
In-Reply-To: <20240710094258.1033943-1-li.ma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 10 Jul 2024 09:47:33 -0400
Message-ID: <CADnq5_OnccCt9o=Zh6Vaqzgr95bibsV4DBoqmD+r3PtYJk76bg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/swsmu: enable Pstates profile levels for SMU
 v14.0.4
To: Li Ma <li.ma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, tim.huang@amd.com, 
 Alexander.Deucher@amd.com, yifan1.zhang@amd.com
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

On Wed, Jul 10, 2024 at 5:50=E2=80=AFAM Li Ma <li.ma@amd.com> wrote:
>
> Enables following UMD stable Pstates profile levels
> of power_dpm_force_performance_level for SMU v14.0.4.
>
>     - profile_peak
>     - profile_min_mclk
>     - profile_min_sclk
>     - profile_standard
>
> Signed-off-by: Li Ma <li.ma@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c   | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> index 5d47d58944f6..8798ebfcea83 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> @@ -69,6 +69,9 @@
>  #define SMU_14_0_0_UMD_PSTATE_SOCCLK                   678
>  #define SMU_14_0_0_UMD_PSTATE_FCLK                     1800
>
> +#define SMU_14_0_4_UMD_PSTATE_GFXCLK                   938
> +#define SMU_14_0_4_UMD_PSTATE_SOCCLK                   938
> +
>  #define FEATURE_MASK(feature) (1ULL << feature)
>  #define SMC_DPM_FEATURE ( \
>         FEATURE_MASK(FEATURE_CCLK_DPM_BIT) | \
> @@ -1296,19 +1299,28 @@ static int smu_v14_0_common_get_dpm_profile_freq(=
struct smu_context *smu,
>         switch (clk_type) {
>         case SMU_GFXCLK:
>         case SMU_SCLK:
> -               clk_limit =3D SMU_14_0_0_UMD_PSTATE_GFXCLK;
> +               if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_V=
ERSION(14, 0, 4))
> +                       clk_limit =3D SMU_14_0_4_UMD_PSTATE_GFXCLK;
> +               else
> +                       clk_limit =3D SMU_14_0_0_UMD_PSTATE_GFXCLK;
>                 if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
>                         smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_S=
CLK, NULL, &clk_limit);
>                 else if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SC=
LK)
>                         smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_S=
CLK, &clk_limit, NULL);
>                 break;
>         case SMU_SOCCLK:
> -               clk_limit =3D SMU_14_0_0_UMD_PSTATE_SOCCLK;
> +               if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_V=
ERSION(14, 0, 4))
> +                       clk_limit =3D SMU_14_0_4_UMD_PSTATE_SOCCLK;
> +               else
> +                       clk_limit =3D SMU_14_0_0_UMD_PSTATE_SOCCLK;
>                 if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
>                         smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_S=
OCCLK, NULL, &clk_limit);
>                 break;
>         case SMU_FCLK:
> -               clk_limit =3D SMU_14_0_0_UMD_PSTATE_FCLK;
> +               if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_V=
ERSION(14, 0, 4))
> +                       smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_F=
CLK, NULL, &clk_limit);
> +               else
> +                       clk_limit =3D SMU_14_0_0_UMD_PSTATE_FCLK;
>                 if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_PEAK)
>                         smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_F=
CLK, NULL, &clk_limit);
>                 else if (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MC=
LK)
> --
> 2.25.1
>
