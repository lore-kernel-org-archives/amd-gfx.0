Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BF0C636D4
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Feb 2023 14:47:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FF6E10E102;
	Wed, 15 Feb 2023 14:47:54 +0000 (UTC)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D60D410E102
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 14:47:52 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id n132so15978008oih.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 06:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OBw1ytbr8ujEXDsfgSCQZ7qMc+i/O2am/RugARgseEM=;
 b=KJI+qgJ+9VIMigvAhGSvNFmL5xBCE8UOJONSEkhy9BpTfw0yCj7hHLcRPDkX51D4EL
 o6hGxSlQwrUZVBCSE6XZ2quGRP0xIN8z6LM+YiEYaUq0nW6UOI3W3GtIXf3Dnx87B5Wy
 p7HDtRc5CHoew9yPkXCEvmRCUGBWyyr0BdT3c9KmobasX+V4usTYWQmrRZwXZScrOSL2
 7soTTOpvsQjeMuC66NDa39hMilviFDscabnwmymcSRTYDX2WdEY/jZEV+tfZswMK/2eG
 9shxTJkQvojNhpf8x1RXDd1WsDZ8hhX7Q3RLk6mSGZZv/69gmfsTc2wtmKtkhnavUWFB
 0O7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OBw1ytbr8ujEXDsfgSCQZ7qMc+i/O2am/RugARgseEM=;
 b=ylXwPTAA4gom2arFDcknE+Et+boTWncyqejysMcd7ndEF/3HgfyIFK19T4wYeqHV2J
 rj772ycxxaTtm5WdXuw1WmFOew6FpGV+qbVkxmiXnJp5NN2r90csv9odbL+XMvQ0sKC9
 krBNRs9LJE8O6AUG9axJLsG5skATZQgz20XO+Jyhu8iKJNs8GxQ4smmRJ2mB+k7mPATe
 CYxE6+YwqoTgNpQd9DyhfmrmdsqtJjWOZWSHbsBUyfa+Gbyod6XprxZI9V6gVI191LLj
 LrfnU0f5zuxLqQTANK40AUnfIDqpfYp+HcRCsFYvLEiSkQUz0QAOZvpAFAwTvsxCQ7X+
 U2Qw==
X-Gm-Message-State: AO0yUKWC5y7COP3fm/XmK+1pfK/7ujZUoVHABLA/VJBJlLMBz1vvwZOP
 wk7CVFmvn8kK0/RBUJAN2SPSF7tLBvQ7BFpdoDA=
X-Google-Smtp-Source: AK7set9Zbifbk9sCwNEfceZCVQy/AuaNXzr39DD6L4axovL/gcFMk+G5ZxsfVhc7Wm1Z7OSK1W6BaUMdG+87VKShihU=
X-Received: by 2002:a05:6808:1305:b0:37d:7bc1:889 with SMTP id
 y5-20020a056808130500b0037d7bc10889mr203067oiv.138.1676472472076; Wed, 15 Feb
 2023 06:47:52 -0800 (PST)
MIME-Version: 1.0
References: <20230215064402.576609-1-kenneth.feng@amd.com>
In-Reply-To: <20230215064402.576609-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Feb 2023 09:47:39 -0500
Message-ID: <CADnq5_O7GKBi4J1F4PCffREN9awBhNnrupU+gPkMD4o1ZaZUmg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: re-enable ac/dc on smu_v13_0_0/10
To: Kenneth Feng <kenneth.feng@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 15, 2023 at 1:44 AM Kenneth Feng <kenneth.feng@amd.com> wrote:
>
> re-enable ac/dc on smu_v13_0_0/10
>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 7c906ab3ddd2..923a9fb3c887 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -147,6 +147,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] =
>                             PPSMC_MSG_SetBadMemoryPagesRetiredFlagsPerChannel,   0),
>         MSG_MAP(AllowGpo,                       PPSMC_MSG_SetGpoAllow,           0),
>         MSG_MAP(AllowIHHostInterrupt,           PPSMC_MSG_AllowIHHostInterrupt,       0),
> +       MSG_MAP(ReenableAcDcInterrupt,          PPSMC_MSG_ReenableAcDcInterrupt,       0),
>  };
>
>  static struct cmn2asic_mapping smu_v13_0_0_clk_map[SMU_CLK_COUNT] = {
> --
> 2.25.1
>
