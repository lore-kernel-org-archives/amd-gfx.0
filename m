Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B74C677F1
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jan 2023 16:57:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9995410E301;
	Thu, 12 Jan 2023 16:57:22 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BACC610E2FC
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 16:57:19 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id n8so15796848oih.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jan 2023 08:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gC1OQHx+mrq0RNUTKlEcYT0YSm1WycveEKfuR5hedes=;
 b=Xi7lRd8N7yTtTo6TPqXbKwRL6wQycpYi1U29P6WGdcz3AoEiQvtPMGD9pFMDih+0Rm
 /7Kf0DW5Fh2ZyJerl5/jYCue9Ccf+LTzHBJT4CJijudAOxJ7Vhuapl4vmajOx9JK1i/j
 c/ySE+z0keAeECHdOEWepKj2EQlyB0h5WWOndWP9oxCo8QaOEWkzlyhpsdjlxBh4YC7K
 HUhkPt0ozuzyuYq5B3+pwLRoUf2qnfwz7XrO6+fVCb3wbP/dMteMbgMZTUwX/kczWcvH
 1h4K4dOD60JRgEBJAUj/xgsdZc6wnpzbM7juldvkmuDIAkzYb/dRBGhrJEHvFwpXt4JI
 X0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gC1OQHx+mrq0RNUTKlEcYT0YSm1WycveEKfuR5hedes=;
 b=yhEJKycMrVlVCFGI9IT4zwQXw+EpkhB9oix1pY01M2SCkUhAAq+iDgnW8x2XCR1jyo
 0ypEpZvHAn8/TB7aG7HkPqm8O4kSvm6dD82FM6VJXHzOH1Z7hogoidcWzdJhGb+7G2Dm
 eygCXA7LV7qTxwjl7MskcBPZCHqKJgjummGEDEI6vYuOnvdDB/6H28vwtoZ+IB8FJY8v
 S3nApszGvugIpeeSkNbzjHx+CvwN/ozsD9VrvIeROnaKkJkmJIsCI9sO419eKEapXiFa
 88jHF+JOIdroxcyMXdg5qjgsT5VTMbwGlji+PbGEsatnrQvIQYcMrJ4VAXLrQqM84StR
 XAHg==
X-Gm-Message-State: AFqh2kruIISZxtMsGCKWqacPrZJ/C4PPtmfW/VHxH48OAucAD2K4tlf1
 puN9bZtoeNid4hi4AEfbyStxIgu9goEdLN0tzoE=
X-Google-Smtp-Source: AMrXdXuraQIes7Ef3k9kqBXAjlU0CGTE3TThsjGJ4Wj3GZFWWhmv6xVA3jHrZaATTbiRbqDV2YUcntNuF2kE+BuZA9k=
X-Received: by 2002:a05:6808:2994:b0:35b:f5f7:3ed0 with SMTP id
 ex20-20020a056808299400b0035bf5f73ed0mr5273493oib.46.1673542638955; Thu, 12
 Jan 2023 08:57:18 -0800 (PST)
MIME-Version: 1.0
References: <20230112162443.603552-1-alexander.deucher@amd.com>
In-Reply-To: <20230112162443.603552-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Jan 2023 11:57:07 -0500
Message-ID: <CADnq5_Nmcu3RcCK3QM9+v4s34jGw-2YF-ng3+BOHKm66Qimj4g@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/smu12: fix power reporting on CZN/BCL
To: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: jesse.zhang@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 12, 2023 at 11:25 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> The metrics interface exposes the socket power in W, but
> apparently RN systems exposed the power as mW.  See
> commit 137aac26a2ed ("drm/amdgpu/smu12: fix power reporting on renoir").
> So leave RN as mW and use W for CZN/BCL.

Just saw that Jesse is working on a proper patch that fixes this for
real based on the firmware versions.  So let's take that instead.

Alex

>
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2321
> Fixes: 137aac26a2ed ("drm/amdgpu/smu12: fix power reporting on renoir")
> Cc: jesse.zhang@amd.com
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index 85e22210963f..77308d481c54 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -1196,7 +1196,10 @@ static int renoir_get_smu_metrics_data(struct smu_context *smu,
>                 *value = metrics->AverageUvdActivity / 100;
>                 break;
>         case METRICS_AVERAGE_SOCKETPOWER:
> -               *value = (metrics->CurrentSocketPower << 8) / 1000;
> +               if (smu->adev->ip_versions[MP1_HWIP][0] == IP_VERSION(12, 0, 0))
> +                       *value = (metrics->CurrentSocketPower << 8) / 1000; /* mW */
> +               else
> +                       *value = metrics->CurrentSocketPower << 8; /* W */
>                 break;
>         case METRICS_TEMPERATURE_EDGE:
>                 *value = (metrics->GfxTemperature / 100) *
> --
> 2.39.0
>
