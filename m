Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CCEC4321E
	for <amd-gfx@archiver.kernel.org>; Sat, 26 Nov 2022 14:01:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 544ED10E084;
	Sat, 26 Nov 2022 14:01:02 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EADA10E084
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Nov 2022 14:00:59 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id i10so15897778ejg.6
 for <amd-gfx@lists.freedesktop.org>; Sat, 26 Nov 2022 06:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SMVl4hOwq17+42S38TotJqmTSiFFXwCrWNztYGRFVqk=;
 b=S4MjX7RC5eQ0DHbWmHCDBUMPP7teNpa7eOUg1hQROt2JliO1CNuSqni34zEp7CTra6
 FWb2WncpkQxLO+yVivT+sk4+GdFWT4RY9T/AMSlWDo18Zl5gqh+MBIgh/XPQoWobHREw
 IV+R6vgrftrePYRzQLeA/IbhWQL2m8wumMCQfIAozv7Oli2I1RtNBpZkfPpZkjNxB4Ol
 NExStracM/U/2qU53Mwk9XG6xmxcvjJzNRSvWlqKxSvmbK3SuLuyv8qQWqIAKjBlbq5/
 Jex/s0Jh8gDjOybqD2eEvUep057e9ORrPondGkNPFIJt2AX+vV9j2ACt2nHsztdQDwnf
 s+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SMVl4hOwq17+42S38TotJqmTSiFFXwCrWNztYGRFVqk=;
 b=I6+T70NIFue6YmOWCP4p4jRGIdFJ6c9kWxaYDY5mqDD40jp+DhOPcYmDS2sCaU+76x
 JzkhKqB4z7HcYVgw2borRvNOysmoFpFXOhQRMLOfkDzzwN3QNI899Pnv4EGiI83vWQTV
 aFTmojySzMIu8XrDDfgLWYj1wOZXQSldJNNI1j8gaJcnfhXIfUwrOWyxMlGTYgFZ3Ca9
 UFNJeiiJTsMMGsAt1J4MiSWzzyf6izgygGNvl6UWkxNN5626RfIlWrGRg9Wed6lOlt0j
 cht3kfBjpZsZYrIZumqMFkrPHlFgQIscOQ3boR6QgPl38usTJ1erN4JXQ/Y4i1Oenopc
 mwDA==
X-Gm-Message-State: ANoB5plcH4vQcVX4xstdlUFbXgeyv2BEiw7+wn8OgpyDZbaY+3b9MJvo
 aclLq9Gr9vDwI6NA0M6nPK0=
X-Google-Smtp-Source: AA0mqf5B9f4pyWwtxMdugDWTKW8fW6VQhXVy/NqEVENtfz/5oDvHLCJNp6DfZUVeDp+hfMWhVxYYeg==
X-Received: by 2002:a17:906:c052:b0:79a:101a:7e57 with SMTP id
 bm18-20020a170906c05200b0079a101a7e57mr36301605ejb.368.1669471257605; 
 Sat, 26 Nov 2022 06:00:57 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:2b25:6773:82d:c38a?
 ([2a02:908:1256:79a0:2b25:6773:82d:c38a])
 by smtp.gmail.com with ESMTPSA id
 u2-20020a509502000000b0044dbecdcd29sm3003782eda.12.2022.11.26.06.00.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 26 Nov 2022 06:00:56 -0800 (PST)
Message-ID: <8385c289-8477-9e8a-d3b7-1e777437d6d6@gmail.com>
Date: Sat, 26 Nov 2022 15:00:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: Fix minmax error
Content-Language: en-US
To: Luben Tuikov <luben.tuikov@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
References: <20221126052505.61384-1-luben.tuikov@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20221126052505.61384-1-luben.tuikov@amd.com>
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 26.11.22 um 06:25 schrieb Luben Tuikov:
> Fix minmax compilation error by using the correct constant and correct integer
> suffix.
>
> Cc: James Zhu <James.Zhu@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Fixes: 58170a7a002ad6 ("drm/amdgpu: fix stall on CPU when allocate large system memory")
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index 8a2e5716d8dba2..65715cb395d838 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -51,7 +51,7 @@
>   #include "amdgpu_amdkfd.h"
>   #include "amdgpu_hmm.h"
>   
> -#define MAX_WALK_BYTE	(64ULL<<30)
> +#define MAX_WALK_BYTE	(2UL << 30)
>   
>   /**
>    * amdgpu_hmm_invalidate_gfx - callback to notify about mm change
> @@ -197,8 +197,8 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>   			hmm_range->start, hmm_range->end);
>   
>   		/* Assuming 512MB takes maxmium 1 second to fault page address */
> -		timeout = max((hmm_range->end - hmm_range->start) >> 29, 1ULL) *
> -			HMM_RANGE_DEFAULT_TIMEOUT;
> +		timeout = max((hmm_range->end - hmm_range->start) >> 29, 1UL);
> +		timeout *= HMM_RANGE_DEFAULT_TIMEOUT;
>   		timeout = jiffies + msecs_to_jiffies(timeout);
>   
>   retry:
>
> base-commit: 9e95ce4c60631c1339204f8723008a715391f410

