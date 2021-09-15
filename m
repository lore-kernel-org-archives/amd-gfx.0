Return-Path: <SRS0=hzS6=OF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728BEC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 10:05:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B1BB61214
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 10:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3B1BB61214
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB73C6E8F5;
	Wed, 15 Sep 2021 10:05:41 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89C286E8F5;
 Wed, 15 Sep 2021 10:05:41 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id q11so2932316wrr.9;
 Wed, 15 Sep 2021 03:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=aHbX+vh7p38j0aXlja9z9KexFfI+M632QTahTG9s6tA=;
 b=b+IEIGbJlAHO+fQWnJYrQww2FDpPPTVNVkP3V5NkcLfhvOJBQw70d5D0uQxWNeZnQI
 /hufIj9DSeY3VMas8ZcWJ8S3JSS2kPQsIqfT/rtgqgHvJay9m3VT/o67/8K38k54uoON
 pZRMfUqoO3jl3vX/jqJl8c17ZcKWfvuqs7NX3aQa34FKBuHboBU8Pu5jjAEWczR7l4IE
 e0jSsDUF/1rTYjN4vL9AtGWkQ2LHDKE4HVMIPR7EzD7qI7B5YpPSHIP+VN5jPYWh54tb
 p0ImxUIXvcgGeVbZKh0OBBOhDxcw9AaisMuXAVSk0qPgjp2WziTA+P0VEt7IMr3DVVEK
 NHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=aHbX+vh7p38j0aXlja9z9KexFfI+M632QTahTG9s6tA=;
 b=hDNCf3Bc0/Xi9rMmCwo47URp36B2rbA9czkjpshLTsa+ONdsNMWYCp1UG6dqKHsySR
 LHsbnT6ygxZBaqrkAcf3Uck0NgwBmmql7UTaPS1LnoZ2RrcEZaGOFR+883OBUErMSclM
 UkIVqmyrEq2+p6hVnl6b8g/PWfgCMHmoKqEG4raQ3X7sRJ7vSFQTMf6+363hJ47KWHFd
 n/Aa2zzxYrb917QpZRiq0ICiITfw0YUiCWjVSEHJ0YHeqnbOgKgron3vd9jPHHXfVNXN
 oTuesTPf960GGps+X8VJz1B6qFNlts6II9Vuahmnn+BliCqnHyA/uWfYw7hgjKEMXZLI
 sU7Q==
X-Gm-Message-State: AOAM530H+Gqk36M4pgw6KQF8xqSs66Y8CHJDbSS3I1OgtMisYEfnzNOW
 YmijC2SfyNNmKWcCqH0PM3DY2e9ohKU=
X-Google-Smtp-Source: ABdhPJxByZZifTgDAjusP/293DDqsduEQUSsO+jbNrveCzk0+DMeUUonBdxOljE5gtnnZksri3rqPw==
X-Received: by 2002:adf:b348:: with SMTP id k8mr4053447wrd.123.1631700339762; 
 Wed, 15 Sep 2021 03:05:39 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:d03d:8939:3840:1f95?
 ([2a02:908:1252:fb60:d03d:8939:3840:1f95])
 by smtp.gmail.com with ESMTPSA id v8sm11569293wrt.12.2021.09.15.03.05.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Sep 2021 03:05:33 -0700 (PDT)
Subject: Re: [resend PATCH] drm/ttm: Fix a deadlock if the target BO is not
 idle during swap
To: Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc: xinhui pan <xinhui.pan@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20210907040832.1107747-1-xinhui.pan@amd.com>
 <074efe24-db7a-df68-3624-05989596f44a@amd.com>
 <YTcrcw+hxWuyyl4C@phenom.ffwll.local>
 <37412f7e-9f6f-04bb-41b1-72931ea1381e@amd.com>
 <YTkAnDncKU7ewW+5@phenom.ffwll.local>
 <97ccbd16-ba3f-1b21-b6fb-5568d34f1af3@amd.com>
 <YUCowZxEhECTlgAH@phenom.ffwll.local>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <e87ad40d-9c07-c307-2b61-75ecc3d0986c@gmail.com>
