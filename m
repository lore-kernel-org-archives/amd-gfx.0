Return-Path: <SRS0=jhpT=HR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F784C433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 18:49:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F061464DFD
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 18:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F061464DFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B34C96E910;
	Mon, 15 Feb 2021 18:49:32 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 720FD6E910;
 Mon, 15 Feb 2021 18:49:31 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id r75so8697479oie.11;
 Mon, 15 Feb 2021 10:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=DB2e39wmNlyzoYXIMSc69EsNZtZJAfxV8F103w5KYGI=;
 b=oXYEVDu4uTGML/zfEiarbYcXKEQcPNMwtPPdMJWa4jXS30e2OU6f48biZk7RQwqezn
 99bmlupbkxFnjs1aK+hmbuDi5sgbHqikxMjQuhR3nlbWMQZrHGQXO5B7nUbN5CN+y761
 OcZBPECUbFKAjQu/gRUi8gaLlNr0mQQeMDv/AHfHGDll26NYz7i31vmUqzFXeSn1M/d8
 9H0NZQVdCFuK29XYKlKDPSHbpZI/IBWB21DvxEJvSaKew3bEFNhPEFWBY9bsWQMYP8H4
 tLb8MiNcg+rw7Xa7SL0rDxpLM/IIfUTwqQra1hwYVEFfDTslvHgYosDGhWxaBUJstbPQ
 FgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DB2e39wmNlyzoYXIMSc69EsNZtZJAfxV8F103w5KYGI=;
 b=AVYtsenqzi3CkVwyRnGzsztZTFgdmdO+udXV5o5XLwdRiKvuyibL23VDTIPNtdVRAl
 YmUDrlFJ2cuGg/MLpzzio6S2aqXpS3g/AOIwEd0uYQDBjxRPLE/zTcKtpOJDlCJ8ppMx
 53ANopI7T5Tj6cUGV8+mk81R2L8d9U2f5zvzE5YuNpwcXYf8gqhAF8le/cgRLDJFph0i
 ob0h7uAaDljCDBsgVb2IzHauJc/PImbRHtkHkv//mc+K+yBY+vkehFWxuHDR0I2KCGvO
 9kZ0m0ZIUkcsdHmFWfzkPWjPIhcMHc0rwgA4M37E7Lha4ShRKFGXSjuzq7/jPziZn/nj
 fkKg==
X-Gm-Message-State: AOAM533tAssz599JUObfUw+bD7H7xTxfnIXW/bzAC8P4s76UzQhwgGV6
 MoYYuVY9IVGAEBO8fO4GO/V04gX/FFjL3BdDJAm2kLb9
X-Google-Smtp-Source: ABdhPJwtNcR+iy1OFkd46IBqezbb6PuDuK3CNJ9h15rAjsTAG8bDhXVe9+Ue5E0HqMfp7H7iOOiO4n6Ukn2d+9HXkyM=
X-Received: by 2002:aca:c786:: with SMTP id x128mr208317oif.120.1613414970760; 
 Mon, 15 Feb 2021 10:49:30 -0800 (PST)
MIME-Version: 1.0
References: <20210210120330.54066-1-colin.king@canonical.com>
In-Reply-To: <20210210120330.54066-1-colin.king@canonical.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Feb 2021 13:49:19 -0500
Message-ID: <CADnq5_NHvHgUzd=3xS0VTKVTWyQx2uQn5d2cMrDMso_o0UiUOA@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/pm: fix spelling mistake in various
 messages "power_dpm_force_perfomance_level"
To: Colin King <colin.king@canonical.com>
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
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Evan Quan <evan.quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 10, 2021 at 7:03 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There are spelling mistakes in error and warning messages, the text
> power_dpm_force_perfomance_level is missing a letter r and should be
> power_dpm_force_performance_level.  Fix them.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  Thanks!

Alex


> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c     | 2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c      | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> index ed05a30d1139..d1358a6dd2c8 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> @@ -1487,7 +1487,7 @@ static int smu10_set_fine_grain_clk_vol(struct pp_hwmgr *hwmgr,
>         }
>
>         if (!smu10_data->fine_grain_enabled) {
> -               pr_err("pp_od_clk_voltage is not accessible if power_dpm_force_perfomance_level is not in manual mode!\n");
> +               pr_err("pp_od_clk_voltage is not accessible if power_dpm_force_performance_level is not in manual mode!\n");
>                 return -EINVAL;
>         }
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 093b01159408..8abb25a28117 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -1462,7 +1462,7 @@ static int vangogh_od_edit_dpm_table(struct smu_context *smu, enum PP_OD_DPM_TAB
>
>         if (!(smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL)) {
>                 dev_warn(smu->adev->dev,
> -                       "pp_od_clk_voltage is not accessible if power_dpm_force_perfomance_level is not in manual mode!\n");
> +                       "pp_od_clk_voltage is not accessible if power_dpm_force_performance_level is not in manual mode!\n");
>                 return -EINVAL;
>         }
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 5faa509f0dba..b59156dfca19 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -351,7 +351,7 @@ static int renoir_od_edit_dpm_table(struct smu_context *smu,
>
>         if (!(smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL)) {
>                 dev_warn(smu->adev->dev,
> -                       "pp_od_clk_voltage is not accessible if power_dpm_force_perfomance_level is not in manual mode!\n");
> +                       "pp_od_clk_voltage is not accessible if power_dpm_force_performance_level is not in manual mode!\n");
>                 return -EINVAL;
>         }
>
> --
> 2.30.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
