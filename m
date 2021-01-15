Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D06BC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 11:22:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB8AD2371F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 11:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB8AD2371F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BBE26E241;
	Fri, 15 Jan 2021 11:22:48 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D991F6E241
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 11:22:46 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id u19so9143356edx.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 03:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=ZwxG/YjKVJfXN3DPsMp3yXd/32IeiKIKoPjRn3EaO7E=;
 b=VL2m1MIWZHXuGELaEqCG1xSm67r8IOUf6M4MlctZ0fBXaTuQ8lvYKu4ea5hbOnop4X
 cXDnZkIox1hhZSmfGh49e4vLSNhi5lBrUj6D4B9CIF6hF+mKDwkAeZTkbXGbnF1f/UNZ
 aO42jI3vWbSnKoYBGJ+ER6uy7rnhJKtq9ijiYuW3OKO7an00etSKE4/VOkzpPtSfqJbA
 PZk1zn4pg9MB4rz8rEvzvUCqx6eynH2mgTOhf7H23z80/83QUfyfv5OvGY/+otTKLbNH
 RHasjNuZI3Bddd+YfsyjOBAJR5BLM2WpD4dORay77R20GNMK+LTLH3oSjgT279bH/tvU
 Jv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=ZwxG/YjKVJfXN3DPsMp3yXd/32IeiKIKoPjRn3EaO7E=;
 b=l/Zl+R0jnW7Hadx6WwnJxzOqIHDZVd6lgLITWIRbH0n1ZiiwTuK0qz6jwfGCXD5mjP
 4/vb7bUQzWVAhSYvUd2Eu6GzNevNOgh2C2Yx1kOZDTXPVC+HypHbdky73JpfOuZ3S78f
 EGXEBIixCME5PUaxsSRcVerz/OCe9Cxkicd58dFtWfjqqDBfBYSkfSoPTI1m76jxnvP6
 GiZJX3ocnRIzKXaRX0Q/eYsItc4Ti8MhlmtlYZ2k/DMEeyWA0Pf7PkBRxVfyad/jyPdX
 B9Dj5Ho38NQB+U+qa6BjB+ksszUbsga0BRor561EllzImR9OG0rXN5py1nQiFfLb+Jqm
 Pquw==
X-Gm-Message-State: AOAM530cR/i9OViisKddtkvd+4qVV81A/QgW7HYk8LXvdAS1Ae7bAfHE
 x5sRnJ4yYnjHbdB0FsavEuk=
X-Google-Smtp-Source: ABdhPJxaZFBgPF+zSo0GscBU/IZTSyWEtLFt8rLbHJFM+WWyHyOXW4ay2OPBLNXRcC1Dk18UdeLOLw==
X-Received: by 2002:aa7:c358:: with SMTP id j24mr9286945edr.265.1610709765582; 
 Fri, 15 Jan 2021 03:22:45 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id lh26sm3190863ejb.119.2021.01.15.03.22.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Jan 2021 03:22:44 -0800 (PST)
Subject: Re: [PATCH] drm/amd/display: fix the system memory page fault because
 of copy overflow
To: Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210115184658.513045-1-ray.huang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <1c67eae5-a77c-b6af-4f80-94b5b80733eb@gmail.com>
Date: Fri, 15 Jan 2021 12:22:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210115184658.513045-1-ray.huang@amd.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: Alex Deucher <alexander.deucher@amd.com>, Jinzhou Su <Jinzhou.Su@amd.com>,
 Lee Jones <lee.jones@linaro.org>, changfeng.zhu@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.01.21 um 19:46 schrieb Huang Rui:
> The buffer is allocated with the size of pointer and copy with the size of
> data structure. Then trigger the system memory page fault. Use the
> orignal data structure to get the object size.
>
> Fixes: a8e30005b drm/amd/display/dc/core/dc_link: Move some local data
> from the stack to the heap
>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> ---
>   drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index 69573d67056d..73178978ae74 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -1380,7 +1380,7 @@ static bool dc_link_construct(struct dc_link *link,
>   
>   	DC_LOGGER_INIT(dc_ctx->logger);
>   
> -	info = kzalloc(sizeof(info), GFP_KERNEL);
> +	info = kzalloc(sizeof(struct integrated_info), GFP_KERNEL);

That should probably be sizeof(*info) instead, we usually try to avoid 
sizeof(struct ...) in the kernel.

There are some automated scripts in place which will send you a patch to 
change it otherwise.

>   	if (!info)
>   		goto create_fail;
>   
> @@ -1545,7 +1545,7 @@ static bool dc_link_construct(struct dc_link *link,
>   	}
>   
>   	if (bios->integrated_info)
> -		memcpy(info, bios->integrated_info, sizeof(*info));
> +		memcpy(info, bios->integrated_info, sizeof(struct integrated_info));

This can then also stay as it is.

Apart from that good catch.

Regards,
Christian.

>   
>   	/* Look for channel mapping corresponding to connector and device tag */
>   	for (i = 0; i < MAX_NUMBER_OF_EXT_DISPLAY_PATH; i++) {

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