Date: Wed, 15 Sep 2021 12:05:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YUCowZxEhECTlgAH@phenom.ffwll.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Am 14.09.21 um 15:50 schrieb Daniel Vetter:
> On Thu, Sep 09, 2021 at 09:10:39AM +0200, Christian König wrote:
>> Am 08.09.21 um 20:27 schrieb Daniel Vetter:
>>> On Tue, Sep 07, 2021 at 11:28:23AM +0200, Christian König wrote:
>>>> Am 07.09.21 um 11:05 schrieb Daniel Vetter:
>>>>> On Tue, Sep 07, 2021 at 08:22:20AM +0200, Christian König wrote:
>>>>>> Added a Fixes tag and pushed this to drm-misc-fixes.
>>>>> We're in the merge window, this should have been drm-misc-next-fixes. I'll
>>>>> poke misc maintainers so it's not lost.
>>>> Hui? It's a fix for a problem in stable and not in drm-misc-next.
>>> Ah the flow chart is confusing. There is no current -rc, so it's always
>>> -next-fixes. Or you're running the risk that it's lost until after -rc1.
>>> Maybe we should clarify that "is the bug in current -rc?" only applies if
>>> there is a current -rc.
>> Yeah, I've noticed this as well.
>>
>> But when there is no current -rc because we are in the merge window then the
>> question is how do I submit patches to the current stable?
> You never submit patches directly to stable. It's always "get it into
> Linus' tree asap" plus either Cc: stable or a Fixes: line.

But what if the code in drm-misc-next-fixes has been restructured and 
doesn't have that issue any more?

How do I get the patch into stable then? Submitting directly to Greg?

Thanks,
Christian.

>   During merge
> window "get into Linus' tree asap" means "put it into drm-misc-next-fixes"
>
>> In other words this patch here is really for 5.14 and should then be
>> backported to 5.13 and maybe even 5.10 as well.
>>
>> The code was restructured for 5.15 and I even need to double check if that
>> still applies there as well.
>>
>> Or should I send patches like those directly to Greg?
> Nope. Just fastest path into Linus' tree is good enough. Greg picks up
> patches directly from the merge window if it has one of the tags. There's
> occasionally a bit of grumbling because there's so many stable patches
> coming in during the merge window, but otherwise it should be in stable in
> the next release like during -rc phase.
> -Daniel
>
>> Regards,
>> Christian.
>>
>>> Anyway Thomas sent out a pr, so it's all good.
>>> -Daniel
>>>
>>>> Christian.
>>>>
>>>>> -Daniel
>>>>>
>>>>>> It will take a while until it cycles back into the development branches, so
>>>>>> feel free to push some version to amd-staging-drm-next as well. Just ping
>>>>>> Alex when you do this.
>>>>>>
>>>>>> Thanks,
>>>>>> Christian.
>>>>>>
>>>>>> Am 07.09.21 um 06:08 schrieb xinhui pan:
>>>>>>> The ret value might be -EBUSY, caller will think lru lock is still
>>>>>>> locked but actually NOT. So return -ENOSPC instead. Otherwise we hit
>>>>>>> list corruption.
>>>>>>>
>>>>>>> ttm_bo_cleanup_refs might fail too if BO is not idle. If we return 0,
>>>>>>> caller(ttm_tt_populate -> ttm_global_swapout ->ttm_device_swapout) will
>>>>>>> be stuck as we actually did not free any BO memory. This usually happens
>>>>>>> when the fence is not signaled for a long time.
>>>>>>>
>>>>>>> Signed-off-by: xinhui pan <xinhui.pan@amd.com>
>>>>>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>>>>>> ---
>>>>>>>      drivers/gpu/drm/ttm/ttm_bo.c | 6 +++---
>>>>>>>      1 file changed, 3 insertions(+), 3 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
>>>>>>> index 8d7fd65ccced..23f906941ac9 100644
>>>>>>> --- a/drivers/gpu/drm/ttm/ttm_bo.c
>>>>>>> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
>>>>>>> @@ -1152,9 +1152,9 @@ int ttm_bo_swapout(struct ttm_buffer_object *bo, struct ttm_operation_ctx *ctx,
>>>>>>>      	}
>>>>>>>      	if (bo->deleted) {
>>>>>>> -		ttm_bo_cleanup_refs(bo, false, false, locked);
>>>>>>> +		ret = ttm_bo_cleanup_refs(bo, false, false, locked);
>>>>>>>      		ttm_bo_put(bo);
>>>>>>> -		return 0;
>>>>>>> +		return ret == -EBUSY ? -ENOSPC : ret;
>>>>>>>      	}
>>>>>>>      	ttm_bo_del_from_lru(bo);
>>>>>>> @@ -1208,7 +1208,7 @@ int ttm_bo_swapout(struct ttm_buffer_object *bo, struct ttm_operation_ctx *ctx,
>>>>>>>      	if (locked)
>>>>>>>      		dma_resv_unlock(bo->base.resv);
>>>>>>>      	ttm_bo_put(bo);
>>>>>>> -	return ret;
>>>>>>> +	return ret == -EBUSY ? -ENOSPC : ret;
>>>>>>>      }
>>>>>>>      void ttm_bo_tt_destroy(struct ttm_buffer_object *bo)

