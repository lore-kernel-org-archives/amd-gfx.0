Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0C45C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 12:30:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65275610C8
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 12:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 65275610C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E33CD6EA40;
	Wed, 13 Oct 2021 12:30:03 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 424956EA40
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 12:30:03 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id g25so7858622wrb.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 05:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=samCHaehaFPwREI7x8AkC9A10ME+kGY/VR4Dz529O3Y=;
 b=KwFUvlCzNCEV9kLYzepURKOHIsgbqHtEKTOffKmjo8kuql5UCymiX96OeFFLTmTS8k
 LXDE/4GhGF3wlHEPJogporUzucMotOsX1hTgNfodmgv9sKFGOy1mtSvFCyWpMpUFiVf0
 lW98iOlgbXZVN6rvPj8Y9QWA9BPAAOCR7jLW8tgRyR9nvbMHJP1dHPQhMKMp6elpetgv
 V689RyTrj/6CU6WwMP0bDqhG4A+3twXbthGtQAohtwW3tuXAjBk4B8Yai0x4Hl/Il8NT
 kBenPFH7sZKisKNP1MDWGJEGvc6D4ChXhgZQU5ARXtalld6XBFTzDwDOgGa7t4alFsTe
 l5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=samCHaehaFPwREI7x8AkC9A10ME+kGY/VR4Dz529O3Y=;
 b=XgoUS6QCNl3jfcL80csTVcYA4/1vTJ9CkUiyKFe8NBYYhoOEBVewBUyBb/TmPe+snR
 N2kZLbz41GldkrPHFE9nTPlTM4Urqf76+/bW8UNqchSdKZiVE6Yhvw8BF0qLUQaFrXlc
 36XunWZzz7LjZgKwPuJCYzEGeNPlLteGUE4MSkF4ela2IfjS6ig0lanDMUUoIJbjsxh+
 BVRxNySotVEKDWbuOhmTGPHUYRrzAVJwpexaTTIdJokA1TnKOFSsAIhoMp4mE3lCeOmb
 aPN18tyrTI+3GP/Gd8WrGpWWj2uPNdRXl0Y9rj4a+aWB3ZdKfXZ5Kty6qgewHh5LuxCo
 QiLw==
X-Gm-Message-State: AOAM531hSiW6I1qH6L2M/A/EiIf+4iUGnr/KzKMBlqrgnSjSvqr61o8+
 H3jLGldUWtEjN43/2uj8IB1UbKEedms=
X-Google-Smtp-Source: ABdhPJxbillmvonvQDsEwx6dwPApdxZBMiB91lvwl7L9+PttIiC8KMl2kPjizIuFSr0jSY7lChATdQ==
X-Received: by 2002:a5d:59aa:: with SMTP id p10mr16712454wrr.45.1634128201788; 
 Wed, 13 Oct 2021 05:30:01 -0700 (PDT)
Received: from ?IPv6:2a02:8109:333f:edd8:2287:c687:8512:6662?
 ([2a02:8109:333f:edd8:2287:c687:8512:6662])
 by smtp.gmail.com with ESMTPSA id z79sm5249431wmc.17.2021.10.13.05.30.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Oct 2021 05:30:01 -0700 (PDT)
Subject: Re: [PATCH Review 1/1] drm/ttm: fix debugfs node create failed
To: "Das, Nirmoy" <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211012115834.19577-1-Stanley.Yang@amd.com>
 <7cab58fe-c6ba-c5cb-921d-67a86ccda725@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <fb4360bf-57e0-e58e-f858-241b5939425c@gmail.com>
Date: Wed, 13 Oct 2021 14:29:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <7cab58fe-c6ba-c5cb-921d-67a86ccda725@amd.com>
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

Am 12.10.21 um 15:12 schrieb Das, Nirmoy:
>
> On 10/12/2021 1:58 PM, Stanley.Yang wrote:
>> Test scenario:
>>      modprobe amdgpu -> rmmod amdgpu -> modprobe amdgpu
>> Error log:
>>      [   54.396807] debugfs: File 'page_pool' in directory 'amdttm' 
>> already present!
>>      [   54.396833] debugfs: File 'page_pool_shrink' in directory 
>> 'amdttm' already present!
>>      [   54.396848] debugfs: File 'buffer_objects' in directory 
>> 'amdttm' already present!
>
>
> We should instead add a check if those debugfs files already 
> exist/created in ttm debugfs dir using debugfs_lookup() before creating.

No, IIRC the Intel guys had fixed that already by adding/removing the 
debugfs file on module load/unload.


Christian.

