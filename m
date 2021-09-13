Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F59C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 19:13:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C89D960F26
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 19:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C89D960F26
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AB386E21D;
	Mon, 13 Sep 2021 19:13:21 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A70426E21D
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 19:13:19 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id 6so15435298oiy.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 12:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JRIjvvxNJkbSZQpZNBqGzW4hLNySlkepyWd4OrxH4nI=;
 b=izfwV/tTitupxogvyq5iLextkfOLr71IrzNmeRPg1BMaUQ34g0H7Q3rPhZtBgDopVQ
 0nyDpMDc1UMPOcwxoQeWKXyt/AukRs1IGctMMKYyTGBZukQQqgF7cEr2BRW+B/7Ubt8n
 jgefOBlOFtYtiamqh9e4I62BBpE8K/GB55vPvSVCSwmuuVwDRCXu+HEEOp7Abhtfqnnk
 v902Ca2VKuM7DVjRj+nDp+OL5LWC5WVTckcEkfaLOStFpLG0q1UkH6DY2bgkwx2/vj4J
 pO0PFCbY8AjpnM0VMTwSl9OAF6FSF5seZSzLAT3pLu2rVdMvTG3Ccbo3xIRUqGIuO/am
 0nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JRIjvvxNJkbSZQpZNBqGzW4hLNySlkepyWd4OrxH4nI=;
 b=klzWsw8pA0ZP8edsMNtUPQi/FYDnR0THiB3GKErvTTdN6tAu3C6SMsuB7+QMNLp87f
 V+7jOml2tOSKAG5QrgJPsBOPjqEPg5BcdexIvqpd2FQDBSwlZuuVEkpgGkkWosk0B9fh
 W+kEOuCnwZhn77zzakItOfDBzI41JW5NwvI0j4xRPtrobCmSqnwvA67Cp0GUu7CB7+78
 65RXFzCXj6Tj5tQyVSa0Hhynz4Cdl114YY/j2K4u6dJ15TgFlrlEc+/qHXg3D7LGfyF8
 lPmjKn8xJZtH1xzjLQIHT0VRdqoIQ41DO//SP5fD287QKL0x4kjobZr/6oyBMBGgYn/h
 SZ2g==
X-Gm-Message-State: AOAM533Hc5G/V9xQjZ0j+UHNPHkVPuI2k6iJhh7NA0T38uqk8yqM+IvP
 PI987++XLSpcLd1Ms82EUQ04JqJ/GM9ZCBtBoEPObrHO
X-Google-Smtp-Source: ABdhPJwgu5JlFnUlNEtKk9pGUjEPO8RvJ/qT5YZrYmgLt4gbFOZG9HWGfZHjmdzknFpX4aX3QrryYlmxrxqmz5WcUhY=
X-Received: by 2002:aca:706:: with SMTP id 6mr7855809oih.5.1631560398971; Mon,
 13 Sep 2021 12:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210913191136.104609-1-nicholas.kazlauskas@amd.com>
In-Reply-To: <20210913191136.104609-1-nicholas.kazlauskas@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Sep 2021 15:13:08 -0400
Message-ID: <CADnq5_NRi4V-MPm-5JWVbPEtAJ0n7pVvL5K+Wonkvr3YXDoTwQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix white screen page fault for gpuvm
To: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, Aaron Liu <aaron.liu@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

Can you add a fixes: tag?

Alex

On Mon, Sep 13, 2021 at 3:11 PM Nicholas Kazlauskas
<nicholas.kazlauskas@amd.com> wrote:
>
> [Why]
> The "base_addr_is_mc_addr" field was added for dcn3.1 support but
> pa_config was never updated to set it to false.
>
> Uninitialized memory causes it to be set to true which results in
> address mistranslation and white screen.
>
> [How]
> Use memset to ensure all fields are initialized to 0 by default.
>
> Cc: Aaron Liu <aaron.liu@amd.com>
> Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 53363728dbb..b0426bb3f2e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1125,6 +1125,8 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
>         uint32_t agp_base, agp_bot, agp_top;
>         PHYSICAL_ADDRESS_LOC page_table_start, page_table_end, page_table_base;
>
> +       memset(pa_config, 0, sizeof(*pa_config));
> +
>         logical_addr_low  = min(adev->gmc.fb_start, adev->gmc.agp_start) >> 18;
>         pt_base = amdgpu_gmc_pd_addr(adev->gart.bo);
>
> --
> 2.25.1
>
