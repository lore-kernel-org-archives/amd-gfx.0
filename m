Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9489CC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 08:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 565C96115A
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 08:45:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 565C96115A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D185E6EB54;
	Tue, 19 Oct 2021 08:45:40 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80EE76EB54
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 08:45:39 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 u8-20020a05600c440800b0030d90076dabso1511143wmn.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 01:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=fatXRHdBFxggfHErOkfha3Bh00bCN/ZDO96CTDGO8yo=;
 b=cmNzMO+6BWkqQ3uYuKgU6Ct+Z/CWiYryrK/t/U10gqp0j5kcuRXwCXUmMSST6xuW29
 bCr4US4Z2Ll4MUeEvDg1vJljYlI+DubVsI58u/I5x0/+CKZVzTpyvv0BAvRfWjTnGb9Y
 H5z3zaF9nGNFygwoMbIP82sllSyKaDBTi2asU6bJEku1LFOJhlMb1dEz2DuCm8De8zKU
 2xnRJKdKpqQjJYqzJbAXgxdYu12wpsLz4211udUsky069dCWNMWCap40g6yXe9v/LDC+
 cZ/Uwuex8n5CLtmgE38FdXR3jNJVK4/Dk2dKpwB2CqW1c/Y6MusDjTonjs5LHV2jAF/s
 650g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=fatXRHdBFxggfHErOkfha3Bh00bCN/ZDO96CTDGO8yo=;
 b=v1QL/+yrN1khc8UisdcahIN1qzEALgxuHaRNCE4b/Mie/GBX1c+3D3CUR//5wF1j2K
 npZL4eKgnZTgfrHBQf0UXFrFCgVhb2bQsSC3sxMlFty4JbfUo+ALX5RGCnrzs4LuvBNo
 cy1L6TQTzOiXbkucAyippCRa3P/atnNgooztQgyB8jsCefa81FqsSKWiS4qF5uXj2SlW
 hWzPRrbWMzJgiYz21wcg2oaF+7wPRuxuzA3Ye3YtpxBS0C956P09yZnMcXIUwPkDu/2t
 rE/KDVXu5qhxGCXpKzy9BzXgLf9T0zmNKWNE3j1zygM1dgXA+R+iJRahGossafdLE17+
 51Tg==
X-Gm-Message-State: AOAM533HomTTGG4xIwx5lf1EjFPia7UsHIqM/FK9UhTejP1Gl2dyPo5t
 QzPXT8skl7wd3IHJ7oIcrSCput7/V18=
X-Google-Smtp-Source: ABdhPJywvwjndb7BJXjqO1nQe0jx8JU9U+jh0TIa7j4ZGXOP0BiSFZl7a+RAmQfT33Q0UcmLBGUpwA==
X-Received: by 2002:a05:600c:4e91:: with SMTP id
 f17mr4564284wmq.180.1634633137971; 
 Tue, 19 Oct 2021 01:45:37 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:f344:748e:38f7:c50?
 ([2a02:908:1252:fb60:f344:748e:38f7:c50])
 by smtp.gmail.com with ESMTPSA id o11sm20083324wry.0.2021.10.19.01.45.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Oct 2021 01:45:37 -0700 (PDT)
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIFJldmlldyAxLzFdIGRybS90dG06IGZp?=
 =?UTF-8?Q?x_debugfs_node_create_failed?=
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "Das, Nirmoy" <Nirmoy.Das@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20211012115834.19577-1-Stanley.Yang@amd.com>
 <7cab58fe-c6ba-c5cb-921d-67a86ccda725@amd.com>
 <fb4360bf-57e0-e58e-f858-241b5939425c@gmail.com>
 <3cee661f-7807-b3e2-f281-07f7a64e40c8@amd.com>
 <BL1PR12MB533412ED7D1DD3BEFC8597179ABD9@BL1PR12MB5334.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <776ce8d2-b61e-d4f2-d6b4-0b6e0e754188@gmail.com>
