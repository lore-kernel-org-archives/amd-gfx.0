Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427E1EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jun 2023 08:24:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBA4410E17E;
	Thu, 15 Jun 2023 08:24:53 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E45710E17E
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 08:24:52 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5187aa18410so3444079a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jun 2023 01:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686817490; x=1689409490;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9qHmxk5iAdHUhJ+qgReSUMex5BNvsHrbcmAnNLTapZs=;
 b=jikAvo1sKkucJ4+OLc0HW9cMslM4oION1Y6Us03USWz+vprBaRqeZtIF3CXGJQ1580
 ATY7avA6p6hmiMMZkUkxlJ/XwxnH8adCmZieEYY8j9uAHZD1af3uSYbQo8aTCidORJ71
 zYwjAWgX5zXDYtTNtJnAJwzKmyIhsOg2zUCHdQB8Bu7l1BtZ52lDNC+APiS82iDxJenh
 FUdkq3mUt4XcC61DtiIEjd+BYWXnKBoBssib9ydJe5BfY4wmFpz7NVoCCPYitRlO6qo8
 VUmabkhPDXlNxDbKENWMsl7jAK2MnwXBaGwwBJzvZBXvIYYWoFeO4pI8uKHisJA8A0uO
 alNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686817490; x=1689409490;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9qHmxk5iAdHUhJ+qgReSUMex5BNvsHrbcmAnNLTapZs=;
 b=Usv5fpERauApQsuqn/n2/HmKj7vwoWBU1CLFFVKjy6cBV378NUnCUog6R/yFtb4XvO
 K+PRTbhMC6CdjicyzDDUBr19VlO4vhiCOPBtGfnExTbfbpeGg6ksTtH799/nPt9JB+3S
 ecA4Y9Dzu/s6sC7W5JkzVtTLSJvISBIJTk4OOhpRkrL31MbrDl7IlE3pvWLtlFO2iBxa
 Ebyl+MqhRdGHfMPRBRAzXNU3XPxWHuQchNSgEiqoJSRJmtr8M00nSiD1t1r8j8FsWvqa
 Nr4p1oXaf52ldp6lbWFutKNj5kWbwm9l8W/x7f4r5YYo2Y1+P9x9+CvGf3x4nVltZ/+n
 9j4g==
X-Gm-Message-State: AC+VfDx+Kh4T2J9Yny0VBGuxgXt/sG4eGJPoZwcw13Cy1kc+YfTf/FCm
 rAXPmBq2clFniwTRJguach4=
X-Google-Smtp-Source: ACHHUZ591CXzMY/0HSxTOrGSis7Gc/0/XGlKeI0nYh/dSR4lt7d7LodMfajo+7aTe/x33VCWnU9dqA==
X-Received: by 2002:aa7:d9d8:0:b0:518:6d88:7169 with SMTP id
 v24-20020aa7d9d8000000b005186d887169mr6319235eds.29.1686817490028; 
 Thu, 15 Jun 2023 01:24:50 -0700 (PDT)
Received: from ?IPV6:2a00:e180:1502:3e00:a4b7:5833:1db2:7e82?
 ([2a00:e180:1502:3e00:a4b7:5833:1db2:7e82])
 by smtp.gmail.com with ESMTPSA id
 o20-20020aa7c7d4000000b005183ce42da9sm5130054eds.18.2023.06.15.01.24.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jun 2023 01:24:49 -0700 (PDT)
Message-ID: <fc0c1d9e-2a7a-1509-77fa-1d435cf7ad89@gmail.com>
Date: Thu, 15 Jun 2023 10:24:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] drm/amdgpu: make sure BOs are locked in
 amdgpu_vm_get_memory
Content-Language: en-US
To: "Chen, Guchun" <Guchun.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "mikhail.v.gavrilov@gmail.com" <mikhail.v.gavrilov@gmail.com>
References: <20230605091122.3363-1-christian.koenig@amd.com>
 <DM5PR12MB2469DA5E1D8B9FB3BB8C7082F152A@DM5PR12MB2469.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <DM5PR12MB2469DA5E1D8B9FB3BB8C7082F152A@DM5PR12MB2469.namprd12.prod.outlook.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 06.06.23 um 03:11 schrieb Chen, Guchun:
