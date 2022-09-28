Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA242C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 17:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3520210E520;
	Wed, 28 Sep 2022 17:45:35 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAA2D10E520
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 17:45:31 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id c30so17092837edn.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 10:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date;
 bh=uNRqH+m9FFN97BH42Z4pRjjuHEyl8dbNeuIgjfeI6QE=;
 b=UKVYL7+GMVOGR6fXteV53LYmJMP+mtP4ajMb75l3j17RwCbi5zGnXflvaPWVkoWVsP
 o9wtolNWWqe5HFu98Z6xijbldRVRXQx6s6n0MjTLrIOrTXL9NZuDUoXrDHAx9mfAIzJ5
 dSpIGWajzF58pCGXTB8dskqm7Gx6kj6Ot5+i2eIKXbbW+luCOTMkS6NEK9rFRzQEOL0k
 HboNxJ+AJUtrLqdO5Rfc47Inuk+jpxe2kfKqkGs0f6sdVmMGggh1O6gK4zEjL1LnPOON
 u419ddl8vh1AYpwSp56H5TwHUMPbCaxxNOeZ2yBxqUDDicIBVGk2YNmet0E84YTGoC10
 FOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=uNRqH+m9FFN97BH42Z4pRjjuHEyl8dbNeuIgjfeI6QE=;
 b=4inE0GN7bgqKOjbhqoIVxWvNpi8+3RqMPuoe/bzlZjnmEJZd1LMHgic0SRlrlfOF+T
 ht8QYgUPH9nh4UasP6DitwkWZWzi4XKAQChrPv7eSYEX4X+Y0+xVMRMGTyDRyJRcUDzZ
 oxm9Id9LonE4qbdyS7L/cYIZICZROt0uB+iq+dRqNfuWA+llj7MADoRt5LHKlzZh8WW1
 jX+XPG/l8HiL5fwoEVHqCASUhOgoISNtCA+TsuHsMb9LEJGiF5BYcUqPaxIVnhFmcxpN
 /g69UPkrKNgoDquzQ73ZW9Tph3EgTa6KR2X/w2R4ojOOHqSqnLP6D7PHbpg5FUR0aijx
 JjbA==
X-Gm-Message-State: ACrzQf0KgT385OlnlLfinPgFudQ1lrZMQ9Prh3eb0QoyaSnUIhwL7ish
 re6bhrOVFSQoEL+555CBQyw=
X-Google-Smtp-Source: AMsMyM5aZV7GyELdJdIyNjxHhP5rjHZHcbrzr6QUS5DfKu+5UPLnmekPKsFZ0isvsdd8GHfCYP4QVw==
X-Received: by 2002:aa7:d449:0:b0:457:12e7:c2f6 with SMTP id
 q9-20020aa7d449000000b0045712e7c2f6mr21993947edr.357.1664387130054; 
 Wed, 28 Sep 2022 10:45:30 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:fe7b:c1da:17d4:a63a?
 ([2a02:908:1256:79a0:fe7b:c1da:17d4:a63a])
 by smtp.gmail.com with ESMTPSA id
 j2-20020a17090623e200b0078015cebd8csm2729761ejg.117.2022.09.28.10.45.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Sep 2022 10:45:29 -0700 (PDT)
Message-ID: <23d82ef8-a3b2-0cda-479e-9ff2588fd0dc@gmail.com>
Date: Wed, 28 Sep 2022 19:45:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Skip put_reset_domain if it doesnt exist
Content-Language: en-US
To: Vignesh Chander <Vignesh.Chander@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220928174321.13409-1-Vignesh.Chander@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220928174321.13409-1-Vignesh.Chander@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Shaoyun.Liu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 28.09.22 um 19:43 schrieb Vignesh Chander:
> For sriov, the reset domain is no longer created so need to check if it
> exists before doing a put.

Why is the reset domain no longer created for SRIOV?

Regards,
Christian.

> Signed-off-by: Vignesh Chander <Vignesh.Chander@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 47159e9a0884..80fb6ef929e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -217,7 +217,8 @@ static void amdgpu_xgmi_hive_release(struct kobject *kobj)
>   	struct amdgpu_hive_info *hive = container_of(
>   		kobj, struct amdgpu_hive_info, kobj);
>   
> -	amdgpu_reset_put_reset_domain(hive->reset_domain);
> +	if (hive->reset_domain)
> +		amdgpu_reset_put_reset_domain(hive->reset_domain);
>   	hive->reset_domain = NULL;
>   
>   	mutex_destroy(&hive->hive_lock);

