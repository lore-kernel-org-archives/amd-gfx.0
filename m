Return-Path: <SRS0=wWp/=3X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A478C35247
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2020 21:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD2A20658
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2020 21:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4UBtWEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD2A20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B88726E43C;
	Mon,  3 Feb 2020 21:31:40 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F6846E43C
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Feb 2020 21:31:39 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id p9so934810wmc.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Feb 2020 13:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=POerSjEcv0EozI7qUYM9Y7hQudZqbYstRVXW/f4lA0s=;
 b=G4UBtWEIW1R++TO7b/S9QroDlAuLOzZV8gx+99RxPIsqgQ95+doD5r0WUnfPJjImYY
 WdhSes3hJQ+iyuGoofihNBe09OJQxOvsuL6En6JiRCjV2lS6z9Vr4nFmja1RWpPXqhJ3
 53yXboWPpDCALCY/Gc9j8tQbN9Zh+ZTjxArtDtLM+ducvnpQ7+WdHXupH/0mFrkvRJHL
 l/CGHNeuHq9uHSavbSvkp0DRC1JMic2rEMhDneAYf1fYWd+8jiREqkRaFVWssJTzQTnh
 f8vvxO+58Uejw/cCkk2iWNPTuVxa4u81k5bM/IvbuxAiNcQAffvkEGKF2+RYVa2Pw4OD
 GzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=POerSjEcv0EozI7qUYM9Y7hQudZqbYstRVXW/f4lA0s=;
 b=P6mGVxypngkZqnGULdUnLWr8wDYft4laxjuIY7/6BRpuwphGUFWMznwei6t7HwmmZg
 ZZejNozEARRM//UrQYZOvAMeFh7dlaUKvL6xwpPi3uzvLm9Jw+1jh7tkoW3Coi7wOTg7
 wVH1SfYWVsrS5ojwlLuWQSU79bTZGe/ajk7bJojL1KSwbeYF9mZwcVseZERWMk66iSU/
 IGRpram0LBV3o+cUdxaHmmOryFmyGP6I9haInk4ogTnFAZPQyys/ltYs0nUCU4tv/RyL
 g5VHvdNGXJhJ2nUnFGnHaLoUGPwPCijHKP3MkW6pc2b0baHU+m3JoYv3xerp/mO1B218
 XPjw==
X-Gm-Message-State: APjAAAVEJ3bDqYIpNPkd3NJe4waQkMtj+1RW2yY0Cg+29NYGs9Mw1K8v
 URarxMSy00Cz4+DNR1g2ZpMblkBm8qKaufqtEneYbw==
X-Google-Smtp-Source: APXvYqwLMl/yo4T4liq+9VRmf0avGm5rB57C/0NWUtNpKHs47rfNWQvYeIToNvVt+y6JjLm/m/pp/Ge/dVnuKLFIiVI=
X-Received: by 2002:a05:600c:218b:: with SMTP id
 e11mr1046676wme.56.1580765497685; 
 Mon, 03 Feb 2020 13:31:37 -0800 (PST)
MIME-Version: 1.0
References: <20200128194707.87898-1-alexander.deucher@amd.com>
 <20200128194707.87898-2-alexander.deucher@amd.com>
In-Reply-To: <20200128194707.87898-2-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 3 Feb 2020 16:31:26 -0500
Message-ID: <CADnq5_OP4DDFUM49AoXb3_qzyKyDjHAjFP1uU7cChZpLR=sX9g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/smu10: fix
 smu10_get_clock_by_type_with_latency
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Tue, Jan 28, 2020 at 2:47 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Only send non-0 clocks to DC for validation.  This mirrors
> what the windows driver does.
>
> Bug: https://gitlab.freedesktop.org/drm/amd/issues/963
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> index 4e8ab139bb3b..273126cfc37d 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c
> @@ -1026,12 +1026,15 @@ static int smu10_get_clock_by_type_with_latency(struct pp_hwmgr *hwmgr,
>
>         clocks->num_levels = 0;
>         for (i = 0; i < pclk_vol_table->count; i++) {
> -               clocks->data[i].clocks_in_khz = pclk_vol_table->entries[i].clk * 10;
> -               clocks->data[i].latency_in_us = latency_required ?
> -                                               smu10_get_mem_latency(hwmgr,
> -                                               pclk_vol_table->entries[i].clk) :
> -                                               0;
> -               clocks->num_levels++;
> +               if (pclk_vol_table->entries[i].clk) {
> +                       clocks->data[clocks->num_levels].clocks_in_khz =
> +                               pclk_vol_table->entries[i].clk * 10;
> +                       clocks->data[clocks->num_levels].latency_in_us = latency_required ?
> +                               smu10_get_mem_latency(hwmgr,
> +                                                     pclk_vol_table->entries[i].clk) :
> +                               0;
> +                       clocks->num_levels++;
> +               }
>         }
>
>         return 0;
> --
> 2.24.1
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
