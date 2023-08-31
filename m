Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38650C83F15
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Aug 2023 03:01:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3E9D10E63B;
	Thu, 31 Aug 2023 03:01:29 +0000 (UTC)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 325CC10E63B
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Aug 2023 03:01:29 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-572a7141434so235645eaf.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Aug 2023 20:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693450888; x=1694055688; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/WVSmGGga1q95QxDvVR6aJ8B6QNx/Egs0qSsCqiuNfQ=;
 b=CH4Q8nSoFJ5m+aHzXqgOce1eyKhRDsVBA9KAzDSk3wORDCHQLQTmLKn+tHX8srqNkm
 gWPM6Bb5+tNPrCfjVvlSy2ippyT0OvWYkiHdO1/u3bsnhDeBQ2ZJyTgfU3p0tGMiotDp
 /4ddY3JY0ga3vGo5J6Bh3AVgi4CUSP6/OADqtw9VBGgLEDb/C4unNsrKsF4QZqkD/QH7
 W1wF+QPPVsfd6tp4CgTKAvg91VOn3t1LGFdQuQOK8xiAe3bUsSg6Re8whSrFHtjxnv7H
 FPpwuLJdYlxAAez90ur0IkNxx6iu9fqPnuGHokms6EkryLggOtJVX+eBw+KkcviMlOG2
 49ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693450888; x=1694055688;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/WVSmGGga1q95QxDvVR6aJ8B6QNx/Egs0qSsCqiuNfQ=;
 b=WLq0MH/8KY1JUh18FK9f2cjUFSON6WekIrq+TJjL1HdtJ35eKLUMw7gH3130+Lq9yg
 N8qHLR5HD4kqsP5/0fp6C5tNXwaRKJ8K+j3igyei5EQAfkmQfpR4rAHltfCkH1GiK1iw
 jRiQj79kXqcYk7HjswjYVnzuEGd7lx/VS/v4ZHmRqtmzl6HpymmzaYEX0r+eaH9pWhHa
 P2RcyWcVLTLlLXwLKMgcs0EaiGEorQIrxqNR7L92A63zyGU2nk647KqxduA0s6M8azxK
 DiBZsSCgRWrzDtF3iGsDHMdK8qfUM4Mmzag1IL/WlV/7vcWlTth0oGei8GsEm8q6P5ug
 cL+w==
X-Gm-Message-State: AOJu0Yz2VqRJHtXKX+9N1zM9XFpsxH1dVjvXHuR8VA1p7eOzciS/u7oj
 eQS6ALSy9sD94Uux4h3NsGvB03+el/PT2saFy5LDf1LX
X-Google-Smtp-Source: AGHT+IFpnKTaF65pqYDmDvNA06nf31Z6V0hSn8p8Zn/CaV0Rpa0qMN0aYngJa5R+G/FhoLABk0DDvhELHiKOuA+GSXU=
X-Received: by 2002:a4a:304f:0:b0:573:7828:ce53 with SMTP id
 z15-20020a4a304f000000b005737828ce53mr3547465ooz.4.1693450888147; Wed, 30 Aug
 2023 20:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230831024221.1011479-1-evan.quan@amd.com>
In-Reply-To: <20230831024221.1011479-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 30 Aug 2023 23:01:16 -0400
Message-ID: <CADnq5_OV5MGH1mqBC6r1B1sMogYzaoHuzKg35ksRciaE-uWm-w@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amd/pm: disable the SMU13 OD feature support
 temporarily"
To: Evan Quan <evan.quan@amd.com>
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Aug 30, 2023 at 10:50=E2=80=AFPM Evan Quan <evan.quan@amd.com> wrot=
e:
>
> This reverts commit 3592cc20beeece83db4c50a0f400e2dd15139de9.
>
> The enablement for the new OD mechanism completed. Also, the support for
> fan control related OD feature has been added via this new mechanism.
> Thus, it is time to bring back the SMU13 OD support.
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   | 18 +++---------------
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   | 12 +++---------
>  2 files changed, 6 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index c48f81450d24..093962a37688 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -348,13 +348,10 @@ static int smu_v13_0_0_check_powerplay_table(struct=
 smu_context *smu)