> [Public]
>
> Acked-by: Guchun Chen <guchun.chen@amd.com> for this series.
>
> A simple question is we don't need to hold the lock if bo locations are not changed?

Well we take the look to make sure that BO locations don't change.

Otherwise we potentially access freed memory when looking at the resource.

Regards,
Christian.

>
> Regards,
> Guchun
>
>> -----Original Message-----
>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>> Sent: Monday, June 5, 2023 5:11 PM
>> To: amd-gfx@lists.freedesktop.org; mikhail.v.gavrilov@gmail.com; Chen,
>> Guchun <Guchun.Chen@amd.com>
>> Subject: [PATCH 1/2] drm/amdgpu: make sure BOs are locked in
>> amdgpu_vm_get_memory
>>
>> We need to grab the lock of the BO or otherwise can run into a crash when
>> we try to inspect the current location.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 69 +++++++++++++++---------
>> --
>>   1 file changed, 39 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 3c0310576b3b..2c8cafec48a4 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -920,42 +920,51 @@ int amdgpu_vm_update_range(struct
>> amdgpu_device *adev, struct amdgpu_vm *vm,
>>        return r;
>>   }
>>
>> +static void amdgpu_vm_bo_get_memory(struct amdgpu_bo_va *bo_va,
>> +                                 struct amdgpu_mem_stats *stats) {
>> +     struct amdgpu_vm *vm = bo_va->base.vm;
>> +     struct amdgpu_bo *bo = bo_va->base.bo;
>> +
>> +     if (!bo)
>> +             return;
>> +
>> +     /*
>> +      * For now ignore BOs which are currently locked and potentially
>> +      * changing their location.
>> +      */
>> +     if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv &&
>> +         !dma_resv_trylock(bo->tbo.base.resv))
>> +             return;
>> +
>> +     amdgpu_bo_get_memory(bo, stats);
>> +     if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv)
>> +         dma_resv_unlock(bo->tbo.base.resv);
>> +}
>> +
>>   void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
>>                          struct amdgpu_mem_stats *stats)
>>   {
>>        struct amdgpu_bo_va *bo_va, *tmp;
>>
>>        spin_lock(&vm->status_lock);
>> -     list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
>> -             if (!bo_va->base.bo)
>> -                     continue;
>> -             amdgpu_bo_get_memory(bo_va->base.bo, stats);
>> -     }
>> -     list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status)
>> {
>> -             if (!bo_va->base.bo)
>> -                     continue;
>> -             amdgpu_bo_get_memory(bo_va->base.bo, stats);
>> -     }
>> -     list_for_each_entry_safe(bo_va, tmp, &vm->relocated,
>> base.vm_status) {
>> -             if (!bo_va->base.bo)
>> -                     continue;
>> -             amdgpu_bo_get_memory(bo_va->base.bo, stats);
>> -     }
>> -     list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status)
>> {
>> -             if (!bo_va->base.bo)
>> -                     continue;
>> -             amdgpu_bo_get_memory(bo_va->base.bo, stats);
>> -     }
>> -     list_for_each_entry_safe(bo_va, tmp, &vm->invalidated,
>> base.vm_status) {
>> -             if (!bo_va->base.bo)
>> -                     continue;
>> -             amdgpu_bo_get_memory(bo_va->base.bo, stats);
>> -     }
>> -     list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {
>> -             if (!bo_va->base.bo)
>> -                     continue;
>> -             amdgpu_bo_get_memory(bo_va->base.bo, stats);
>> -     }
>> +     list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status)
>> +             amdgpu_vm_bo_get_memory(bo_va, stats);
>> +
>> +     list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status)
>> +             amdgpu_vm_bo_get_memory(bo_va, stats);
>> +
>> +     list_for_each_entry_safe(bo_va, tmp, &vm->relocated,
>> base.vm_status)
>> +             amdgpu_vm_bo_get_memory(bo_va, stats);
>> +
>> +     list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status)
>> +             amdgpu_vm_bo_get_memory(bo_va, stats);
>> +
>> +     list_for_each_entry_safe(bo_va, tmp, &vm->invalidated,
>> base.vm_status)
>> +             amdgpu_vm_bo_get_memory(bo_va, stats);
>> +
>> +     list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status)
>> +             amdgpu_vm_bo_get_memory(bo_va, stats);
>>        spin_unlock(&vm->status_lock);
>>   }
>>
>> --
>> 2.34.1