>
>
> Regards,
>
> Nirmoy
>
>
>
>> Reason:
>>      page_pool, page_pool_shrink and buffer_objects can be removed when
>>      rmmod amdttm, in the above test scenario only rmmod amdgpu, so 
>> those
>>      debugfs node will not be removed, this caused file create failed.
>> Soultion:
>>      create ttm_page directory under ttm_root directory when insmod 
>> amdgpu,
>>      page_pool, page_pool_shrink and buffer_objects are stored in 
>> ttm_page directiry,
>>      remove ttm_page directory when do rmmod amdgpu, this can fix 
>> above issue.
>>
>> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/ttm/ttm_device.c | 12 +++++++++++-
>>   drivers/gpu/drm/ttm/ttm_module.c |  1 +
>>   drivers/gpu/drm/ttm/ttm_module.h |  1 +
>>   drivers/gpu/drm/ttm/ttm_pool.c   |  4 ++--
>>   4 files changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/ttm/ttm_device.c 
>> b/drivers/gpu/drm/ttm/ttm_device.c
>> index 1de23edbc182..ad170328f0c8 100644
>> --- a/drivers/gpu/drm/ttm/ttm_device.c
>> +++ b/drivers/gpu/drm/ttm/ttm_device.c
>> @@ -55,6 +55,10 @@ static void ttm_global_release(void)
>>         ttm_pool_mgr_fini();
>>   +#ifdef CONFIG_DEBUG_FS
>> +    debugfs_remove(ttm_debugfs_page);
>> +#endif
>> +
>>       __free_page(glob->dummy_read_page);
>>       memset(glob, 0, sizeof(*glob));
>>   out:
>> @@ -85,6 +89,10 @@ static int ttm_global_init(void)
>>           >> PAGE_SHIFT;
>>       num_dma32 = min(num_dma32, 2UL << (30 - PAGE_SHIFT));
>>   +#ifdef CONFIG_DEBUG_FS
>> +    ttm_debugfs_page = debugfs_create_dir("ttm_page", 
>> ttm_debugfs_root);
>> +#endif
>> +
>>       ttm_pool_mgr_init(num_pages);
>>       ttm_tt_mgr_init(num_pages, num_dma32);
>>   @@ -98,8 +106,10 @@ static int ttm_global_init(void)
>>       INIT_LIST_HEAD(&glob->device_list);
>>       atomic_set(&glob->bo_count, 0);
>>   -    debugfs_create_atomic_t("buffer_objects", 0444, ttm_debugfs_root,
>> +#ifdef CONFIG_DEBUG_FS
>> +    debugfs_create_atomic_t("buffer_objects", 0444, ttm_debugfs_page,
>>                   &glob->bo_count);
>> +#endif
>>   out:
>>       mutex_unlock(&ttm_global_mutex);
>>       return ret;
>> diff --git a/drivers/gpu/drm/ttm/ttm_module.c 
>> b/drivers/gpu/drm/ttm/ttm_module.c
>> index 88970a6b8e32..66595e6e7087 100644
>> --- a/drivers/gpu/drm/ttm/ttm_module.c
>> +++ b/drivers/gpu/drm/ttm/ttm_module.c
>> @@ -38,6 +38,7 @@
>>   #include "ttm_module.h"
>>     struct dentry *ttm_debugfs_root;
>> +struct dentry *ttm_debugfs_page;
>>     static int __init ttm_init(void)
>>   {
>> diff --git a/drivers/gpu/drm/ttm/ttm_module.h 
>> b/drivers/gpu/drm/ttm/ttm_module.h
>> index d7cac5d4b835..6007dc66f44e 100644
>> --- a/drivers/gpu/drm/ttm/ttm_module.h
>> +++ b/drivers/gpu/drm/ttm/ttm_module.h
>> @@ -36,5 +36,6 @@
>>   struct dentry;
>>     extern struct dentry *ttm_debugfs_root;
>> +extern struct dentry *ttm_debugfs_page;
>>     #endif /* _TTM_MODULE_H_ */
>> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c 
>> b/drivers/gpu/drm/ttm/ttm_pool.c
>> index 8be7fd7161fd..ecb33daad7b5 100644
>> --- a/drivers/gpu/drm/ttm/ttm_pool.c
>> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
>> @@ -709,9 +709,9 @@ int ttm_pool_mgr_init(unsigned long num_pages)
>>       }
>>     #ifdef CONFIG_DEBUG_FS
>> -    debugfs_create_file("page_pool", 0444, ttm_debugfs_root, NULL,
>> +    debugfs_create_file("page_pool", 0444, ttm_debugfs_page, NULL,
>>                   &ttm_pool_debugfs_globals_fops);
>> -    debugfs_create_file("page_pool_shrink", 0400, ttm_debugfs_root, 
>> NULL,
>> +    debugfs_create_file("page_pool_shrink", 0400, ttm_debugfs_page, 
>> NULL,
>>                   &ttm_pool_debugfs_shrink_fops);
>>   #endif

