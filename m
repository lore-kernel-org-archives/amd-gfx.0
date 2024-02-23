Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731E7C5478C
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Feb 2024 16:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF9B710EC68;
	Fri, 23 Feb 2024 16:33:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B6oeFS8N";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7607710EC70
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Feb 2024 16:33:18 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-29a6dcfdd30so362539a91.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Feb 2024 08:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708705998; x=1709310798; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xiM9bH5VjqYJX+etJTrLXxfvi1iycthNA4DwqdRH6GU=;
 b=B6oeFS8N8rvVjfM8VhWyes0BrRHBywPyJSmQ1nRGbTegPx4vb2R/jhQoqLincBdQSI
 S+vK+FnWZR58bjtGl8LHG5yJBSHwtfa9fr+8AjZ0RLUT8KEhCqK3IFiFTwceVSLpQ3C2
 l/xzhNPqsysigR1X1hj7KFJB4ptWaia00gmyJw6bEzte3Rfyrdi45ykXOp/WKst6TYzy
 NKMqwKYMFrfkHSUeB6/dL6ICeDkFHjRlFZSHc0fAwgi0tGaJN8fiDP5h46wOxjiW4LNy
 kCOjWpg8j6FNiPBuGyzLs3tXJoqB8+JsXdgeZnchYRAn69FQZ4UvcY6LLPtHRNUZIi9Y
 Ik+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708705998; x=1709310798;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xiM9bH5VjqYJX+etJTrLXxfvi1iycthNA4DwqdRH6GU=;
 b=gQq+6KOrUFeHMUcMHjHVnH1cnjxNpgXbhozS7WCi+NDJYC2U0im4SA40ak6PLmjAnK
 vdVDptBBEVrfxTX60b7Tccm1SN51DoYtDdD7AYg0v82d3NamgY5DRUOYSmqY8ez7BVYY
 stRBEHKhBmG3hdDhAc893mKDHWVqCVIG3Cpui0D6RVAy+DL4VgT1RuxqxopUtc4woYqh
 vDIeHyEgd37J4GSsPJHUKxBr5sY+ocVZb/ZY7xrVJz6rSxVEQKAM6wvCRfT4VBsbqntN
 9UJsqd0W/+u1wofaK3EmqN+Iyfdc7AQjgLhUhC0qk78/GMZFVIDRRU7cewzRHPwaa3wb
 eeEQ==
X-Gm-Message-State: AOJu0YxMnIxPPacEXQKDU7hw3AiYVnTFtZh02yHCCcOIlxD/z9ZlGAOj
 dm5kkucsBcgEbhWPLXPg1vgo8bkELVhn/T3MrZT53M8uLirx/Muqd9mhVCAFA3rHo5+k47lEdcU
 ewlgUGcawP9NGKPk0Tpoj9L3SNv0=
X-Google-Smtp-Source: AGHT+IGPXi6S6qh+urHSBKPikHfBzbPRIbtQFy+VHJOzjjOyhr/RRK5K8bXxf7nS7e4HgQOzFQs9uu2Ri/XYpD6y22M=
X-Received: by 2002:a17:90b:1bc5:b0:299:4a63:9e50 with SMTP id
 oa5-20020a17090b1bc500b002994a639e50mr344783pjb.14.1708705997834; Fri, 23 Feb
 2024 08:33:17 -0800 (PST)
MIME-Version: 1.0
References: <20240223091911.1850226-1-Jun.Ma2@amd.com>
In-Reply-To: <20240223091911.1850226-1-Jun.Ma2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 Feb 2024 11:33:05 -0500
Message-ID: <CADnq5_P70-2goVHkq8RKLeQcKmBgze8geE3C+ZJx5WFwSbBsug@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/pm: Fix the power1_min_cap value
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

On Fri, Feb 23, 2024 at 4:20=E2=80=AFAM Ma Jun <Jun.Ma2@amd.com> wrote:
>
> It's unreasonable to use 0 as the power1_min_cap when
> OD is disabled. So, use the same lower limit as the value
> used when OD is enabled.
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>

