Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E4E7C46CA1
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Sep 2023 08:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0BCD10E212;
	Mon, 18 Sep 2023 08:23:06 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91C3210E212
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Sep 2023 08:23:03 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5310a63cf7bso957461a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Sep 2023 01:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695025382; x=1695630182; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qtC6GVrj7bQIcWJrCrxmT4uuYVVYZi1W829CcJI9ZaM=;
 b=Wb4Fk3UodH0pw7AHIq4lAjGpHVBCZr1ng7VxOvMV5dbVlT04GjLF/l8WHjepLFvAlI
 /zk6UhgceFXhvjFZi4KOMRLvvOhgsL+fnf21OjelhklBSLJbXCpUnXynaUS+RMYo+QmT
 D9gEBwp6KNQ9M8oq3sEQkLltI3T9CcsFogio5Uc2xUdFNOXGWamalF+bF1+cCeTKHhuy
 i0BgO/1cY6gr8LG/Tl4EJek2Eo/kn/1lC4alXxpRnjTwo8NKSq07pktT8IEClZ6h2Th3
 iLpzTQFZ7JnfK+LroZu9ni+p8mewr9BhZSQnlxOERkvE6Vhjp4Gpbch+/Jotc4tCpWXb
 adRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695025382; x=1695630182;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qtC6GVrj7bQIcWJrCrxmT4uuYVVYZi1W829CcJI9ZaM=;
 b=jNLWzFZHUQmzPSb8qvgaw1exY9YxoC59exFSedZo5k9TOL4tYGZ3DOngsZWpuH+N5V
 EfAtfu7z0RLzeXuU0FlzT7gljB4Cre9zlyj734EjPteYVEvc8TV8gwF+UagDQs/ZV0ZU
 Oy84ttM+4ogWvHVpIp215MOM8G9h4fNq6Yd8SpUoCml8hB6EQZntCLwyOD+h0Gb392yO
 PVFvazJMzCqA09D6KZZVSbSbGk3ndN3szs5SOo6lDHlSFdhBv2KN0z5Mq5mv08BBOZGb
 UPat/LorKEnOsDjxRvGUBexeJ0K7FjDze4MuiQrWKItuM9CFPRbb2XrgJ15Dct3XsRTQ
 RGXQ==
X-Gm-Message-State: AOJu0YzcBcj5PuKQtSKrzVUjeuiTpMhKY7bhIVbRc9/Z0FgM91ecXxOu
 gxdVsyZmuM9lgQCa6PRnDHgJSHLVN44=
X-Google-Smtp-Source: AGHT+IGqjU/CoZB8Y2dcNLy1dXQSeJbV3RTFpR3XWrup5KhK654TnzO3U1pa+nCeFF71XR6YRucTNg==
X-Received: by 2002:a50:ee0d:0:b0:52a:6497:d02b with SMTP id
 g13-20020a50ee0d000000b0052a6497d02bmr7306677eds.16.1695025381601; 
 Mon, 18 Sep 2023 01:23:01 -0700 (PDT)
Received: from [192.168.178.25] ([185.254.126.99])
 by smtp.gmail.com with ESMTPSA id
 eh16-20020a0564020f9000b005256aaa6e7asm1165940edb.78.2023.09.18.01.23.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Sep 2023 01:23:01 -0700 (PDT)
Message-ID: <535e3add-e885-3c88-6afe-8371e565e675@gmail.com>
Date: Mon, 18 Sep 2023 10:23:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/amdkfd: Use gpu_offset for user queue's wptr
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org,
 "Sharma, Shashank" <Shashank.Sharma@amd.com>
References: <20230915025213.2463291-1-YuBiao.Wang@amd.com>
 <81a73442-2d27-eab8-4dec-cb1a6d179ab3@amd.com>
 <f82d33ef-3ace-0b74-04ab-9ce646dfb0bb@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <f82d33ef-3ace-0b74-04ab-9ce646dfb0bb@amd.com>
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
Cc: Feifei Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Kevin Wang <Kevin1.Wang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Monk Liu <Monk.Liu@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.09.23 um 16:53 schrieb Felix Kuehling:
> On 2023-09-15 2:50, Christian König wrote:
>> Am 15.09.23 um 04:52 schrieb YuBiao Wang:
>>> Directly use tbo's start address will miss the domain start offset. 
>>> Need
>>> to use gpu_offset instead.
>>>
>>> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
>>
>> Felix and/or Shashank should probably take a look as well, but of 
>> hand that looks like the correct fix.
>
> Looks reasonable to me. Why did this not cause problems before? Are we 
> just lucky that the domain start offset is 0 on the GPUs we've tested 
> so far?

By coincident the GART ended up being placed at 0 before. Now Alex has 
to move it to work around other issues.

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> index 77159b03a422..36e7171ad9a7 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> @@ -216,7 +216,7 @@ static int add_queue_mes(struct 
>>> device_queue_manager *dqm, struct queue *q,
>>>         if (q->wptr_bo) {
>>>           wptr_addr_off = (uint64_t)q->properties.write_ptr & 
>>> (PAGE_SIZE - 1);
>>> -        queue_input.wptr_mc_addr = 
>>> ((uint64_t)q->wptr_bo->tbo.resource->start << PAGE_SHIFT) + 
>>> wptr_addr_off;
>>> +        queue_input.wptr_mc_addr = amdgpu_bo_gpu_offset(q->wptr_bo) 
>>> + wptr_addr_off;
>>>       }
>>>         queue_input.is_kfd_process = 1;
>>