Date: Tue, 19 Oct 2021 10:45:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <BL1PR12MB533412ED7D1DD3BEFC8597179ABD9@BL1PR12MB5334.namprd12.prod.outlook.com>
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

Am 19.10.21 um 10:02 schrieb Yang, Stanley:
> [AMD Official Use Only]
>
>
>> -----邮件原件-----
>> 发件人: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> 代表 Das,
>> Nirmoy
>> 发送时间: Thursday, October 14, 2021 2:11 AM
>> 收件人: Christian König <ckoenig.leichtzumerken@gmail.com>; amd-
>> gfx@lists.freedesktop.org
>> 主题: Re: [PATCH Review 1/1] drm/ttm: fix debugfs node create failed
>>
>>
>> On 10/13/2021 2:29 PM, Christian König wrote:
>>> Am 12.10.21 um 15:12 schrieb Das, Nirmoy:
>>>> On 10/12/2021 1:58 PM, Stanley.Yang wrote:
>>>>> Test scenario:
>>>>>       modprobe amdgpu -> rmmod amdgpu -> modprobe amdgpu Error log:
>>>>>       [   54.396807] debugfs: File 'page_pool' in directory 'amdttm'
>>>>> already present!
>>>>>       [   54.396833] debugfs: File 'page_pool_shrink' in directory
>>>>> 'amdttm' already present!
>>>>>       [   54.396848] debugfs: File 'buffer_objects' in directory
>>>>> 'amdttm' already present!
>>>>
>>>> We should instead add a check if those debugfs files already
>>>> exist/created in ttm debugfs dir using debugfs_lookup() before creating.
>>> No, IIRC the Intel guys had fixed that already by adding/removing the
>>> debugfs file on module load/unload.
>>
>> Adding/removing on ttm module load/unload is nicer.
> The point is that page_pool, page_pool_shrink and buffer_objects are created by amdgpu driver,

Yeah, but the debugfs files are not created by the driver. Those are 
global to TTM and can trivially be created during module load/unload.

Christian.

