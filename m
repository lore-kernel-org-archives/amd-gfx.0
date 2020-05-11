Return-Path: <SRS0=XsTU=6Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7C4C47255
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 06:45:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 313802075E
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2020 06:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SzyQivQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 313802075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B07D26E1BE;
	Mon, 11 May 2020 06:45:32 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E1456E1BC;
 Mon, 11 May 2020 06:45:31 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id u16so17763355wmc.5;
 Sun, 10 May 2020 23:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=1EGHCNZLop6lpa2MpQukB0Jzk7xjNDSSnPYZVksTl3g=;
 b=SzyQivQ/k/7XrX8ar4XJQSn6XsTnFG6KqOIWxsJDuWQaChKGSnVAjtH0PyEm1stXRX
 2hdUyzb8OXIMagIdiS94rTquleNZLkmhyeLuYncHNTgT3mjGHceSe0v0LHx63jEUAOPS
 5zR0mNg8H0+PD7hmGrH18koC9v0HpLJ0uyvbWs2qnDhEszLQTM6EjsPZFrzbH6CDK7Bh
 yjaLRU8Xw1xNvKBua9jLiFz1qOznXnd8+2Ag0BPocSmLSEh2muXsod8FWd5IkGf2ndSD
 ww5ZFpHG8nxl2qMqw28CHdfCe/tbQWI4PBHxXwajJX8BbZIjQvGHmCDMOe7JJcK8xBmk
 RciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=1EGHCNZLop6lpa2MpQukB0Jzk7xjNDSSnPYZVksTl3g=;
 b=pjVxYyQoAsPLLeRmC+Qb54gXAWQboE8rUXdkOqjCIdo6uI3bFasYKqFvEgC1bWCB/u
 GaoW1SNXqw8MhmM94BQKPs5BAjusSbtEXu9Bp6vccaOZteX/EiuO0JvkfQvp0yCyfg2p
 3AmoI6wLNuNcwQZGGOZslLybh1xiP6g15BZJTBnZRelXmfa80n9MtETeiqvVWw2dqRhi
 +UaSPjn32qJw+//v0CQK6SAHaBdOynHYSorry/VBJegqvWnAi3jHzs5H/ZouZrlE+3Ke
 pYY2GxwJPeq/qlYrMVZRyfGN6xmtMs15t8Tr57AN2njiFkPiX9sG23rXyTqY7In7ll5q
 7Uxg==
X-Gm-Message-State: AGi0PuYb/s2N+15RGclQvkgSSLoh1ogqJ952HXoP+2qKmFVimgW3fycY
 4ail9qdK7TLCLIuLYxA6OII=
X-Google-Smtp-Source: APiQypK5EFJWbdLc5bXtXjCxgAaG3RfG35us+gztlEfpNe17D+ozOZBQZM+xCfL9V1I+x56wlVuhTA==
X-Received: by 2002:a1c:1f16:: with SMTP id f22mr10040983wmf.46.1589179529773; 
 Sun, 10 May 2020 23:45:29 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id d9sm874290wmd.10.2020.05.10.23.45.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 10 May 2020 23:45:29 -0700 (PDT)
Subject: Re: [PATCH 1/6] drm/ttm: Add unampping of the entire device address
 space
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <1589050310-19666-1-git-send-email-andrey.grodzovsky@amd.com>
 <1589050310-19666-2-git-send-email-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e293af59-99df-c147-68d6-8fa3ade38829@gmail.com>
Date: Mon, 11 May 2020 08:45:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1589050310-19666-2-git-send-email-andrey.grodzovsky@amd.com>
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
Cc: alexdeucher@gmail.com, daniel.vetter@ffwll.ch, michel@daenzer.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 09.05.20 um 20:51 schrieb Andrey Grodzovsky:
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>   drivers/gpu/drm/ttm/ttm_bo.c    | 22 +++++++++++++++++++++-
>   include/drm/ttm/ttm_bo_driver.h |  2 ++
>   2 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index c5b516f..eae61cc 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -1750,9 +1750,29 @@ void ttm_bo_unmap_virtual(struct ttm_buffer_object *bo)
>   	ttm_bo_unmap_virtual_locked(bo);
>   	ttm_mem_io_unlock(man);
>   }
> +EXPORT_SYMBOL(ttm_bo_unmap_virtual);
>   
> +void ttm_bo_unmap_virtual_address_space(struct ttm_bo_device *bdev)
> +{
> +	struct ttm_mem_type_manager *man;
> +	int i;
>   
> -EXPORT_SYMBOL(ttm_bo_unmap_virtual);

> +	for (i = 0; i < TTM_NUM_MEM_TYPES; i++) {
> +		man = &bdev->man[i];
> +		if (man->has_type && man->use_type)
> +			ttm_mem_io_lock(man, false);
> +	}

You should drop that it will just result in a deadlock warning for 
Nouveau and has no effect at all.

Apart from that looks good to me,
Christian.

> +
> +	unmap_mapping_range(bdev->dev_mapping, 0, 0 , 1);
> +	/*TODO What about ttm_mem_io_free_vm(bo) ? */
> +
> +	for (i = TTM_NUM_MEM_TYPES - 1; i >= 0; i--) {
> +		man = &bdev->man[i];
> +		if (man->has_type && man->use_type)
> +			ttm_mem_io_unlock(man);
> +	}
> +}
> +EXPORT_SYMBOL(ttm_bo_unmap_virtual_address_space);
>   
>   int ttm_bo_wait(struct ttm_buffer_object *bo,
>   		bool interruptible, bool no_wait)
> diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo_driver.h
> index c9e0fd0..3133463 100644
> --- a/include/drm/ttm/ttm_bo_driver.h
> +++ b/include/drm/ttm/ttm_bo_driver.h
> @@ -600,6 +600,8 @@ int ttm_bo_device_init(struct ttm_bo_device *bdev,
>    */
>   void ttm_bo_unmap_virtual(struct ttm_buffer_object *bo);
>   
> +void ttm_bo_unmap_virtual_address_space(struct ttm_bo_device *bdev);
> +
>   /**
>    * ttm_bo_unmap_virtual
>    *

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