Fixes: 1958946858a6 ("drm/amd/pm: Support for getting power1_cap_min value"=
)

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 9 ++++-----
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 9 ++++-----
>  drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 9 ++++-----
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c    | 9 ++++-----
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c    | 9 ++++-----
>  5 files changed, 20 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/=
gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 4cd43bbec910..bcad42534da4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -1303,13 +1303,12 @@ static int arcturus_get_power_limit(struct smu_co=
ntext *smu,
>         if (default_power_limit)
>                 *default_power_limit =3D power_limit;
>
> -       if (smu->od_enabled) {
> +       if (smu->od_enabled)
>                 od_percent_upper =3D le32_to_cpu(powerplay_table->overdri=
ve_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> -               od_percent_lower =3D le32_to_cpu(powerplay_table->overdri=
ve_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> -       } else {
> +       else
>                 od_percent_upper =3D 0;
> -               od_percent_lower =3D 100;
> -       }
> +
> +       od_percent_lower =3D le32_to_cpu(powerplay_table->overdrive_table=
.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
>
>         dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d=
 (default power: %d)\n",
>                                                         od_percent_upper,=
 od_percent_lower, power_limit);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index 8d1d29ffb0f1..ed189a3878eb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -2357,13 +2357,12 @@ static int navi10_get_power_limit(struct smu_cont=
ext *smu,
>                 *default_power_limit =3D power_limit;
>
>         if (smu->od_enabled &&
> -                   navi10_od_feature_is_supported(od_settings, SMU_11_0_=
ODCAP_POWER_LIMIT)) {
> +                   navi10_od_feature_is_supported(od_settings, SMU_11_0_=
ODCAP_POWER_LIMIT))
>                 od_percent_upper =3D le32_to_cpu(powerplay_table->overdri=
ve_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> -               od_percent_lower =3D le32_to_cpu(powerplay_table->overdri=
ve_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> -       } else {
> +       else
>                 od_percent_upper =3D 0;
> -               od_percent_lower =3D 100;
> -       }
> +
> +       od_percent_lower =3D le32_to_cpu(powerplay_table->overdrive_table=
.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
>
>         dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d=
 (default power: %d)\n",
>                                         od_percent_upper, od_percent_lowe=
r, power_limit);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/dr=
ivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index f2f401f00ed1..a405424dd699 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -640,13 +640,12 @@ static int sienna_cichlid_get_power_limit(struct sm=
u_context *smu,
>         if (default_power_limit)
>                 *default_power_limit =3D power_limit;
>
> -       if (smu->od_enabled) {
> +       if (smu->od_enabled)
>                 od_percent_upper =3D le32_to_cpu(powerplay_table->overdri=
ve_table.max[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
> -               od_percent_lower =3D le32_to_cpu(powerplay_table->overdri=
ve_table.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
> -       } else {
> +       else
>                 od_percent_upper =3D 0;
> -               od_percent_lower =3D 100;
> -       }
> +
> +       od_percent_lower =3D le32_to_cpu(powerplay_table->overdrive_table=
.min[SMU_11_0_7_ODSETTING_POWERPERCENTAGE]);
>
>         dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d=
 (default power: %d)\n",
>                                         od_percent_upper, od_percent_lowe=
r, power_limit);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 67f44f851f59..9649484f11c0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2372,13 +2372,12 @@ static int smu_v13_0_0_get_power_limit(struct smu=
_context *smu,
>         if (default_power_limit)
>                 *default_power_limit =3D power_limit;
>
> -       if (smu->od_enabled) {
> +       if (smu->od_enabled)
>                 od_percent_upper =3D le32_to_cpu(powerplay_table->overdri=
ve_table.max[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
> -               od_percent_lower =3D le32_to_cpu(powerplay_table->overdri=
ve_table.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
> -       } else {
> +       else
>                 od_percent_upper =3D 0;
> -               od_percent_lower =3D 100;
> -       }
> +
> +       od_percent_lower =3D le32_to_cpu(powerplay_table->overdrive_table=
.min[SMU_13_0_0_ODSETTING_POWERPERCENTAGE]);
>
>         dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d=
 (default power: %d)\n",
>                                         od_percent_upper, od_percent_lowe=
r, power_limit);
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 49e77f8896c1..ac27734674db 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -2336,13 +2336,12 @@ static int smu_v13_0_7_get_power_limit(struct smu=
_context *smu,
>         if (default_power_limit)
>                 *default_power_limit =3D power_limit;
>
> -       if (smu->od_enabled) {
> +       if (smu->od_enabled)
>                 od_percent_upper =3D le32_to_cpu(powerplay_table->overdri=
ve_table.max[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
> -               od_percent_lower =3D le32_to_cpu(powerplay_table->overdri=
ve_table.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
> -       } else {
> +       else
>                 od_percent_upper =3D 0;
> -               od_percent_lower =3D 100;
> -       }
> +
> +       od_percent_lower =3D le32_to_cpu(powerplay_table->overdrive_table=
.min[SMU_13_0_7_ODSETTING_POWERPERCENTAGE]);
>
>         dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d=
 (default power: %d)\n",
>                                         od_percent_upper, od_percent_lowe=
r, power_limit);
> --
> 2.34.1
>
