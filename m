Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20543EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 07:38:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9894F10E15E;
	Thu, 15 Jun 2023 07:37:59 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE79410E15E
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 07:37:57 +0000 (UTC)
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-4f8467e39cfso140594e87.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 00:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686814676; x=1689406676;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZnXvTLLgfL+ohKr5bKWhwptShy/L9ePUshah6tdckUg=;
 b=PL9ajzPKNEUmM376yZbkYS4JFQ/PuIdddu4/d3rcqYc+bYFFV1CWIb3pwdMZhu27+H
 0F7F2IMDr9epKwagI6uI205AtlbnAH9JaxhD1BlRtY8lJHOPM/BQeuIiqhioxynQ4LH+
 /oUXXc54dkr2I92bidCUGDl7qbSLfCdqVacC4XvjUxLnmfnJ876cVBagRt7x5WzPdzI1
 mKvYf37GouZJ7uBr5CDIb9cNaWqCut3NLnpw4n6Y8CYN1zVDdo81WnBcEBOYmkXN+rr1
 0RIwTJq5altG4UHnUjzX/1Y7okC4U9g1SrNw4ljX0tuz4CJxVuuC/ldgBMseVSm9IbBU
 QlPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686814676; x=1689406676;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZnXvTLLgfL+ohKr5bKWhwptShy/L9ePUshah6tdckUg=;
 b=ZyCXMmcwn3MVoFj2jJB74fF2l99qdoyg3umfmQyqj4HM6w9iN0NjT0pXDftEUIE1ZH
 KXrn88gIfBSh2E2I+3kGGdt/zmjTWbgzYuedt+tLZex5lPLqcRfuiJvlAy9Wx/NYYxXf
 G8jxrNx6rHYn4eKjqlWvBhzr0zBjGUwMenUUOIwPDQuF4X5gLiZeVguZsQY+dpGE8p12
 mKIXTvSgLKaa1hHMdRZAdi+VvY7WPj5qPpbtlzP8tBaHsr+zSq9NzS65E1JGD7hrjSgg
 IISd7xEC+T1Oy8SppcLCDfjNcHF+Z8UO6QciQ3BSUktxJo9wNHOOpCrirqHliPT0R1pt
 Tihw==
X-Gm-Message-State: AC+VfDxtKR1Cx3ZbZ8iNldteQ4XvJBBZv783axNc1x5mZpVv+/cHQoUW
 cFpkVrSOh0tG7ydaTJeZg7k=
X-Google-Smtp-Source: ACHHUZ6mPQ6GsDeTrQ/qwC3P9hUc/xYikQf71c4wPpaiR0uSiMlyoPuaXNvgGazX4ZzBt9JKiqaVwQ==
X-Received: by 2002:a05:6512:2f5:b0:4f3:aa29:b672 with SMTP id
 m21-20020a05651202f500b004f3aa29b672mr10239979lfq.30.1686814675212; 
 Thu, 15 Jun 2023 00:37:55 -0700 (PDT)
Received: from ?IPV6:2a00:e180:1502:3e00:a4b7:5833:1db2:7e82?
 ([2a00:e180:1502:3e00:a4b7:5833:1db2:7e82])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a7bc5c6000000b003f7f87ba116sm19561907wmk.19.2023.06.15.00.37.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jun 2023 00:37:54 -0700 (PDT)
Message-ID: <cca4179c-bf58-b4f5-60b1-698da27fe508@gmail.com>
Date: Thu, 15 Jun 2023 09:37:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] drm/amdgpu: Implement new dummy vram manager
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230509220144.474723-1-alexander.deucher@amd.com>
 <20230509220144.474723-2-alexander.deucher@amd.com>
 <851ebfd9-bad6-8a11-5f73-44b183d2cb36@gmail.com>
 <a17ccb9e-7798-fc33-ff0e-53e96511a92a@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <a17ccb9e-7798-fc33-ff0e-53e96511a92a@amd.com>
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
Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.06.23 um 17:42 schrieb Felix Kuehling:
> Am 2023-06-14 um 06:38 schrieb Christian König:
>> Am 10.05.23 um 00:01 schrieb Alex Deucher:
>>> From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>>>
>>> This adds dummy vram manager to support ASICs that do not have a
>>> dedicated or carvedout vram domain.
>>
>> Well that doesn't seem to make much sense. Why we should have that?
>
> TTM always expects a resource manager for VRAM. There are no NULL 
> pointer checks in TTM for not having a resource manager for VRAM. The 
> existing amdgpu_vram_mgr gets confused if there is no VRAM. It seemed 
> cleaner to add a dummy manager than to scatter conditions for a 
> memory-less GPU corner case through the regular VRAM manager.

Well no that's absolutely *not* cleaner. TTM has a predefined manager if 
you need to use a dummy.

