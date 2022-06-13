Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9799DC43334
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jun 2022 06:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2688B10E498;
	Mon, 13 Jun 2022 06:10:09 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97A8810E498
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jun 2022 06:10:08 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id bg6so9174079ejb.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Jun 2022 23:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=u5roo8mvatJ4jIhC61iqzFGSDWyAylWXtVnhYE+idsw=;
 b=cP+HS4+CPdnMY4fK41WRyAYj+Hpy5yPGqSYJmxO0Gli2vaehkZX5jPzBCf49mr7dO3
 bG15YrxBF4WkG/3cXcjWo/ivoelpu580Jn3h2b9HBVAvpXs/kVwuriRCaA+icE6nqMvh
 WwXF3gP5whXBZwkYo9y24Dlg84W56GiA7qwV20m96stHV6BxcKXHdsy+6Mc29VEdMKt4
 62mC/0Oyu6Ff8Q2OYY0AfGGobT9s4vhw8uiLMfOpXG6+OULIn40+eKfZ6ilAyZxdLZBs
 VjJjayWUupUFp9bHfU3WHDGof+rKIvLJI8NX69iLUt/0Vawi4MFM0K4xS+7VKFtNxq7B
 Y1tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=u5roo8mvatJ4jIhC61iqzFGSDWyAylWXtVnhYE+idsw=;
 b=jrlerXTmPSb5b2qHZ7YvJABTJavH6dFXxlID8QIV6UScNB/T8KU6+95OwHJOaXRpsa
 hz2aMRw24T7JruDh8Sxs7gwWVDA8YvCWq7gJ5mUQOlFK4rGGaPhNFLjt8kMJ7L59jwzK
 BLMbteLo5hBHtQyBk7iTlQXzZY+zHbJYrtXydwAgIIlzMlZfpqEsQoOJ9fURpT0J0lIu
 +dgOMWDb1kbL7oOYcLtP6EAANHrg97z8ztLmL23RQETszFtLuDD4Ox3wTgAwLU4dFnck
 v7IB6hp/iYNQDMBaOTS1uMtonHoHSgCvePjdZC6+0s+Kk1BqBryjhmt34eef63C8RLQU
 96VQ==
X-Gm-Message-State: AOAM530C/enLFIP0S9glqrdqBNXV381ORcUa7Qg6qYYWhb9fEj/2K8Oe
 ZqMomLGS4g8Ia6nxwGYtx20wMsg6jEU=
X-Google-Smtp-Source: ABdhPJxTHSn9voZLzUrhBuxbSl88njAWS7SIm+sM2jBTjcArePI6rNbB4kkNRFTJIy/QuPIzxDQVgQ==
X-Received: by 2002:a17:906:3bd9:b0:6ff:4b5:4a8f with SMTP id
 v25-20020a1709063bd900b006ff04b54a8fmr45397083ejf.139.1655100607184; 
 Sun, 12 Jun 2022 23:10:07 -0700 (PDT)
Received: from [192.168.178.21] (p57b0b659.dip0.t-ipconnect.de.
 [87.176.182.89]) by smtp.gmail.com with ESMTPSA id
 x15-20020aa7d38f000000b0042dd1584e74sm4234172edq.90.2022.06.12.23.10.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jun 2022 23:10:06 -0700 (PDT)
Message-ID: <1253a338-ab53-4813-6587-407a6377cee7@gmail.com>
Date: Mon, 13 Jun 2022 08:10:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] drm/amdkfd: fix warning when CONFIG_HSA_AMD_P2P is not
 set
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220610154604.338282-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20220610154604.338282-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.06.22 um 17:46 schrieb Alex Deucher:
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1542:11:
> warning: variable 'i' set but not used [-Wunused-but-set-variable]
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Ideally we should put the code for this into a separate function and 
then guard the decleration of the function with #ifdefs.

But not code that I'm deeply involved with so Acked-by: Christian König 
<christian.koenig@amd.com> anyway.

Christian.

> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 3e240b22ec91..411447357196 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1539,7 +1539,10 @@ static int kfd_dev_create_p2p_links(void)
>   {
>   	struct kfd_topology_device *dev;
>   	struct kfd_topology_device *new_dev;
> -	uint32_t i, k;
> +#if defined(CONFIG_HSA_AMD_P2P)
> +	uint32_t i;
> +#endif
> +	uint32_t k;
>   	int ret = 0;
>   
>   	k = 0;
> @@ -1553,7 +1556,6 @@ static int kfd_dev_create_p2p_links(void)
>   		return 0;
>   
>   	k--;
> -	i = 0;
>   
>   	/* create in-direct links */
>   	ret = kfd_create_indirect_link_prop(new_dev, k);
> @@ -1562,6 +1564,7 @@ static int kfd_dev_create_p2p_links(void)
>   
>   	/* create p2p links */
>   #if defined(CONFIG_HSA_AMD_P2P)
> +	i = 0;
>   	list_for_each_entry(dev, &topology_device_list, list) {
>   		if (dev == new_dev)
>   			break;

