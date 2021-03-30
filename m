Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7222C433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 07:10:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A3D961999
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 07:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A3D961999
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06F736E85C;
	Tue, 30 Mar 2021 07:10:58 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 159EC6E85C
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 07:10:56 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id x21so16946747eds.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 00:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=l7B5YZztqkgMS0pUkaqcUaLKS++FfCymbn+tkUd3edk=;
 b=lQKCFaj4JiVsdudiiPIoCTdsf4sjdRydvzxWqLgzCunrL4dRYL7ZLfAIAsEZg2woIc
 +0IgeiaSGerZf39oJnWko7FHJFj9WFUrFeGVX/enzcH8Pr6B2nKgGxDfJtrcFRzDz0ji
 wjWayvkfXv1ZQ2zeXLDDny4NrhzIFESQb6tGTRMAlNzvqbx/Wi0GC0ZhYwxKeoYAVvOu
 N9AERAMKAX6aZjVT4rsbESCrVZHk/8T0Mff9gXbs/duEM7WZ9qLFy5RaQCmPK2Mm0+3b
 CvYUIycvaK5uMqLs81KMC8mhOEl4aaTVxvXNz1aRKSD8Cu5lB+iIEauD3mTWBUlbH5lM
 Uu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=l7B5YZztqkgMS0pUkaqcUaLKS++FfCymbn+tkUd3edk=;
 b=J0j/3nw0ap+3V8zFMN+UbiNTcHq+yAiNlyWmyGvkwFYu8OW9y/cDsj5KM7WBYkOmNP
 UnKu7YEBLym7k0Bl+K2076HiYRyJZ/OOulFGtImrJPvDIsIDksiigOPOkZj+x5RbLq4q
 RnkYCQx0oZ01yy5mPfO++vyA8eGnlgqPxtu+I4Vt39rhA9Zb72ibiQnmPOM2FHRPTFYs
 TFdIoaFFMGLm3QCpFE6z6n4JIVnNuysG/yEzXkKwxqDV6GxN90Q53jfqGRs1oYCw4bZ7
 0piyNo1OyGN/gVw8T9/pc4niUljZ/mcQkwe+jMZ655FJD00hZRyif8AKsZmPiyAruCC5
 jweA==
X-Gm-Message-State: AOAM532HhQqk2GHL4TrSTcBZstcjQzCtVLgbrdLSZ66I038rupPStdHG
 xrLr3yci/n076YWJFnSRu8EphFjOMvs=
X-Google-Smtp-Source: ABdhPJya5VvM6R7MBbg4QYYYk82uet7GiiYMD0n02M+QGH/HcmNW5PVbsaypwz87dkPOSbiOccbA4Q==
X-Received: by 2002:aa7:c1d5:: with SMTP id d21mr31431189edp.167.1617088254762; 
 Tue, 30 Mar 2021 00:10:54 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:8ca4:a46e:6aa7:208c?
 ([2a02:908:1252:fb60:8ca4:a46e:6aa7:208c])
 by smtp.gmail.com with ESMTPSA id a9sm10423304eds.33.2021.03.30.00.10.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Mar 2021 00:10:54 -0700 (PDT)
Subject: Re: [PATCH 6/6] drm/amdgpu: Fix driver unload issue
To: "Deng, Emily" <Emily.Deng@amd.com>,
 "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210330044147.57802-1-Emily.Deng@amd.com>
 <20210330044147.57802-6-Emily.Deng@amd.com>
 <BY5PR12MB48854A0C129A2F6BE99503E8EA7D9@BY5PR12MB4885.namprd12.prod.outlook.com>
 <BY5PR12MB4115A92F867D543FFF7444798F7D9@BY5PR12MB4115.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <a9a978f1-fbd6-a90a-d966-ab2ebc2bc4f5@gmail.com>
Date: Tue, 30 Mar 2021 09:10:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB4115A92F867D543FFF7444798F7D9@BY5PR12MB4115.namprd12.prod.outlook.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Good morning,

yes Jiansong is right that patch is really not a good idea.

Moving buffers can indeed happen during shutdown while some memory is 
still referenced.

Just ignoring the move is not the right approach, you need to find out 
why the memory is moved in the first place.

You could add something like WARN_ON(adev->shutdown);

Regards,
Christian.

Am 30.03.21 um 09:05 schrieb Deng, Emily:
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi Jiansong,
>       It does happen,  maybe have the race condition?
>
>
> Best wishes
> Emily Deng
>
>
>
>> -----Original Message-----
>> From: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
>> Sent: Tuesday, March 30, 2021 2:49 PM
>> To: Deng, Emily <Emily.Deng@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deng, Emily <Emily.Deng@amd.com>
>> Subject: RE: [PATCH 6/6] drm/amdgpu: Fix driver unload issue
>>
>> [AMD Official Use Only - Internal Distribution Only]
>>
>> I still wonder how the issue takes place? According to my humble knowledge
>> in driver model, the reference count of the kobject for the device will not
>> reach zero when there is still some device mem access, and shutdown should
>> not happen.
>>
>> Regards,
>> Jiansong
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Emily
>> Deng
>> Sent: Tuesday, March 30, 2021 12:42 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deng, Emily <Emily.Deng@amd.com>
>> Subject: [PATCH 6/6] drm/amdgpu: Fix driver unload issue
>>
>> During driver unloading, don't need to copy mem, or it will introduce some
>> call trace, such as when sa_manager is freed, it will introduce warn call trace
>> in amdgpu_sa_bo_new.
>>
>> Signed-off-by: Emily Deng <Emily.Deng@amd.com>
>> ---
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 +++
>> 1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index e00263bcc88b..f0546a489e0d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -317,6 +317,9 @@ int amdgpu_ttm_copy_mem_to_mem(struct
>> amdgpu_device *adev,  struct dma_fence *fence = NULL;  int r = 0;
>>
>> +if (adev->shutdown)
>> +return 0;
>> +
>> if (!adev->mman.buffer_funcs_enabled) {  DRM_ERROR("Trying to move
>> memory with ring turned off.\n");  return -EINVAL;
>> --
>> 2.25.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.fr
>> eedesktop.org%2Fmailman%2Flistinfo%2Famd-
>> gfx&amp;data=04%7C01%7CJiansong.Chen%40amd.com%7C1b4c71d7b96247
>> 6a367508d8f3362f40%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7
>> C637526761354532311%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
>> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat
>> a=RxRnZW0fmwjKSGMN1nf6kIHRdAPVs9J5OBluDYhR6vQ%3D&amp;reserved
>> =0
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
