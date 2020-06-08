Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E6CC433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 22:22:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41B462068D
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 22:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjXWnVdE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B462068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFFC889B99;
	Mon,  8 Jun 2020 22:22:54 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAD6889E43
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 22:22:53 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id e1so19174183wrt.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Jun 2020 15:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WsjUtdqtxV5bGEDnq4+EEAdg82KjBMU91x2gRiDEZ64=;
 b=KjXWnVdECIh96nhb9F5hV61QlT2Lx/LD0qWGNgT9Qs1l/2/E15G3SSKWwLED9dhoX1
 w7MYniikzp5ALA7bhL5tgeSWPP49XrmqvxVWmZ5W/O9nnsmSqgZLDOunWg/aM4o5NYM6
 Eudq3btWx/UpF5450XaB9MdvgNgd0A2JHwu6rqZM595COxdjwM3cMZc/JiIqQDWhAK0x
 n6SI5fdIpdV0u6d+s/CgsYsHOLndYrfKw4hb5CBlWayddy13D5NAAvQab8jxFIxpuws4
 gROVAVIOPHjKGcHr8+w978nTWRc50KHkYX/6JuV5XgAnnudJ6Vk1HmEHC5UxVM8T4hCy
 Js+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WsjUtdqtxV5bGEDnq4+EEAdg82KjBMU91x2gRiDEZ64=;
 b=GG7LLg7tuETUmOapbyKvtdwekUssx0B6vb5SqAxq15Ew9vQvdTwqGrr6ozXlQYM4Qc
 ZO2c+ccaWh5xiUHripk4x5BrDbhH1MG1TFjJ0XLLyvpTExy6uBtlb9w3vC/dFTQr/HsV
 VxiyZB64742EKFao7h7HR8Y7v8cX/1S2WaIbAyzLlqLTOj3ifJUnJr2fLWASUvANQzSF
 TAUq+3HWFovZOfmyGOEp0oTDXA8CRMqSfNrtoj6HqCD4EZYRrWqjJXFPeuMv+JkpH0Iy
 w3JdOfErjPcxbSpQVCPEBI0z95HFXN3g8Ty6rL8h1/+aMEp9oNSSXPYbroUM2vARyN2y
 yhoQ==
X-Gm-Message-State: AOAM530XrpZLxWJKTtFiLFsmg/Zw66+h+DUrJJXoFVkb8juO2DetyHjf
 +BVaNs1135v03/W9ZQagi+Go8ldHfyZeyCa/zlKcIA==
X-Google-Smtp-Source: ABdhPJyTw0DSlYrqzzGNIAu42JdKldWuco3UwjhSVI3e0C2c/xqEa6MfQE1wbQPJWI7QdcIg4EV1dt9WAFIAT56YatE=
X-Received: by 2002:a05:6000:1003:: with SMTP id
 a3mr935758wrx.111.1591654972689; 
 Mon, 08 Jun 2020 15:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200608105234.29864-1-evan.quan@amd.com>
 <20200608105234.29864-7-evan.quan@amd.com>
In-Reply-To: <20200608105234.29864-7-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Jun 2020 18:22:41 -0400
Message-ID: <CADnq5_OZAkBNwUa4Oh5OAZLDwK=KCrGiLL7Z0Okmu4zqOSXhVQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] drm/amd/powerplay: add check for power limit OD
 support
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 8, 2020 at 6:53 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Before counting the OD percent into max power limit margin.
>
> Change-Id: I83b24d614e07fbc5eac41ff7cd668a1c2f33c6b2
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> index 186cdf6696f8..115794557190 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -1920,6 +1920,7 @@ static int navi10_get_power_limit(struct smu_context *smu)
>  {
>         struct smu_11_0_powerplay_table *powerplay_table =
>                 (struct smu_11_0_powerplay_table *)smu->smu_table.power_play_table;
> +       struct smu_11_0_overdrive_table *od_settings = smu->od_settings;
>         PPTable_t *pptable = smu->smu_table.driver_pptable;
>         uint32_t power_limit, od_percent;
>
> @@ -1934,7 +1935,8 @@ static int navi10_get_power_limit(struct smu_context *smu)
>         }
>         smu->current_power_limit = power_limit;
>
> -       if (smu->od_enabled) {
> +       if (smu->od_enabled &&
> +           navi10_od_feature_is_supported(od_settings, SMU_11_0_ODCAP_POWER_LIMIT)) {
>                 od_percent = le32_to_cpu(powerplay_table->overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
>
>                 dev_dbg(smu->adev->dev, "ODSETTING_POWERPERCENTAGE: %d (default: %d)\n", od_percent, power_limit);
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
