Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A33C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Dec 2021 08:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE1A0112546;
	Wed, 22 Dec 2021 08:11:04 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6531F112546
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Dec 2021 08:11:04 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 a203-20020a1c7fd4000000b003457874263aso3309125wmd.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Dec 2021 00:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=+BxDvWH9O+bjIEGEOb0fyZp+XpVGE0FDUGCjIylvmdo=;
 b=ncyoqdqYMQ7l3jcKatDEObclpR8jXydtSdRLg3EQvbgv8msWmp8dZUB3w2iXJNTUXx
 FuGvz46CmLwjDV6moOdr1Gq/wts1IiFrZPzieOA7asJddyUCFNhRxtWqfgp6kej+EGQH
 hTvM+9xafio7LQ4H85jlEbMduRWAkhHhkgc3K7FZ/9WeAuXugLbi3dLDW3SekqE5hsFX
 9yoj6VDDJoJ+XC4kJqi1v+1iWeWgWkaJxt74ESGhK2J8IpnWNlBwftrYXgIWm4NdvEIq
 6yCkquo3H3yH3iF2uGIqpuP9drX3wnubBk7UXjNoB6Rttjp6sgZFGooWD9Zqz9HKhV9i
 vWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=+BxDvWH9O+bjIEGEOb0fyZp+XpVGE0FDUGCjIylvmdo=;
 b=TGuVad1rryL7UjgO399W/U6bzRM+uDX1NNa36p6suX5k6ZKai2S4EJGVxS4AQIoK8r
 ZQR4IQBwq5SU+2q57bee2GxcCsWGRxysqtPZ+RW79TtOPzYOQptyQSMvwEj8HPO2T7n3
 mJZ0fZJlfaOycfFuPHCs+Ew9S9fTuNVouQEIAr2hukaIuQGGUkwiyyyfp0J1cXLZSHvy
 fDQ/bJ2HcSetMyHmlSbY53zDypFcnVLK1VGaP/6busomY4fEzEHHqiXPRRunMHIH6ov9
 QpnKAmJiC0d9MpXhCSLvuk+HvM4i9gTm0mdhm+i3l15d6RLbhXwMqSlVz+QQ0R2P5f/W
 Y+EQ==
X-Gm-Message-State: AOAM531dp3elFF3Z2mzFLvASJbt+i4adY1CMLoWJF44EN9gPfvVy46io
 i+HbyhPErH3desqAhzAADG3QUjuqr84=
X-Google-Smtp-Source: ABdhPJwjweMQJF0fQU0YIFQfegB8zOrtzc0x8CvuT/WyoXgoZeI/0BI/lG47jP/zelJ3HRVYxeflrg==
X-Received: by 2002:a05:600c:1e01:: with SMTP id
 ay1mr60987wmb.152.1640160662985; 
 Wed, 22 Dec 2021 00:11:02 -0800 (PST)
Received: from [192.168.178.21] (p57b0bff8.dip0.t-ipconnect.de.
 [87.176.191.248])
 by smtp.gmail.com with ESMTPSA id j17sm1223512wrp.68.2021.12.22.00.11.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Dec 2021 00:11:02 -0800 (PST)
Subject: Re: [PATCH] drm/ttm: add workaround for some arm hardware issue
To: Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211222055140.1215839-1-Victor.Zhao@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <b6edb4d8-b9b6-224f-d35f-5477fc1f7687@gmail.com>
Date: Wed, 22 Dec 2021 09:11:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211222055140.1215839-1-Victor.Zhao@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 22.12.21 um 06:51 schrieb Victor Zhao:
> Some Arm based platform has hardware issue which may
> generate incorrect addresses when receiving writes from the CPU
> with a discontiguous set of byte enables. This affects the writes
> with write combine property.

Can you point out which arm platforms are that exactly?

> Workaround by change PROT_NORMAL_NC to PROT_DEVICE_nGnRE on arm.
> As this is an issue with some specific arm based cpu, adding
> a ttm parameter to control.

Something as fundamental as this should not be made controllable by an 
module parameter.

Write combining is very important for good performance and so we should 
only disable it on boards where we know that this won't work correctly.

Regards,
Christian.

>
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>   drivers/gpu/drm/ttm/ttm_module.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_module.c b/drivers/gpu/drm/ttm/ttm_module.c
> index e87f40674a4d..b27473cbbd52 100644
> --- a/drivers/gpu/drm/ttm/ttm_module.c
> +++ b/drivers/gpu/drm/ttm/ttm_module.c
> @@ -41,6 +41,12 @@
>   
>   #include "ttm_module.h"
>   
> +static int enable_use_wc = 1;
> +
> +MODULE_PARM_DESC(enable_use_wc,
> +	"control write combine usage on arm platform due to hardware issue with write combine found on some specific arm cpu (1 = enable(default), 0 = disable)");
> +module_param(enable_use_wc, int, 0644);
> +
>   /**
>    * ttm_prot_from_caching - Modify the page protection according to the
>    * ttm cacing mode
> @@ -63,7 +69,7 @@ pgprot_t ttm_prot_from_caching(enum ttm_caching caching, pgprot_t tmp)
>   #endif
>   #if defined(__ia64__) || defined(__arm__) || defined(__aarch64__) || \
>   	defined(__powerpc__) || defined(__mips__)
> -	if (caching == ttm_write_combined)
> +	if (caching == ttm_write_combined && enable_use_wc != 0)
>   		tmp = pgprot_writecombine(tmp);
>   	else
>   		tmp = pgprot_noncached(tmp);