Why the heck didn't you ask me before doing stuff like that?

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>>
>> Christian.
>>
>>>
>>> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
>>> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 67 
>>> ++++++++++++++++++--
>>>   1 file changed, 60 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>> index 43d6a9d6a538..89d35d194f2c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>> @@ -370,6 +370,45 @@ int amdgpu_vram_mgr_query_page_status(struct 
>>> amdgpu_vram_mgr *mgr,
>>>       return ret;
>>>   }
>>>   +static void amdgpu_dummy_vram_mgr_debug(struct 
>>> ttm_resource_manager *man,
>>> +                  struct drm_printer *printer)
>>> +{
>>> +    DRM_DEBUG_DRIVER("Dummy vram mgr debug\n");
>>> +}
>>> +
>>> +static bool amdgpu_dummy_vram_mgr_compatible(struct 
>>> ttm_resource_manager *man,
>>> +                       struct ttm_resource *res,
>>> +                       const struct ttm_place *place,
>>> +                       size_t size)
>>> +{
>>> +    DRM_DEBUG_DRIVER("Dummy vram mgr compatible\n");
>>> +    return false;
>>> +}
>>> +
>>> +static bool amdgpu_dummy_vram_mgr_intersects(struct 
>>> ttm_resource_manager *man,
>>> +                       struct ttm_resource *res,
>>> +                       const struct ttm_place *place,
>>> +                       size_t size)
>>> +{
>>> +    DRM_DEBUG_DRIVER("Dummy vram mgr intersects\n");
>>> +    return true;
>>> +}
>>> +
>>> +static void amdgpu_dummy_vram_mgr_del(struct ttm_resource_manager 
>>> *man,
>>> +                struct ttm_resource *res)
>>> +{
>>> +    DRM_DEBUG_DRIVER("Dummy vram mgr deleted\n");
>>> +}
>>> +
>>> +static int amdgpu_dummy_vram_mgr_new(struct ttm_resource_manager *man,
>>> +                   struct ttm_buffer_object *tbo,
>>> +                   const struct ttm_place *place,
>>> +                   struct ttm_resource **res)
>>> +{
>>> +    DRM_DEBUG_DRIVER("Dummy vram mgr new\n");
>>> +    return -ENOSPC;
>>> +}
>>> +
>>>   /**
>>>    * amdgpu_vram_mgr_new - allocate new ranges
>>>    *
>>> @@ -817,6 +856,14 @@ static void amdgpu_vram_mgr_debug(struct 
>>> ttm_resource_manager *man,
>>>       mutex_unlock(&mgr->lock);
>>>   }
>>>   +static const struct ttm_resource_manager_func 
>>> amdgpu_dummy_vram_mgr_func = {
>>> +    .alloc    = amdgpu_dummy_vram_mgr_new,
>>> +    .free    = amdgpu_dummy_vram_mgr_del,
>>> +    .intersects = amdgpu_dummy_vram_mgr_intersects,
>>> +    .compatible = amdgpu_dummy_vram_mgr_compatible,
>>> +    .debug    = amdgpu_dummy_vram_mgr_debug
>>> +};
>>> +
>>>   static const struct ttm_resource_manager_func amdgpu_vram_mgr_func 
>>> = {
>>>       .alloc    = amdgpu_vram_mgr_new,
>>>       .free    = amdgpu_vram_mgr_del,
>>> @@ -841,17 +888,22 @@ int amdgpu_vram_mgr_init(struct amdgpu_device 
>>> *adev)
>>>       ttm_resource_manager_init(man, &adev->mman.bdev,
>>>                     adev->gmc.real_vram_size);
>>>   -    man->func = &amdgpu_vram_mgr_func;
>>> -
>>> -    err = drm_buddy_init(&mgr->mm, man->size, PAGE_SIZE);
>>> -    if (err)
>>> -        return err;
>>> -
>>>       mutex_init(&mgr->lock);
>>>       INIT_LIST_HEAD(&mgr->reservations_pending);
>>>       INIT_LIST_HEAD(&mgr->reserved_pages);
>>>       mgr->default_page_size = PAGE_SIZE;
>>>   +    if (!adev->gmc.is_app_apu) {
>>> +        man->func = &amdgpu_vram_mgr_func;
>>> +
>>> +        err = drm_buddy_init(&mgr->mm, man->size, PAGE_SIZE);
>>> +        if (err)
>>> +            return err;
>>> +    } else {
>>> +        man->func = &amdgpu_dummy_vram_mgr_func;
>>> +        DRM_INFO("Setup dummy vram mgr\n");
>>> +    }
>>> +
>>>       ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, 
>>> &mgr->manager);
>>>       ttm_resource_manager_set_used(man, true);
>>>       return 0;
>>> @@ -886,7 +938,8 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device 
>>> *adev)
>>>           drm_buddy_free_list(&mgr->mm, &rsv->allocated);
>>>           kfree(rsv);
>>>       }
>>> -    drm_buddy_fini(&mgr->mm);
>>> +    if (!adev->gmc.is_app_apu)
>>> +        drm_buddy_fini(&mgr->mm);
>>>       mutex_unlock(&mgr->lock);
>>>         ttm_resource_manager_cleanup(man);
>>