>   I think it's better to remove them by amdgpu module due to amdgpu module create them,
> otherwise, there will be a scene create them failed only reload amdgpu module.
>
> Stanley
>>
>> Nirmoy
>>
>>>
>>> Christian.
>>>
>>>>
>>>> Regards,
>>>>
>>>> Nirmoy
>>>>
>>>>
>>>>
>>>>> Reason:
>>>>>       page_pool, page_pool_shrink and buffer_objects can be removed
>>>>> when
>>>>>       rmmod amdttm, in the above test scenario only rmmod amdgpu, so
>>>>> those
>>>>>       debugfs node will not be removed, this caused file create failed.
>>>>> Soultion:
>>>>>       create ttm_page directory under ttm_root directory when insmod
>>>>> amdgpu,
>>>>>       page_pool, page_pool_shrink and buffer_objects are stored in
>>>>> ttm_page directiry,
>>>>>       remove ttm_page directory when do rmmod amdgpu, this can fix
>>>>> above issue.
>>>>>
>>>>> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
>>>>> ---
>>>>>    drivers/gpu/drm/ttm/ttm_device.c | 12 +++++++++++-
>>>>>    drivers/gpu/drm/ttm/ttm_module.c |  1 +
>>>>>    drivers/gpu/drm/ttm/ttm_module.h |  1 +
>>>>>    drivers/gpu/drm/ttm/ttm_pool.c   |  4 ++--
>>>>>    4 files changed, 15 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/ttm/ttm_device.c
>>>>> b/drivers/gpu/drm/ttm/ttm_device.c
>>>>> index 1de23edbc182..ad170328f0c8 100644
>>>>> --- a/drivers/gpu/drm/ttm/ttm_device.c
>>>>> +++ b/drivers/gpu/drm/ttm/ttm_device.c
>>>>> @@ -55,6 +55,10 @@ static void ttm_global_release(void)
>>>>>          ttm_pool_mgr_fini();
>>>>>    +#ifdef CONFIG_DEBUG_FS
>>>>> +    debugfs_remove(ttm_debugfs_page); #endif
>>>>> +
>>>>>        __free_page(glob->dummy_read_page);
>>>>>        memset(glob, 0, sizeof(*glob));
>>>>>    out:
>>>>> @@ -85,6 +89,10 @@ static int ttm_global_init(void)
>>>>>            >> PAGE_SHIFT;
>>>>>        num_dma32 = min(num_dma32, 2UL << (30 - PAGE_SHIFT));
>>>>>    +#ifdef CONFIG_DEBUG_FS
>>>>> +    ttm_debugfs_page = debugfs_create_dir("ttm_page",
>>>>> ttm_debugfs_root);
>>>>> +#endif
>>>>> +
>>>>>        ttm_pool_mgr_init(num_pages);
>>>>>        ttm_tt_mgr_init(num_pages, num_dma32);
>>>>>    @@ -98,8 +106,10 @@ static int ttm_global_init(void)
>>>>>        INIT_LIST_HEAD(&glob->device_list);
>>>>>        atomic_set(&glob->bo_count, 0);
>>>>>    -    debugfs_create_atomic_t("buffer_objects", 0444,
>>>>> ttm_debugfs_root,
>>>>> +#ifdef CONFIG_DEBUG_FS
>>>>> +    debugfs_create_atomic_t("buffer_objects", 0444,
>>>>> +ttm_debugfs_page,
>>>>>                    &glob->bo_count);
>>>>> +#endif
>>>>>    out:
>>>>>        mutex_unlock(&ttm_global_mutex);
>>>>>        return ret;
>>>>> diff --git a/drivers/gpu/drm/ttm/ttm_module.c
>>>>> b/drivers/gpu/drm/ttm/ttm_module.c
>>>>> index 88970a6b8e32..66595e6e7087 100644
>>>>> --- a/drivers/gpu/drm/ttm/ttm_module.c
>>>>> +++ b/drivers/gpu/drm/ttm/ttm_module.c
>>>>> @@ -38,6 +38,7 @@
>>>>>    #include "ttm_module.h"
>>>>>      struct dentry *ttm_debugfs_root;
>>>>> +struct dentry *ttm_debugfs_page;
>>>>>      static int __init ttm_init(void)
>>>>>    {
>>>>> diff --git a/drivers/gpu/drm/ttm/ttm_module.h
>>>>> b/drivers/gpu/drm/ttm/ttm_module.h
>>>>> index d7cac5d4b835..6007dc66f44e 100644
>>>>> --- a/drivers/gpu/drm/ttm/ttm_module.h
>>>>> +++ b/drivers/gpu/drm/ttm/ttm_module.h
>>>>> @@ -36,5 +36,6 @@
>>>>>    struct dentry;
>>>>>      extern struct dentry *ttm_debugfs_root;
>>>>> +extern struct dentry *ttm_debugfs_page;
>>>>>      #endif /* _TTM_MODULE_H_ */
>>>>> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c
>>>>> b/drivers/gpu/drm/ttm/ttm_pool.c index 8be7fd7161fd..ecb33daad7b5
>>>>> 100644
>>>>> --- a/drivers/gpu/drm/ttm/ttm_pool.c
>>>>> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
>>>>> @@ -709,9 +709,9 @@ int ttm_pool_mgr_init(unsigned long num_pages)
>>>>>        }
>>>>>      #ifdef CONFIG_DEBUG_FS
>>>>> -    debugfs_create_file("page_pool", 0444, ttm_debugfs_root, NULL,
>>>>> +    debugfs_create_file("page_pool", 0444, ttm_debugfs_page, NULL,
>>>>>                    &ttm_pool_debugfs_globals_fops);
>>>>> -    debugfs_create_file("page_pool_shrink", 0400, ttm_debugfs_root,
>>>>> NULL,
>>>>> +    debugfs_create_file("page_pool_shrink", 0400, ttm_debugfs_page,
>>>>> NULL,
>>>>>                    &ttm_pool_debugfs_shrink_fops);
>>>>>    #endif