>                 table_context->power_play_table;
>         struct smu_baco_context *smu_baco =3D &smu->smu_baco;
>         PPTable_t *pptable =3D smu->smu_table.driver_pptable;
> -#if 0
> -       PPTable_t *pptable =3D smu->smu_table.driver_pptable;
>         const OverDriveLimits_t * const overdrive_upperlimits =3D
>                                 &pptable->SkuTable.OverDriveLimitsBasicMa=
x;
>         const OverDriveLimits_t * const overdrive_lowerlimits =3D
>                                 &pptable->SkuTable.OverDriveLimitsMin;
> -#endif
>
>         if (powerplay_table->platform_caps & SMU_13_0_0_PP_PLATFORM_CAP_H=
ARDWAREDC)
>                 smu->dc_controlled_by_gpio =3D true;
> @@ -366,27 +363,18 @@ static int smu_v13_0_0_check_powerplay_table(struct=
 smu_context *smu)
>         if (powerplay_table->platform_caps & SMU_13_0_0_PP_PLATFORM_CAP_M=
ACO)
>                 smu_baco->maco_support =3D true;
>
> -       /*
> -        * We are in the transition to a new OD mechanism.
> -        * Disable the OD feature support for SMU13 temporarily.
> -        * TODO: get this reverted when new OD mechanism online
> -        */
> -#if 0
>         if (!overdrive_lowerlimits->FeatureCtrlMask ||
>             !overdrive_upperlimits->FeatureCtrlMask)
>                 smu->od_enabled =3D false;
>
> +       table_context->thermal_controller_type =3D
> +               powerplay_table->thermal_controller_type;
> +
>         /*
>          * Instead of having its own buffer space and get overdrive_table=
 copied,
>          * smu->od_settings just points to the actual overdrive_table
>          */
>         smu->od_settings =3D &powerplay_table->overdrive_table;
> -#else
> -       smu->od_enabled =3D false;
> -#endif
> -
> -       table_context->thermal_controller_type =3D
> -               powerplay_table->thermal_controller_type;
>
>         smu->adev->pm.no_fan =3D
>                 !(pptable->SkuTable.FeaturesToRun[0] & (1 << FEATURE_FAN_=
CONTROL_BIT));
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 99bc449799a6..430ad1b05ba3 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -338,12 +338,10 @@ static int smu_v13_0_7_check_powerplay_table(struct=
 smu_context *smu)
>         struct smu_baco_context *smu_baco =3D &smu->smu_baco;
>         PPTable_t *smc_pptable =3D table_context->driver_pptable;
>         BoardTable_t *BoardTable =3D &smc_pptable->BoardTable;
> -#if 0
>         const OverDriveLimits_t * const overdrive_upperlimits =3D
>                                 &smc_pptable->SkuTable.OverDriveLimitsBas=
icMax;
>         const OverDriveLimits_t * const overdrive_lowerlimits =3D
>                                 &smc_pptable->SkuTable.OverDriveLimitsMin=
;
> -#endif
>
>         if (powerplay_table->platform_caps & SMU_13_0_7_PP_PLATFORM_CAP_H=
ARDWAREDC)
>                 smu->dc_controlled_by_gpio =3D true;
> @@ -355,22 +353,18 @@ static int smu_v13_0_7_check_powerplay_table(struct=
 smu_context *smu)
>         if (smu_baco->platform_support && (BoardTable->HsrEnabled || Boar=
dTable->VddqOffEnabled))
>                 smu_baco->maco_support =3D true;
>
> -#if 0
>         if (!overdrive_lowerlimits->FeatureCtrlMask ||
>             !overdrive_upperlimits->FeatureCtrlMask)
>                 smu->od_enabled =3D false;
>
> +       table_context->thermal_controller_type =3D
> +               powerplay_table->thermal_controller_type;
> +
>         /*
>          * Instead of having its own buffer space and get overdrive_table=
 copied,
>          * smu->od_settings just points to the actual overdrive_table
>          */
>         smu->od_settings =3D &powerplay_table->overdrive_table;
> -#else
> -       smu->od_enabled =3D false;
> -#endif
> -
> -       table_context->thermal_controller_type =3D
> -               powerplay_table->thermal_controller_type;
>
>         return 0;
>  }
> --
> 2.34.1
>
