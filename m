Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D81BC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 16:53:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8369C10E77F;
	Fri, 18 Nov 2022 16:53:58 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDC4110E780
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 16:53:55 +0000 (UTC)
Received: by mail-ej1-x633.google.com with SMTP id n20so14619715ejh.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 08:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PHuupowCU7YHILOI1a9BgEQ+moMaXcZG3XoYyaI05LY=;
 b=TsdmLhUyT7zaJr/88H7GawuDfmm3ZiI2gYoI5DCFDm8dwZSgFbxXwjSl3WNEX9LMQu
 flp7EwBu6VgwvOFqz/loyfm1t7AlwQyljy5wuEmDGEOPm5Byvop8RHHbrq/cTfmp0/hU
 MOrbLC9IKgd1KxzrVvGOA2dfSR+4g9hx276PkUHPZAXeMmgbhhJfkAzvnAkiMeRa6CDD
 N4pobl0kJkmQPJwhrGqAmLTiUzanXfB0ZJBNVL71Sdq00TKP67JfKlsos892aqLd/Tcr
 ChQOqchWNY+3XxO7Nda2CHWLnTaHv1tVr8bR7VbjFJ+FGB2SkzOgHCXdLpePvLglykrP
 iBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PHuupowCU7YHILOI1a9BgEQ+moMaXcZG3XoYyaI05LY=;
 b=3W6yPDMbQnzR6fsCLmH3yct/xiyEWCbEIOeNPUZlHwUuzGLnAHr15RfiWYfWRPHs6v
 g/DLzANZGwNnI7aYS56cPe6tjb4QmBHs7T6sCxzRhPYzagTTAK5+hrMnmYzbXz4cCbcp
 zaTJbVYve1eBF/xBwQv6/4FGFcmZBPnsFBKkEpZ5uFpyhP7pqZmZmPVECfG8+s1Vn+Wp
 e2Lst0HJ/xSmp2cXtnK9bIi+git6u00obbouoHY/q8eBGqaI2W9NJ3gkvvaSbNNj1P1e
 3PJY2JJJtPZzVoxyhms9mqoepKg2HnU3ZwyZhjutAB4A3SiBrVq2dYY4O4b6+i+dcXjX
 FLqw==
X-Gm-Message-State: ANoB5pkg8dTWpkhGK6rC83J9iTrn5B5wFYuVOMFhL3kigNYLiTbO9hOz
 nY7FUXDpBW3WmeJ2xrVgIKU=
X-Google-Smtp-Source: AA0mqf5eXQQ5RibIozseOYcrJjrKRmRTwtMVmomeprNE+64wIor+NE98/YG46X3FYb4+u3id8JVzdg==
X-Received: by 2002:a17:906:b28f:b0:7ad:a942:4d6b with SMTP id
 q15-20020a170906b28f00b007ada9424d6bmr6565713ejz.379.1668790434225; 
 Fri, 18 Nov 2022 08:53:54 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:6df3:758:835a:3ec8?
 ([2a02:908:1256:79a0:6df3:758:835a:3ec8])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a1709062a8c00b00781d411a63csm1893042eje.151.2022.11.18.08.53.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Nov 2022 08:53:53 -0800 (PST)
Message-ID: <a180281a-c78e-0d0f-7163-c57f104b714c@gmail.com>
Date: Fri, 18 Nov 2022 17:53:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: handle gang submit before VMID
Content-Language: en-US
To: =?UTF-8?Q?Timur_Krist=c3=b3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20221118153023.312582-1-christian.koenig@amd.com>
 <3144fa81950d36c0e30d984ecc775664a86f754f.camel@gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <3144fa81950d36c0e30d984ecc775664a86f754f.camel@gmail.com>
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
Cc: Alexander.Deucher@amd.com,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Pushed to drm-misc-fixes, should be picked up for the next rc.

Let me know if you run into any more problems with that.

Thanks,
Christian.

Am 18.11.22 um 16:36 schrieb Timur Kristóf:
> Can you guys please push this into the next 6.1 RC? This solves a
> significant issue with gang submit.
>
> On Fri, 2022-11-18 at 16:30 +0100, Christian König wrote:
>> Otherwise it can happen that not all gang members can get a VMID
>> assigned and we deadlock.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> Tested-by: Timur Kristóf <timur.kristof@gmail.com>
>> Acked-by: Timur Kristóf <timur.kristof@gmail.com>
>> Fixes: 68ce8b242242 ("drm/amdgpu: add gang submit backend v2")
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> index cd968e781077..abb99cff8b4b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> @@ -254,6 +254,9 @@ static struct dma_fence
>> *amdgpu_job_dependency(struct drm_sched_job *sched_job,
>>                          DRM_ERROR("Error adding fence (%d)\n", r);
>>          }
>>   
>> +       if (!fence && job->gang_submit)
>> +               fence = amdgpu_device_switch_gang(ring->adev, job-
>>> gang_submit);
>> +
>>          while (fence == NULL && vm && !job->vmid) {
>>                  r = amdgpu_vmid_grab(vm, ring, &job->sync,
>>                                       &job->base.s_fence->finished,
>> @@ -264,9 +267,6 @@ static struct dma_fence
>> *amdgpu_job_dependency(struct drm_sched_job *sched_job,
>>                  fence = amdgpu_sync_get_fence(&job->sync);
>>          }
>>   
>> -       if (!fence && job->gang_submit)
>> -               fence = amdgpu_device_switch_gang(ring->adev, job-
>>> gang_submit);
>> -
>>          return fence;
>>   }
>>   

