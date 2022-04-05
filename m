Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C422C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Apr 2022 17:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12A9810ED55;
	Tue,  5 Apr 2022 17:27:37 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84EB110ED55
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Apr 2022 17:27:35 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id e189so14057575oia.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Apr 2022 10:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LiVaghWF5ijEUinAmxa/kOs1hJSKrAl3rfJNZ9ow/TQ=;
 b=J8VnX7kJNM6VImv9zM1b2cGDJi7HxE4a3d3HmsWJYm/q3LhG9mGblsGOPIbFAUhS15
 BIwERg+9CoRfS0c5JNr3qwCftLEyQ48951t26kEfkHPf9qzUM5uVe2k+vMES+o0DtccM
 TxAgYmHhLxKPk97kW6tzVKvUeZG+XSWh3HOoS29f02lEPQcyVhK+brkSD5N6zkWz5N2e
 hbkhQn8KacsqZZkwyBAf2pGdG5d/nQwKjQ4u9gUroPtaEmZVpjCV+w632J5vExG/HPxU
 W0x3CpREHldngqyM0eZHEJFkl5bRpS0vCoY/IXm3QBuX2PouQ6sXnOp58NPTrk9iNd1r
 X/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LiVaghWF5ijEUinAmxa/kOs1hJSKrAl3rfJNZ9ow/TQ=;
 b=3dh+p8vHJrD6pDyzX6BYtLONr7uLIYi0euxNU0t8z+zDU/V1EVr1sXi9cenMIULpqj
 Gj7L2i+QgkVu2D7ToRDNkS3PGSJNFNGV3TIS6sbyJkK3IPlRYU8vXl87+Kvo0r+PPcpE
 LTyvljrzI1IfK1UhYUUSZs9p/q6Le2Xjlw7CQB3PeZK2hhC1nIgSKW+6/SYQpeyIk6Jv
 RFl6Agfaxr9ucOOFZlMEgMons3YM/5Ga4/89Pnsk6rBDcvDwSQEmhuNs9gBEvv+OIdx3
 cU24pDr3T0opfWYyuBbfVLNjh6jTHNx4K852GH8WP/9fQSkYrKRQR9WZE6qyTDMxawYt
 hNzw==
X-Gm-Message-State: AOAM532Th0vwNp/zhC5WvMEdeTgKIJN203+6I1AX8KvsPm220vlDkA27
 ckUecsUpgslMxq4LygA58ewBx+0ZmEZNm9LR0tQ=
X-Google-Smtp-Source: ABdhPJxG4cqQKG94s6GxqhrndXIg9yCU2ZhTAYylUUMRIHN3qxWuzEY7dIj2SQwgZCi8UBqB6NDF8Iz4yzocJJ3VEWQ=
X-Received: by 2002:aca:d04:0:b0:2ef:8b45:d235 with SMTP id
 4-20020aca0d04000000b002ef8b45d235mr1968569oin.253.1649179654764; Tue, 05 Apr
 2022 10:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220401151608.2910979-1-alexander.deucher@amd.com>
In-Reply-To: <20220401151608.2910979-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Apr 2022 13:27:23 -0400
Message-ID: <CADnq5_NgSbAyg7s3eR_TYhJ9VWi2JKvmzgbVxb4KWsbCVbAN0w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/smu10: fix SoC/fclk units in auto mode
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Fri, Apr 1, 2022 at 11:16 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> SMU takes clock limits in Mhz units.  socclk and fclk were
> using 10 khz units in some cases.  Switch to Mhz units.
> Fixes higher than required SoC clocks.
>
> Fixes: 97cf32996c46d9 ("drm/amd/pm: Removed fixed clock in auto mode DPM")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> index 9ddd8491ff00..545dd68a8c18 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> @@ -773,13 +773,13 @@ static int smu10_dpm_force_dpm_level(struct pp_hwmgr *hwmgr,
>                 smum_send_msg_to_smc_with_parameter(hwmgr,
>                                                 PPSMC_MSG_SetHardMinFclkByFreq,
>                                                 hwmgr->display_config->num_display > 3 ?
> -                                               data->clock_vol_info.vdd_dep_on_fclk->entries[0].clk :
> +                                                   (data->clock_vol_info.vdd_dep_on_fclk->entries[0].clk / 100) :
>                                                 min_mclk,
>                                                 NULL);
>
>                 smum_send_msg_to_smc_with_parameter(hwmgr,
>                                                 PPSMC_MSG_SetHardMinSocclkByFreq,
> -                                               data->clock_vol_info.vdd_dep_on_socclk->entries[0].clk,
> +                                               data->clock_vol_info.vdd_dep_on_socclk->entries[0].clk / 100,
>                                                 NULL);
>                 smum_send_msg_to_smc_with_parameter(hwmgr,
>                                                 PPSMC_MSG_SetHardMinVcn,
> @@ -792,11 +792,11 @@ static int smu10_dpm_force_dpm_level(struct pp_hwmgr *hwmgr,
>                                                 NULL);
>                 smum_send_msg_to_smc_with_parameter(hwmgr,
>                                                 PPSMC_MSG_SetSoftMaxFclkByFreq,
> -                                               data->clock_vol_info.vdd_dep_on_fclk->entries[index_fclk].clk,
> +                                               data->clock_vol_info.vdd_dep_on_fclk->entries[index_fclk].clk / 100,
>                                                 NULL);
>                 smum_send_msg_to_smc_with_parameter(hwmgr,
>                                                 PPSMC_MSG_SetSoftMaxSocclkByFreq,
> -                                               data->clock_vol_info.vdd_dep_on_socclk->entries[index_socclk].clk,
> +                                               data->clock_vol_info.vdd_dep_on_socclk->entries[index_socclk].clk / 100,
>                                                 NULL);
>                 smum_send_msg_to_smc_with_parameter(hwmgr,
>                                                 PPSMC_MSG_SetSoftMaxVcn,
> --
> 2.35.1
>
